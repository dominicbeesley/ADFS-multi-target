;;
;; BGET from hard drive
;; --------------------
.HD_BGET_ReadSector		
		lda	#&08				; &08 - READ
		jsr	HD_CommandBGETBPUTsector	; Send command block to hard drive
		bne	LACD5				; Error
		lda	&B2
		pha
		lda	&B3
		pha
		lda	&BE
		sta	&B2
		lda	&BF
		sta	&B3
		jsr	MMC_StartRead
		bne	LACD5				; Error
		jsr	MMC_Read256
		jsr	MMC_16Clocks			; ignore CRC
		pla
		sta	&B3
		pla
		sta	&B2
.LACD5		jsr	CommandDone			; Release, get result
