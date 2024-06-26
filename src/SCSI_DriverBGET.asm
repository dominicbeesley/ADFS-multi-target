		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.export HD_BGET_ReadSector
		
		.segment "hd_driver_bget"

;;
;; BGET from hard drive
;; --------------------
HD_BGET_ReadSector:
		lda	#$08				; &08 - READ
		jsr	HD_CommandBGETBPUTsector	; Send command block to hard drive
		jsr	SCSI_WaitforReq			; Wait for hard drive Req
		bmi	LACD5				; If SCSI is writing, finish
		ldy	#$00
LACCD:		
.ifdef HD_SCSI_VFS
		jsr	SCSI_WaitforReq
.endif
		lda	SCSI_DATA			; Get byte from hard drive
		sta	($BE),Y				; Store to buffer
		iny
		bne	LACCD				; Loop for 256 bytes
LACD5:		jsr	CommandDone			; Release, get result
