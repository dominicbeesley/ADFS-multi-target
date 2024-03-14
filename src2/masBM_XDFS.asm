; Build file for Master ADFS with SCSI drivers on internal VFS slot
; --------------------------------------------

TARGETOS=3		; 3=Master
FLOPPY=TRUE		; Floppy drivers
AUTOHAZEL=FALSE		; Autohazel for blitter
HD_SCSI=TRUE		; SCSI drivers
HD_IDE=FALSE
HD_MMC=FALSE
HD_MMC_HOG=FALSE
HD_SCSI2=FALSE
HD_XDFS=TRUE
;
FULL_INFO=FALSE		; Truncated *INFO
FULL_ACCESS=FALSE	; Truncated OSFILE 1-4
UNSUPPORTED_OSFILE=FALSE	; Unknown OSFILE returns A corrupted
PRESERVE_CONTEXT=FALSE	; Ctrl-Break loses context
TRIM_REDUNDANT=FALSE	; Don't remove redundant code
LARGE_DISK=FALSE	; Future development
EXTERNAL=FALSE		; External support
;
USE65C12=TRUE


include "adfs.asm"
