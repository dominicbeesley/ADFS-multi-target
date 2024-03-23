		.include "config.inc"
.ifndef __HARDWARE_INC__
__HARDWARE_INC__:

; drive control flags (some set below in machine specific section)
FDCDS0 				= $01
FDCDS1 				= $02


; Target-specific equates
; -----------------------
.if   TARGETOS=0
  VERBASE=$100		; Electron
  SYSVIA=$FCB0		; Sys via expansion
  HDDBASE=$FC40		; Hard drive controller
  FDCBASE=$FCC4		; Floppy controller
  DRVSEL =FDCBASE-4	; Drive control register
  FDCRES =$20		; Reset FDC
  FDCSIDE=$04		; Side select
  ROMSEL =$FE05		; ROM select register
  TUBEIO =$FCE5		; Tube data port
  TUBEIOSTAT =$FCE4
  FILEBLK=$02E2		; OSFILE control block
  ULA_CTL=$FE07		; ULA mode/control register
.elseif TARGETOS=1 || TARGETOS=2
  VERBASE=$130		; BBC B, BBC B+
  SYSVIA=$FE40		; Sys via
  HDDBASE=$FC40		; Hard drive controller
  FDCBASE=$FE84		; Floppy controller
  DRVSEL =FDCBASE-4	; Drive control register
  FDCRES =$20		; Reset FDC
  FDCSIDE=$04		; Side select
  ROMSEL =$FE30		; ROM select register
  TUBEIO =$FEE5		; Tube data port
  TUBEIOSTAT = $FEE4
  FILEBLK=$02EE	  ; OSFILE control block
.elseif TARGETOS>2
  .ifdef HD_SCSI_VFS
  	VERBASE=$170		; Master VFS
  .else
  	VERBASE=$150		; Master
  .endif
  SYSVIA=$FE40		; Sys via
.if .def(HD_SCSI_XDFS)
  	HDDBASE=$FC44		; Hard drive controller
.elseif .def(HD_SCSI_VFS)
  	HDDBASE=$FE80		; VFS controller

.else
  	HDDBASE=$FC40		; Hard drive controller
.endif
  FDCBASE=$FE28		; Floppy controller
  DRVSEL =FDCBASE-4	; Drive control register
  FDCRES =$04		; Reset FDC
  FDCSIDE=$10		; Side select
  ROMSEL =$FE30		; ROM select register
  TUBEIO =$FEE5		; Tube data port
  TUBEIOSTAT = $FEE4
  FILEBLK=$02EE		; OSFILE control block
.endif

FDC_CMD 		= FDCBASE
FDC_TRACK		= FDCBASE+1
FDC_SEC			= FDCBASE+2
FDC_DATA		= FDCBASE+3

; HD INTERFACE specifics
.ifdef HD_IDE
	IDE_DATA 	= HDDBASE + 0
	IDE_ERROR	= HDDBASE + 1
	IDE_SEC_CT	= HDDBASE + 2
	IDE_SEC_NO	= HDDBASE + 3
	IDE_CYL_NO_LO	= HDDBASE + 4
	IDE_CYL_NO_HI	= HDDBASE + 5
	IDE_DRVHEAD	= HDDBASE + 6
	IDE_STATUS	= HDDBASE + 7
.elseif .def(HD_SCSI) || .def(HD_XDFS)
	SCSI_DATA 	= HDDBASE + 0
	SCSI_STATUS	= HDDBASE + 1
	SCSI_SELECT	= HDDBASE + 2
	SCSI_IRQEN	= HDDBASE + 3

	SCSI_STATUS_BIT_CnD		= $80			; 1 for command 0 for data
	SCSI_STATUS_BIT_InO		= $40			; 0 for I->T 1 for T->I
	SCSI_STATUS_BIT_REQ		= $20			; 1 for data ready
	SCSI_STATUS_BIT_IF		= $10			; 1 when interrupt pending
	SCSI_STATUS_BIT_BUSY	 	= $02			; 1 when SCSI bus BUSY asserted
	SCSI_STATUS_BIT_MSG	 	= $01			; 1 when SCSI bus MSG asserted


.elseif .def(HD_MMC_JGH) || .def(HD_MMC_HOG)

.elseif .def(HD_SCSI2)
	; The host adapter is always ID=7!
	SCSI2_INITIATOR_ID		=	7
	SCSI2_INITIATOR_ID_BITS		=	1<<SCSI2_INITIATOR_ID

	SCSI2_DATA_0			=	HDDBASE + 0	; live data bus lines

	SCSI2_INIT_CMD_1		=	HDDBASE + 1	; initiator command reg
	S2_INIT_CMD_ASSERT_DATA		=	$01
	S2_INIT_CMD_ASSERT_nATN		=	$02
	S2_INIT_CMD_ASSERT_nSEL		=	$04
	S2_INIT_CMD_ASSERT_nBSY		=	$08
	S2_INIT_CMD_ASSERT_nACK		=	$10
	S2_INIT_CMD_ARB_LOST		=	$20
	S2_INIT_CMD_ARB_PROG		=	$40
	S2_INIT_CMD_ASSERT_nRST		=	$80

	SCSI2_MODE_2			=	HDDBASE + 2
	S2_MODE_ARBITRATE		=	$01
	S2_MODE_DMA			=	$02
	S2_MODE_MONITOR_BSY		=	$04
	S2_MODE_IE_EOP			=	$08
	S2_MODE_IE_PAR			=	$10
	S2_MODE_PARCHECK		=	$20
	S2_MODE_TARGET			=	$40

	SCSI2_TARGET_CMD_3		=	HDDBASE + 3
	S2_TARG_CMD_ASSERT_InO		=	$01
	S2_TARG_CMD_ASSERT_CnD		=	$02
	S2_TARG_CMD_ASSERT_nMSG		=	$04
	S2_TARG_CMD_ASSERT_nREQ		=	$08
	S2_TARG_CMD_ASSERT_LASTBYTE	=	$80

	SCSI2_BUS_STATUS_4		=	HDDBASE + 4
	S2_BUS_nDBP			=	$01
	S2_BUS_nSEL			=	$02
	S2_BUS_InO			=	$04
	S2_BUS_CnD			=	$08
	S2_BUS_nMSG			=	$10
	S2_BUS_nREQ			=	$20
	S2_BUS_nBSY			=	$40
	S2_BUS_nRST			=	$80

	SCSI2_SELECT_ENABLE_4		=	HDDBASE + 4

	SCSI2_BUS_STATUS2_5		=	HDDBASE + 5
	S2_BUS2_nACK			=	$01
	S2_BUS2_nATN			=	$02
	S2_BUS2_BUSY_ERR		=	$04
	S2_BUS2_PHASE_MATCH		=	$08
	S2_BUS2_IRQ			=	$10
	S2_BUS2_PARTIY_ERR		=	$20
	S2_BUS2_DMA_REQ			=	$40
	S2_BUS2_DMA_END			=	$80
	SCSI2_DMA_INIT_SEND		=	HDDBASE + 5

	SCSI2_DATA_IN_6			=	HDDBASE + 6	; latched data
	SCSI2_DMA_INIT_TGT_RCV_6	=	HDDBASE + 6

	SCSI2_DMA_INIT_RECV_7		=	HDDBASE + 7

	SCSI2_IRQRESET			=	HDDBASE + 7

	SCSI2_DMA_DATA			=	HDDBASE + 8


; phase bits in status 4 register, shift right by 2 for TCR register bits
	S2_BUS_PHASE_MASK 		=	(S2_BUS_nMSG | S2_BUS_CnD | S2_BUS_InO)
												; ==		targetcmd
	S2_BUS_PHASE_DATAOUT		=	0						; 00			0
	S2_BUS_PHASE_DATAIN		=	S2_BUS_InO					; 04			1
	S2_BUS_PHASE_CMDOUT		=	S2_BUS_CnD					; 08			2
	S2_BUS_PHASE_STATIN		=	(S2_BUS_CnD | S2_BUS_InO)			; 0C			3
	S2_BUS_PHASE_MSGOUT		=	(S2_BUS_nMSG | S2_BUS_CnD)			; 18			6
	S2_BUS_PHASE_MSGIN		=	(S2_BUS_nMSG | S2_BUS_CnD | S2_BUS_InO)	; 1C			7
	S2_BUS_PHASE_UNKNOWN		=	$FF

	S2_CMD_PHASE_DATAOUT		=	0						; 00			0
	S2_CMD_PHASE_DATAIN		=	1						; 04			1
	S2_CMD_PHASE_CMDOUT		=	2						; 08			2
	S2_CMD_PHASE_STATIN		=	3						; 0C			3
	S2_CMD_PHASE_MSGOUT		=	6						; 18			6
	S2_CMD_PHASE_MSGIN		=	7						; 1C			7

	S2_MSG_IDENTIFY			=	$80
	S2_MSG_IDENTIFY_DISCPRIV	=	$40
	S2_MSG_IDENTIFY_LUNTAR		=	$20
.endif

.endif