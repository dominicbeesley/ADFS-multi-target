		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"
		.include "nmivars.inc"

		.export bne_FloppyErrorA0or2E3
		.export FloppyErrorA0or2E3
		.export LBD6E
		.export LBDBA
		.export LBE77
		.export LBF0A
		.export LBF6F
		.export XA_DIV16_TO_YA

		.segment "floppy_nmi_D"

;;
LBD6E:		lda	WKSP_ADFS_2E2
.if TARGETOS=0 && .def(HD_SCSI)
		sta	$CF
		lda	#0
		sta	$CE
.else
		sta	$0D0F
.ifdef USE65C12
		stz	$0D0E
.else
		lda	#0
		sta	$0D0E
.endif
.endif
		jsr	LBAFA
		jsr	LBD1E
		lda	$A3
		pha
		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR
		sta	$A5
		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
		sta	$A6
		lda	#$00
		sta	$A3
		lda	WKSP_ADFS_2E2			; Point &A3/4 to where partial sector loaded
		sta	$A4
		bit	ZP_ADFS_FLAGS
		bvc	LBDAB
		ldy	#$00
LBD99:		lda	($A3),Y
		ldx	#$07
LBD9D:		dex
		bne	LBD9D				; Tube transfer delay
.if TARGETOS = 0 && (!.def(HD_SCSI))
		sbc	$EDED				; TODO: reinstate TUBE
.else
		sta	TUBEIO
.endif
		iny
		cpy	WKSP_ADFS_21E_DSKOPSAV_SECCNT
		bne	LBD99
		beq	LBDB6
LBDAB:		ldy	WKSP_ADFS_21E_DSKOPSAV_SECCNT			; Get partial sector length
LBDAE:		dey
		lda	($A3),Y
		sta	($A5),Y				; Copy to memory
		tya
		bne	LBDAE
LBDB6:		pla
		sta	$A3
		rts

;;
LBDBA:		jsr	LBAFA
.ifdef USE65C12
		lda	#$40
		tsb	$A2
.else
		lda	$A2
		ora	#$40
		sta	$A2
.endif
		ldy	#$07
		lda	($B0),Y				; Sector b8-b15
		sta	NMIVARS_SECTOR_COUNT
		iny
		lda	($B0),Y				; Sector b0-b7
		iny
		clc
		adc	($B0),Y				; Sector count
		sta	NMIVARS_SECTOR			; Sector b0-b7+count
		bcc	LBDD7
		inc	NMIVARS_SECTOR_COUNT		; NMIVARS_SECTOR/8=sector after last sector
LBDD7:		lda	NMIVARS_SECTOR_COUNT
		tax
		lda	NMIVARS_SECTOR
		ldy	#$FF
		jsr	XA_DIV16_TO_YA			; Convert to Y=track, A=sector
		cmp	#$00
		bne	LBDE9				; Not sector 0
		lda	#$10				; Convert sector 0 to pseudo sector &10
LBDE9:		ldy	#$09
		sec
		sbc	($B0),Y				; EndSector - SectorCount
		bcs	LBE0D				; Only one track left to do
		lda	#$10
		sec
		sbc	$A4				; 16-sector = number to do on this track
		sta	NMIVARS_SECTOR_COUNT		; sector count for this track
		lda	($B0),Y				; Get sector count
		sec
		sbc	NMIVARS_SECTOR_COUNT		; Subtract count for this track
		ldx	#$00
		ldy	#$FF
		jsr	XA_DIV16_TO_YA			; Convert to Y=track, A=sector
		sty	NMIVARS_TRACK_COUNT			; Store track about to start at
		sta	NMIVARS_SECTOR			; Store sector about to start at
		bpl	LBE1C
LBE0D:		ldy	#$09
		lda	($B0),Y				; Get sector count
		sta	NMIVARS_SECTOR_COUNT
		lda	#$FF
		sta	NMIVARS_TRACK_COUNT			; track=&FF

.ifdef USE65C12
		stz	NMIVARS_SECTOR			; sector=&00
.else
		lda	#0
		sta	NMIVARS_SECTOR			; sector=&00
.endif

LBE1C:
.ifdef USE65C12
		stz	NMIVARS_SECTORS_THIS_TRACK
.else
		lda	#0
		sta	NMIVARS_SECTORS_THIS_TRACK
.endif
		inc	NMIVARS_TRACK_COUNT
		dec	NMIVARS_SECTOR_COUNT
		ldx	#$01
		jsr	LBB3B				; Set track
		bit	$A1
		bmi	LBE35
.if TARGETOS=0 && .def(HD_SCSI)
		lda	#$A3
		cmp	#$14
		lda	#$A0
		bcc	LBE37
.else
		lda	#$A0				; &A0=writing
.endif
		ora	NMIVARS_CMD_PRECOMP
		bne	LBE37
LBE35:		lda	#$80				; &80=reading
LBE37:		sta	$A6
		jsr	LBD46
		lda	$A6

.if TARGETOS<>0 || (!.def(HD_SCSI))
		sta	FDC_CMD			; FDC Status/Command
.endif

LBE41:		jsr	FloppyWaitNMIFinish
elkLBE4A:	lda	$A2
		and	#$02
		beq	LBE5C
		jsr	LBD46
		jsr	LBD50
		lda	#$54
		ora	NMIVARS_FDC_CMD_STEP
.if TARGETOS<>0 || (!.def(HD_SCSI))
		sta	FDC_CMD				; FDC Status/Command
.endif
		inc	$A3
.if TARGETOS=0 && .def(HD_SCSI)
		jsr	FloppyWaitNMIFinish2elk
		jmp	elkLBE4A
.else
		bne	LBE41
.endif
LBE5C:		lda	$A2
		and	#$08
		beq	LBE90
		jsr	LBD46
		jsr	LBD4B
		inc	$A3
		jsr	FloppySetSide1
.if TARGETOS=0 && .def(HD_SCSI)
		lda	#$04
.else
		lda	#$00
.endif
		ora	NMIVARS_FDC_CMD_STEP
.if TARGETOS=0 && .def(HD_SCSI)
		jsr	FloppyWaitNMIFinish2elk
.else
		sta	FDC_CMD				; FDC Status/Command
.endif

.if TARGETOS=0 && .def(HD_SCSI)
		jmp	elkLBE4A
.else
		bpl	LBE41
.endif

		;;
;; NMI Routine - called from &0D00
;; ===============================
LBE77:		jsr	LBD46
		jsr	LBE91
		txa
		bne	LBE85
.ifdef USE65C12
		lda	#$01
		tsb	$A2
.else
		ror	$A2
		sec
		rol	$A2
.endif
		rts
;;
LBE85:		jsr	LBD50
.if TARGETOS<>0 || (!.def(HD_SCSI))
		lda	$A6
		jsr	ORA4_if_2E4_b0
		sta	FDC_CMD				; FDC Status/Command
.endif
LBE90:		rts
;;
LBE91:		lda	NMIVARS_SECTOR_COUNT
		bne	LBEF8
		lda	NMIVARS_TRACK_COUNT
		bne	LBEAA
		lda	NMIVARS_SECTOR
		bne	LBEA4
		ldx	#$00
		beq	LBF09
LBEA4:		dec	NMIVARS_SECTOR
		jmp	LBEFB
;;
LBEAA:		lda	NMIVARS_SECTORS_THIS_TRACK
		bne	LBEF2

.if TARGETOS<>0 || (!.def(HD_SCSI))
.ifdef USE65C12
		lda	#$01
		tsb	WKSP_ADFS_2E4
.else
		ror	WKSP_ADFS_2E4
		sec
		rol	WKSP_ADFS_2E4
.endif
.endif ; ELK SCSI
		lda	FDC_TRACK			; FDC Track register
		cmp	#$4F
		bcc	LBEDA				; Less than 80
		lda	NMIVARS_SIDE
		and	#FDCSIDE
		beq	LBEC7
		ldx	#$00
		jmp	LBEFD
;;
LBEC7:		lda	#$FF
		sta	$A3
		jsr	FloppySetSide1
		lda	NMIVARS_SIDE
		sta	DRVSEL				; Drive control
		lda	$A2
		ora	#$08
		bne	LBEDE
LBEDA:		lda	$A2
		ora	#$02
LBEDE:		sta	$A2
		dec	NMIVARS_TRACK_COUNT
		beq	LBEEA
		lda	#$10
		sta	NMIVARS_SECTORS_THIS_TRACK
LBEEA:		lda	#$FE
		sta	$A4
		ldx	#$00
		beq	LBEFD
LBEF2:		dec	NMIVARS_SECTORS_THIS_TRACK
		jmp	LBEFB
;;
LBEF8:		dec	NMIVARS_SECTOR_COUNT
LBEFB:		ldx	#$FF
LBEFD:		inc	$A4
LBEFF:		lda	$A4
		sta	FDC_SEC			; FDC Sector register
		cmp	FDC_SEC			; Keep storing until it stays there
		bne	LBEFF
LBF09:		rts


;;
;;   &A0  Returned error, &40+FDC status or &00+HDD error
;;   &A1  b7=write/read, b5=hardware has been accessed, b0=error occured?
;;   &A2  b0=?
;;   &A3
;;   &A4 sector
;;   &A5 track
;;   &A6 drive
;;   &A7
;;
LBF0A:
		ldy	#$06
		lda	($B0),Y				; Get drive
		ora	WKSP_ADFS_317_CURDRV			; OR with current drive
		sta	$A6				; Store drive in &A6
		and	#$1F				; Lose drive bits
		beq	LBF1A				; If sector<&10000, continue
		jmp	LBF6F				; If sector>&FFFF, jump to 'Sector out of range'

;;
LBF1A:		bit	$A6				; Check drive
		bvc	LBF24				; Drive 0,1,4,5 -> jump ahead
;;			    Can patch here to support drive 2,3,6,7
		lda	#$65				; Otherwise, floppy error &25 (Bad drive)
		sta	$A0				; Set error
.ifdef EXTERNAL
		bne	LBF75				; Make external call for 2,3,6,7
.else
		bne	bne_FloppyErrorA0or2E3				; Jump to return error
.endif

;;
;; Drive 0,1,4,5;; -------------
LBF24:		lda	$A6				; Get drive
		and	#$20
		bne	LBF2E				; Drive 1,5 -> jump ahead
		lda	#FDCRES + FDCDS0		; Drive 0,4 -> &05=SDEN+DS0
		bne	LBF30
LBF2E:		lda	#FDCRES + FDCDS1		; Drive 1,5 -> &06=SDEN+DS1
LBF30:		sta	NMIVARS_SIDE			; Store drive control byte

.if TARGETOS<>0 || (!.def(HD_SCSI))
.ifdef USE65C12
		lda	#$01
		tsb	WKSP_ADFS_2E4
.else
		ror	WKSP_ADFS_2E4
		sec
		rol	WKSP_ADFS_2E4
.endif
.endif
		jsr	FloppyCalcTrkSecFromBlkChkRange	; Calculate sector/track
		lda	NMIVARS_SIDE			; Get drive control byte

.if TARGETOS = 0 && (!.def(HD_SCSI))
		lda	DRVSEL				; I'm not sure that this is right! TODO: Ask JGH
.else
		sta	DRVSEL				; Set drive control register
.endif
		ror	A				; Rotate drive 1 bit into carry
		bcc	LBF50				; Jump if drive 0
		lda	WKSP_ADFS_2E5
		sta	$A3
		bit	WKSP_ADFS_2E4
		bpl	LBF5D
		bmi	LBF5A
;;
LBF50:		lda	WKSP_ADFS_2E6
		sta	$A3
		bit	WKSP_ADFS_2E4
		bvc	LBF5D
LBF5A:		jsr	FloppyRestTrk0
LBF5D:		rts

;;
;; Calculate track and sector
;; --------------------------
FloppyCalcTrkSecFromBlkChkRange:
		ldy	#$07
		lda	($B0),Y				; Get sector b8-b15
		cmp	#$0A				; Check for sector &0A00
		bcc	FloppyCalcTrackSectorFromB0blk	; <&A00 - sector within range

.ifndef TRIM_REDUNDANT
							;Bug, the rest of these checks shouldn't happen
							;Should just drop straight into 'Sector out of range'
		bne	LBF6F				; >&AFF - sector out of range
		iny					; Check sector &0Axx for some reason
		lda	($B0),Y				; Get sector b0-b7
		cmp	#$00				; Sector &A00? But CMP #0 will always give CS.
		bcc	LBF75				; Will never follow this jump - should this be BEQ ?
.endif
LBF6F:		lda	#$61				; Floppy error &21 (Bad address)
LBF71:		sta	$A0

; Jump to abort and return floppy error
; -------------------------------------
bne_FloppyErrorA0or2E3:
		bne	FloppyErrorA0or2E3		; Jump to return error in &A0

.ifndef EXTERNAL
; This code never entered, as the above BCC LBF75 is never followed.
; It seems as though it is attempting to check if sector+length would span
; past the end of the disk, but any transfer that starts before the end of
; the disk has already been filtered out and accepted as valid.
LBF75:		lda	$A1				; Get flag
		and	#$10
		beq	FloppyCalcTrackSectorFromB0blk				; If b3=0, do it anyway
		ldy	#$09
		lda	($B0),Y				; Get count
		dey					; Point to sector b0-b7
		clc
		adc	($B0),Y				; A=sector.b0-7 + count
		bcs	LBF89				; >255, jump to volume error
		cmp	#$01
		bcc	FloppyCalcTrackSectorFromB0blk				; sector+count<1 - do it
LBF89:		lda	#$63				; Floppy error &23 (Volume error)
		sta	$A0				; Store error
		bne	FloppyErrorA0or2E3		; Jump to return error
.else
LBF75:		ldx	$B0
		ldy	$B1
		lda	#$76
		jsr	$FFF1
		jmp	FloppyErrorA0or2E3
	.ifndef IDE_HOG_TMP
		.byte	0,0,0,0,0,0,0
		.byte	0,0,0,0,0,0,0
	.endif
.endif

; Sector < &A00, convert to track+sector
; --------------------------------------
FloppyCalcTrackSectorFromB0blk:
.ifndef TRIM_REDUNDANT
		ldy	#$07				; A already holds (&B0),7 if coming from FloppyCalcTrkSecFromBlkChkRange
		lda	($B0),Y				; Get sector b8-b15
.endif
		tax					; Pass to X
		iny
		lda	($B0),Y				; Get sector b0-b7
FloppyCalcTrackSectorFromXA:
		ldy	#$FF
		jsr	XA_DIV16_TO_YA			; Divide by 16
		sta	$A4				; A=sector
		sty	$A5				; Y=track 0-159
		tya
		sec
		sbc	#$50				; Track <80?
		bmi	LBFB6				; Side 0, leave track as 0-79
		sta	$A5				; Store track 0-79
		jmp	FloppySetSide1				; Set side 1

		;
; Divide by 16
; ============
; On entry: A=low byte
;	    X=high byte
;           Y=&FF (this could be moved to subroutine)	; TODO: OPTIMISE LDY#&FF here!?
; On exit:  Y=&XA DIV 16
;	    A=&XA MOD 16
XA_DIV16_TO_YA:
		sec
		sbc	#$10
		iny
		bcs	XA_DIV16_TO_YA
		dex
		bpl	XA_DIV16_TO_YA
		adc	#$10
LBFB6:		rts

; Return result from &A0 (or from &C2E3 if hardware not accessed)
; ---------------------------------------------------------------
FloppyErrorA0or2E3:
.if TARGETOS=0 && .def(HD_SCSI)
		jsr	FloppyElkAfterNMI
.endif
		ldx	WKSP_ADFS_2E7_STKSAVE
		txs					; Reset stack
		lda	WKSP_ADFS_2E0
		and	#$20				; Has drive actually been accessed?
		beq	DRVNOTACC			; b6=0, no drive access, jump to release and return
		lda	NMIVARS_SIDE			; Get drive control byte
		ror	A				; Cy=0 drv1/5, Cy=1 drv0/4
		lda	$A3
		bcc	DR1				; Jump if drive 1/5
		sta	WKSP_ADFS_2E5			; Store
		rol	WKSP_ADFS_2E4
		clc
		ror	WKSP_ADFS_2E4			; Clear b7
		bcs	NOT_DR1				; always
;;
DR1:		sta	WKSP_ADFS_2E6
		lda	WKSP_ADFS_2E4
		and	#$BF
		sta	WKSP_ADFS_2E4			; Clear b6
;;
NOT_DR1:	lda	$A0				; Get error
		sta	WKSP_ADFS_2E3_ERR_NO		; Store in error block
		jsr	LBC0E				; Release NMI
DRVNOTACC:	jsr	TubeRelease			; Release Tube, restore screen
		ldx	$B0
		lda	WKSP_ADFS_2E3_ERR_NO		; Get error
		beq	NOERR				; If zero, jump to return Ok
		ora	#$40				; Set bit 6 to flag FDC error
		ldy	#$FF
		sty	WKSP_ADFS_2E4
NOERR:		ldy	$B1
		and	#$7F				; Remove bit 7 and set EQ
		rts					; Return with A=error, EQ=Ok

