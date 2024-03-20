.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for BBC ADFS with IDE drivers
; ----------------------------------------

TARGETOS		:=	1		; 1=BBC B (also B+)
FLOPPY			:=	1		; Floppy drivers
HD_IDE			:=	1		; IDE drivers
;
PRESERVE_CONTEXT	:=	1		; Ctrl-Break preserves context
;

IDE_DC			:= 	1	
.endif