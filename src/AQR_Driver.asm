
		.include "config.inc"
		.include "workspace.inc"
		.include "os.inc"
		.include "hardware.inc"

		.export	HD_Command
		.export CommandDone

		.segment "hd_driver_1"

HD_Command:
		ldy	#$06				; Update ADFS error infomation
		lda	($B0),Y				; Get Drive+Sector b16-b19
		ora	WKSP_ADFS_317_CURDRV		; OR with current drive
		bmi	CommandExecFloppyOp
		ldy	#$01				; Addr0
		lda	($B0),Y
		sta	$B2
		iny					; Addr1
		lda	($B0),Y
		sta	$B3				; &B2/3=Address low word
		ldy	#$06				; Get Drive+Sector b16-b19 again
		lda	($B0),Y
		ora	WKSP_ADFS_317_CURDRV		; OR with current drive
		sta	WKSP_ADFS_AQR_SECTOR+2
		sta	WKSP_ADFS_333_LASTACCDRV
		iny					; Sector b8-b15
		lda	($B0),Y
		sta	WKSP_ADFS_AQR_SECTOR+1
		iny					; Sector b0-b7
		lda	($B0),Y
		sta	WKSP_ADFS_AQR_SECTOR
.ifdef ELK_PRES_E00
		ldy	#$05				; Command
		lda	($B0),Y
.endif
		jsr	LB7DB_pres			; Setup AQR access code and vars
		ldy	#$09				; Sector count
		lda	($B0),Y
		sta	WKSP_ADFS_AQR_SECTORS
		ldy	#$03				; Addr2
		lda	($B0),Y
		cmp	#$FE
		bcc	L8100
		iny					; Addr3
		lda	($B0),Y
		cmp	#$FF
		beq	L8103
L8100:		jsr	TUBE_CLAIM_IF_PRESENT
L8103:
.ifdef ELK_PRES_E00
		ldy	#$05				; Command
		lda	($B0),Y
.endif
		ldy	#$00
		bit	$CD				; Test bit 6 ($40) ie TUBE in use flag
		bvs	L814B_pres			; -> L814B if TUBE_INUSE
L8109:		lda	WKSP_ADFS_AQR_SECTORS		; How many sectors left?
		beq	CommandDone
		ldy	#$05				; Command
		lda	($B0),Y
		ldy	#$00
		cmp	#$08				; Command &08 - Read
		beq	L8131				; Otherwise write
		lda	#$B2				; Do AQR write sector
		jsr	LB93A_pres
.export L811D_pres
L811D_pres:
		dec	WKSP_ADFS_AQR_SECTORS		; Next sector
		inc	$B3				; (NB there's no overflow into b8-b15)
		jmp	L8109

CommandDone:						; L81AD
		jsr	TubeRelease			; Release Tube and restore screen
L81D2:		lda	#$00				; A=0 - OK
L81D4:		ldx	$B0				; Restore XY pointer
		ldy	$B1
.ifdef HD_SCSI_VFS
		and	#$FF
.else
		and	#$7F				; Lose bit 7, set EQ from result
.endif
		rts					; Return with result in A

.export L8131
L8131:		lda	#$B2				; Read AQR sector
		jsr	LB910_pres			; Do it
		jmp	L811D_pres			; Next sector in loop

;;
L8200:		inc	WKSP_ADFS_228
		bne	L820D
		inc	WKSP_ADFS_229
		bne	L820D
		inc	WKSP_ADFS_22A
L820D:		ldx	#<WKSP_ADFS_227_TUBE_XFER
		ldy	#>WKSP_ADFS_227_TUBE_XFER
		rts

.export L814B_pres
L814B_pres:
.ifdef ELK_PRES_SPACESAVE
		jsr	L820D
.else ; ELK_PRES_SPACESAVE
		ldx	#<WKSP_ADFS_227_TUBE_XFER
		ldy	#>WKSP_ADFS_227_TUBE_XFER
.endif ; ELK_PRES_SPACESAVE

L814E_pres:
		lda	WKSP_ADFS_AQR_SECTORS
		beq	CommandDone
		ldy	#$05				; Get command
		lda	($B0),Y
		cmp	#$08				; Command &08 - Read
		beq	L8177_pres
		lda	#$06				; Otherwise write
		jsr	TubeStartXferSEI_406		; Transfer next sector data from tube
L8160:		ldy	#$00				; Loop one sector

		nop
		nop
		nop

		lda	TUBEIO				; Read from TUBE
		jsr	AQR_savebyte			; Save byte into AQR
		iny
		bne	L8160				; Next byte
		jsr	L8200				; Update address
		dec	WKSP_ADFS_AQR_SECTORS
		jmp	L814E_pres

L8177_pres:	ldy	#$00				; Read - transfer this sector data
		lda	#$07				; across tube to language processor
		jsr	TubeStartXferSEI_406

L817E:		nop
		nop
		nop

		jsr	AQR_loadbyte			; Load byte from AQR

		sta	TUBEIO
		iny
		bne	L817E
		dec	WKSP_ADFS_AQR_SECTORS
		jsr	L8200
		jmp	L814E_pres

;;; There is no hd_driver_2
;		.segment "hd_driver_2"

;;;

;;;  TubeStartXfer must be linked in here

;;; There is no hd_driver_3
;		.segment "hd_driver_3"

