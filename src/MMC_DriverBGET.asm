		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"
		.include "MMC.inc"

		.export HD_BGET_ReadSector
		
		.segment "hd_driver_bget"


;;
;; BGET from hard drive
;; --------------------
HD_BGET_ReadSector:
		lda	#$08				; &08 - READ
		jsr	HD_CommandBGETBPUTsector	; Send command block to hard drive
.ifdef HD_MMC_HOG
		jsr	SCSI_WaitforReq
		nop
		nop
		ldy	#0
.else
		bne	LACD5				; Error
.endif
		lda	$B2
		pha
		lda	$B3
		pha
		lda	$BE
		sta	$B2
		lda	$BF
		sta	$B3
		jsr	MMC_StartRead
.ifndef HD_MMC_HOG
		bne	LACD5				; Error
.endif
		jsr	MMC_Read256
		jsr	MMC_16Clocks			; ignore CRC
		pla
		sta	$B3
		pla
		sta	$B2
.ifdef HD_MMC_HOG
		jsr	CommandExit2
.else
LACD5:		jsr	CommandDone			; Release, get result
.endif
