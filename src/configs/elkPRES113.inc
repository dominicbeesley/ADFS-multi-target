.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for Electron ADFS with SCSI drivers
; ----------------------------------------

TARGETOS	:=	0		; 0=Electron
FLOPPY		:=	1		; Floppy drivers
NO_HD		:=	1
ELK_PRES_AQR	:=	1

ELK_100_FLOPPY	:=	1		; include original "100" version floppy drivers
ELK_100_ADFS    :=	1
ELK_100_TUBE	:=	1
ELK_PRES	:=      1
ELK_PRES_110	:=	1
ELK_PRES_113	:=	1

ELK_PRES_SPACESAVE	:=	1
ELK_PRES_SPACESAVE_2	:=	1

VERSION		:=	$113

.endif
