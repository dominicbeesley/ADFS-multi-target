		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.export Svc5_IRQ
.ifndef HD_SCSI_VFS
		.export LABB4
.endif
		.segment "hd_driver_svc5"


;;
;; Service 5 - Interupt occured
;; ============================
Svc5_IRQ:	lda	ZP_ADFS_FLAGS			; Get flags
		and	#(ADFS_FLAGS_HD_PRESENT + ADFS_FLAGS_ENSURING); Check for hard drive+files being ensured
		cmp	#(ADFS_FLAGS_HD_PRESENT + ADFS_FLAGS_ENSURING)
		bne	LAB98				; No hard drive or no files being ensured
		jsr	SCSI_GetStatus			; Get SCSI status
		cmp	#$F2
		beq	LAB9B
LAB98:		lda	#$05				; Return from service call
		rts
;;
LAB9B:
.ifdef USE65C12
		phy					; Send something to SCSI
.else
		tya
		pha
.endif
		lda	#$00
		sta	SCSI_IRQEN
.ifdef USE65C12
		lda	#ADFS_FLAGS_ENSURING
		trb	ZP_ADFS_FLAGS			; Clear 'files being ensured'
.else
		ror	ZP_ADFS_FLAGS			; Clear 'files being ensured'
		clc					; ; and #ADFS_FLAGS_ENSURING EOR &FF
		rol	ZP_ADFS_FLAGS
.endif
		lda	SCSI_DATA
.ifdef HD_SCSI_VFS
		jsr	SCSI_WaitforReq_noCLI
.else
		jsr	SCSI_WaitforReq
.endif
		ora	SCSI_DATA			; Get SCSI result
		sta	WKSP_ADFS_331			; Save for error handler later
		jmp	L9DB4				; Restore Y,X, claim call

.ifndef HD_SCSI_VFS
; Check for data loss
; ===================
; IDE and MMC don't have IRQ handlers, this never happens
LABB4:		lda	WKSP_ADFS_331			; Get SCSI result from IRQ handler
		beq	LABE6				; Ok, jump forward to exit
		lda	#$00
		sta	WKSP_ADFS_331			; Clear the flag
		ldx	WKSP_ADFS_2D4			; Get channel being used
		jsr	GenerateErrorSuffX				; Generate 'Data lost' error with X=channel
		.byte	$CA				; ERR=202
		.byte	"Data lost, channel"
		.byte	$00
.endif