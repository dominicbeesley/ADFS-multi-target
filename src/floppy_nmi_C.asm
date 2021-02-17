.ORA4_if_2E4_b0		
		ror	WKSP_ADFS_2E4
		bcc	LBD6A
		ora	#&04
		clc
.LBD6A		rol	WKSP_ADFS_2E4
		rts
