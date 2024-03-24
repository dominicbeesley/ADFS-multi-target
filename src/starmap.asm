		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.export starMAP

		.segment "starMAP"



; separated into own file as ELK/SCSI includes this in a different place

starMAP:	jsr	L92A8
		.byte	"Address :  Length", $8D
		ldx	#$00
LA0A9:		cpx	WKSP_ADFS_100_FSM_S1 + $FE
		beq	LA091
		inx
		inx
		inx
.ifdef ELK_100_ADFS
		stx	$B2
.else
		stx	$C6
.endif
		ldy	#$02
LA0B5:		dex
		lda	WKSP_ADFS_000_FSM_S0,X
		jsr	L9322
		dey
		bpl	LA0B5
		jsr	L92A8
		.byte	"  : ", $A0

.ifdef ELK_100_ADFS
		ldx	$B2
.else
		ldx	$C6
.endif
		ldy	#$02
LA0CB:		dex
		lda	WKSP_ADFS_100_FSM_S1,X
		jsr	L9322
		dey
		bpl	LA0CB
.if TARGETOS > 1
		jsr	masPrintCRLFNoSpool
.else
		jsr	OSNEWL
.endif

.ifdef ELK_100_ADFS
		ldx	$B2
.else
		ldx	$C6
.endif

.if .def(USE65C12) && (!.def(HD_SCSI_VFS))
		bra	LA0A9
.else
		bne	LA0A9
.endif

