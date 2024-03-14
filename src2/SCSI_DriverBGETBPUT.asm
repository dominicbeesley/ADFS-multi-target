;;
;; Set up a hard drive command for for BGET/BPUT
;; ---------------------------------------------
.HD_CommandBGETBPUTsector		
		pha
		jsr	WaitEnsuring			; Wait for ensuring to complete
		jsr	SCSI_StartCommand2		; Set SCSI to command mode
		pla
		jsr	SCSI_SendCMDByte		; Send command
		lda	WKSP_ADFS_203,X
		sta	WKSP_ADFS_333_LASTACCDRV
		jsr	SCSI_SendCMDByte		; Send sector address
		lda	WKSP_ADFS_202,X
		jsr	SCSI_SendCMDByte
		lda	WKSP_ADFS_201,X
		jsr	SCSI_SendCMDByte
		lda	#&01				; Send '1 sector'
		jsr	SCSI_SendCMDByte
		lda	#&00
		jmp	SCSI_SendCMDByte
