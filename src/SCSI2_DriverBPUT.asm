HD_BPUT_WriteSector:

; setup data address frmo &BE
	lda	$BC
	sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR
	lda	$BD
	sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
	lda	#$FF
	sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+2
	sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+3
	lda	#$0A				; &08 - READ
	ldx	$C1
	jsr	HD_CommandBGETBPUTsector
	bne	LAB5BJmpGenerateError
