; Build file for BBC ADFS with IDE drivers
; ----------------------------------------

TARGETOS=1		; 1=BBC B (also B+)
FLOPPY=TRUE		; Floppy drivers
HD_SCSI=FALSE
HD_IDE=TRUE		; IDE drivers
HD_IDE_FAST=FALSE
HD_MMC=FALSE
HD_MMC_HOG=FALSE
HD_SCSI2=FALSE
;
FULL_INFO=TRUE		; Truncated *INFO
FULL_ACCESS=TRUE	; Truncated OSFILE 1-4
UNSUPPORTED_OSFILE=TRUE ; Unknown OSFILE returns A corrupted
PRESERVE_CONTEXT=TRUE	; Ctrl-Break preserves context
LARGE_DISK=FALSE	; Future development
TRIM_REDUNDANT=FALSE	; Don't remove redundant code
EXTERNAL=TRUE		; External support
;
USE65C12=FALSE

include "adfs.asm"
