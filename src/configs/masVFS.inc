.ifndef __CONFIG_INC__
__CONFIG_INC__:

; Build file for Master ADFS with SCSI drivers
; --------------------------------------------

TARGETOS	:=	3		; 3=Master
HD_SCSI		:=	1		; VFS SCSI drivers
HD_SCSI_VFS	:=	1
;
USE65C12	:=	1		; use 65C12 opcodes
		.pc02		; USE65C12

VFS_FLOPPY_VESTIGE	:= 1

.endif