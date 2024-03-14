; Build file for Electron ADFS with SCSI drivers
; ----------------------------------------

TARGETOS		:=	0		; 0=Electron
FLOPPY		:=	1		; Floppy drivers
HD_SCSI		:=	1

.include "adfs.asm"
