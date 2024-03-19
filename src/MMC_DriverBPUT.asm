		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"
		.include "MMC.inc"

		.export HD_BPUT_WriteSector
		.export ResultCodes

		.segment "hd_driver_bput"

; Note: this file also contains the service call 5 / IRQ code for this device

;;
;; BPUT to hard drive
;; --------------------
HD_BPUT_WriteSector:
		ldx	$C1				; Get offset to current channel info
		lda	#$0A				; &0A - Write
		jsr	HD_CommandBGETBPUTsector	; Send command block to SCSI/IDE/SD
.if HD_MMC_HOG
		ldy	#0
	        jsr	SCSI_WaitforReq		        ;; Wait for SCSI not busy???? TODO: what
		bra	LAB76
ResultCodes:
       .byte $12
       .byte $06
       .byte $2F
       .byte $02
       .byte $10
       .byte $28
       .byte $11
       .byte $19
       .byte $03
       .byte $81      ;; Junk - so a binary compare will pass

.else
		bne	LAB5BJmpGenerateError		; Error, generate a disk error
.endif							; Fall through to write

;;
;; Write a BPUT buffer to hard drive
;; ---------------------------------
LAB76:		lda	$B2
		pha
		lda	$B3
		pha
		lda	$BC
		sta	$B2
		lda	$BD
		sta	$B3
		jsr	MMC_StartWrite
.ifndef HD_MMC_HOG					; TODO: reinstate for HOG?
		bne	LAB5BJmpGenerateError		; Error occured
.endif
		jsr	MMC_Write256
		jsr	MMC_EndWrite
.ifndef HD_MMC_HOG					; TODO: reinstate for HOG?
		bne	LAB5BJmpGenerateError		; Error occured
.endif
		pla
		sta	$B3
		pla
		sta	$B2
.ifdef USE65C12
		lda	#ADFS_FLAGS_ENSURING
		tsb	ZP_ADFS_FLAGS			; set 'files being updated' bit
.else
		lda	#ADFS_FLAGS_ENSURING
		ora	ZP_ADFS_FLAGS			; set 'files being updated' bit
		sta	ZP_ADFS_FLAGS
.endif
		dey

.ifdef HD_MMC_HOG		; TODO get rid
		nop
		nop
		nop
.endif




