; Build file for Master ADFS with User Port MMC drivers
; -----------------------------------------------------

TARGETOS=3		; 3=Master
FLOPPY=FALSE		; Floppy drivers
HD_SCSI=FALSE
HD_IDE=FALSE
HD_MMC=TRUE		; MMC drivers
HD_MMC_HOG=TRUE
_TURBOMMC=TRUE
HD_SCSI2=FALSE
_VIA_BASE=&FE60
HD_XDFS=FALSE
;
FULL_INFO=FALSE		; Full *INFO
FULL_ACCESS=TRUE	; Full OSFILE 1-4
UNSUPPORTED_OSFILE=FALSE; Unknown OSFILE returns A preserved
PRESERVE_CONTEXT=TRUE	; Ctrl-Break doesn't lose context
TRIM_REDUNDANT=TRUE	; Remove redundant code
LARGE_DISK=FALSE	; Future development
EXTERNAL=FALSE		; External support
;
USE65C12=TRUE

include "adfs.asm"