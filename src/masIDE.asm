; Build file for Master ADFS with IDE drivers
; -------------------------------------------

TARGETOS=3		; 3=Master
FLOPPY=TRUE		; Floppy drivers
HD_SCSI=FALSE
HD_IDE=TRUE		; IDE drivers
HD_IDE_FAST=FALSE
HD_MMC=FALSE
HD_MMC_HOG=FALSE
HD_SCSI2=FALSE
HD_XDFS=FALSE
;
FULL_INFO=TRUE		; Full *INFO
FULL_ACCESS=TRUE	; Full OSFILE 1-4
UNSUPPORTED_OSFILE=TRUE	; Unknown OSFILE returns A preserved
PRESERVE_CONTEXT=TRUE	; Ctrl-Break doesn't lose context
TRIM_REDUNDANT=FALSE	; Don't remove redundant code
LARGE_DISK=FALSE	; Future development
EXTERNAL=TRUE		; External support
;
USE65C12=TRUE

include "adfs.asm"
