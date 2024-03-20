		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.export HD_BPUT_WriteSector
		.export ResultCodes

		.segment "hd_driver_bput"

; Note: this file also contains the service call 5 / IRQ code for this device

;;
;; BPUT to hard drive
;; --------------------
HD_BPUT_WriteSector:
		ldx	$C1				; Get offset to current channel info
		lda	#$0A				; &0A - Write
		jsr	HD_CommandBGETBPUTsector	; Send command block to SCSI/IDE/SD
		ldy	#$00
		jsr	IDE_WaitforReq			; Wait for IDE not busy
.if TARGETOS = 0
	.ifndef IDE_HOG_TMP
		nop					; TODO: Ask JGH - is this necessary?
	.endif
.endif
		jmp	LAB76				; Always jump to write
.if TARGETOS = 0
ResultCodes:
		.byte	$FF
		.byte	$FF
		.byte	$60
		.byte	$FF
		.byte	$50
		.byte	$65
		.byte	$48
		.byte	$FF

.else ; TARGETOS > 0
ResultCodes:
		.byte	$12
		.byte	$06
		.byte	$2F
		.byte	$02
		.byte	$10
		.byte	$28
		.byte	$11
		.byte	$19
		.byte	$03
.endif ; TARGETOS > 0 and HD_IDE

;;
;; Write a BPUT buffer to hard drive
;; ---------------------------------
LAB76:		lda	($BC),Y				; Get byte from buffer
		sta	IDE_DATA			; Send to hard drive
		iny
		bne	LAB76				; Loop for 256 bytes
.ifdef USE65C12
		lda	#ADFS_FLAGS_ENSURING
		tsb	ZP_ADFS_FLAGS			; set 'files being updated' bit
.else
		lda	#ADFS_FLAGS_ENSURING
		ora	ZP_ADFS_FLAGS			; set 'files being updated' bit
		sta	ZP_ADFS_FLAGS
.endif
		dey
	.ifndef IDE_HOG_TMP
		nop					; Don't trample on IDE register
		nop
		nop
	.endif




