		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"
		.include "nmivars.inc"

		.export ORA4_if_2E4_b0

		.segment "floppy_nmi_C"


ORA4_if_2E4_b0:
		ror	WKSP_ADFS_2E4
		bcc	LBD6A
		ora	#$04
		clc
LBD6A:		rol	WKSP_ADFS_2E4
		rts
