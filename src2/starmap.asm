; separated into own file as ELK/SCSI includes this in a different place			

.starMAP	jsr	L92A8
		EQUS	"Address :  Length", &8D
		ldx	#&00
.LA0A9		cpx	WKSP_ADFS_100_FSM_S1 + &FE
		beq	LA091
		inx
		inx
		inx
IF TARGETOS=0 AND HD_SCSI
		stx	&B2
ELSE
		stx	&C6
ENDIF
		ldy	#&02
.LA0B5		dex
		lda	WKSP_ADFS_000_FSM_S0,X
		jsr	L9322
		dey
		bpl	LA0B5
		jsr	L92A8
		EQUS	"  : ", &A0

IF TARGETOS=0 AND HD_SCSI
		ldx	&B2
ELSE
		ldx	&C6
ENDIF
		ldy	#&02
.LA0CB		dex
		lda	WKSP_ADFS_100_FSM_S1,X
		jsr	L9322
		dey
		bpl	LA0CB
IF TARGETOS > 1
		jsr	LA03A
ELSE
		jsr	OSNEWL
ENDIF

IF TARGETOS=0 AND HD_SCSI
		ldx	&B2
ELSE
		ldx	&C6
ENDIF

IF USE65C12
		bra	LA0A9
ELSE
		bne	LA0A9
ENDIF

