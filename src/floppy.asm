		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"
		.include "nmivars.inc"

		.export DoFloppySCSICommand
		.export DoFloppySCSICommandIND
		.export ExecFloppyReadBPUTSector
		.export ExecFloppyReadBPUTSectorIND
		.export ExecFloppyPartialSectorBuf
		.export ExecFloppyPartialSectorBufIND
		.export ExecFloppyWriteBPUTSectorIND

		.export LBA57
		.export LBAFA
		.export LBB3B
		.export LBC0E

.if TARGETOS <= 1
		.export floppy_check_present_bbc
.endif

		.segment "floppy"

;; ACCESS FLOPPY CONTROLLER
;; ========================

;; Pass SCSI command to floppy controller
;; --------------------------------------
.if TARGETOS = 0 && .def(HD_SCSI)
		brk
.elseif TARGETOS <= 1
		.byte	$2E
		.byte	$0D
.endif
DoFloppySCSICommandIND:					; LBA4B
		jmp	DoFloppySCSICommand		; Do a SCSI action with floppy drive
ExecFloppyPartialSectorBufIND:
		jmp	ExecFloppyPartialSectorBuf	; Load a partial sector
ExecFloppyWriteBPUTSectorIND:
		jmp	ExecFloppyWriteBPUTSector
ExecFloppyReadBPUTSectorIND:
		jmp	ExecFloppyReadBPUTSector

LBA57:		lda	#$FF
		sta	WKSP_ADFS_2E4

.if TARGETOS <= 1

floppy_check_present_bbc:
		lda	#$5A				; store 90 in track register
		sta	FDC_TRACK
		lda	FDC_TRACK
		cmp	#$5A
		bne	LBA5Crts			; return NE ?? CC for not present
		lda	DRVSEL
		and	#$03
		beq	LBA5Crts
		clc
.endif
LBA5Crts:	rts



		.segment "floppy_3"

;;
ExecFloppyWriteBPUTSector:
		lda	#$40
		bne	LBA63
ExecFloppyReadBPUTSector:
		lda	#$C0
LBA63:		sta	WKSP_ADFS_2E0
		txa
		tsx
		stx	WKSP_ADFS_2E7_STKSAVE
		pha
.if TARGETOS=0 && .def(HD_SCSI)
		jsr	FloppyElkBeforeNMI
.endif
		jsr	FloppyGetStepRate
		jsr	LBBBE
.ifdef USE65C12
		plx
.else
		pla
		tax
.endif
		bit	$A1
		bmi	LBA83
		lda	$BC
.if TARGETOS=0 && .def(HD_SCSI)
		sta	ZP_ELK_CE_NMIPTR
.else
		sta	a:$0D00 + NMICODE_WR_OFFS + 1
.endif
		lda	$BD
.if TARGETOS=0 && .def(HD_SCSI)
		sta	ZP_ELK_CE_NMIPTR+1
.else
		sta	a:$0D00 + NMICODE_WR_OFFS + 2	; set write source address
.endif
		bne	LBA8D
LBA83:		lda	$BE
.if TARGETOS=0 && .def(HD_SCSI)
		sta	ZP_ELK_CE_NMIPTR
.else
		sta	a:$0D00 + NMICODE_RD_OFFS + 1
.endif
		lda	$BF
.if TARGETOS=0 && .def(HD_SCSI)
		sta	ZP_ELK_CE_NMIPTR+1
.else
		sta	a:$0D00 + NMICODE_RD_OFFS + 2	; set read dest address
.endif
LBA8D:		lda	WKSP_ADFS_203,X
		pha
		and	#$1F
		beq	LBA99
LBA95:		pla
		jmp	LBF6F
;;
LBA99:		pla
		pha
		and	#$40
		bne	LBA95
		pla
		and	#$20
		bne	LBAA8
		lda	#FDCRES + FDCDS0
		bne	LBAAA
LBAA8:		lda	#FDCRES + FDCDS1
LBAAA:		sta	NMIVARS_SIDE
.if TARGETOS<>0 || (!.def(HD_SCSI))
.ifdef USE65C12
		lda	#$01
		tsb	WKSP_ADFS_2E4
.else
		ror	WKSP_ADFS_2E4
		sec
		rol	WKSP_ADFS_2E4
.endif
.endif ; ELK SCSI
		lda	WKSP_ADFS_201,X
		pha
		lda	WKSP_ADFS_202,X
		tax
		pla
		ldy	#$FF
		jsr	XA_DIV16_TO_YA
		sta	$A4
		sty	$A5
		tya
		sec
		sbc	#$50
		bmi	LBACF
		sta	$A5
		jsr	FloppySetSide1
LBACF:		lda	NMIVARS_SIDE
		sta	DRVSEL				; Drive control register
		ror	A
		bcc	LBAE4
		lda	WKSP_ADFS_2E5
		sta	$A3
		bit	WKSP_ADFS_2E4
		bpl	LBAF1
		bmi	LBAEE
LBAE4:		lda	WKSP_ADFS_2E6
		sta	$A3
		bit	WKSP_ADFS_2E4
		bvc	LBAF1
LBAEE:		jsr	FloppyRestTrk0
LBAF1:		jsr	LBAFA
		jsr	LBD1E
		jmp	FloppyErrorA0or2E3
;;
LBAFA:		jsr	LBD46
		ldx	#$00
		jsr	LBB3B
		inx
		jsr	LBB3B
		inx
		jsr	LBB3B
		cmp	$A3
.if TARGETOS<>0 || (!.def(HD_SCSI))
		beq	LBB26
.ifdef USE65C12
		lda	#$01
		tsb	WKSP_ADFS_2E4
.else
		ror	WKSP_ADFS_2E4
		sec
		rol	WKSP_ADFS_2E4
.endif
.endif
		lda	#$14
.if TARGETOS=0 && .def(HD_SCSI)
		ora	NMIVARS_FDC_CMD_STEP
		jsr	FloppyWaitNMIFinish2elk
.else
		ora	NMIVARS_FDC_CMD_STEP
		sta	FDC_CMD				; FDC Status/Command
		jsr	FloppyWaitNMIFinish
.endif ; ELK SCSI
		lda	$A1
		ror	A
		bcc	LBB26
LBB23:		jmp	FloppyErrorA0or2E3
;;
LBB26:		lda	$A5
		sta	$A3
		bit	$A1
		bvs	LBB38
		ldy	#$05
		lda	($B0),Y				; Command
		cmp	#$0B
		bne	LBB38
		beq	LBB23
LBB38:		jmp	LBD46
;;
LBB3B:		lda	$A3,X
LBB3D:		sta	FDC_TRACK,X			; Store in FDC Track/Sector
		cmp	FDC_TRACK,X			; Keep storing until it stays there
.if TARGETOS <= 1
		bne	LBB3B				; TODO: this is silly but keep byte perfect for now
.else
		bne	LBB3D
.endif
		rts
;;
;;
;; Access Floppy Disk Controller
;; -----------------------------
DoFloppySCSICommand:					; LBB46
		tsx
		stx	WKSP_ADFS_2E7_STKSAVE			; Save stack pointer
.if TARGETOS=0 && .def(HD_SCSI)
		jsr	FloppyElkBeforeNMI
.endif
		lda	#$10
		sta	WKSP_ADFS_2E0
		jsr	LBB72				; Check and set up address, command, sector, track
		jsr	LBDBA
		beq	LBB23				; EQ, jump to restore and return disk result

; Enter here to load a partial sector
ExecFloppyPartialSectorBuf:		sta	WKSP_ADFS_2E2			; Store where to load partial sector to
		tsx
		stx	WKSP_ADFS_2E7_STKSAVE
.if TARGETOS=0 && .def(HD_SCSI)
		jsr	FloppyElkBeforeNMI
.endif
		lda	#>WKSP_ADFS_215_DSKOPSAV_RET			; Point to copy of command block in workspace
		sta	$B1
		lda	#<WKSP_ADFS_215_DSKOPSAV_RET
		sta	$B0

.ifdef USE65C12
		stz	WKSP_ADFS_2E0
.else
		lda	#0
		sta	WKSP_ADFS_2E0
.endif
		jsr	LBB72
		jsr	LBD6E
		jmp	FloppyErrorA0or2E3				; Jump to restore and return disk result
;;
LBB72:
.ifdef USE65C12
		stz	WKSP_ADFS_2E3_ERR_NO
.else
		lda	#0
		sta	WKSP_ADFS_2E3_ERR_NO
.endif
		ldy	#$01				; Point to address
		lda	($B0),Y
		sta	$B2
		iny
		lda	($B0),Y
		sta	$B3				; &B2/3=>Address low word
		iny
		lda	($B0),Y				; Address byte 3
		tax
		iny
		lda	($B0),Y				; Address byte 4
		inx
		beq	LBB8D
		inx
		bne	LBB91
LBB8D:		cmp	#$FF
		beq	LBB98
LBB91:		bit	ZP_ADFS_FLAGS
		bpl	LBB98
		jsr	TUBE_CLAIM_IF_PRESENT
LBB98:		ldy	#$05
		lda	($B0),Y				; Get command
		cmp	#$08
		beq	LBBB0				; Jump with Read
		cmp	#$0A
		beq	LBBB5				; Jump with Write
		cmp	#$0B
		beq	LBBB0				; Jump with Seek
		lda	#$67				; Floppy error &27 'Unsupported command'
		sta	WKSP_ADFS_2E3_ERR_NO			; Store result in control block
		jmp	FloppyErrorA0or2E3				; Jump to return with result=&67
							;(&C2E0 AND &20)=0 so result in &A0 will not be copied to &C2E3
;
; Read from floppy
; ----------------
LBBB0:
.ifdef USE65C12
		lda	#$80
		tsb	WKSP_ADFS_2E0			; Set 'reading'
.else
		rol	WKSP_ADFS_2E0			; Set 'reading'
		sec
		ror	WKSP_ADFS_2E0

.endif
;
; Write to floppy
; ---------------
LBBB5:		jsr	FloppyGetStepRate				; Get disk settings from configuration
		jsr	LBBBE				; Set up NMIs
		jmp	LBF0A				; Jump to check sector and calculate track/sector
;
LBBBE:		jsr	LBC01				; Claim NMIs
		lda	WKSP_ADFS_2E8_FDC_CMD_STEP
		sta	NMIVARS_FDC_CMD_STEP
.ifdef USE65C12
		stz	$A0				; Clear error
		stz	$A2
.else
		lda	#0
		sta	$A0				; Clear error
		sta	$A2
.endif
		lda	WKSP_ADFS_2E0			; b7=0=floppy write, 1=floppy read
		ora	#$20				; b5=hardware has been accessed
		sta	WKSP_ADFS_2E0
		sta	$A1
		lda	ZP_ADFS_FLAGS
		sta	NMIVARS_FLAGS_SAVE
		jsr	CopyCodeToNMISpace		; Copy NMI code to NMI space
		rts					; Don't optimise out to JMP

; Set disk stepping speed from configuration
; ------------------------------------------
; ADFS CMOS byte
;  b7    Floppy/Hard
;  b6    NoDir/Dir
;  b5    (Caps)
;  b4    (NoCaps)
;  b3    (ShCaps)
;  b2-b0 FDrive
;
FloppyGetStepRate:
.ifdef USE65C12
		stz	NMIVARS_CMD_PRECOMP		; Set to zero
		stz	WKSP_ADFS_2E8_FDC_CMD_STEP			; Set to zero
.else
.if TARGETOS<>0 || (!.def(HD_SCSI))
		lda	#0
		sta	NMIVARS_CMD_PRECOMP		; Set to zero
		sta	WKSP_ADFS_2E8_FDC_CMD_STEP			; Set to zero
.endif	;65c12
.endif	;OPT2

.if TARGETOS > 1
		ldx	#CMOS_ADFS			; &0B=ADFS CMOS byte
		lda	#OSBYTE_A1_READ_CMOS		; &A1=Read CMOS
		jsr	OSBYTE				; Read ADFS CMOS byte
		tya
		pha
		and	#$02
.else
		lda	#OSBYTE_FF_RW_STARTOPT
		ldx	#0
		tay
		jsr	OSBYTE				; Read ADFS CMOS byte
		txa
.if TARGETOS=0 && .def(HD_SCSI)
		eor 	#$FF				; invert options
		ror 	a
		ror 	a
		ror 	a
		ror 	a				; ror 4, bit 2=precomp, 0-1=step rate
		pha			
		and	#$03
		tax					; X= step rate
		pla
		ror	a
		and	#$02
		sta	NMIVARS_CMD_PRECOMP		; set pre comp
		stx	WKSP_ADFS_2E8_FDC_CMD_STEP		; store step rate
.else
		pha
		and	#$20
.endif
.endif	;TARGETOS=0

.if TARGETOS<>0 || (!.def(HD_SCSI))
		beq	LBBF6
		lda	#$03
		sta	WKSP_ADFS_2E8_FDC_CMD_STEP		; If FDrive=2,3,6,7 set &C2E8=3
LBBF6:		pla
		and	#CONFIG_BIT_FD_SPEED
		beq	LBC00
		lda	#$02				; If FDrive=1,3,5,7 set NMIVARS_CMD_PRECOMP=2
		sta	NMIVARS_CMD_PRECOMP
.endif ; !ELK SCSI
LBC00:		rts

; Claim NMI space
; ---------------
LBC01:
		lda	#OSBYTE_8F_ISSUE_SERV
		ldx	#SERVICE_0C_CLAIM_NMI
		ldy	#$FF
		jsr	OSBYTE				; Claim NMI space
		sty	WKSP_ADFS_2E1			; Store previous owner's ID
		rts

;; Release NMI space
;; -----------------
LBC0E:		ldy	WKSP_ADFS_2E1			; Get previous owner's ID
		lda	#OSBYTE_8F_ISSUE_SERV
		ldx	#SERVICE_0B_RELEASE_NMI
		jmp	OSBYTE				; Release NMI



