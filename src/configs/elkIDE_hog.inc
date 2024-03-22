.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for Electron ADFS with SCSI drivers
; ----------------------------------------

TARGETOS	:=	0		; 0=Electron
FLOPPY		:=	1		; Floppy drivers
HD_IDE		:=	1
FULL_ACCESS :=  1
FULL_INFO   :=  1
UNSUPPORTED_OSFILE := 1

IDE_ELK_HOG	:=	1
ELK_100_FLOPPY  :=	1

.endif
