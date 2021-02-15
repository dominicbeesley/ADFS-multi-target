;;
;; Set up a hard drive command for for BGET/BPUT
;; ---------------------------------------------
.HD_CommandBGETBPUTsector		
		pha
		jsr	WaitEnsuring				; Wait for ensuring to complete
IF TARGETOS > 0						; TODO: This needs to be reinstaged for Elk after byte perfect
		nop					; Pause for PanOS
		nop
		nop
ENDIF
		jsr	IDE_WaitforReq
		lda	#1				; one sector
		sta	IDE_SEC_CT
		clc
		lda	WKSP_ADFS_201,X			; Set sector b0-b5
		and	#63
		adc	#1
		sta	IDE_SEC_NO
		lda	WKSP_ADFS_202,X			; Set sector b8-b15
IF TARGETOS = 0
		adc	#0				; TODO: Ask JGH - is this really not necessary in other versions?
ENDIF
		sta	IDE_CYL_NO_LO
		lda	WKSP_ADFS_203,X			; Set sector b16-b21
		sta	WKSP_ADFS_333_LASTACCDRV
		jmp	SetRandom
IF TARGETOS = 0
		nop
		nop
ELSE
		EQUB	0
ENDIF
