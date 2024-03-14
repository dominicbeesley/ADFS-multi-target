;;
;; Copy NMI code to NMI space
;; --------------------------
.CopyCodeToNMISpace
		ldy	#NMICODELEN - 1
.LBC1A		lda	NMICODE_START,Y			; Copy NMI code to NMI space
		sta	NMI,Y
		dey
		bpl	LBC1A
		ldy	#&01
		lda	(&B0),Y
		sta	NMI + NMICODE_RD_OFFS + 1	; Set initial dest address
		iny
		lda	(&B0),Y
		sta	NMI + NMICODE_RD_OFFS + 2
		bit	&A1
		bmi	LBC39				; Keep AND #&1F if reading
		lda	#&5F				; Change to AND #&5F for writing
		sta	NMI + NMICODE_STATMASK_OFFS
.LBC39		bit	ZP_ADFS_FLAGS
		bvc	LBC48				; Jump if not Tube transfer
		lda	&A1
		and	#&FD				; Clear bit 1 if Tube transfer
		sta	&A1
		jsr	LBC54
		bmi	LBC4B
.LBC48		jsr	LBC83				; Modify code if writing
.LBC4B		sta	NMIVAR_WTF			; $80 for read, addr hi for write?!? TODO: investigate if this is needed!
		lda	ZP_MOS_CURROM
		sta	NMI + NMICODE_ROMOFFS
		rts
;;
;;
.LBC54		lda	&A1
		rol	A				; Copy write/read into Carry
		lda	#&00
		rol	A				; A=0/1 for write/read
		ldy	#>WKSP_ADFS_227_TUBE_XFER
		ldx	#<WKSP_ADFS_227_TUBE_XFER
		jsr	&0406				; Start Tube transfer
		lda	&A1
		and	#&10
		beq	LBC76
		bit	&A1
		bmi	LBC77				; Jump to copy Tube Read code
		ldy	#&07
.LBC6D		lda	NMITUBEWRCODE,Y			; Copy Tube Write code
		sta	NMI + NMICODE_WR_OFFS,Y
		dey
		bpl	LBC6D
.LBC76		rts
;;
.LBC77		ldy	#NMI_TUBE_RD_CODE_LEN - 1
.LBC79		lda	NMITUBERDCODE,Y			; Copy Tube Read code
		sta	NMI + NMICODE_WR_OFFS,Y
		dey
		bpl	LBC79
		rts
;;
.LBC83		bit	&A1
		bmi	LBC9F				; Exit if reading
		ldy	#NMI_WRITE_CODE_LEN-1
.LBC89		lda	NMIWRITECODE,Y			; Change transfer code for writing
		sta	NMI + NMICODE_WR_OFFS,Y
		dey
		bpl	LBC89
		ldy	#&01
		lda	(&B1-1),Y
		sta	NMI + NMICODE_WR_OFFS + 1	; Set initial source address
		iny
		lda	(&B1-1),Y
		sta	NMI + NMICODE_WR_OFFS + 2
.LBC9F		rts


; NMI code, copied to &0D00
; -------------------------
; DO NOT ATTEMPT TO OPTIMISE!
.NMICODE_START		
		pha
		lda	FDC_CMD				; FDC Status/Command
		and	#&1F				; #&1F or #&5F
NMICODE_STATMASK_OFFS = P% - NMICODE_START - 1
		cmp	#&03
		bne	LBCBA
.NMICODE_RW
NMICODE_WR_OFFS = P% - NMICODE_START
; vvvv this part changed for writing
		lda	FDC_DATA			; FDC Data
NMICODE_RD_OFFS = P% - NMICODE_START
		sta	&FFFF				; Replaced with destination address
		inc	NMI + NMICODE_RD_OFFS + 1
		bne	LBCB8
		inc	NMI + NMICODE_RD_OFFS + 2
; ^^^^
.LBCB8		pla
		rti
;;
.LBCBA		and	#&58				; Check b3, b4, b6 (CRC, Not Found, Write Prot)
		beq	LBCCA				; No error
		sta	&A0				; Store as floppy error
IF USE65C12
		lda	#&01
		tsb	&A1
ELSE
		ror	&A1
		sec
		rol	&A1
ENDIF
.LBCC4
IF USE65C12
		lda	#&01
		tsb	&A2
ELSE
		ror	&A2
		sec
		rol	&A2

ENDIF
		pla
		rti
;;
.LBCCA		bit	&A2
		bvc	LBCC4
		lda	ZP_MOS_CURROM
		pha					; Save current ROM
		lda	#&00				; Replaced with ADFS ROM number
NMICODE_ROMOFFS = P% - NMICODE_START - 1
		sta	ZP_MOS_CURROM			; Page in ADFS ROM
IF TARGETOS = 0
		sta	&FE30				; TODO: Ask JGH - I'm sure this is wrong!
ELSE
		sta	ROMSEL
ENDIF
IF USE65C12
		phx
ELSE
		txa
		pha
ENDIF
		jsr	LBE77				; Call code in ADFS ROM
IF USE65C12
		plx
ELSE
		pla
		tax
ENDIF
		pla
		sta	ZP_MOS_CURROM				; Restore ROM
IF TARGETOS = 0
		sta	&FE30				; TODO: Ask JGH - I'm sure this is wrong!
ELSE
		sta	ROMSEL
ENDIF
		pla
		rti

;;.NMICODE_END
NMICODELEN = P% - NMICODE_START

;;
.FloppyWaitNMIFinish		
		lda	&A2
		ror	A
		bcc	LBCEB
		rts
;;
.LBCEB		lda	NMIVARS_FLAGS_SAVE
		and	#ADFS_FLAGS_FSM_INCONSISTENT
		beq	FloppyWaitNMIFinish
		bit	ZP_MOS_ESCFLAG
		bpl	FloppyWaitNMIFinish
IF USE65C12
		stz	DRVSEL				; Drive control
ELSE
		lda	#0
		sta	DRVSEL				; Drive control
ENDIF
		lda	#&6F				; Floppy error &2F (Abort)
		sta	&A0
		jmp	FloppyErrorA0or2E3

IF HD_SCSI2 AND USE65C12
.delay32	jsr	delay16
.delay16	jsr	delay8
.delay8		jsr	delay4
.delay4		rts
ENDIF


;;
; NMI code for writing, copied to &0D0A
; -------------------------------------
; DO NOT ATTEMPT TO OPTIMISE!
.NMIWRITECODE	lda	&FFFF
		sta	FDC_DATA			; FDC Data register
		inc	NMI + NMICODE_WR_OFFS + 1
		bne	NMIwrsk
		inc	NMI + NMICODE_WR_OFFS + 2
.NMIwrsk
NMI_WRITE_CODE_LEN = P%-NMIWRITECODE

; NMI code for Tube writing, copied to &0D0A
; ------------------------------------------
; DO NOT ATTEMPT TO OPTIMISE!
.NMITUBEWRCODE	
IF TARGETOS = 0						; TODO : reinstate
		sbc	&EDED
ELSE
		lda	TUBEIO
ENDIF
		sta	FDC_DATA			; FDC Data register
		bcs	LBD1C
NMI_TUBE_WR_CODE_LEN = P% - NMITUBEWRCODE

; NMI code for Tube reading, copied to &0D0A
; ------------------------------------------
; DO NOT ATTEMPT TO OPTIMISE!
.NMITUBERDCODE		
		lda	FDC_DATA			; FDC Data register
IF TARGETOS = 0						; TODO : reinstate
		sbc	&EDED
ELSE
		sta	TUBEIO
ENDIF
IF TARGETOS=0 AND HD_SCSI
.LBD1C		EQUB 0,0				; BODGE!
ELSE
.LBD1C		bcs	LBD24
ENDIF
NMI_TUBE_RD_CODE_LEN = P% - NMITUBERDCODE
