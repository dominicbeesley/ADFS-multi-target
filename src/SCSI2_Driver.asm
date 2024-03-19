		.include "config.inc"
		.include "workspace.inc"
		.include "os.inc"
		.include "hardware.inc"

		.export HD_Command
		.export CommandDone
		.export SCSI2_CommandPartialSector

		.segment "hd_driver_1"

ZP_ADFS_SCSI2_PHASE		=	$CC			;; store the current scsi 2 phase

WKSP_ADFS_3FC_SCSI2_FNPTR	= WKSP_BASE + $03FC	;; TODO: check this doesn't crash anything!
WKSP_ADFS_3FE_SCSI2_STATUS	= WKSP_BASE + $03FE	;; status byte
WKSP_ADFS_3FF_SCSI2_COUNT	= WKSP_BASE + $03FF	;; counter used in partial sector transfers

tbl_SCSI2_phase_h:
		.byte	>(SCSI2_phase_data_inout_main-1)
		.byte	>(SCSI2_phase_data_inout_main-1)
		.byte	>(SCSI2_phase_cmd_out-1)
		.byte	>(SCSI2_phase_stat_in-1)
		.byte	>(SCSI2_phase_sink-1)
		.byte	>(SCSI2_phase_sink-1)
		.byte	>(SCSI2_phase_nop-1)
		.byte	>(SCSI2_phase_msg_in-1)
tbl_SCSI2_phase_l:
		.byte	<(SCSI2_phase_data_inout_main-1)
		.byte	<(SCSI2_phase_data_inout_main-1)
		.byte	<(SCSI2_phase_cmd_out-1)
		.byte	<(SCSI2_phase_stat_in-1)
		.byte	<(SCSI2_phase_sink-1)
		.byte	<(SCSI2_phase_sink-1)
		.byte	<(SCSI2_phase_nop-1)
		.byte	<(SCSI2_phase_msg_in-1)


.proc SCSI2_phase_nop

lp:
		lda	#8				; SCSI nop message
		jsr	SCSI2_send_byteA
		bcc	SCSI2_phase_loop
		bcs	lp
.endproc

.proc SCSI2_phase_msg_in

		jsr	SCSI2_read_byteA		; assume this will work as we've got req already
		bne	l1
		jmp	CommandDone			; got a message 0 -done
l1:		jsr	SCSI2_read_byteA
		bcc	SCSI2_phase_loop
		bcs	l1

.endproc

;;.SCSI2_phase_data_inout
;;		jmp	(WKSP_ADFS_3FC_SCSI2_FNPTR)
;;
;;
;; Hard drive hardware is present. Check what drive is being accessed.
;;
HD_Command:
              	ldy    #$06
              	lda    ($B0),Y                            ; Get drive
              	ora    WKSP_ADFS_317_CURDRV        	; OR with current drive
.if FLOPPY
              	bmi    CommandExecFloppyOp         	; Jump back with 4,5,6,7 as floppies
.endif


		lda	#0
		sta	WKSP_ADFS_3FF_SCSI2_COUNT

SCSI2_startCommandHD_partial2:				; enter here for partial transfer, length in WKSP_ADFS_3FF_SCSI2_COUNT

;;
;; Access a hard drive via the SCSI API
;; ------------------------------------
              	jsr    SCSI2_StartCommand          	; Write &01 to SCSI, returns Y=0
                                                 	;Put SCSI in command mode

;;; TubeCheckAddrAndClaim must be linked in here

		.segment "hd_driver_2"


; Do a data transfer to/from a hard drive device
; ----------------------------------------------
;;		lda	#<SCSI2_phase_data_inout_main
;;		sta	WKSP_ADFS_3FC_SCSI2_FNPTR
;;		lda	#>SCSI2_phase_data_inout_main
;;		sta	WKSP_ADFS_3FC_SCSI2_FNPTR+1


.proc SCSI2_phase_loop
		jsr	SCSI2_WaitforReq		; Wait for next req and read bus state to decide what SCSI wants to do
		bpl	s
		jmp	CommandDoneUnEx			; BUSY dropped...panic
s:		sta	SCSI2_TARGET_CMD_3		; set up current phase
		tax
		lda	tbl_SCSI2_phase_h,X
		pha
		lda	tbl_SCSI2_phase_l,X
		pha
		rts					; jump to phase handler
.endproc

.proc SCSI2_phase_cmd_out
		;Do a SCSI data transfer
		;-----------------------
		ldy	#5				; Get command
L814A:		lda	($B0),Y				; Get a command block byte
		cpy	#6
		bne	L814C
		and	#$1F				; blank out LUN
L814C:		jsr	SCSI2_send_byteA		; Send to SCSI data port
		bcc	SCSI2_phase_loop		; If SCSI says enough command (phase changed)
		iny					; Keep sending command block
		bne	L814A				; until SCSI says 'stop!'
.endproc

.proc SCSI2_phase_data_inout_main
		lda	ZP_ADFS_SCSI2_PHASE
		ror	a
		bcs	skiprd1
		lda	#S2_INIT_CMD_ASSERT_DATA
		sta	SCSI2_INIT_CMD_1
skiprd1:

		lda	#S2_MODE_DMA
		sta	SCSI2_MODE_2
		bcs	skiprd2

		sta	SCSI2_DMA_INIT_SEND
		bne	s2


skiprd2:		sta	SCSI2_DMA_INIT_RECV_7

s2:		ldy	#$00				; Initialise Y to 0
		bit	ZP_ADFS_FLAGS			; Accessing Tube?
		bvc	nottube				; No, jump ahead to do the transfer
		ldx	#<WKSP_ADFS_227_TUBE_XFER
		ldy	#>WKSP_ADFS_227_TUBE_XFER	; XY=>Tube address
		lda	#$00				; A=0
		php					; Save CC/CS state
		rol	A				; A=0/1 for Read/Write
		jsr	TubeStartXfer406		; Claim the Tube
		plp					; Restore CC/CS state
;;
;; Do a data transfer to/from SCSI device
;; --------------------------------------
		bvs 	nocount				; always
iolp:

		bit	WKSP_ADFS_3FF_SCSI2_COUNT
		beq	nocount
		dec	WKSP_ADFS_3FF_SCSI2_COUNT	; if no more to transfer
		beq	datainout_sink
		bne	nocount
nottube:
		bcc	nocount				; write
		; fast read?
		bit	WKSP_ADFS_3FF_SCSI2_COUNT
		bne	nocount
		; yes
frlp:		bit	SCSI2_BUS_STATUS2_5
		bvc	chkph
		lda	SCSI2_DMA_DATA			; Read byte from SCSI data port
		sta	($B2),Y				; Store byte in memory
		iny					; Point to next byte
		bne	frlp				; Loop for 256 bytes
		inc	$B3				; Increment address high byte
		bcs	frlp				; Loop for next 256 bytes (always)


chkph:		lda	#S2_BUS2_PHASE_MATCH
		bit	SCSI2_BUS_STATUS2_5
		beq	datainout_done
		bne	frlp


nocount:	lda	#S2_BUS2_PHASE_MATCH
		bit	SCSI2_BUS_STATUS2_5
		bvs	datareq
		beq	datainout_done
		bne	nocount

datareq:	bit	ZP_ADFS_FLAGS			; Check Tube flags
		bvs	dotube				; Jump for Tube transfer
		bcc	dowrite

doread:		lda	SCSI2_DMA_DATA			; Read byte from SCSI data port
		sta	($B2),Y				; Store byte in memory
next:		iny					; Point to next byte
		bne	iolp				; Loop for 256 bytes
		inc	$B3				; Increment address high byte
		bcs	iolp				; Loop for next 256 bytes

dowrite:
;;			    I/O write
		lda	($B2),Y				; Get byte from memory
		sta	SCSI2_DMA_DATA			; Write to SCSI data port
		bcc	next
;;
;;
dotube:		bcs	dotuberead			; Jump for Tube read
		lda	TUBEIO				; Get byte from Tube
		sta	SCSI2_DMA_DATA			; Write byte to SCSI data port
		bcc	iolp				; Loop for next byte

dotuberead:
		lda	SCSI2_DMA_DATA			; Get byte from SCSI data port
		sta	TUBEIO				; Write to Tube
		bcs	iolp

datainout_done:
		jsr	rst_cmd
		jmp	SCSI2_phase_loop
datainout_sink:
		jsr	rst_cmd
		jmp	SCSI2_phase_sink

rst_cmd:
		lda	#0
		sta	SCSI2_INIT_CMD_1
		sta	SCSI2_MODE_2
		rts


.endproc
;;



CommandDoneUnEx:
		jsr	TubeRelease			; Release Tube and restore screen
		jmp	SCSI2_RequestSense_L82A5		; Return result=&7F
CommandDone:
		jsr	TubeRelease			; Release Tube and restore screen
		lda	WKSP_ADFS_3FE_SCSI2_STATUS
;;
		tax					; Save result in X
		and	#$02				; Check b1
		beq	L81D2				; If b1=0, return with &00
		jmp	SCSI2_RequestSense		; Get status from SCSI and return it
;;
;;.L81D2	lda	#&00				; A=0 - OK		;;TODO: check this is right!?
L81D2:		txa
L81D4:		ldx	$B0				; Restore XY pointer
		ldy	$B1
		and	#$7F				; Lose bit 7, set EQ from result
		rts					; Return with result in A

.proc SCSI2_phase_sink

lp:
		jsr	SCSI2_read_byteA
		bcs	lp
		jmp	SCSI2_phase_loop
.endproc


SCSI2_CommandPartialSector:

		lda	WKSP_ADFS_21E_DSKOPSAV_SECCNT	; this actually holds the number of bytes here (TODO: could be got from WKSP_ADFS_220_DSKOPSAV_XLEN!?)
		sta	WKSP_ADFS_3FF_SCSI2_COUNT
		lda	#1
		sta	WKSP_ADFS_21E_DSKOPSAV_SECCNT	; set to single sector transfer

		jmp	SCSI2_startCommandHD_partial2

.proc SCSI2_phase_stat_in

		jsr	SCSI2_read_byteA
		sta	WKSP_ADFS_3FE_SCSI2_STATUS
		jmp	SCSI2_phase_loop
.endproc


;;;; IS! SCSI Read or Write
;;;; ----------------------
;;.HD_DataTransfer256
;;		ldy	#&00
;;		bit	ZP_ADFS_FLAGS			; Check ADFS status flag
;;		bvs	L821F				; Jump if Tube being used
;;.L81E1		jsr	SCSI2_WaitforReq
;;		bmi	CommandDone			; Jump to get result and return
;;		bvs	L81F4
;;.L81E8		lda	(&B2),Y
;;		sta	SCSI2_DATA_0
;;		iny
;;		bne	L81E8
;;		inc	&B3
;;IF USE65C12
;;		bra	L81E1
;;ELSE
;;		bvc	L81E1
;;ENDIF
;;;;
;;.L81F4		lda	SCSI2_DATA_0
;;		sta	(&B2),Y
;;		iny
;;		bne	L81F4
;;		inc	&B3
;;IF USE65C12
;;		bra	L81E1
;;ELSE
;;		bvs	L81E1
;;ENDIF
;;;;
;;.L8200		inc	WKSP_ADFS_228
;;		bne	L820D
;;		inc	WKSP_ADFS_229
;;		bne	L820D
;;		inc	WKSP_ADFS_22A
;;.L820D		ldx	#<WKSP_ADFS_227_TUBE_XFER
;;		ldy	#>WKSP_ADFS_227_TUBE_XFER
;;		rts

;;;  TubeStartXfer must be linked in here

		.segment "hd_driver_3"

;;.L821F		ldx	#<WKSP_ADFS_227_TUBE_XFER
;;		ldy	#>WKSP_ADFS_227_TUBE_XFER
;;.L8223		jsr	SCSI2_WaitforReq
;;		bpl	L822B
;;		jmp	CommandDone			; Jump to get result and return
;;;;
;;.L822B		bvs	L8245
;;		php
;;		lda	#&06
;;		jsr	TubeStartXferSEI_406
;;.L8233		nop					; 3xNOP delay for Tube I/O
;;		nop
;;		nop
;;		lda	TUBEIO				; Read from Tube
;;		sta	SCSI2_DATA_0			; Write to SCSI data
;;		iny
;;		bne	L8233
;;		jsr	L8200
;;		plp
;;IF USE65C12
;;		bra	L8223
;;ELSE
;;		bvc	L8223
;;ENDIF
;;;;
;;.L8245		php
;;		lda	#&07
;;		jsr	TubeStartXferSEI_406
;;.L824B		nop					; 3xNOP delay for Tube I/O
;;		nop
;;		nop
;;		lda	SCSI2_DATA_0			; Read SCSI data
;;		sta	TUBEIO				; Write to Tube
;;		iny
;;		bne	L824B
;;		jsr	L8200
;;		plp
;;IF USE65C12
;;		bra	L8223
;;ELSE
;;		bvs	L8223
;;ENDIF
;;
;; Read result from SCSI and return it as a result
;; -----------------------------------------------
.proc SCSI2_RequestSense
		lda	$B0
		pha
		lda	$B1
		pha					; TODO: check if this is necessary, is it alwats C215?

		lda	#0
		pha					; room for the data sent back
		pha
		pha
		pha
		pha
		pha
		tsx					; setup x to point at return data
		pha

		pha					; data length = 0
		pha
		pha
		pha

		pha					; control byte					+10 = 0
		lda	#7
		pha					; SCSI alloc length 				+9 = 7
		sta	WKSP_ADFS_3FF_SCSI2_COUNT
		lda	#0
		pha					; sector					+8 = 0
		pha					; sector					+7 = 0

		lda	WKSP_ADFS_317_CURDRV
		and	#$E0

		pha					; sector msb/drive				+6 = drive
		lda	#3
		pha					; command					+5
		lda	#$FF				; data addr
		pha					; data msb					+4
		pha					; data						+3
		lda	#1
		pha					; data						+2
		sta	$B1
		txa
		pha					; data lsb					+1 = stack addr of data
		tsx					; address of control block
		stx	$B0

		jsr	SCSI2_startCommandHD_partial2

		tsx					; unstack command
		txa
		clc
		adc	#15
		tax
		txs


		pla					; result code
		pla					; skip segment no
		pla					; sense key
		sta	WKSP_ADFS_2D3_ERR_CODE
		and	#$0F
		pla					; skip msb of sector
		ldx	#2
lp:		pla
		sta	WKSP_ADFS_2D0_ERR_SECTOR,X
		dex
		bpl	lp

		pla
		sta	$B1
		pla
		sta	$B0


		lda	WKSP_ADFS_2D3_ERR_CODE
		tax
		and	#$02				; Test bit 1 of first byte
		beq	sk1				; If set, jump to return &7F
L82A5:		lda	#$FF				; result = $FF
		bne	sk2
sk1:		txa					; return SCSI code
sk2:		jmp	L81D4
.endproc


; Set SCSI to command mode
; ------------------------
SCSI2_StartCommand:					; L807E
		ldy	#$00				; Useful place to set Y=0
SCSI2_StartCommand2:

		lda	#0
		; start arbitration phase
		sta	SCSI2_TARGET_CMD_3		; clear this to make bus driven

		lda	#SCSI2_INITIATOR_ID_BITS
		sta	SCSI2_DATA_0

		lda	#S2_MODE_ARBITRATE
		sta	SCSI2_MODE_2			; start arbitration

scsi2_sc_lp1:
		lda	SCSI2_INIT_CMD_1
		and	#S2_INIT_CMD_ARB_PROG
		bne	arbdone

		lda	SCSI2_MODE_2
		and	#S2_MODE_ARBITRATE
		beq	arbdone
		bne	scsi2_sc_lp1
arbdone:
		jsr	L8098rts			; delay

		lda	SCSI2_INIT_CMD_1
		and	#S2_INIT_CMD_ARB_LOST
		bne	SCSI2_StartCommand2		; arbitration lost...try again

		;TODO: this always selects drive 0!
		lda	#SCSI2_INITIATOR_ID_BITS + 1	; set our ID bit and drive 0
		sta	SCSI2_DATA_0


		; assert bsy, sel data and atn (to get msg out)
		lda	#S2_INIT_CMD_ASSERT_nBSY | S2_INIT_CMD_ASSERT_DATA | S2_INIT_CMD_ASSERT_nSEL | S2_INIT_CMD_ASSERT_nATN
		sta	SCSI2_INIT_CMD_1

		; stop arbitrating
		lda	#0
		sta	SCSI2_MODE_2

		jsr	L8098rts			; delay

		; drop bsy, hold sel data and atn (to get msg out)
		lda	#S2_INIT_CMD_ASSERT_DATA | S2_INIT_CMD_ASSERT_nSEL | S2_INIT_CMD_ASSERT_nATN
		sta	SCSI2_INIT_CMD_1


		; wait for BUSY from target
		lda	#S2_BUS_nBSY
scsi2bsylp:	bit	SCSI2_BUS_STATUS_4
		beq	scsi2bsylp


		; drop bsy, sel data, hold atn (to get msg out)
		lda	#S2_INIT_CMD_ASSERT_nATN
		sta	SCSI2_INIT_CMD_1


		lda	#S2_BUS_PHASE_MSGOUT >> 2	; setup phase
		sta	SCSI2_TARGET_CMD_3

		lda	#S2_MSG_IDENTIFY + 0
		jsr	SCSI2_send_byteA

		lda	#S2_BUS_PHASE_CMDOUT>>2
		sta	SCSI2_TARGET_CMD_3		; expect command out mode...TODO: Check this is sane

		rts

		; this has a different API to other HD
		; return CS for phase MATCH
		; returns MI for busy loss

.proc SCSI2_WaitforReq
lp:		lda	SCSI2_BUS_STATUS_4		; Get SCSI status
		and	#S2_BUS_nREQ			; Check REQUEST
		beq	lp				; Loop until REQUEST set
		lda	SCSI2_BUS_STATUS_4		; Get SCSI status
		and	#S2_BUS_PHASE_MASK		; return phase
		lsr	a
		lsr	a
		sta	ZP_ADFS_SCSI2_PHASE
		lda	SCSI2_BUS_STATUS2_5
		ror	a
		ror	a
		ror	a
		ror	a
		lda	ZP_ADFS_SCSI2_PHASE
		rts
.endproc

		; wait for req to go low
.proc SCSI2_waitreqno
		lda	#S2_BUS_nREQ
lp:		bit	SCSI2_BUS_STATUS_4
		bne	lp
		rts
.endproc


.proc SCSI2_send_byteA
		pha
		jsr	SCSI2_WaitforReq		; Wait until SCSI ready
		bcc	plarts			; Wrong phase i.e. SCSI wants to do data in not out!
							; WRONG?: SCSI not responding, drop return and return result=UNKNOWN
		bmi	abort				; unexpected loss of BSY abort
		pla
		sta	SCSI2_DATA_0

		lda	#S2_INIT_CMD_ASSERT_DATA	; during a MSGOUT (identify) ATN goes low here
		sta	SCSI2_INIT_CMD_1
		ora	#S2_INIT_CMD_ASSERT_nACK
finit:
		sta	SCSI2_INIT_CMD_1

		jsr	SCSI2_waitreqno

		lda	#$00				; Return Ok
		sta	SCSI2_INIT_CMD_1
		rts
plarts:		pla
anrts:		rts
abort:		pla
abort2:		pla					; Drop return address
		pla
		jmp	CommandDoneUnEx			; Jump to get result and return
.endproc

.proc SCSI2_read_byteA
		jsr	SCSI2_WaitforReq			; Wait until SCSI ready
		bcc	SCSI2_send_byteA::anrts		; Wrong phase i.e. SCSI wants to do data in not out!
							; WRONG?: SCSI not responding, drop return and return result=UNKNOWN
		bmi	SCSI2_send_byteA::abort2		; unexpected loss of BSY abort
		lda	SCSI2_DATA_0
		pha
		lda	#S2_INIT_CMD_ASSERT_nACK
		jsr	SCSI2_send_byteA::finit
		pla
		rts

.endproc

SCSI2_SendCMDByte:
		jsr	L8324				; Wait until not busy, then write command to command register
		bne	GenerateError			; If not Ok, generate disk error
		rts
L8324:		jsr	SCSI2_send_byteA		; This code cannot be inlined or JMPed as
		rts					; SCSI_send_byteA changes stack


; TODO: why must scopes be forward declared?
SCSI2_RequestSense_L82A5 = SCSI2_RequestSense::L82A5


