; this file is empty, there is a bodge in main adfs.asm for MMC rts for IRQ
; TODO: optimise away the MMC irq handler and service call code

IF HD_MMC_HOG	; TODO remove this lot?
;;
;; Service 5 - Interupt occured
;; ============================
.Svc5_IRQ		rts				; Remove IRQ routine

.UpdateDrive
		lda	&85				; Merge with current drive
		ora	WKSP_ADFS_317_CURDRV
		sta	&85
		sta	WKSP_ADFS_333_LASTACCDRV			; Store for any error
		lda	#&7F
		rts

		equb	&03
		lda		#$05
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
		sta	&FC43					; TODO: remove!
IF USE65C12
		lda	#ADFS_FLAGS_ENSURING
		trb	ZP_ADFS_FLAGS			; Clear 'files being ensured'
ELSE
		ror	ZP_ADFS_FLAGS			; Clear 'files being ensured'
		clc					; ; and #ADFS_FLAGS_ENSURING EOR &FF
		rol	ZP_ADFS_FLAGS
ENDIF
		lda	&FC40					; TODO: remove!
		jsr	SCSI_WaitforReq
		ora	&FC40			; Get SCSI result
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
		jsr	GenerateErrorSuffX				; Generate 'Data lost' error with X=channel
		EQUB	&CA				; ERR=202
		EQUS	"Data lost, channel"
		EQUB	&00
ENDIF
