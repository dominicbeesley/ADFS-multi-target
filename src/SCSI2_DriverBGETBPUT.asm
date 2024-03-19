		.include "config.inc"

.proc HD_CommandBGETBPUTsector

		;TODO: check assumptions:
		; - I can trample B0,B1
		; - I can trample B2,B3
		; - I can trample WKSP_ADFS_215_DSKOPSAV_RET onwards for my own block

		; on entry
		;	A contains 08 for read, 0A for write
		;	X contains channel pointer into channel data at

		pha
		jsr	WaitEnsuring
		pla

		sta	WKSP_ADFS_21A_DSKOPSAV_CMD

		; set sector address from channel data

		lda	WKSP_ADFS_203,X
		sta	WKSP_ADFS_333_LASTACCDRV
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC
		lda	WKSP_ADFS_202,X
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+1
		lda	WKSP_ADFS_201,X
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+2

		; set error code and xlen, ctl=0; seccnt=1
		ldx	#0
		stx	WKSP_ADFS_215_DSKOPSAV_RET
		stx	WKSP_ADFS_220_DSKOPSAV_XLEN	; TODO: check I think this can be dispensed with if sector count is set
		stx	WKSP_ADFS_220_DSKOPSAV_XLEN+1
		stx	WKSP_ADFS_220_DSKOPSAV_XLEN+2
		stx	WKSP_ADFS_220_DSKOPSAV_XLEN+3
		stx	WKSP_ADFS_21F_DSKOPSAV_CTL
		inx
		stx	WKSP_ADFS_21E_DSKOPSAV_SECCNT

		ldx	#3
l:		lda	$B0,X
		pha
		dex
		bpl	l

		; calculate address of RND file buffer from offset in X
		ldx	#<WKSP_ADFS_215_DSKOPSAV_RET
		stx	$B0
		ldy	#>WKSP_ADFS_215_DSKOPSAV_RET
		sty	$B1
		jsr	HD_Command

		ldx	#0
l2:		pla
		sta	$B0,X
		inx
		cpx	#4
		bne	l2


		rts
.endproc
;WKSP_ADFS_216_DSKOPSAV_MEMADDR
