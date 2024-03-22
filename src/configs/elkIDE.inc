.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for Electron ADFS with IDE drivers
; ----------------------------------------

TARGETOS			:=	0		; 0=Electron
FLOPPY				:=	1		; Floppy drivers
HD_IDE				:=	1		; IDE drivers
PRESERVE_CONTEXT	:=	1		; Ctrl-Break preserves context

ELK_100_TUBE		:=  1
ELK_103_TUBE		:=  1
ELK_100_DRVSEL_BUG  :=  1

.endif
