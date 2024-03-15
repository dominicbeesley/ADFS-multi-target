; Build file for Master ADFS with SCSI drivers on internal VFS slot
; --------------------------------------------

TARGETOS		:=	3		; 3=Master
FLOPPY		:=	1		; Floppy drivers
HD_XDFS		:=	1
;
USE65C12		:=	1


.include "adfs.asm"
