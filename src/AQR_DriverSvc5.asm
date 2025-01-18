		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.export Svc5_IRQ
		.export LABB4
		.segment "hd_driver_svc5"


;;
;; Service 5 - Interupt occured
;; ============================
Svc5_IRQ:	rts

LABB4:
.if .def(ELK_PRES_E00) && (!.def(ELK_PRES_E00_126))
		lda	ZP_ELK_CE_NMIPTR		; Get SCSI result from IRQ handler
		beq	LABE6				; Ok, jump forward to exit
		lda	#$00
		sta	ZP_ELK_CE_NMIPTR		; Clear the flag
.else
		lda	WKSP_ADFS_331			; Get SCSI result from IRQ handler
		beq	LABE6				; Ok, jump forward to exit
		lda	#$00
		sta	WKSP_ADFS_331			; Clear the flag
.endif
		ldx	WKSP_ADFS_2D4			; Get channel being used
		jsr	GenerateErrorSuffX				; Generate 'Data lost' error with X=channel
		.byte	$CA				; ERR=202
		.byte	"Data lost, channel"
		.byte	$00
