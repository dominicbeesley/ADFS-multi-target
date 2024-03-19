.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for BBC ADFS with SCSI drivers
; -----------------------------------------

TARGETOS		:=	1		; 1=BBC B (also B+)
AUTOHAZEL	:=	1		; Autohazel for blitter
FLOPPY		:=	1		; Floppy drivers
HD_SCSI		:=	1		; SCSI drivers

TRIM_REDUNDANT	:=	1	; Don't remove redundant code

.endif