;; ACCESS FLOPPY CONTROLLER
;; ========================

;; Pass SCSI command to floppy controller
;; --------------------------------------
IF TARGETOS = 0 AND HD_SCSI
		brk
ELIF TARGETOS <= 1
		EQUB	&2E
		EQUB	&0D
ENDIF
.DoFloppySCSICommandIND					; LBA4B	
		jmp	DoFloppySCSICommand		; Do a SCSI action with floppy drive
.ExecFloppyPartialSectorBufIND		
		jmp	ExecFloppyPartialSectorBuf	; Load a partial sector
.ExecFloppyWriteBPUTSectorIND		
		jmp	ExecFloppyWriteBPUTSector
.ExecFloppyReadBPUTSectorIND		
		jmp	ExecFloppyReadBPUTSector

.LBA57		lda	#&FF
		sta	WKSP_ADFS_2E4

IF TARGETOS <= 1
							
.floppy_check_present_bbc		
		lda	#&5A				; store 90 in track register
		sta	FDC_TRACK			
		lda	FDC_TRACK			
		cmp	#&5A				
		bne	LBA5Crts			; return NE ?? CC for not present
		lda	DRVSEL				
		and	#&03				
		beq	LBA5Crts			
		clc					
ENDIF
.LBA5Crts	rts

IF TARGETOS=0 AND HD_SCSI
	INCLUDE "floppy_elk.asm"
ENDIF

;;
.ExecFloppyWriteBPUTSector		
		lda	#&40
		bne	LBA63
.ExecFloppyReadBPUTSector		
		lda	#&C0
.LBA63		sta	WKSP_ADFS_2E0
		txa
		tsx
		stx	WKSP_ADFS_2E7_STKSAVE
		pha
IF TARGETOS=0 AND HD_SCSI
		jsr	elkLBB20
ENDIF
		jsr	FloppyGetStepRate
		jsr	LBBBE
IF USE65C12
		plx
ELSE
		pla
		tax
ENDIF
		bit	&A1
		bmi	LBA83
		lda	&BC
IF TARGETOS=0 AND HD_SCSI
		sta	&CE
ELSE
		sta	&0D00 + NMICODE_WR_OFFS + 1
ENDIF
		lda	&BD
IF TARGETOS=0 AND HD_SCSI
		sta	&CF
ELSE
		sta	&0D00 + NMICODE_WR_OFFS + 2	; set write source address
ENDIF
		bne	LBA8D
.LBA83		lda	&BE
IF TARGETOS=0 AND HD_SCSI
		sta	&CE
ELSE
		sta	&0D00 + NMICODE_RD_OFFS + 1
ENDIF
		lda	&BF
IF TARGETOS=0 AND HD_SCSI
		sta	&CF
ELSE
		sta	&0D00 + NMICODE_RD_OFFS + 2	; set read dest address
ENDIF
.LBA8D		lda	WKSP_ADFS_203,X
		pha
		and	#&1F
		beq	LBA99
.LBA95		pla
		jmp	LBF6F
;;
.LBA99		pla
		pha
		and	#&40
		bne	LBA95
		pla
		and	#&20
		bne	LBAA8
		lda	#FDCRES + FDCDS0
		bne	LBAAA
.LBAA8		lda	#FDCRES + FDCDS1
.LBAAA		sta	NMIVARS_SIDE
IF TARGETOS<>0 OR NOT(HD_SCSI)
IF USE65C12
		lda	#&01
		tsb	WKSP_ADFS_2E4
ELSE
		ror	WKSP_ADFS_2E4
		sec
		rol	WKSP_ADFS_2E4
ENDIF
ENDIF ; ELK SCSI
		lda	WKSP_ADFS_201,X
		pha
		lda	WKSP_ADFS_202,X
		tax
		pla
		ldy	#&FF
		jsr	XA_DIV16_TO_YA
		sta	&A4
		sty	&A5
		tya
		sec
		sbc	#&50
		bmi	LBACF
		sta	&A5
		jsr	FloppySetSide1
.LBACF		lda	NMIVARS_SIDE
		sta	DRVSEL				; Drive control register
		ror	A
		bcc	LBAE4
		lda	WKSP_ADFS_2E5
		sta	&A3
		bit	WKSP_ADFS_2E4
		bpl	LBAF1
		bmi	LBAEE
.LBAE4		lda	WKSP_ADFS_2E6
		sta	&A3
		bit	WKSP_ADFS_2E4
		bvc	LBAF1
.LBAEE		jsr	FloppyRestTrk0
.LBAF1		jsr	LBAFA
		jsr	LBD1E
		jmp	FloppyErrorA0or2E3
;;
.LBAFA		jsr	LBD46
		ldx	#&00
		jsr	LBB3B
		inx
		jsr	LBB3B
		inx
		jsr	LBB3B
		cmp	&A3
IF TARGETOS<>0 OR NOT(HD_SCSI)
		beq	LBB26
IF USE65C12
		lda	#&01
		tsb	WKSP_ADFS_2E4
ELSE
		ror	WKSP_ADFS_2E4
		sec
		rol	WKSP_ADFS_2E4
ENDIF
ENDIF
		lda	#&14
IF TARGETOS=0 AND HD_SCSI
		ora	NMIVARS_FDC_CMD_STEP
		jsr	FloppyWaitNMIFinish2elk
ELSE
		ora	NMIVARS_FDC_CMD_STEP
		sta	FDC_CMD				; FDC Status/Command
		jsr	FloppyWaitNMIFinish
ENDIF ; ELK SCSI
		lda	&A1
		ror	A
		bcc	LBB26
.LBB23		jmp	FloppyErrorA0or2E3
;;
.LBB26		lda	&A5
		sta	&A3
		bit	&A1
		bvs	LBB38
		ldy	#&05
		lda	(&B0),Y				; Command
		cmp	#&0B
		bne	LBB38
		beq	LBB23
.LBB38		jmp	LBD46
;;
.LBB3B		lda	&A3,X
.LBB3D		sta	FDC_TRACK,X			; Store in FDC Track/Sector
		cmp	FDC_TRACK,X			; Keep storing until it stays there
IF TARGETOS <= 1
		bne	LBB3B				; TODO: this is silly but keep byte perfect for now
ELSE
		bne	LBB3D
ENDIF
		rts
;;
;;
;; Access Floppy Disk Controller
;; -----------------------------
.DoFloppySCSICommand					; LBB46
		tsx
		stx	WKSP_ADFS_2E7_STKSAVE			; Save stack pointer
IF TARGETOS=0 AND HD_SCSI
		jsr	elkLBB20
ENDIF
		lda	#&10
		sta	WKSP_ADFS_2E0
		jsr	LBB72				; Check and set up address, command, sector, track
		jsr	LBDBA
		beq	LBB23				; EQ, jump to restore and return disk result

; Enter here to load a partial sector
.ExecFloppyPartialSectorBuf		sta	WKSP_ADFS_2E2			; Store where to load partial sector to
		tsx
		stx	WKSP_ADFS_2E7_STKSAVE
IF TARGETOS=0 AND HD_SCSI
		jsr	elkLBB20
ENDIF
		lda	#>WKSP_ADFS_215_DSKOPSAV_RET			; Point to copy of command block in workspace
		sta	&B1
		lda	#<WKSP_ADFS_215_DSKOPSAV_RET
		sta	&B0

IF USE65C12
		stz	WKSP_ADFS_2E0
ELSE
		lda	#0
		sta	WKSP_ADFS_2E0
ENDIF
		jsr	LBB72
		jsr	LBD6E
		jmp	FloppyErrorA0or2E3				; Jump to restore and return disk result
;;
.LBB72
IF USE65C12
		stz	WKSP_ADFS_2E3_ERR_NO
ELSE
		lda	#0
		sta	WKSP_ADFS_2E3_ERR_NO
ENDIF
		ldy	#&01				; Point to address
		lda	(&B0),Y
		sta	&B2
		iny
		lda	(&B0),Y
		sta	&B3				; &B2/3=>Address low word
		iny
		lda	(&B0),Y				; Address byte 3
		tax
		iny
		lda	(&B0),Y				; Address byte 4
		inx
		beq	LBB8D
		inx
		bne	LBB91
.LBB8D		cmp	#&FF
		beq	LBB98
.LBB91		bit	ZP_ADFS_FLAGS
		bpl	LBB98
		jsr	TUBE_CLAIM_IF_PRESENT
.LBB98		ldy	#&05
		lda	(&B0),Y				; Get command
		cmp	#&08
		beq	LBBB0				; Jump with Read
		cmp	#&0A
		beq	LBBB5				; Jump with Write
		cmp	#&0B
		beq	LBBB0				; Jump with Seek
		lda	#&67				; Floppy error &27 'Unsupported command'
		sta	WKSP_ADFS_2E3_ERR_NO			; Store result in control block
		jmp	FloppyErrorA0or2E3				; Jump to return with result=&67
							;(&C2E0 AND &20)=0 so result in &A0 will not be copied to &C2E3
;
; Read from floppy
; ----------------
.LBBB0
IF USE65C12
		lda	#&80
		tsb	WKSP_ADFS_2E0			; Set 'reading'
ELSE
		rol	WKSP_ADFS_2E0			; Set 'reading'
		sec
		ror	WKSP_ADFS_2E0

ENDIF
;
; Write to floppy
; ---------------
.LBBB5		jsr	FloppyGetStepRate				; Get disk settings from configuration
		jsr	LBBBE				; Set up NMIs
		jmp	LBF0A				; Jump to check sector and calculate track/sector
;
.LBBBE		jsr	LBC01				; Claim NMIs
		lda	WKSP_ADFS_2E8_FDC_CMD_STEP
		sta	NMIVARS_FDC_CMD_STEP
IF USE65C12
		stz	&A0				; Clear error
		stz	&A2
ELSE
		lda	#0
		sta	&A0				; Clear error
		sta	&A2
ENDIF
		lda	WKSP_ADFS_2E0			; b7=0=floppy write, 1=floppy read
		ora	#&20				; b5=hardware has been accessed
		sta	WKSP_ADFS_2E0
		sta	&A1
		lda	ZP_ADFS_FLAGS
		sta	NMIVARS_FLAGS_SAVE
IF TARGETOS=0 AND HD_SCSI
		jsr	CopyCodeToNMISpace2Elk		; Copy NMI code to NMI space
ELSE
		jsr	CopyCodeToNMISpace		; Copy NMI code to NMI space
ENDIF
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
.FloppyGetStepRate
IF USE65C12
		stz	NMIVARS_CMD_PRECOMP		; Set to zero
		stz	WKSP_ADFS_2E8_FDC_CMD_STEP			; Set to zero
ELSE
IF TARGETOS<>0 OR NOT(HD_SCSI)
		lda	#0
		sta	NMIVARS_CMD_PRECOMP		; Set to zero
		sta	WKSP_ADFS_2E8_FDC_CMD_STEP			; Set to zero
ENDIF	;65c12
ENDIF	;OPT2

IF TARGETOS > 1
		ldx	#CMOS_ADFS			; &0B=ADFS CMOS byte
		lda	#OSBYTE_A1_READ_CMOS		; &A1=Read CMOS
		jsr	OSBYTE				; Read ADFS CMOS byte
		tya
		pha
		and	#&02
ELSE
		lda	#OSBYTE_FF_RW_STARTOPT
		ldx	#0
		tay
		jsr	OSBYTE				; Read ADFS CMOS byte
		txa
IF TARGETOS=0 AND HD_SCSI
		eor 	#&FF
		ror 	a
		ror 	a
		ror 	a
		ror 	a
		pha
		and	#&03
		tax
		pla
		ror	a
		and	#&02
		sta	NMIVARS_CMD_PRECOMP
		stx	WKSP_ADFS_2E8_FDC_CMD_STEP
ELSE
		pha
		and	#&20
ENDIF
ENDIF	;TARGETOS=0

IF TARGETOS<>0 OR NOT(HD_SCSI)
		beq	LBBF6
		lda	#&03
		sta	WKSP_ADFS_2E8_FDC_CMD_STEP			; If FDrive=2,3,6,7 set &C2E8=3
.LBBF6		pla
		and	#CONFIG_BIT_FD_SPEED
		beq	LBC00
		lda	#&02				; If FDrive=1,3,5,7 set NMIVARS_CMD_PRECOMP=2
		sta	NMIVARS_CMD_PRECOMP
ENDIF ; ELK SCSI
.LBC00		rts

; Claim NMI space
; ---------------
.LBC01
		lda	#&8F
		ldx	#&0C
		ldy	#&FF
		jsr	OSBYTE				; Claim NMI space
		sty	WKSP_ADFS_2E1			; Store previous owner's ID
		rts

;; Release NMI space
;; -----------------
.LBC0E		ldy	WKSP_ADFS_2E1			; Get previous owner's ID
		lda	#&8F
		ldx	#&0B
		jmp	OSBYTE				; Release NMI


NMIVARS_CMD_PRECOMP		= &0D56			; bit 2 set if precomp
NMIVARS_TRACK_COUNT		= &0D57
NMIVARS_SECTOR_COUNT		= &0D58			; sector count?
NMIVARS_SECTOR			= &0D59			; sector number? 
NMIVARS_SECTORS_THIS_TRACK	= &0D5A
NMIVARS_FDC_CMD_STEP		= &0D5C			; bits 0/1 set to step rate
NMIVARS_FLAGS_SAVE 		= &0D5D			; ZP_ADFS_FLAGS is put here before an NMI transfer
NMIVARS_SIDE			= &0D5E			; side of disk
NMIVAR_WTF			= &0D5F			; gets set but not read?


IF TARGETOS=0 AND HD_SCSI
		INCLUDE "floppy_nmi_A.asm"
		INCLUDE "floppy_nmi_D.asm"
ELSE
		INCLUDE "floppy_nmi_B.asm"
		INCLUDE "floppy_nmi_A.asm"
		INCLUDE "floppy_nmi_C.asm"
		INCLUDE "floppy_nmi_D.asm"
ENDIF
