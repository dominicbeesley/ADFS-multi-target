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
