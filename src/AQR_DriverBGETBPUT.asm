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
.ifndef ELK_PRES_SPACESAVE
		tay
.endif
		lda	WKSP_ADFS_203,X
		sta	WKSP_ADFS_333_LASTACCDRV
;; ??
;		sta	$10eb
;		lda	$1002,x
;		sta	$10ea
;		lda	$1001,x
;		sta	$10e9
		sta	WKSP_ADFS_AQR_SECTOR+2
		lda	WKSP_ADFS_202,x
		sta	WKSP_ADFS_AQR_SECTOR+1
		lda	WKSP_ADFS_201,x
		sta	WKSP_ADFS_AQR_SECTOR
.ifndef ELK_PRES_SPACESAVE
		tya
		jsr	LB7DB_pres
		rts
.else
		jmp	LB7DB_pres
.endif
