;;
;; BGET from hard drive
;; --------------------
.HD_BGET_ReadSector		
		lda	#&08				; &08 - READ
		jsr	HD_CommandBGETBPUTsector	; Send command block to hard drive
		jsr	IDE_WaitforReq			; Wait for hard drive not busy
		nop
		nop
		ldy	#&00
.LACCD		
		lda	IDE_DATA			; Get byte from hard drive
		sta	(&BE),Y				; Store to buffer
		iny
		bne	LACCD				; Loop for 256 bytes
.LACD5		jsr	CommandDone			; Release, get result
