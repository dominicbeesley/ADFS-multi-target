		.include "config.inc"
		.include "workspace.inc"
		.include "os.inc"
		.include "hardware.inc"

		.export HD_Command
		.export CommandDone

		.segment "hd_driver_1"


;;
;; Hard drive hardware is present. Check what drive is being accessed.
;;
HD_Command:
.ifndef HD_SCSI_VFS
		ldy	#$06
		lda	($B0),Y                     	; Get drive
		ora	WKSP_ADFS_317_CURDRV        	; OR with current drive
  .ifdef FLOPPY
		bmi	CommandExecFloppyOp         	; Jump back with 4,5,6,7 as floppies
  .endif
.endif
		jsr	SCSI_StartCommand           	; Write &01 to SCSI, returns Y=0


;;; TubeCheckAddrAndClaim must be linked in here

		.segment "hd_driver_2"


; Do a data transfer to/from a hard drive device
; ----------------------------------------------


		;Do a SCSI data transfer
		;-----------------------
		ldy	#5				; Get command
		lda	($B0),Y
		jsr	SCSI_send_byteA			; Send to SCSI data port
		iny
		lda	($B0),Y				; Get Drive
		ora	WKSP_ADFS_317_CURDRV		; OR with current drive
.ifdef HD_SCSI_VFS
		cmp	#$FF
		bne	@sk1
		inc	A
@sk1:
.endif
		sta	WKSP_ADFS_333_LASTACCDRV
		jmp	L814C				; Send rest of command block
;;
L814A:		lda	($B0),Y				; Get a command block byte
L814C:		jsr	SCSI_send_byteA			; Send to SCSI data port
		jsr	SCSI_WaitforReq			; Wait until SCSI REQ
		bpl	L8159				; If SCSI says enough command
		bvs	L8159				; bytes sent, jump ahead
		iny					; Keep sending command block
		bne	L814A				; until SCSI says 'stop!'
L8159:		ldy	#$05
		lda	($B0),Y				; Get Command
		and	#$FD				; Lose bit 1
		eor	#$08				; Is Command &08 or &0A?
.ifdef HD_SCSI_VFS
		bne	@sk2
		jmp	HD_DataTransfer256
@sk2:
.else
		beq	HD_DataTransfer256		; Jump if not Read or Write
.endif
		jsr	SCSI_WaitforReq			; Wait until SCSI busy
		clc					; CC=Read
		bvc	L816A				; Jump past with Read
		sec					; CS=Write
L816A:		ldy	#$00				; Initialise Y to 0
		bit	ZP_ADFS_FLAGS			; Accessing Tube?
		bvc	L817C				; No, jump ahead to do the transfer
		ldx	#<WKSP_ADFS_227_TUBE_XFER
		ldy	#>WKSP_ADFS_227_TUBE_XFER	; XY=>Tube address
		lda	#$00				; A=0
		php					; Save CC/CS state
		rol	A				; A=0/1 for Read/Write
		jsr	TubeStartXfer406				; Claim the Tube
		plp					; Restore CC/CS state
;;
;; Do a data transfer to/from SCSI device
;; --------------------------------------
L817C:		jsr	SCSI_WaitforReq			; Check SCSI status
		bmi	CommandDone			; Transfer finished, get and return result
		bit	ZP_ADFS_FLAGS			; Check Tube/Direction flags
		bvs	L819B				; Jump for Tube transfer
		bcs	L818E				; Jump for I/O read
;;
;;			    I/O write
		lda	($B2),Y				; Get byte from memory
.ifdef HD_SCSI_VFS
		eor	#$FF
.endif
		sta	SCSI_DATA			; Write to SCSI data port
.if .def(USE65C12) && (!.def(HD_SCSI_VFS))
		bra	L8193				; Jump to update address
.else
		bcc	L8193				; Jump to update address
.endif
;;
L818E:		lda	SCSI_DATA			; Read byte from SCSI data port
		sta	($B2),Y				; Store byte in memory
L8193:		iny					; Point to next byte
		bne	L817C				; Loop for 256 bytes
		inc	$B3				; Increment address high byte
		jmp	L817C				; Loop for next 256 bytes
;;
L819B:		bcs	L81A5				; Jump for Tube read
		lda	TUBEIO				; Get byte from Tube
.ifdef HD_SCSI_VFS
		eor	#$FF
.endif
		sta	SCSI_DATA			; Write byte to SCSI data port
.if .def(USE65C12) && (!.def(HD_SCSI_VFS))
		bra	L817C				; Loop for next byte
.else
		bcc	L817C				; Loop for next byte
.endif
;;
L81A5:		lda	SCSI_DATA			; Get byte from SCSI data port
		sta	TUBEIO				; Write to Tube
.if .def(USE65C12) && (!.def(HD_SCSI_VFS))
		bra	L817C				; Loop for next byte
.else
		bcs	L817C				; Loop for next byte
.endif
;;
CommandDone:						; L81AD
		jsr	TubeRelease			; Release Tube and restore screen
L81B0:		jsr	SCSI_WaitforReq			; Wait for SCSI data ready
		lda	SCSI_DATA			; Get result byte
		jsr	SCSI_WaitforReq			; Wait for SCSI data ready
		tay					; Save result
		jsr	SCSI_GetStatus			; Get SCSI status
		and	#$01
		beq	L81B0				; Loop to try to get result again
		tya					; Get result back
		ldx	SCSI_DATA				; Get second result byte
		beq	L81CA				; OK, jump to return result
		jmp	L82A5				; Return result=&7F
;;
L81CA:		tax					; Save result in X
		and	#$02				; Check b1
		beq	L81D2				; If b1=0, return with &00
		jmp	SCSI_RequestSense		; Get status from SCSI and return it
;;
L81D2:		lda	#$00				; A=0 - OK
L81D4:		ldx	$B0				; Restore XY pointer
		ldy	$B1
		and	#$7F				; Lose bit 7, set EQ from result
		rts					; Return with result in A

;; Not SCSI Read or Write
;; ----------------------
HD_DataTransfer256:
		ldy	#$00
		bit	ZP_ADFS_FLAGS			; Check ADFS status flag
		bvs	L821F				; Jump if Tube being used
L81E1:		jsr	SCSI_WaitforReq
		bmi	CommandDone			; Jump to get result and return
		bvs	L81F4
L81E8:		lda	($B2),Y
.ifdef HD_SCSI_VFS
		eor	#$FF
.endif
		sta	SCSI_DATA
		iny
		bne	L81E8
		inc	$B3
.ifdef USE65C12
		bra	L81E1
.else
		bvc	L81E1
.endif
;;
L81F4:		jsr	0
		lda	SCSI_DATA
		sta	($B2),Y
		iny
		bne	L81F4
		inc	$B3
.ifdef USE65C12
		bra	L81E1
.else
		bvs	L81E1
.endif
;;
L8200:		inc	WKSP_ADFS_228
		bne	L820D
		inc	WKSP_ADFS_229
		bne	L820D
		inc	WKSP_ADFS_22A
L820D:		ldx	#<WKSP_ADFS_227_TUBE_XFER
		ldy	#>WKSP_ADFS_227_TUBE_XFER
		rts

;;;  TubeStartXfer must be linked in here

		.segment "hd_driver_3"


L821F:		ldx	#<WKSP_ADFS_227_TUBE_XFER
		ldy	#>WKSP_ADFS_227_TUBE_XFER
L8223:		jsr	SCSI_WaitforReq
		bpl	L822B
		jmp	CommandDone			; Jump to get result and return
;;
L822B:		bvs	L8245
		php
		lda	#$06
		jsr	TubeStartXferSEI_406
L8233:		
.ifndef HD_SCSI_VFS
		nop					; 3xNOP delay for Tube I/O
		nop
		nop
.endif
		lda	TUBEIO				; Read from Tube
.ifdef HD_SCSI_VFS
		eor	#$FF
.endif
		sta	SCSI_DATA			; Write to SCSI data
		iny
		bne	L8233
		jsr	L8200
		plp
.ifdef USE65C12
		bra	L8223
.else
		bvc	L8223
.endif
;;
L8245:		php
		lda	#$07
		jsr	TubeStartXferSEI_406
L824B:		nop					; 3xNOP delay for Tube I/O
		nop
		nop
		lda	SCSI_DATA			; Read SCSI data
		sta	TUBEIO				; Write to Tube
		iny
		bne	L824B
		jsr	L8200
		plp
.ifdef USE65C12
		bra	L8223
.else
		bvs	L8223
.endif
;;
;; Read result from SCSI and return it as a result
;; -----------------------------------------------
SCSI_RequestSense:
		jsr	SCSI_StartCommand		; Set SCSI to command mode, returns Y=0
		lda	#$03
		tax
		tay
		jsr	SCSI_send_byteA			; Send &03 to SCSI
		lda	WKSP_ADFS_333_LASTACCDRV
		and	#$E0
		jsr	SCSI_send_byteA			; Send drive to SCSI
L826F:		jsr	SCSI_send_byteA			; Send &00 to SCSI
		dey
		bpl	L826F				; Send 4 zeros: sends &03 dd &00 &00 &00 &00
L8275:		jsr	SCSI_WaitforReq			; Wait for SCSI
		lda	SCSI_DATA			; Get byte from SCSI
		sta	WKSP_ADFS_2D0_ERR_SECTOR,X	; Store in error block
		dex
		bpl	L8275				; Loop to fetch four bytes, err, sec.hi, sec.mid, sec.lo
		lda	WKSP_ADFS_333_LASTACCDRV
.if HD_SCSI_VFS
		cmp	#$FF
		beq	L82A5
.endif
		and	#$E0
		ora	WKSP_ADFS_2D0_ERR_SECTOR+2	; ORA drive number with current drive
		sta	WKSP_ADFS_2D0_ERR_SECTOR+2
		jsr	SCSI_WaitforReq			; Wait for SCSI
		ldx	WKSP_ADFS_2D3_ERR_CODE		; Get returned error number
		lda	SCSI_DATA			; Get a byte from SCSI
		jsr	SCSI_WaitforReq			; Wait for SCSI
		ldy	SCSI_DATA			; Get another byte from SCSI
		bne	L82A5				; Second byte is non-zero, jump to return &7F
		and	#$02				; Test bit 1 of first byte
		bne	L82A5				; If set, jump to return &7F
		txa
		jmp	L81D4				; Return returned SCSI result
L82A5:		lda	#$FF				; Result=&FF
		jmp	L81D4				; Jump to return result
