;TODO: investigate odd crashes when loading using mod play and then unable to continue until multiple resets


; Build file for BBC ADFS with SCSI drivers
; -----------------------------------------

TARGETOS=1		; 1=BBC B (also B+)
FLOPPY=TRUE		; Floppy drivers
HD_SCSI=FALSE		; SCSI drivers
HD_IDE=FALSE
HD_MMC=FALSE
HD_SCSI2=TRUE
;
FULL_INFO=FALSE		; Truncated *INFO
FULL_ACCESS=FALSE	; Truncated OSFILE 1-4
UNSUPPORTED_OSFILE=FALSE ; Unknown OSFILE returns A corrupted
PRESERVE_CONTEXT=FALSE	; Ctrl-Break loses context
LARGE_DISK=FALSE	; Future development
TRIM_REDUNDANT=FALSE	; Don't remove redundant code
OPTIMISE=0		; Don't do any code optimisation
EXTERNAL=FALSE		; External support
;
USE65C12=FALSE		; TODO: this only for testing on blitter!

include "adfs.asm"
