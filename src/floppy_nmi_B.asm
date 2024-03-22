		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"
		.include "nmivars.inc"

		.export CopyCodeToNMISpace
		.export FloppyWaitNMIFinish

		.export NMICODE_WR_OFFS
		.export NMICODE_RD_OFFS


		.segment "floppy_nmi_B"

;;
;; Copy NMI code to NMI space
;; --------------------------
CopyCodeToNMISpace:
		ldy	#NMICODELEN - 1
LBC1A:		lda	NMICODE_START,Y			; Copy NMI code to NMI space
		sta	NMI,Y
		dey
		bpl	LBC1A
		ldy	#$01
		lda	($B0),Y
		sta	a:NMI + NMICODE_RD_OFFS + 1	; Set initial dest address
		iny
		lda	($B0),Y
		sta	a:NMI + NMICODE_RD_OFFS + 2
		bit	$A1
		bmi	LBC39				; Keep AND #&1F if reading
		lda	#$5F				; Change to AND #&5F for writing
		sta	a:NMI + NMICODE_STATMASK_OFFS
LBC39:		bit	ZP_ADFS_FLAGS
		bvc	LBC48				; Jump if not Tube transfer
		lda	$A1
		and	#$FD				; Clear bit 1 if Tube transfer
		sta	$A1
		jsr	LBC54
		bmi	LBC4B
LBC48:		jsr	LBC83				; Modify code if writing
LBC4B:		sta	NMIVAR_WTF			; $80 for read, addr hi for write?!? TODO: investigate if this is needed!
		lda	ZP_MOS_CURROM
		sta	a:NMI + NMICODE_ROMOFFS
		rts
;;
;;
LBC54:		lda	$A1
		rol	A				; Copy write/read into Carry
		lda	#$00
		rol	A				; A=0/1 for write/read
		ldy	#>WKSP_ADFS_227_TUBE_XFER
		ldx	#<WKSP_ADFS_227_TUBE_XFER
		jsr	$0406				; Start Tube transfer
		lda	$A1
		and	#$10
		beq	LBC76
		bit	$A1
		bmi	LBC77				; Jump to copy Tube Read code
		ldy	#$07
LBC6D:		lda	NMITUBEWRCODE,Y			; Copy Tube Write code
		sta	NMI + NMICODE_WR_OFFS,Y
		dey
		bpl	LBC6D
LBC76:		rts
;;
LBC77:		ldy	#NMI_TUBE_RD_CODE_LEN - 1
LBC79:		lda	NMITUBERDCODE,Y			; Copy Tube Read code
		sta	NMI + NMICODE_WR_OFFS,Y
		dey
		bpl	LBC79
		rts
;;
LBC83:		bit	$A1
		bmi	LBC9F				; Exit if reading
		ldy	#NMI_WRITE_CODE_LEN-1
LBC89:		lda	NMIWRITECODE,Y			; Change transfer code for writing
		sta	NMI + NMICODE_WR_OFFS,Y
		dey
		bpl	LBC89
		ldy	#$01
		lda	($B1-1),Y
		sta	a:NMI + NMICODE_WR_OFFS + 1	; Set initial source address
		iny
		lda	($B1-1),Y
		sta	a:NMI + NMICODE_WR_OFFS + 2
LBC9F:		rts


; NMI code, copied to &0D00
; -------------------------
; DO NOT ATTEMPT TO OPTIMISE!
NMICODE_START:
		pha
		lda	FDC_CMD				; FDC Status/Command
		and	#$1F				; #&1F or #&5F
NMICODE_STATMASK_OFFS = * - NMICODE_START - 1
		cmp	#$03
		bne	LBCBA
NMICODE_RW:
NMICODE_WR_OFFS = * - NMICODE_START
; vvvv this part changed for writing
		lda	FDC_DATA			; FDC Data
NMICODE_RD_OFFS = * - NMICODE_START
		sta	$FFFF				; Replaced with destination address
		inc	NMI + NMICODE_RD_OFFS + 1
		bne	LBCB8
		inc	NMI + NMICODE_RD_OFFS + 2
; ^^^^
LBCB8:		pla
		rti
;;
LBCBA:		and	#$58				; Check b3, b4, b6 (CRC, Not Found, Write Prot)
		beq	LBCCA				; No error
		sta	$A0				; Store as floppy error
.ifdef USE65C12
		lda	#$01
		tsb	$A1
.else
		ror	$A1
		sec
		rol	$A1
.endif
LBCC4:
.ifdef USE65C12
		lda	#$01
		tsb	$A2
.else
		ror	$A2
		sec
		rol	$A2

.endif
		pla
		rti
;;
LBCCA:		bit	$A2
		bvc	LBCC4
		lda	ZP_MOS_CURROM
		pha					; Save current ROM
		lda	#$00				; Replaced with ADFS ROM number
NMICODE_ROMOFFS = * - NMICODE_START - 1
		sta	ZP_MOS_CURROM			; Page in ADFS ROM
.if TARGETOS = 0
		sta	$FE30				; TODO: Ask JGH - I'm sure this is wrong!
.else
		sta	ROMSEL
.endif
.ifdef USE65C12
		phx
.else
		txa
		pha
.endif
		jsr	LBE77				; Call code in ADFS ROM
.ifdef USE65C12
		plx
.else
		pla
		tax
.endif
		pla
		sta	ZP_MOS_CURROM				; Restore ROM
.if TARGETOS = 0
		sta	$FE30				; TODO: Ask JGH - I'm sure this is wrong!
.else
		sta	ROMSEL
.endif
		pla
		rti

;;.NMICODE_END
NMICODELEN = * - NMICODE_START

;;
FloppyWaitNMIFinish:
		lda	$A2
		ror	A
		bcc	LBCEB
		rts
;;
LBCEB:		lda	NMIVARS_FLAGS_SAVE
		and	#ADFS_FLAGS_FSM_INCONSISTENT
		beq	FloppyWaitNMIFinish
		bit	ZP_MOS_ESCFLAG
		bpl	FloppyWaitNMIFinish
.ifdef USE65C12
		stz	DRVSEL				; Drive control
.else
		lda	#0
		sta	DRVSEL				; Drive control
.endif
		lda	#$6F				; Floppy error &2F (Abort)
		sta	$A0
		jmp	FloppyErrorA0or2E3

.if .def(HD_SCSI2) && .def(USE65C12)
delay32:	jsr	delay16
delay16:	jsr	delay8
delay8:		jsr	delay4
delay4:		rts
.endif


;;
; NMI code for writing, copied to &0D0A
; -------------------------------------
; DO NOT ATTEMPT TO OPTIMISE!
NMIWRITECODE:	lda	$FFFF
		sta	FDC_DATA			; FDC Data register
		inc	NMI + NMICODE_WR_OFFS + 1
		bne	NMIwrsk
		inc	NMI + NMICODE_WR_OFFS + 2
NMIwrsk:
NMI_WRITE_CODE_LEN = * - NMIWRITECODE

; NMI code for Tube writing, copied to &0D0A
; ------------------------------------------
; DO NOT ATTEMPT TO OPTIMISE!
NMITUBEWRCODE:
.ifdef ELK_100_TUBE					; TODO : reinstate
		sbc	$EDED
.else
		lda	TUBEIO
.endif
		sta	FDC_DATA			; FDC Data register
		bcs	LBD1C
NMI_TUBE_WR_CODE_LEN = * - NMITUBEWRCODE

; NMI code for Tube reading, copied to &0D0A
; ------------------------------------------
; DO NOT ATTEMPT TO OPTIMISE!
NMITUBERDCODE:
		lda	FDC_DATA			; FDC Data register
.ifdef ELK_100_TUBE					; TODO : reinstate
		sbc	$EDED
.else
		sta	TUBEIO
.endif
.if TARGETOS=0 && .def(HD_SCSI)
LBD1C:		.byte 0,0				; BODGE!
.else
LBD1C:		bcs	LBD24
.endif
NMI_TUBE_RD_CODE_LEN = * - NMITUBERDCODE
