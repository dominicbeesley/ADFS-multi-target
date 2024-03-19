		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.export Svc5_IRQ

		.segment "hd_driver_svc5"

; TODO: remove?
Svc5_IRQ:	rts
