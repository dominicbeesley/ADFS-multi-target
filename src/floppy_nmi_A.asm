		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"
		.include "nmivars.inc"

		.export FloppyRestTrk0
		.export FloppySetSide1
		.export LBD1E
		.export LBD24
		.export LBD46
		.export LBD4B
		.export LBD50

		.segment "floppy_nmi_A"


LBD1E:		bit	$A1
		bmi	LBD2F
		lda	$A3
LBD24:		cmp	#$14
		lda	#$A0
		bcc	LBD31
		ora	NMIVARS_CMD_PRECOMP
		bne	LBD31				; always!?
LBD2F:		lda	#$80
LBD31:

.ifndef ELK_100_FLOPPY
		jsr	ORA4_if_2E4_b0
		sta	FDC_CMD				; FDC Status/Command
.endif
		jmp	FloppyWaitNMIFinish
	;; TODO: this block looks to be pretty redundant!
	.ifndef IDE_HOG_TMP
;;
.ifdef USE65C12
		lda	#FDCSIDE
		trb	NMIVARS_SIDE			; Set side 0
.else
		lda	NMIVARS_SIDE			; Set side 0
		and	#FDCSIDE ^ $FF
		sta	NMIVARS_SIDE
.endif
		rts
	.endif
;;
FloppySetSide1:
.ifdef USE65C12
		lda	#FDCSIDE
		tsb	NMIVARS_SIDE			; Set side 1
.else
		lda	NMIVARS_SIDE			; Set side 1
		ora	#FDCSIDE
		sta	NMIVARS_SIDE
.endif
		rts
;;
LBD46:
.ifdef USE65C12
		lda	#$01
		trb	$A2
.else
		ror	$A2
		clc
		rol	$A2
.endif
		rts

LBD4B:
.ifdef USE65C12
		lda	#$08
		trb	$A2
.else
		lda	$A2
		and	#$08 ^ $FF
		sta	$A2
.endif
		rts
;;
LBD50:
.ifdef USE65C12
		lda	#$02
		trb	$A2
.else
		lda	$A2
		and	#$02 ^ $FF
		sta	$A2
.endif
		rts

;;
FloppyRestTrk0:
.ifdef ELK_100_FLOPPY
		lda	#$04
.else
		lda	#$00
.endif
		sta	$A3
		ora	NMIVARS_FDC_CMD_STEP
.ifndef ELK_100_FLOPPY
		sta	FDC_CMD				; FDC Status/Command
.endif

.ifdef ELK_100_FLOPPY
		jmp	FloppyWaitNMIFinish2elk
.else
		jmp	FloppyWaitNMIFinish
.endif


