
;TODO: DB - sort out hard coded addresses and harmonise with adfs.asm style

; ADFS MMC Card Driver
; (C) 2015 David Banks
; Based on code from MMFS ROM by Martin Mather
;
; 20-Feb-2016 JGH:
; Corrected error numbers. None of these should be errors, they should be
; return results otherwise, eg OSWORD &72 bombs out instead of returning a
; result.
;
; 27-Mar-2016 JGH:
; MMC_BEGIN redefined interface to destroy all registers, returns result,
; falls through to MMC_INIT to initialise and return result.
; setCommandAddress returns error result on failure.
; StartRead/Write return error result on failure.
; MMC return codes translated to ADFS return codes.


MMC_TRYS=$32

go_idle_state    =$40
send_op_cond     =$41
mmc_command_48   =$48
send_cid         =$4A
set_blklen       =$50
read_single_block=$51
write_block      =$58


.if HD_MMC_HOG

;; **** Begin Read Transaction ****
MMC_StartRead:
     JSR MMC_DoCommand
     BNE errRead
     JMP MMC_WaitForData

;; **** Begin Write Transaction ****
MMC_StartWrite:
     JSR MMC_DoCommand
     BNE errWrite
     JMP MMC_SendingData

errRead:
     ORA #$40  ;; Setting bit 6 in the fault code will ensure it's printed
     TAX
     JSR GenerateErrorSuffX ;; This version prints the fault code in X
     .byte $C5
     .byte "MMC Read fault"
     .byte $00

errWrite:
     ORA #$40  ;; Setting bit 6 in the fault code will ensure it's printed
     TAX
     JSR GenerateErrorSuffX ;; This version prints the fault code in X
     .byte $C5
     .byte "MMC Write fault"
     .byte $00


;; **** Set-up MMC command sequence ****
;; C=0 for read, C=1 for write
MMC_SetupRW:
     LDA #write_block
     BCS MMC_SetCommand
     LDA #read_single_block

;; **** Reset MMC Command Sequence ****
;; A=cmd, token=&FF

MMC_SetCommand:
     STA MMC_CMDSEQ+1
     LDA #0
     STA MMC_CMDSEQ+2
     STA MMC_CMDSEQ+3
     STA MMC_CMDSEQ+4
     STA MMC_CMDSEQ+5
     LDA #$FF
     STA MMC_CMDSEQ
     STA MMC_CMDSEQ+6                   ;; token
     STA MMC_CMDSEQ+7
     RTS


.else


; MMC_BEGIN - Initialise MMC card
; *******************************
; Returns EQ, A=0 ok
;         NE, A=MMC error code, failed
; Corrupts X,Y
.proc MMC_BEGIN

	JSR MMC_DEVICE_RESET	; Reset device
	BIT MMC_MMCSTATE		; Check if MMC initialised
	BVC MMC_INIT		; Card needs initialising
	LDA #$00		; Return A='ok'
	RTS
.endproc

.endif


; MMC_INIT - Initialise MMC card
; ******************************
; Returns EQ, A=0 if ok
;         NE, A=ADFS error code, card can't be initialised
; Corrupts X,Y
MMC_INIT:

.if .def(USE65C12) && (!.def(HD_MMC_HOG))    ; TODO Reinstate for HOG
     STZ MMC_MMCSTATE
.else
     LDA #0
     STA MMC_MMCSTATE
.endif

     LDA #MMC_TRYS
     STA MMC_ATTEMPTS

     ;; 80 Clocks
iloop:
     LDY #10
     JSR MMC_Clocks

     ;; CMD0
     LDA #go_idle_state
     JSR MMC_SetCommand
     LDA #$95
     STA MMC_CMDSEQ+6                   ; token (crc7)
     JSR MMC_DoCommand
     AND #$81                        ; ignore errors
     CMP #1                          ; b0='idle state'

.ifdef HD_MMC_HOG       ; TODO: reinstate JGH?
          beq  il0
          jmp  ifail
.else
     SEC
     BNE il10                        ; not idle, fail this attempt
.endif
il0:
     LDA #$01
     STA MMC_CARDSORT
     LDA #$48
     JSR MMC_SetCommand
     LDA #$01
     STA MMC_CMDSEQ+4
     LDA #$AA
     STA MMC_CMDSEQ+5
     LDA #$87
     STA MMC_CMDSEQ+6
     JSR MMC_DoCommand
     CMP #1
     BEQ isdhc

     LDA #$02
     STA MMC_CARDSORT
il1:
     ;; CMD1
     LDA #send_op_cond
     JSR MMC_SetCommand
     JSR MMC_DoCommand
     CMP #2                          ; anything other than 'idle'
il10:

.ifdef HD_MMC_HOG       ; TODO: reinstate JGH?
          bcc  il11
          jmp  ifail
.else
          bcs ifail                       ; not idle, fail this attempt
.endif

il11:
     BIT EscapeFlag                  ; may hang
     BMI ifail
     CMP #0
     BNE il1                         ; not 'ok', try again
     LDA #$02
     STA MMC_CARDSORT

.ifdef HD_MMC_HOG  ; TODO: REINSTATE JGH
          jmp  iok
.else
     BNE iok
.endif

isdhc:
     JSR UP_ReadByteX
     JSR UP_ReadByteX
     JSR UP_ReadByteX
     JSR UP_ReadByteX
isdhc2:
     LDA #$77
     JSR MMC_SetCommand
     JSR MMC_DoCommand
     LDA #$69
     JSR MMC_SetCommand
     LDA #$40
     STA MMC_CMDSEQ+2
     JSR MMC_DoCommand
     CMP #$00
     BNE isdhc2
     LDA #$7A
     JSR MMC_SetCommand
     JSR MMC_DoCommand
     CMP #$00
     BNE ifail
     JSR UP_ReadByteX
     AND #$40
     PHA
     JSR UP_ReadByteX
     JSR UP_ReadByteX
     JSR UP_ReadByteX
     PLA
     BNE iok
     LDA #2
     STA MMC_CARDSORT

     ;; Set blklen=512
iok:
     LDA #set_blklen
     JSR MMC_SetCommand
     LDA #2
     STA MMC_CMDSEQ+4
     JSR MMC_DoCommand
     BNE blkerr

     ;; All OK!
     LDA #$40
     STA MMC_MMCSTATE

.ifdef HD_MMC_HOG  ; TODO: reinstate JGH - along with all error checks
          clc
.else
          lda  #$00     ;; A=0, EQ=Ok
.endif
     RTS

ifail:
     ;; Try again?
     DEC MMC_ATTEMPTS
     BEQ ifaildone
     JMP iloop

ifaildone:
.ifdef HD_MMC_HOG       ; TODO: check this isn't done elsewhere?
          sec
          rts
.endif
blkerr:

.ifdef HD_MMC_HOG
          JSR       GenerateErrorNoSuff
          .byte      $CD
          .byte      "MMC Set block len error"
          .byte      $00
.else

translate_error:
     LDX #$FF
translate_lp:
     INX
     LSR A
     BCC translate_lp
     LDA translate_table,X
     RTS        ;; NE=Failed, return ADFS error code
     ; MMC_DoCommand R1 response codes
translate_table:
     .byte $00	; b0 = In idle state        -> No error
     .byte $2F	; b1 = Erase reset          -> Abort
     .byte $27	; b2 = Illegal command
     .byte $20	; b3 = Command CRC error
     .byte $05	; b4 = Erase Sequence error -> Malformed command
     .byte $21	; b5 = Address error
     .byte $24	; b6 = Parameter error
     .byte $7F	; b7 = 0                    -> Unknown

.endif

.ifdef HD_MMC_HOG            ; TODO - merge this with the section above in own file?

.proc MMC_BEGIN

     PHA
     ;; Reset device
     JSR MMC_DEVICE_RESET

     ;; Check if MMC initialised
     ;; If not intialise the card
     BIT MMC_MMCSTATE
     BVS beg2

     PHX
     PHY
     JSR MMC_INIT
     PLY
     PLX
     BCS carderr
beg2:
     PLA
     RTS

;; Failed to initialise card!
carderr:
     JSR GenerateErrorNoSuff
     .byte $CD
     .byte "Card?"
     .byte $00

.endproc


.endif

.ifndef HD_MMC_HOG       ; TODO - merge this with the section above in own file?

; **** Begin Read Transaction ****
; On exit, EQ=Ok
;          NE, A=translated error code
MMC_StartRead:
     JSR MMC_DoCommand
     BNE translate_error
     JMP MMC_WaitForData

; **** Begin Write Transaction ****
; On exit, EQ=Ok
;          NE, A=translated error code
MMC_StartWrite:
     JSR MMC_DoCommand
     BNE translate_error
     JMP MMC_SendingData


;; **** Set up MMC command sequence ****
;; Cy=0 for read, Cy=1 for write
;; X,Y preserved, A corrupted
MMC_SetupRW:
     LDA #write_block
     BCS MMC_SetCommand
     LDA #read_single_block

;; **** Reset MMC Command Sequence ****
;; A=cmd, token=&FF
MMC_SetCommand:
     STA MMC_CMDSEQ+1
.if USE65C12
     STZ MMC_CMDSEQ+2
     STZ MMC_CMDSEQ+3
     STZ MMC_CMDSEQ+4
     STZ MMC_CMDSEQ+5
.else
     LDA #0
     STA MMC_CMDSEQ+2
     STA MMC_CMDSEQ+3
     STA MMC_CMDSEQ+4
     STA MMC_CMDSEQ+5
.endif
     LDA #$FF
     STA MMC_CMDSEQ+0
     STA MMC_CMDSEQ+6                   ;; token
     STA MMC_CMDSEQ+7
     RTS

.endif


;; Set Random/Command Address
;; **************************
;; Translate the sector number into a SPI Command Address
;; Sector number is in 256 bytes sectors which are stretched to become 512 byte sectors
;; For SDHC cards this is in blocks (which are also sectors)
;; For SD cards this needs converting to bytes by multiplying by 512

;; (&B0) + 8 is the LSB
;; (&B0) + 6 is the MSB
;; MMC_CMDSEQ+5 is the LSB
;; MMC_CMDSEQ+2 is the MSB

;; Set MMC Command Address from random access index
;; ************************************************
;; On entry, X=>offset from &C200 to random access info
;; On exit,  EQ A=0  - ok
;;           NE A<>0 - failed, returns ADFS error code
;; Corrupts X,Y
.proc setRandomAddress


.ifdef HD_MMC_HOG            ; TODO: reinstate JGH
          phx
          lda   #0         ;; MSB of sector number
          pha
          lda   $C203,X
          pha
          lda   $C202,X
          pha
          lda   $C201,X    ;; LSB of sector number
          pha
          bra   setAddressFromStack
.else
          lda  #0         ;; b24-b31 of sector number
          pha
          ldy  #3         ;; 3 bytes for remainder of sector number
loop:
          lda  $C203,X    ;; byte 2/1/0 of sector number
          pha            ;; stack it
          dex
          dey
          bne  loop
          bra  setAddressFromStack
.endif

.endproc

;; Set MMC Command Address from (&B0),control block
;; ************************************************
;; On exit,  EQ A=0  - ok
;;           NE A<>0 - failed
;; Corrupts X,Y
.proc setCommandAddress

.ifdef HD_MMC_HOG       ; TODO: reinstate JGH
    PHX
    LDA #0          ;; MSB of sector number
    PHA
    LDY #6          ;; Point to sector MSB in the control block
    LDX #3          ;; sector number is 3 bytes
loop:
    LDA ($B0), Y    ;; Stack the MSB first, LSB last
    PHA
    INY
    DEX
    BNE loop

.else

    LDA #0         ;; b24-b31 of sector number
    PHA
    LDY #6         ;; Point to sector b16-b23 in the control block
loop:
    LDA ($B0), Y    ;; Stack the MSB first, LSB last
    PHA
    INY
    CPY #9
    BNE loop
.endif
.endproc

; Stack now has -> b0-b7, b8-b15, b16-b23+drive, &00
setAddressFromStack:

;; Process the drive number
     TSX
     LDA $103,X     ;; Bits 7-5 are the drive number
     PHA
     ORA $C317      ;; Add in current drive
     STA $C333      ;; Store for any error

     CLC            ;; Rotate into bits 0-2
     ROL A
     ROL A
     ROL A
     ROL A
     AND #$07
     CMP MMC_NUMDRIVES ;; check against number of ADFS partitions found
     BCS invalidDrive

     ASL A          ;; Shift into bits 4-2 to index the drive table
     ASL A
     TAY            ;; Y will be used to index the drive table

     PLA            ;; Mask out the drive number, leaving just the MS sector
     AND #$1F
     STA $103, X    ;; Store back into sector on stack

     CLC
addDriveOffset:
     LDA $101, X
     ADC MMC_DRIVETABLE, Y
     STA $101, X
     INX
     INY
     TYA
     AND #$03
     BNE addDriveOffset

.ifdef HD_MMC_HOG  ; TODO: compare and reinstate JGH?
     LDX #3          ;; sector number is 4 bytes
;;
     LDA MMC_CARDSORT   ;; Skip multiply for SDHC cards (cardsort = 01)
     CMP #2
     BNE setCommandAddressSDHC
;;
;; Convert to bytes by multiplying by 512
;;
     CLC
loop:                ;; for SD the command address is bytes
     PLA
     ROL A
     STA MMC_CMDSEQ+1, X
     DEX
     BNE loop
     STZ MMC_CMDSEQ+5   ;; LSB is always 0
     BCS overflow    ;; if carry is set, overflow has occurred
     PLA             ;; if the MS byte of the original sector
     BNE overflow    ;; was non zero, overflow has occurred
     PLX
     RTS
.else
     ;; Usefully, X now points to end of stacked data
     LDA MMC_CARDSORT   ;; Need to skip multiply for SDHC cards (cardsort = 01)
     TAY
     DEY             ;; Y=&00 no multiply needed, Y<>&00 multiply needed
     LDX #4          ;; sector number is 4 bytes
     CLC
loop:
     PLA
     INY
     DEY
     BEQ nomult      ;; Multiply not needed
     ROL A
nomult:
     STA MMC_CMDSEQ+1, X
     DEX
     BNE loop
     BCS overflow    ;; if carry is set, overflow has occurred
     LDA #$00        ;; A=0, EQ, Ok
     STA MMC_CMDSEQ+5   ;; LSB is always 0
     RTS
.endif

.ifdef HD_MMC_HOG

invalidDrive:
     JSR GenerateErrorNoSuff        ;; Generate error
     .byte $A9         ;; ERR=169
     .byte "Invalid drive"
     .byte $00

overflow:
     JSR GenerateErrorNoSuff        ;; Generate error
     .byte $A9         ;; ERR=169
     .byte "Sector overflow"
     .byte $00


.proc setCommandAddressSDHC

loop:                ;; for SDHC the command address is sectors
     PLA             ;; copy directly to MMC_CMDSEQ+2 ...MMC_CMDSEQ+5
     STA MMC_CMDSEQ+2, X
     DEX
     BPL loop
     PLX
     RTS
.endproc

.else
invalidDrive:
      TXS           ; Step past stacked data
      LDA #$25      ; A='Invalid drive number'
      RTS

overflow:
      LDA #$21      ; A='Sector out of range'
      RTS


.endif


.ifdef HD_MMC_HOG  ; TODO: compare and REINSTATE JGH

.proc incCommandAddress

     LDA MMC_CARDSORT
     CMP #2
     BNE incCommandAddressSDHC
;; Add 512 to address (Sector always even)
     INC MMC_CMDSEQ+4
incMS:
     INC MMC_CMDSEQ+4
     BNE incDone
     INC MMC_CMDSEQ+3
     BNE incDone
     INC MMC_CMDSEQ+2
incDone:
     RTS

;; Add one to address
incCommandAddressSDHC:
     INC MMC_CMDSEQ+5
     BEQ incMS
     RTS
.endproc


.else

;; Update sector address
;; *********************
.proc incCommandAddress

     LDA MMC_CARDSORT
     CMP #2
     BEQ incAddr    ; &02   - add &200
     LDA #1         ; <>&02 - add &100
incAddr:
     CLC
     ADC MMC_CMDSEQ+5
     STA MMC_CMDSEQ+5
     BCC incDone
     INC MMC_CMDSEQ+4
     BNE incDone
     INC MMC_CMDSEQ+3
     BNE incDone
     INC MMC_CMDSEQ+2
incDone:
     RTS
.endproc

.endif


.proc initializeDriveTable

; Load 512b sector 0 (MBR) to &C000-&C1FF
; Normally MBR resides here, but we do this before MBR is loaded
; We can't use OSWORD &72 to do this, as we don't want alternative bytes skipped
; This is done during filing system selection, so generating errors would leave
; system in an inconsistant state.
;
; This MUST be able to terminate if the hardware is absent.
;
     JSR MMC_BEGIN      ; Initialize the card, if not already initialized
.ifndef HD_MMC_HOG       ; TODO: REINSTATE JGH?
     BNE init_exit	; Couldn't initialise
.endif
     CLC                ; C=0 for Read
     JSR MMC_SetupRW
     JSR MMC_StartRead
.ifndef HD_MMC_HOG       ; TODO: REINSTATE JGH?
     BNE init_exit	; Couldn't read
.endif
     LDA #<MMC_MBRSECTOR
     STA MMC_DATPTR + 0
     LDA #>MMC_MBRSECTOR
     STA MMC_DATPTR + 1
     JSR MMC_Read512
     JSR MMC_16Clocks	;; ignore CRC

     LDA MMC_MBRSECTOR + $1FE
     CMP #$55
     BNE noMBR
     LDA MMC_MBRSECTOR + $1FF
     CMP #$AA
     BNE noMBR

;; Partition entry 0 is 1BE
;; Partition entry 1 is 1CE
;; Partition entry 2 is 1DE
;; Partition entry 3 is 1EE

;; Partition entry has following structure
;; 00 = status (whether bootable)
;; 01-03 = CHS address of first absolute sector in partition
;; 04 = partition type (AD for ADFS)
;; 05-07 = CHS address of last absolute sector in partition
;; 08-0B = LBA of first absolute sector in partition
;; 0C-0F = Number of sectors in partition

     LDA #<(MMC_MBRSECTOR + $1BE)  ;; The start of the first partition entry
     STA MMC_DATPTR+0              ;; is offset &1BE into the MBR
     LDA #>(MMC_MBRSECTOR + $1BE)
     STA MMC_DATPTR+1

     LDX #(MAX_DRIVES * 4)      ;; Clear the drive table
loop:
     STZ MMC_DRIVETABLE - 1, X     ;; all zeros is treated as an invalid drive
     DEX
     BNE loop

.ifdef HD_MMC_HOG       ; TODO: reinstate JGH
     STZ MMC_NUMDRIVES             ;; clear the number of drives
.else
     STX MMC_NUMDRIVES             ;; clear the number of drives
.endif

testPartition:
     LDY #$04
     LDA (MMC_DATPTR),Y
     CMP #$AD                   ;; ADFS = partition type AD
     BNE nextPartition
     INC MMC_NUMDRIVES
     LDY #$08
copyLBA:
     LDA (MMC_DATPTR),Y            ;; Read the LBA from the partition entry
     STA MMC_DRIVETABLE, X         ;; Store it in the drive table
     INX
     INY
     CPY #$0C
     BNE copyLBA
     CPX #(MAX_DRIVES * 4)
     BEQ done

nextPartition:
     CLC
     LDA MMC_DATPTR               ;; Move to the next partition entry
     ADC #$10
     STA MMC_DATPTR
     CMP #$FE                   ;; &FE = &BE + &10 * 4
     BNE testPartition

.ifdef HD_MMC_HOG  ; TODO: REINSTATE JGH?
done:
     CPX #0                     ;; Did we find any ADFS partitions?
     BEQ noADFS                 ;; No, then fatal error
     RTS

noMBR:
     JSR GenerateErrorNoSuff
     .byte $CD
     .byte "No MBR!"
     .byte $00

noADFS:
     JSR GenerateErrorNoSuff
     .byte $CD
     .byte "No ADFS partitions!"
     .byte $00
.endproc


.else

done:
     TXA                        ;; Did we find any ADFS partitions?
     BEQ noADFS                 ;; No, then fatal error
     LDA #$00			;; A='Ok'
init_exit:
     RTS

noMBR:
     LDA #$01			;; A='No Master Boot Record'
     RTS
noADFS:
     LDA #$1C			;; A='No ADFS partitions'
     RTS
.endproc

.endif
