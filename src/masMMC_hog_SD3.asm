; Build file for Master ADFS with User Port MMC drivers
; -----------------------------------------------------

TARGETOS		:=	3		; 3=Master
HD_MMC		:=	1		; MMC drivers
HD_MMC_HOG	:=	1
_VIA_BASE	:=	$FEA0

FULL_ACCESS	:=	1	; Full OSFILE 1-4
PRESERVE_CONTEXT	:=	1	; Ctrl-Break doesn't lose context
TRIM_REDUNDANT	:=	1	; Remove redundant code

USE65C12		:=	1

.include "adfs.asm"
