
		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

.ifndef STANDALONE

.segment "starAQR"

.export starAQR_run
starAQR_run:

.else
; standalone program
.segment "program"
; runs at 1F00

start:
		ldx	#$00
printbanner:	lda	strBanner,x
		cmp	#$FF
		beq	L1F0F
		jsr	$FFE3			; OSASCI
		inx
		bne	printbanner

.endif

L1F0F:		lda	$F4
		sta	a:$0000
.ifndef STANDALONE
		dec	a:$0000
.endif
		sta	$FCFD			; Unlock AQR
		lda	#$02			; Check bank 2(/3)
		jsr	checkAQR
		sta	a:$0001
		lda	#$00			; Check bank 0(/1)
		jsr	checkAQR
		sta	a:$0002			; Do we have at least one AQR bank?
		ora	a:$0001
		bne	aqrOK

		brk
		.byte	$00, "No vacant AQR cartridge"
;.ifndef STANDALONE
		.byte	"s"
;.endif
		.byte	" found", $00

aqrOK:
.ifndef STANDALONE
		; Zero out the buffer area
		ldx	#$00
		txa
LA544:		sta	L2300,X
		sta	L2300+$100,X
		sta	L2300+$200,X
		sta	L2300+$300,X
		sta	L2300+$400,X
		sta	L2300+$500,X
		sta	L2300+$600,X
		inx
		bne	LA544
		
		; Now fill it in
		; sectors 0/1 - free space map and misc
		lda	#$07
		sta	L2300
		lda	#$04
		sta	L2300+$FD
		lda	#$0B
		sta	L2300+$FF
		lda	#$F9
		sta	L2300+$100
		lda	#$03
		sta	L2300+$101
		lda	#$AD
		sta	L2300+$1FB
		lda	#$55
		sta	L2300+$1FC
		lda	#$03
		sta	L2300+$1FE
		lda	#$02
		sta	L2300+$1FF
		
		; Hugo signature for root dir header and footer
		ldx	#$04
LA58B:		lda	L1193,x
		sta	L2300+$200,x		; beginning of root dir
		sta	L2300+$6FA,x		; root dir footer
		dex
		bne	LA58B
		; 
		lda	#$24
		sta	L2300+$6CC
		lda	#$0D
		sta	L2300+$6CD 
		lda	#$02
		sta	L2300+$6D6
		
		; TITLE, dir name
		ldx	#$12
LA5A8:		lda	L1198,x
		sta	L2300+$6D9,x
		dex
		bpl	LA5A8
		
		; done
.endif ; !STANDALONE

		lda	a:$0002			; Status of bank 0(/1)
		beq	L1F83
		lda	a:$0001			; Status of bank 2(/3)
		beq	L1F83
		
		;; Make a 512K RAM disc using 2 vacant AQRs
		; Update the disc image
		;  Sector 0, FC/FD/FE - total number of sectors on disk
		;  0x800 (2048 sectors of 256 bytes = 512K)
		lda	#$08
		sta	L2300+$FD
		;  Sector 0, FF - checksum of sector zero
		lda	#$0F
		sta	L2300+$FF
		;  Sector 1, length of free space
		; first free space is 
		lda	#$07
		sta	L2300+$101
		;  Sector 1, FF - checksum of sector one
		lda	#$06
		sta	L2300+$1FF
		; Update *TITLE and success message to say "512K" not "256K"
		lda	#$35			; '5'
		; Sector 
		sta	L2300+$06DE		; TITLE
		sta	strDone			; Success msg
		lda	#$31			; '1'
		sta	L2300+$6DE+1		; TITLE
		sta	strDone+1		; Success msg
		lda	#$32			; '2'
		sta	L2300+$6DE+2		; TITLE
		sta	strDone+2		; Success msg
; Jump straight here if we only have 1 AQR
L1F83:		ldx	#$02			; Get ready to select bank 2
		lda	a:$01			; Status of bank 2(/3) in A
		bne	L1F8C
		ldx	#$00			; Not 2(/3)? select bank 0
; Bank 2(/3) is AQR
L1F8C:		jsr	slctROM
		ldx	#$00			; Initialize loop
						; Also convenient for selecting AQR page 0
		stx	$FCFC			; Select AQR page zero
		stx	$FCFD			; Unlock AQR
L1F97:		lda	L2300,x			; Copy the beginnning of the ADFS image
		sta	$8000,x			; into the AQR
		lda	L2300+$100,x
		sta	$8100,x
		lda	L2300+$200,x
		sta	$8200,x
		lda	L2300+$300,x
		sta	$8300,x
		lda	L2300+$400,x
		sta	$8400,x
		lda	L2300+$500,x
		sta	$8500,x
		lda	L2300+$600,x
		sta	$8600,x
		dex
		bne	L1F97			; Loop

		jsr	rstrROM
		ldx	#$10			; Size of AQR image in pages
						; default to 16
		lda	a:$02			; Status of bank 0(/1)
		beq	L1FD5
		lda	a:$01			; Status of bank 2(/3)
		beq	L1FD5
		ldx	#$20			; 32 pages (2xAQR carts)
L1FD5:		stx	a:$03			; Save number of pages len
		ldx	#$FF
		ldy	#$FF
		lda	a:$01			; Status of bank 2(/3)
		beq	L1FEC
		ldx	#$02			; Bank 0/1 has AQR -> X=2
		lda	a:$02			; Status of bank 0(/1)
		beq	L1FEE
		ldy	#$00			; Bank 2/3 has AQR -> Y=0
		beq	L1FEE
L1FEC:		ldx	#$00			; Bank 0/1 no AQR -> X=0
L1FEE:		stx	a:$04
		sty	a:$05
		lda	$CD			; ADFS status flags
		ora	#$20			; Set AQR flag
		sta	$CD
		
.ifdef STANDALONE
		ldx	$F4			; ADFS ROM number
		lda	$0DF0,x			; (assumes this util run direct from disk)
		cmp	#$BF			; $BF if PRES E00 ADFS
		beq	L2023
; Non-E00 ADFS workspace update
		lda	a:$03
		sta	$10F6
		lda	a:$04
		sta	$10F0
		lda	a:$05
		sta	$10F1
		lda	$111B
		ora	#$80
		sta	$111B
		lda	$1117
		jmp	L2040
.endif

; E00 ADFS workspace update
L2023:		lda	a:$03
		sta	$B3E9
		lda	a:$04			; Bank 0/1
		sta	$B3EA			; 0 if no AQR; 2 if AQR
		lda	a:$05			; Status of bank 2/3
		sta	$B3EB			; FF if no AQR; 0 if AQR
		lda	$B41B
		ora	#$80
		sta	$B41B
		lda	$B417

.ifndef STANDALONE
		cmp	#$FF
		bne	L2040
		lda	#$30
		bne	LA689			; branch always taken
L2040:		and	#$60
		beq	LA693
		lda	#$35			; '5'
LA689:		sta	L20B3			; Drive number
LA693:		ldx	a:$0000
		inx
		jsr	L2062
.else

L2040:		and	#$60
		beq	L2049
		lda	#$35			; '5'
		sta	L20B3			; Drive number

.endif

; Print the success message
L2049:		ldx	#$00
L204B:		lda	strDone,x
		cmp	#$FF
		beq	L2058
		jsr	$FFE3			; OSASCI
		inx
		bne	L204B
L2058:		ldx	#<L20AE			; run the *DIR command
		ldy	#>L20AE			; to go back to the floppy we were on
		jmp	$FFF7			; OSCLI and exit

; Select ROM in $00 (ie restore orig ROM)
rstrROM:
L205F:		ldx	a:$0000
; Select ROM in X
slctROM:
L2062:
.ifdef ELK_PRES_E00_330
		lda	#$0C
.else
		lda	#$0F
.endif
		jsr	L2068
		txa
; Write to ROMSEL
L2068:		sta	$F4
		sta	$FE05
		rts

;; Check a bank for AQR presence

; Bank to check in A on entry
checkAQR:	tax				; Save the bank to check
L206F:		stx	a:$06
		lda	$02A0,x			; Check ROM presense
		ora	$02A1,x			; for both banks
		bne	notAQR			; Not AQR or AQR not empty
		sta	$FCFE			; Lock AQR
		jsr	slctROM
		jsr	testROMwrite
		bne	notAQR			; Not AQR if writable when locked
		sta	$FCFD			; Unlock AQR
		jsr	testROMwrite
		beq	notAQR			; Not AQR if not writable when unlocked
		;; this is AQR...
		lda	#$42			; flag to ADFS that this is AQR ramdisc
		ldx	a:$06
		sta	$0DF0,x			; flag to ADFS that this is AQR ramdisc
		jsr	rstrROM
		lda	#$10			; Signal is AQR
		rts

notAQR:		jsr	rstrROM
		lda	#$00			; Signal not AQR
		rts

; ----------------------------------------------------------------------------
; Test if currently selected ROM is writable
; Returns with Z set if not, clear if yes
testROMwrite:	lda	$8000			; see if we can modify $8000
		inc	$8000
		cmp	$8000
		sta	$8000			; set it back to original contents
		rts

L20AE:		.byte	"DIR :"
L20B3:		.byte	"4.$",$0d

.ifdef STANDALONE
;; Not used in ROM version but still here?
strBanner:
L20B7:
		.byte	22,6			; MODE 6
		.byte	$0d
		.byte	17,0			; COLOR 0 (black fg)
		.byte	17,$87			; COLOR 135 (white bg)
		.byte	"PRES ADFS AQR loader for ADFS 1.10/1.20"
		.byte	17,7			; COLOR 7 (white fg)
		.byte	17,$80			; COLOR 128 (black bg)
		.byte	$0d
		.byte	"(C) 1987 PRES.",$0d
		.byte	$0d,$ff
.endif

strDone:
L20FB:
		.byte	"256K"
strDone2:
L2100:
		.byte	" AQR ADFS disc now ready for use.",$0d
		.byte	"The AQR is now drive 0, and the normal",$0d
		.byte	"drives are numbered 4 and 5.",$0d
		.byte	$0d
		.byte	"Use *MOUNT 0 to access the AQR disc.",$0d
		.byte	$0d,$ff

.ifdef STANDALONE

strLIB:		.byte	"LIB",$0d

.segment "credit"

		.byte	" NAQRMA"
		.byte	$01, $f6, $10

.segment "disc"
;; this is generated by code above in the ROM version

L2300:
;; sector 0
; location of first free space - sector 7
		.byte $07,$00,$00
; next &51 FSM start entries (all zero)
		.res ($51*3), $00
; reserved, used by L3FS/RISC OS
		.res (3*2), $00
; total number of sectors on disk - 1024
		.byte $00,$04,$00
; checksum
		.byte $0b

;; sector 1
; length of first free space - (1024-7)=1017=0x3f9 sectors
		.byte $f9,$03,$00
; next &51 FSM length entries (all zero)
		.res ($51*3), $00
; reserved, used by L3FS/RISC OS
		.res 3, $00
		.res 2, $00
; Disk identifier
		.byte $ad, $55
; Boot option (*OPT 4)
		.byte $00
; Pointer to end of free space list
		.byte $03
; checksum
		.byte $02

;; sectors 2-6 - root dir
; master sequence number
		.byte $00
; signature
		.byte "Hugo"
; 47 empty directory entries
		.res (47*$1a),$00
; footer
		.byte $00
		.byte "$",$0d,$0,$0,$0,$0,$0,$0,$0,$0	; dir name
		.byte $02,$00,$00			; start sector of parent dir
		.byte "ADFS 256K AQR DISC",$0d		; Directory title
		.res 14,$00				; reserved
		.byte $00				; dir master sequence number
		.byte "Hugo"				; signature
		.byte $00

.else
L2300 = $2300

L1193:		.byte 0, "Hugo"
L1198:		.byte "ADFS 256K AQR DISC",$0d

.endif
