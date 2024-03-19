.ifndef __CONFIG_INC__
__CONFIG_INC__:

;TODO: investigate odd crashes when loading using mod play and then unable to continue until multiple resets


; Build file for BBC ADFS with SCSI drivers
; -----------------------------------------

TARGETOS		:=	1		; 1=BBC B (also B+)
FLOPPY		:=	1		; Floppy drivers
HD_SCSI2		:=	1		; Dossytronics SCSI2 board

.endif