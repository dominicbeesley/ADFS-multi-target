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
		jsr	IDE_WaitforReq			; Wait for hard drive not busy
	.ifndef X_IDE_HOG
		nop
		nop
	.endif
		ldy	#$00
LACCD:
		lda	IDE_DATA			; Get byte from hard drive
		sta	($BE),Y				; Store to buffer
		iny
		bne	LACCD				; Loop for 256 bytes
LACD5:		jsr	CommandDone			; Release, get result
