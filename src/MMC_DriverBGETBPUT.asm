;;
;; Set up a hard drive command for for BGET/BPUT
;; ---------------------------------------------
.HD_CommandBGETBPUTsector		
		cmp	#&09				; C=0 for read, C=1 for write
		php
		jsr	MMC_BEGIN			; Initialize the card, if not already initialized
		bne	LAAE8				; Couldn't initialise, return error
		plp
		jsr	MMC_SetupRW			; Set up SD card command block
		jmp	setRandomAddress		; Set the sector address from &C201,X .. &C203,X
.LAAE8		plp					; Drop RD/WR flag in Carry
		ora	#&00				; Set NE from result
		rts