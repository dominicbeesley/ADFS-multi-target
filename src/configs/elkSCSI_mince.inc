.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for Electron ADFS with SCSI drivers
; ----------------------------------------

TARGETOS		:=	0		; 0=Electron
FLOPPY			:=	1		; Floppy drivers
HD_SCSI			:=	1

SCSI_ELK_HOG		:=	0
ELK_100_FLOPPY  	:=	1
ELK_MINCE_COMPACT 	:=	1

.endif
