.LBD1E		bit	&A1
		bmi	LBD2F
		lda	&A3
.LBD24		cmp	#&14
		lda	#&A0
		bcc	LBD31
		ora	NMIVARS_CMD_PRECOMP
		bne	LBD31				; always!?
.LBD2F		lda	#&80
.LBD31		

IF TARGETOS<>0 OR NOT(HD_SCSI)
		jsr	ORA4_if_2E4_b0
		sta	FDC_CMD				; FDC Status/Command
ENDIF
		jmp	FloppyWaitNMIFinish
;;
IF USE65C12
		lda	#FDCSIDE
		trb	NMIVARS_SIDE			; Set side 0
ELSE
		lda	NMIVARS_SIDE			; Set side 0
		and	#FDCSIDE EOR &FF
		sta	NMIVARS_SIDE
ENDIF
		rts
;;
.FloppySetSide1
IF USE65C12
		lda	#FDCSIDE
		tsb	NMIVARS_SIDE			; Set side 1
ELSE
		lda	NMIVARS_SIDE			; Set side 1
		ora	#FDCSIDE
		sta	NMIVARS_SIDE
ENDIF
		rts
;;
.LBD46
IF USE65C12
		lda	#&01
		trb	&A2
ELSE
		ror	&A2
		clc
		rol	&A2
ENDIF
		rts

.LBD4B
IF USE65C12
		lda	#&08
		trb	&A2
ELSE
		lda	&A2
		and	#&08 EOR &FF
		sta	&A2
ENDIF
		rts
;;
.LBD50
IF USE65C12
		lda	#&02
		trb	&A2
ELSE
		lda	&A2
		and	#&02 EOR &FF
		sta	&A2
ENDIF
		rts

;;
.FloppyRestTrk0		
IF TARGETOS=0 AND HD_SCSI
		lda	#&04
ELSE
		lda	#&00
ENDIF
		sta	&A3
IF OPTIMISE<6
		ora	NMIVARS_FDC_CMD_STEP

IF TARGETOS<>0 OR NOT(HD_SCSI)
		sta	FDC_CMD				; FDC Status/Command
ENDIF	; ELK SCSI

ELSE
		jsr	FloppyORA_STEP_SET_FDC_CMD
ENDIF

IF TARGETOS=0 AND HD_SCSI
		jmp	FloppyWaitNMIFinish2elk
ELSE
		jmp	FloppyWaitNMIFinish
ENDIF


IF OPTIMISE>=6
.FloppyORA_STEP_SET_FDC_CMD
		ora	NMIVARS_FDC_CMD_STEP
		sta	FDC_CMD				; FDC Status/Command
		rts
ENDIF
