; Build file for BBC ADFS with IDE drivers
; ----------------------------------------

TARGETOS		:=	1		; 1=BBC B (also B+)
FLOPPY		:=	1		; Floppy drivers
HD_IDE		:=	1		; IDE drivers
HD_IDE_FAST	:=	1
;
FULL_INFO	:=	1		; Truncated *INFO
FULL_ACCESS	:=	1		; Truncated OSFILE 1-4
UNSUPPORTED_OSFILE:=	1		; Unknown OSFILE returns A corrupted
PRESERVE_CONTEXT	:=	1		; Ctrl-Break preserves context
EXTERNAL		:=	1		; External support
;

.include "adfs.asm"
