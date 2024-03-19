.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for BBC ADFS with IDE drivers
; ----------------------------------------

TARGETOS		:=	1		; 1=BBC B (also B+)
FLOPPY		:=	1		; Floppy drivers
HD_IDE		:=	1		; IDE drivers
;
FULL_INFO	:=	1		; Truncated *INFO
FULL_ACCESS	:=	1		; Truncated OSFILE 1-4
UNSUPPORTED_OSFILE:=	1		; Unknown OSFILE returns A corrupted
PRESERVE_CONTEXT	:=	1		; Ctrl-Break preserves context
EXTERNAL		:=	1		; External support
;

.endif