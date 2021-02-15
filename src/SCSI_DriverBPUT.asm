; Note: this file also contains the service call 5 / IRQ code for this device
;;
;; BPUT to hard drive
;; --------------------
.HD_BPUT_WriteSector		
		ldx	&C1				; Get offset to current channel info
		lda	#&0A				; &0A - Write
		jsr	HD_CommandBGETBPUTsector	; Send command block to SCSI/IDE/SD
		ldy	#&00
		jsr	SCSI_WaitforReq			; Wait for SCSI not busy
		bpl	LAB76				; Jump ahead with writing
		jsr	CommandDone			; Release Tube, get SCSI status
		dec	ZP_ADFS_RETRY_CTDN		; Decrease retries
		bpl	HD_BPUT_WriteSector				; Loop to try again
		jmp	GenerateError			; Generate a disk error

;;
;; Write a BPUT buffer to hard drive
;; ---------------------------------
.LAB76		lda	(&BC),Y				; Get byte from buffer
		sta	SCSI_DATA			; Send to hard drive
		iny
		bne	LAB76				; Loop for 256 bytes
IF USE65C12
		lda	#ADFS_FLAGS_ENSURING
		tsb	ZP_ADFS_FLAGS			; set 'files being updated' bit
ELSE
		lda	#ADFS_FLAGS_ENSURING
		ora	ZP_ADFS_FLAGS			; set 'files being updated' bit
		sta	ZP_ADFS_FLAGS
ENDIF
		dey
		sty	SCSI_IRQEN			; Set &FC43 to &FF
