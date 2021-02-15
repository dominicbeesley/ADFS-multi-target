;;
;; Hard drive hardware is present. Check what drive is being accessed.
;;
.HD_Command
IF OPTIMISE<6
              ldy    #&06
              lda    (&B0),Y                            ; Get drive
              ora    WKSP_ADFS_317_CURDRV        ; OR with current drive
ELSE
              jsr    GetDrive
ENDIF
IF FLOPPY
              bmi    CommandExecFloppyOp         ; Jump back with 4,5,6,7 as floppies
ENDIF
              ldy    #&00
              nop

              include "TubeCheckAddrAndClaim.asm"

; Do a data transfer to/from a hard drive device
; ----------------------------------------------

IF TARGETOS = 0
		jmp	_lelkA0C4
		nop
		nop
		nop
		nop

ELSE
							;Do an IDE data transfer
							;-----------------------
		ldy	#5				; Get command
		lda	(&B0),Y
		cmp	#&09				; CC=Read, CS=Write
		and	#&FD				; Jump if Read (&08) or Write (&0A)
		eor	#&08
		beq	CommandOk
		lda	#&27				; Return 'unsupported command' otherwise
		bne	CommandExit
ENDIF ;TARGETOS = 0
.CommandOk
		ldy	#9
.CommandSaveLp
		lda	&7F,Y				; Save &80-&89 and copy block
		pha
		lda	(&B0),Y
		sta	&7F,Y
		dey
		bne	CommandSaveLp
		lda	&B0
		pha
		lda	&B1
		pha
		jsr	UpdateDrive			; Merge drive, returns A=&7F, Y is still &00
		sta	&B0				; Point to block in RAM at &007F+1
		sty	&B1
		php					; Set shape to c*4*64
		jsr	SetGeometry
		plp
.CommandLoop
;		ldx	#2
;.Twice							; First pass to seek sector
		bit	ZP_ADFS_FLAGS
		bvc	CommandStart			; Accessing I/O memory
		php
IF USE65C12 AND OPTIMISE > 1
		phx					; DB: correction - was plx!
ELSE
		txa
		pha
ENDIF
		ldx	#<WKSP_ADFS_227_TUBE_XFER	; Point to address block
		ldy	#>WKSP_ADFS_227_TUBE_XFER
IF TARGETOS = 0 
		lda	#0
		rol	a
		eor	#1				; why?
		jsr	TubeStartXfer406
ELSE
		jsr	TubeAction			; Set Tube action
ENDIF
IF USE65C12 AND OPTIMISE >= 1
		plx
ELSE
		pla
		tax
ENDIF
		plp
.CommandStart						; C=R/W, &B0/1=>block
		jsr	SetSector			; Set sector, count, command

		; once busy has gone low we don't need to test for each byte?!?
		jsr	WaitForData
		and	#&21
		bne	TransDone

.TransferLoop
		bit	ZP_ADFS_FLAGS
		bvs	TransTube
		bcc	IORead
.IOWrite
		lda	(&80),Y
		sta	IDE_DATA
		iny
		bne	IOWrite
		beq	TransferBytesDone


.IORead
		lda	IDE_DATA
		sta	(&80),Y
		iny
		bne	IORead
		beq	TransferBytesDone

IF TARGETOS = 0
;;; TODO: what's all this then!?
.TransTube
		bcc     _lelk817E                       ; 8173 90 09                    ..
        	sbc     $EDED                           ; 8175 ED ED ED                 ...
        	sbc     $EDED                           ; 8178 ED ED ED                 ...
        	jmp     TransferByte                    ; 817B 4C 99 81                 L..

; ----------------------------------------------------------------------------
._lelk817E	sbc     $EDED                           ; 817E ED ED ED                 ...
        	sbc     $EDED                           ; 8181 ED ED ED                 ...
        	jmp     TransferByte                    ; 8184 4C 99 81                 L..

; ----------------------------------------------------------------------------
._lelk8187  	jmp     CommandLoop                     ; 8187 4C 3B 81                 L;.
ELSE ; TARGETOS > 0
.TransTube
		bcc	TubeRead
.TubeWrite	lda	TUBEIOSTAT
		bpl	TubeWrite
		lda	TUBEIO
		sta	IDE_DATA
		iny
		bne	TubeWrite
		beq	TransferBytesDone


.TubeRead	lda	IDE_DATA
.TubeReadW	bit	TUBEIOSTAT
		bvc	TubeReadW
		sta	TUBEIO
		iny
		bne	TubeRead
		beq	TransferBytesDone


ENDIF ; TARGETOS > 0

.L81AD							; Aligned to L81AD
IF L81AD<>&81AD
		print	L81AD
;;	ERROR "L81AD/CommandDone must be anchored at &81AD"
ENDIF
.CommandDone
		jsr	IDE_GetResult			; Get IDE result
.CommandExit
		pha
		jsr	TubeRelease				; Release Tube
		pla
		ldx	&B0				; Restore registers, set EQ flag
		ldy	&B1
		and	#&7F
		rts
;;.TransferByte
;;		iny					; Loop for 256 bytes
;;		bne	TransferLoop
;;;		dex
;;;		bne	Twice				; Second pass to do real transfer


.TransferBytesDone

		inc	&81
		lda	IDE_STATUS
		and	#&21
		bne	TransDone			; Error occured
		inc	WKSP_ADFS_228
		bne	TubeAddr			; Increment Tube address
		inc	WKSP_ADFS_229
		bne	TubeAddr
		inc	WKSP_ADFS_22A
.TubeAddr
		inc	&87				; Increment sector
		bne	TransCount
		inc	&86
		bne	TransCount
		inc	&85
.TransCount
		dec	&88				; Loop for all sectors
IF TARGETOS = 0
		bne	_lelk8187
ELSE
		beq	TransDone
		jmp	CommandLoop			; Done, check for errors
ENDIF
.TransDone
		pla					; Restore pointer
		sta	&B1
		pla
		sta	&B0
		iny
.CommandRestore						; Restore memory
		pla
		sta	&7F,Y
		iny
		cpy	#10
		bne	CommandRestore
		beq	CommandDone			; Jump to get result

.SetGeometry
		jsr	IDE_WaitforReq
		lda	#64				; 64 sectors per track
		sta	IDE_SEC_CT
		sta	IDE_SEC_NO
		ldy	#6				; Get drive number
		lda	(&B0),Y
		lsr	A
		lsr	A
		ora	#3
		jsr	IDE_SetDriveHeadA
		lda	#&91
		bne	IDE_SetCmd				; 4 heads per cylinder


		include	"TubeStartXfer.asm"

IF TARGETOS > 0
.TubeAction
		lda	#0				; Set Tube action
		rol	A				; A=0/1 for Read/Write
		eor	#1				; A=1/0 for Read/Write
		bcc	TubeStartXfer406				; Start Tube transfer
ENDIF
.SetSector
		php
		jsr	IDE_WaitforReq			; Save CC/CS Read/Write
		ldy	#8
		lda	#1				; One sector
		sta	IDE_SEC_CT
		clc					; Set sector b0-b5
		lda	(&B0),Y
		and	#63
		adc	#1
		sta	IDE_SEC_NO
		dey					; Set sector b8-b15 Y=7
		lda	(&B0),Y
IF TARGETOS = 0
		adc	#0				; TODO: ASK JGH
ENDIF
		sta	IDE_CYL_NO_LO
		dey					; Set sector b16-b21 Y=6
		lda	(&B0),Y
		jsr	IDE_SetCylinderHi
		iny					; Merge Drive and Head Y=7
		iny					; Y=8
		eor	(&B0),Y
		and	#2
		eor	(&B0),Y
		jsr	IDE_SetDriveHead			; Get SCSI command &08 or &0A
		dey
		dey
		dey
		lda	(&B0),Y
.SetCommand
IF TARGETOS > 0
		asl	A				; Convert &08/&0A to &20/&30
		asl	A
		asl	A
		eor	#&60
ELSE
		and     #$02                            ; 822F 29 02                    ).
        	pha                                     ; 8231 48                       H
        	eor     #$02                            ; 8232 49 02                    I.
        	lsr     a                               ; 8234 4A                       J
        	lsr     a                               ; 8235 4A                       J
        	pla                                     ; 8236 68                       h
        	asl     a                               ; 8237 0A                       .
        	asl     a                               ; 8238 0A                       .
        	asl     a                               ; 8239 0A                       .
        	ora     #$20                            ; 823A 09 20                    . 
ENDIF
		ldy	#0				; Set IDE command &20 or &30
		plp					; Get CC/CS Read/Write back
.IDE_SetCmd
		sta	IDE_STATUS
		rts
.IDE_SetDriveHead
		rol	A				; Move into position
		rol	A
		rol	A
.IDE_SetDriveHeadA
		and	#&13				; Set device + sector b6-b7
		sta	IDE_DRVHEAD
		rts
.IDE_SetCylinderHi
		pha					; Set sector b16-b21
		and	#&3F
IF TARGETOS = 0
		adc	#0
ENDIF
		sta	IDE_CYL_NO_HI
		pla					; Get Drive 0-1/2-3 into b1
		rol	A
		rol	A
		rol	A
		rol	A
		rts
.SetRandom
		jsr	IDE_SetCylinderHi		; Set sector b16-b21
		eor	WKSP_ADFS_201,X			; Merge Drive and Head
		and	#&02
		eor	WKSP_ADFS_201,X
		jsr	IDE_SetDriveHead			; Set device and command
		pla
IF TARGETOS > 0
		php
		jmp	SetCommand
ELSE
		jmp	_lelkLA0D8			; TODO: Ask JGH - is this vestigial it seems unnecessary
ENDIF
.IDE_GetResult
		lda	IDE_STATUS			; Get IDE result
		and	#&21
		beq	GetResOk
IF TARGETOS = 0
		ora	IDE_ERROR			; Get IDE error code, CS already set
ELSE	
		lda	IDE_ERROR			; Get IDE error code, CS already set
ENDIF
		ldx	#&FF
.GetResLp
		inx					; Translate result code
		ror	A
		bcc	GetResLp
		lda	ResultCodes,X
.GetResOk
		rts
