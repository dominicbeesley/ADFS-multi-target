; Build file for Electron ADFS with SCSI drivers
; ----------------------------------------

TARGETOS=0		; 0=Electron
FLOPPY=TRUE		; Floppy drivers
HD_SCSI=TRUE
HD_IDE=FALSE
HD_MMC=FALSE
HD_MMC_HOG=FALSE
HD_SCSI2=FALSE
;
FULL_INFO=FALSE		; Truncated *INFO
FULL_ACCESS=FALSE	; Truncated OSFILE 1-4
UNSUPPORTED_OSFILE=FALSE; Unknown OSFILE returns A corrupted
PRESERVE_CONTEXT=FALSE	; Ctrl-Break preserves context
LARGE_DISK=FALSE	; Future development
TRIM_REDUNDANT=FALSE	; Don't remove redundant code
OPTIMISE=0		; Don't do any code optimisation
EXTERNAL=FALSE		; External support
;
USE65C12=FALSE

include "adfs.asm"
