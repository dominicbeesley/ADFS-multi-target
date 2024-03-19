.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for Electron ADFS with IDE drivers
; ----------------------------------------

TARGETOS		:=	0		; 0=Electron
FLOPPY		:=	1		; Floppy drivers
HD_IDE		:=	1		; IDE drivers
PRESERVE_CONTEXT	:=	1		; Ctrl-Break preserves context

.endif
