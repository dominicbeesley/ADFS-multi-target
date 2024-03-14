; Build file for BBC ADFS with SCSI drivers
; -----------------------------------------

TARGETOS		:=	1		; 1=BBC B (also B+)
FLOPPY		:=	1		; Floppy drivers
HD_SCSI		:=	1		; SCSI drivers
;

.include "adfs.asm"
