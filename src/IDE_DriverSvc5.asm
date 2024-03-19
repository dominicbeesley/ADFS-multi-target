		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.export Svc5_IRQ
		.export LABB4
		.export UpdateDrive

		.segment "hd_driver_svc5"

;;
;; Service 5 - Interupt occured
;; ============================
Svc5_IRQ:	rts					; Remove IRQ routine
UpdateDrive:
		lda	$85				; Merge with current drive
		ora	WKSP_ADFS_317_CURDRV
		sta	$85
		sta	WKSP_ADFS_333_LASTACCDRV	; Store for any error
		lda	#$7F
		rts
.if TARGETOS > 0
GetChar:
		lda	($F2),Y
		cmp	#$20
		rts
		.dword	0,0,0
		.dword	0,0,0
.if TARGETOS = 1
		.byte	0,0
.endif ; TARGETOS = 1
.else ; TARGETOS = 0
		nop
		lda	#$05
		rts

		tya
		pha
		lda	#$00
		sta     IDE_SEC_NO                      ; AB8E 8D 43 FC                 .C.
        	ror     ZP_ADFS_FLAGS                   ; AB91 66 CD                    f.
        	clc                                     ; CLEAR bit 0 - ADFS_FLAGS_ENSURING
        	rol     ZP_ADFS_FLAGS                   ; AB94 26 CD                    &.
        	lda     IDE_DATA                         ; AB96 AD 40 FC                 .@.
        	jsr     IDE_WaitforReq                   ; AB99 20 0F 83                  ..
        	ora     IDE_DATA                        ; AB9C 0D 40 FC                 .@.
        	sta     $1131                           ; AB9F 8D 31 11                 .1.
        	jmp     L9DB4			        ; ABA2 4C 63 9D
.endif ; TARGETOS = 0

; Check for data loss
; ===================
; IDE and MMC don't have IRQ handlers, this never happens	; TODO: get rid then?!?
LABB4:		lda	WKSP_ADFS_331			; Get SCSI result from IRQ handler
		beq	LABE6				; Ok, jump forward to exit
		lda	#$00
		sta	WKSP_ADFS_331			; Clear the flag
		ldx	WKSP_ADFS_2D4			; Get channel being used
		jsr	GenerateErrorSuffX				; Generate 'Data lost' error with X=channel
		.byte	$CA				; ERR=202
		.byte	"Data lost, channel"
		.byte	$00
