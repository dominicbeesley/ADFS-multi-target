; Note: this file also contains the service call 5 / IRQ code for this device

;;
;; BPUT to hard drive
;; --------------------
.HD_BPUT_WriteSector		
		ldx	&C1				; Get offset to current channel info
		lda	#&0A				; &0A - Write
		jsr	HD_CommandBGETBPUTsector	; Send command block to SCSI/IDE/SD
		ldy	#&00
		jsr	IDE_WaitforReq			; Wait for IDE not busy
IF TARGETOS = 0
		nop					; TODO: Ask JGH - is this necessary?
ENDIF
		jmp	LAB76				; Always jump to write
IF TARGETOS = 0
.ResultCodes
		EQUB	&FF
		EQUB	&FF
		EQUB	&60
		EQUB	&FF
		EQUB	&50
		EQUB	&65
		EQUB	&48
		EQUB	&FF

ELSE ; TARGETOS > 0
.ResultCodes
		EQUB	&12
		EQUB	&06
		EQUB	&2F
		EQUB	&02
		EQUB	&10
		EQUB	&28
		EQUB	&11
		EQUB	&19
		EQUB	&03
ENDIF ; TARGETOS > 0 and HD_IDE

;;
;; Write a BPUT buffer to hard drive
;; ---------------------------------
.LAB76		lda	(&BC),Y				; Get byte from buffer
		sta	IDE_DATA			; Send to hard drive
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
		nop					; Don't trample on IDE register
		nop
		nop




