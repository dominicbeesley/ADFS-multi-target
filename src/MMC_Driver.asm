; ADFS MMC Card Driver
; (C) 2015 David Banks
; Based on code from JGH's IDE Patch
;
; 27-Mar-2016 JGH: Tweeked comments
; JSR MMC_BEGIN exits on failure
; JSR setCommandAddress exits on failure


;;; MMC settings
_VIA_BASE  =VIABASE             ; Base Address of 6522 VIA
_TURBOMMC  =0                   ; 1 = build for TurboMMC, and enable PB2-4 as outputs
MAX_DRIVES          = 2         ; Don't make this bigger than 2 or the drive table below will overflow

attempts%           = &C2E9     ; 1 byte
sectorcount%        = &C2EA     ; 1 byte
cardsort%           = &C2EB     ; 1 byte
mmcstate%           = &C2EC     ; 1 byte
numdrives%          = &C2ED     ; 1 byte
cmdseq%             = &C2F0     ; 8 bytes
drivetable%         = &C2F8     ; 4 * MAX_DRIVES
mbrsector%          = &C000     ; 512 bytes tmp storage before fs is mounted
datptr%             = &B2
EscapeFlag          = &FF
;;;;

;TODO: do we need B0 here at all - isn't it always from WKSP_215...?
;TODO: free up B0 and use for temp vars instead of WKSP?

;;
;; Hard drive hardware is present. Check what drive is being accessed.
;;
.HD_Command
              ldy    #&06
              lda    (&B0),Y                            ; Get drive
              ora    WKSP_ADFS_317_CURDRV        ; OR with current drive
IF FLOPPY
              bmi    CommandExecFloppyOp         ; Jump back with 4,5,6,7 as floppies
ENDIF
;;
;; Access a hard drive via the SCSI API
;; ------------------------------------
              ldy    #&00

IF HD_MMC_HOG
              nop
ENDIF

              include "TubeCheckAddrAndClaim.asm"

; Do a data transfer to/from a hard drive device
; ----------------------------------------------


; Do a data transfer
       LDY #5           ; Get command
       LDA (&B0),Y
       CMP #&09		; CC=Read, CS=Write
       AND #&FD         ; Jump if Read (&08) or Write (&0A)
       EOR #&08
       BEQ CommandOk
       LDA #&27         ; Return 'unsupported command' otherwise
       BRA CommandExit

.CommandOk
       BIT &CD		; Check ADFS status byte
       BVC CommandStart ; Accessing I/O memory
       PHP
       PHX
       LDX #&27         ; Point to address in control block
       LDY #&C2
       LDA #0           ; Set Tube action
       ROL A		; A=0/1 for Read/Write
       EOR #1		; A=1/0 for Read/Write
       JSR TubeStartXfer406	; Start Tube transfer
       PLX
       PLP

.CommandStart
       PHP		; Save Read/Write in Carry
       JSR MMC_BEGIN    ; Initialize the card, if not already initialized
IF NOT(HD_MMC_HOG)
       BNE CommandExit1	; Exit if failed to initialise
ENDIF
       PLP
       PHP              ; Get the the carry flag back: C=0 for read, C=1 for write
       JSR MMC_SetupRW
       JSR setCommandAddress
IF NOT(HD_MMC_HOG)
       BNE CommandExit1	; Exit if failed to select
ENDIF
       LDY #9
       LDA (&B0), Y     ; Get the number of sectors to be transferred
       STA sectorcount%

.SectorLoop
       PLP              ; Get the Read/Write flag back to Carry
       PHP
       BCC SectorRead

.SectorWrite
       JSR MMC_StartWrite
IF NOT(HD_MMC_HOG)
       BNE CommandExit1	; Exit if failed to start
ENDIF
       JSR MMC_Write256
       JSR MMC_EndWrite
       BRA SectorNext

.SectorRead
       JSR MMC_StartRead
IF NOT(HD_MMC_HOG)
       BNE CommandExit1	; Exit if failed to start
ENDIF
       JSR MMC_Read256
       JSR MMC_16Clocks	;; ignore CRC

.SectorNext             ;; Update command block to point to next sector
IF HD_MMC_HOG
       JSR    incCommandAddress
ENDIF
       INC &B3          ;; Increment the MSB of I/O transfer address
       INC &C228        ;; Increment Tube address
       BNE TubeAddr
       INC &C229
       BNE TubeAddr
       INC &C22A
.TubeAddr
IF NOT(HD_MMC_HOG)
       JSR incCommandAddress	; Increment MMC sector
ENDIF
       DEC sectorcount%		; Decrement number to do
       BNE SectorLoop		; Loop for all sectors

IF HD_MMC_HOG
.CommandExit1
       PLP
.CommandExit2
       LDA #0
ELSE
       LDA #0			; If we've got to here, all must be ok
.CommandExit1
       PLP		; Drop Carry
ENDIF
.CommandDone
.CommandExit
       PHA
       JSR TubeRelease      ; Release Tube
       PLA
       LDX &B0              ; Restore registers
       LDY &B1
       AND #&7F		; Set EQ flag from result
       RTS


              include       "TubeStartXfer.asm"


