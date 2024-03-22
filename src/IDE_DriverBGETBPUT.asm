		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.export HD_CommandBGETBPUTsector

		.segment "hd_driver_bget_bput"


;;
;; Set up a hard drive command for for BGET/BPUT
;; ---------------------------------------------
HD_CommandBGETBPUTsector:
		pha
		jsr	WaitEnsuring				; Wait for ensuring to complete
.if TARGETOS > 0						; TODO: This needs to be reinstaged for Elk after byte perfect
  .if (!.def(IDE_HOG_TMP)) && (!.def(IDE_DC))
		nop					; Pause for PanOS
		nop
		nop
  .endif
.endif
		jsr	IDE_WaitforReq
		lda	#1				; one sector
		sta	IDE_SEC_CT
		clc
		lda	WKSP_ADFS_201,X			; Set sector b0-b5
		and	#63
		adc	#1
		sta	IDE_SEC_NO
		lda	WKSP_ADFS_202,X			; Set sector b8-b15
.ifdef X_IDE_OLD
		adc	#0				; TODO: Ask JGH - is this really not necessary in other versions?
.endif
		sta	IDE_CYL_NO_LO
		lda	WKSP_ADFS_203,X			; Set sector b16-b21
		sta	WKSP_ADFS_333_LASTACCDRV
		jmp	SetRandom
.ifdef X_IDE_OLD
		nop
		nop
.else
  .ifndef X_IDE_HOG
		.byte	0
  .endif
.endif
