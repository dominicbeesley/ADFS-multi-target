.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for Master ADFS with SCSI drivers on internal VFS slot
; --------------------------------------------

TARGETOS		:=	3		; 3=Master
FLOPPY		:=	1		; Floppy drivers
HD_XDFS		:=	1
;

USE65C12 	:= 1
		.pc02		; USE65C12

.endif
