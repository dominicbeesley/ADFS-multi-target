.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for Master ADFS with User Port MMC drivers
; -----------------------------------------------------

TARGETOS		:=	3		; 3=Master
HD_MMC_HOG	:=	1		; MMC drivers
MMC_VIA_BASE	:=	$FE80

FULL_ACCESS	:=	1	; Full OSFILE 1-4
PRESERVE_CONTEXT	:=	1	; Ctrl-Break doesn't lose context
TRIM_REDUNDANT	:=	1	; Remove redundant code

USE65C12		:=	1
		.pc02		; USE65C12

.endif
