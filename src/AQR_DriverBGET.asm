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
;;;
		ldy	#$00
		lda	#$BE
;LACD5:		jsr	CommandDone			; Release, get result
		jsr	LB910_pres
