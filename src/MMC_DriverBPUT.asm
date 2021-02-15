; Note: this file also contains the service call 5 / IRQ code for this device

;;
;; BPUT to hard drive
;; --------------------
.HD_BPUT_WriteSector		
		ldx	&C1				; Get offset to current channel info
		lda	#&0A				; &0A - Write
		jsr	HD_CommandBGETBPUTsector	; Send command block to SCSI/IDE/SD
		bne	LAB5BJmpGenerateError		; Error, generate a disk error
							; Fall through to write

;;
;; Write a BPUT buffer to hard drive
;; ---------------------------------
.LAB76		lda	&B2
		pha
		lda	&B3
		pha
		lda	&BC
		sta	&B2
		lda	&BD
		sta	&B3
		jsr	MMC_StartWrite
		bne	LAB5BJmpGenerateError		; Error occured
		jsr	MMC_Write256
		jsr	MMC_EndWrite
		bne	LAB5BJmpGenerateError		; Error occured
		pla
		sta	&B3
		pla
		sta	&B2
IF USE65C12
		lda	#ADFS_FLAGS_ENSURING
		tsb	ZP_ADFS_FLAGS			; set 'files being updated' bit
ELSE
		lda	#ADFS_FLAGS_ENSURING
		ora	ZP_ADFS_FLAGS			; set 'files being updated' bit
		sta	ZP_ADFS_FLAGS
ENDIF
		dey




