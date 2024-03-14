;;
;; BGET from hard drive
;; --------------------
.HD_BGET_ReadSector		
		lda	#&08				; &08 - READ
		jsr	HD_CommandBGETBPUTsector	; Send command block to hard drive
IF HD_MMC_HOG
		jsr	SCSI_WaitforReq
		nop
		nop
		ldy	#0
ELSE
		bne	LACD5				; Error
ENDIF
		lda	&B2
		pha
		lda	&B3
		pha
		lda	&BE
		sta	&B2
		lda	&BF
		sta	&B3
		jsr	MMC_StartRead
IF NOT(HD_MMC_HOG)
		bne	LACD5				; Error
ENDIF
		jsr	MMC_Read256
		jsr	MMC_16Clocks			; ignore CRC
		pla
		sta	&B3
		pla
		sta	&B2
IF HD_MMC_HOG
		jsr	CommandExit2
ELSE
.LACD5		jsr	CommandDone			; Release, get result
ENDIF
