		.include "config.inc"


		.export TubeDelay
		.export TubeDelay2
		.export TubeStartXfer406
		.export TubeStartXferSEI_406

		.segment "tube_start_xfer"

; Start a Tube transfer
; ---------------------
TubeStartXferSEI_406:
		sei
TubeStartXfer406:
		jsr	$0406
		ldy	#$00
TubeDelay:
		jsr	TubeDelay2				; Delay
TubeDelay2:	jsr	TubeDelayRts
TubeDelayRts:	rts
