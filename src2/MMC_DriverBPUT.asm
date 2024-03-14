; Note: this file also contains the service call 5 / IRQ code for this device

;;
;; BPUT to hard drive
;; --------------------
.HD_BPUT_WriteSector		
		ldx	&C1				; Get offset to current channel info
		lda	#&0A				; &0A - Write
		jsr	HD_CommandBGETBPUTsector	; Send command block to SCSI/IDE/SD
IF HD_MMC_HOG
		ldy	#0
	        jsr	SCSI_WaitforReq		        ;; Wait for SCSI not busy???? TODO: what
		bra	LAB76
.ResultCodes
       EQUB &12
       EQUB &06
       EQUB &2F
       EQUB &02
       EQUB &10
       EQUB &28
       EQUB &11
       EQUB &19
       EQUB &03
       EQUB &81      ;; Junk - so a binary compare will pass

ELSE
		bne	LAB5BJmpGenerateError		; Error, generate a disk error
ENDIF							; Fall through to write

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
IF NOT(HD_MMC_HOG)					; TODO: reinstate for HOG?
		bne	LAB5BJmpGenerateError		; Error occured
ENDIF
		jsr	MMC_Write256
		jsr	MMC_EndWrite
IF NOT(HD_MMC_HOG)					; TODO: reinstate for HOG?
		bne	LAB5BJmpGenerateError		; Error occured
ENDIF
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

IF HD_MMC_HOG		; TODO get rid
		nop
		nop
		nop
ENDIF




