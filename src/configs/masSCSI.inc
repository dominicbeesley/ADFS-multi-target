.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for Master ADFS with SCSI drivers
; --------------------------------------------

TARGETOS		:=	3		; 3=Master
FLOPPY		:=	1		; Floppy drivers
HD_SCSI		:=	1		; SCSI drivers
;
USE65C12		:=	1		; use 65C12 opcodes
		.pc02		; USE65C12

.endif