.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for Electron ADFS with SCSI drivers
; ----------------------------------------

STANDALONE	:=	1

TARGETOS	:=	0		; 0=Electron
FLOPPY		:=	1		; Floppy drivers
NO_HD		:=	1
ELK_PRES_AQR	:=	1

.endif
