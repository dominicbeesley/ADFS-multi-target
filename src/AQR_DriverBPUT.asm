		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.export HD_BPUT_WriteSector

		.segment "hd_driver_bput"

; Note: this file also contains the service call 5 / IRQ code for this device
;;
;; BPUT to hard drive
;; --------------------
HD_BPUT_WriteSector:
		ldx	$C1				; Get offset to current channel info
		lda	#$0A				; &0A - Write
		jsr	HD_CommandBGETBPUTsector	; Send command block to SCSI/IDE/SD
		ldy	#$00
		lda	#$BC
		jsr	LB93A_pres
