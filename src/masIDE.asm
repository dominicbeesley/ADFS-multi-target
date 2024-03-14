; Build file for Master ADFS with IDE drivers
; -------------------------------------------

TARGETOS 	:= 	3	; 3=Master
FLOPPY		:=	1	; Floppy drivers
HD_IDE		:=	1	; IDE drivers
;
FULL_INFO	:=	1	; Full *INFO
FULL_ACCESS	:=	1	; Full OSFILE 1-4
UNSUPPORTED_OSFILE:=	1	; Unknown OSFILE returns A preserved
PRESERVE_CONTEXT	:=	1	; Ctrl-Break doesn't lose context
EXTERNAL		:=	1	; External support
;
USE65C12		:=	1	; use 65c12 opcodes

.include "adfs.asm"
