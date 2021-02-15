
;;
;; Service 5 - Interupt occured
;; ============================
.Svc5_IRQ	lda	ZP_ADFS_FLAGS			; Get flags
		and	#(ADFS_FLAGS_HD_PRESENT + ADFS_FLAGS_ENSURING); Check for hard drive+files being ensured
		cmp	#(ADFS_FLAGS_HD_PRESENT + ADFS_FLAGS_ENSURING)
		bne	LAB98				; No hard drive or no files being ensured
		jsr	SCSI_GetStatus			; Get SCSI status
		cmp	#&F2
		beq	LAB9B
.LAB98		lda	#&05				; Return from service call
		rts
;;
.LAB9B
IF USE65C12
		phy					; Send something to SCSI
ELSE
		tya
		pha
ENDIF
		lda	#&00
		sta	SCSI_IRQEN
IF USE65C12
		lda	#ADFS_FLAGS_ENSURING
		trb	ZP_ADFS_FLAGS			; Clear 'files being ensured'
ELSE
		ror	ZP_ADFS_FLAGS			; Clear 'files being ensured'
		clc					; ; and #ADFS_FLAGS_ENSURING EOR &FF
		rol	ZP_ADFS_FLAGS
ENDIF
		lda	SCSI_DATA
		jsr	SCSI_WaitforReq
		ora	SCSI_DATA			; Get SCSI result
		sta	WKSP_ADFS_331			; Save for error handler later
		jmp	L9DB4				; Restore Y,X, claim call


; Check for data loss
; ===================
; IDE and MMC don't have IRQ handlers, this never happens
.LABB4		lda	WKSP_ADFS_331			; Get SCSI result from IRQ handler
		beq	LABE6				; Ok, jump forward to exit
		lda	#&00
		sta	WKSP_ADFS_331			; Clear the flag
		ldx	WKSP_ADFS_2D4			; Get channel being used
IF OPTIMISE<3
		jsr	GenerateErrorSuffX				; Generate 'Data lost' error with X=channel
		EQUB	&CA				; ERR=202
		EQUS	"Data lost, channel"
		EQUB	&00
ELSE
		stx	WKSP_ADFS_2D5_CUR_CHANNEL			; Store channel for error generation
		jsr	GenerateErrorNoSuff				; Generate 'Data lost' error +' on channel NNN'
		EQUB	&CA				; ERR=202
		EQUS	"Data lost"
		EQUB	&00
ENDIF
