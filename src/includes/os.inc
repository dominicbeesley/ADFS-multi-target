	.include "config.inc"

.ifndef __OS_INC__
__OS_INC__:

NMI=$0D00

;; MOS ZP regs
ZP_MOS_CURROM		= $F4
ZP_MOS_ESCFLAG 		= $FF

USERV					:=	$0200	; User vector, called by *LINE, *CODE, OSWORD >=&E0
BRKV					:=	$0202	; The BRK vector
IRQ1V					:=	$0204	; Main interrupt vector
IRQ2V					:=	$0206	; Secondary interrupt vector
CLIV					:=	$0208	; Command Line Interpreter vector
BYTEV					:=	$020A	; OSBYTE (*FX) calls
WORDV					:=	$020C	; OSWORD calls
WRCHV					:=	$020E	; Send character to current output stream
RDCHV					:=	$0210	; Wait for a character from current input stream

FSVECS_BASE				:=	FILEV
FILEV					:=	$0212	; Operate on a whole file, eg loading/saving/delete/etc
ARGSV					:=	$0214	; Read/Write arguments on an open file
BGETV					:=	$0216	; Read a byte from an open file
BPUTV					:=	$0218	; Write a byte to an open file
GBPBV					:=	$021A	; Read/Write block of data from/to open file or device
FINDV					:=	$021C	; Open or close a file
FSCV					:=	$021E	; Various filing system control calls
FSVECS_LEN				:=	$0220-FILEV
EVNTV					:=	$0220	; Event handler
UPTV					:=	$0222	; User Print vector
NETV					:=	$0224	; Network Print vector
VDUV					:=	$0226	; Unrecognised VDU commands
KEYV					:=	$0228	; Read the keyboard
INSV					:=	$022A	; Insert characters into a buffer
REMV					:=	$022C	; Remove characters from a buffer
CNPV					:=	$022E	; Count or Purge a buffer


sysvar_BREAK_LAST_TYPE	:= $028D	; fx253	  &FD	Last BREAK type

SYSVARS_DF0_PWSKPTAB	:= $DF0

EXTVEC_ENTER_FILEV			:=	$FF1B	; Operate on a whole file, eg loading/saving/delete/etc
EXTVEC_ENTER_ARGSV			:=	$FF1E	; Read/Write arguments on an open file
EXTVEC_ENTER_BGETV			:=	$FF21	; Read a byte from an open file
EXTVEC_ENTER_BPUTV			:=	$FF24	; Write a byte to an open file
EXTVEC_ENTER_GBPBV			:=	$FF27	; Read/Write block of data from/to open file or device
EXTVEC_ENTER_FINDV			:=	$FF2A	; Open or close a file
EXTVEC_ENTER_FSCV			:=	$FF2D	; Various filing system control calls

;; OS CALLS
OSDEFVEC_LEN	= $FFB6
OSDEFVEC_PTR	= $FFB7
GSINIT			= $FFC2
GSREAD			= $FFC5
OSASCI			= $FFE3
OSNEWL			= $FFE7
OSWRCH			= $FFEE
OSARGS			= $FFDA
OSWORD			= $FFF1
OSBYTE			= $FFF4
OSCLI			= $FFF7

OSBYTE_15_FLUSH_BUF		= $15
OSBYTE_16_INCPOLL		= $16
OSBYTE_77_CLOSE			= $77
OSBYTE_78_WRITE_KEYPRESS= $78
OSBYTE_7A_KEY_SCAN_10	= $7A
OSBYTE_7E_ESC_ACK		= $7E
OSBYTE_83_OSHWM			= $83
OSBYTE_84_HIMEM			= $84
OSBYTE_86_TXT_POS		= $86
OSBYTE_87_SCRCHAR_MODE	= $87
OSBYTE_8A_INS_BUF		= $8A
OSBYTE_8F_ISSUE_SERV	= $8F
OSBYTE_99_INS_BUF_CKESC = $99
OSBYTE_A1_READ_CMOS		= $A1
OSBYTE_A2_WRITE_CMOS	= $A2
OSBYTE_A8_ADDR_EXTVEC	= $A8
OSBYTE_C6_RW_EXEC		= $C6
OSBYTE_C7_RW_SPOOL		= $C7
OSBYTE_DB_RW_TAB_CODE	= $DB
OSBYTE_FD_LAST_BREAK	= $FD
OSBYTE_EA_RW_TUBEPRESENT= $EA
OSBYTE_FF_RW_STARTOPT	= $FF

OSWORD_01_TIME			= $01
OSWORD_76_QRY			= $76		; MDFS.net says RAMFS sector - used in floppy_nmi_D

SYSVARS_291_ILACE		= $291

TUBE_CLAIM 				= $C0

CMOS_ADFS				= $B
CMOS_PER_ROM_BASE		= $14		; note: this appears to be a VFS bug, should be $30 according to https://beebwiki.mdfs.net/CMOS_configuration_RAM_allocation

.if TARGETOS > 1
CONFIG_BIT_FD_SPEED	= $01
.else
CONFIG_BIT_FD_SPEED	= $10
.endif

.if TARGETOS = 0
OSBYTE_73_BLANK_PAL 		= $73
OSBYTE_F2_ELK_ULA_CTL_COPY 	= $F2
.endif

SERVICE_04_UK_OSCLI			= $04
SERVICE_0A_CLAIM_ABS_WKSP	= $0A
SERVICE_0B_RELEASE_NMI		= $0B
SERVICE_0C_CLAIM_NMI		= $0C
SERVICE_0F_FS_VECS_CHANGED  = $0F
SERVICE_15_100Hz_POLL		= $15

SYSVARS_ELK_291_TIME_A		= $291
SYSVARS_ELK_296_TIME_B		= $296
.endif

;***********************************************************************
;* User VIA                                                            *
;***********************************************************************
sheila_USRVIA_orb			:= $FE60
sheila_USRVIA_ora			:= $FE61
sheila_USRVIA_ddrb			:= $FE62
sheila_USRVIA_ddra			:= $FE63
sheila_USRVIA_t1cl			:= $FE64
sheila_USRVIA_t1ch			:= $FE65
sheila_USRVIA_t1ll			:= $FE66
sheila_USRVIA_t1lh			:= $FE67
sheila_USRVIA_t2cl			:= $FE68
sheila_USRVIA_t2ch			:= $FE69
sheila_USRVIA_sr			:= $FE6A
sheila_USRVIA_acr			:= $FE6B
sheila_USRVIA_pcr			:= $FE6C
sheila_USRVIA_ifr			:= $FE6D
sheila_USRVIA_ier			:= $FE6E
sheila_USRVIA_ora_nh		:= $FE6F

;***********************************************************************
;*  VIA constants                                                      *
;***********************************************************************

VIA_IFR_BIT_ANY				:= $80
VIA_IFR_BIT_T1				:= $40
VIA_IFR_BIT_T2				:= $20
VIA_IFR_BIT_CB1				:= $10
VIA_IFR_BIT_CB2				:= $08
VIA_IFR_BIT_SR				:= $04
VIA_IFR_BIT_CA1				:= $02
VIA_IFR_BIT_CA2				:= $01

VIA_ACR_SHIFTMODE_0			:= $00
VIA_ACR_SHIFTMODE_1			:= $04
VIA_ACR_SHIFTMODE_2			:= $08
VIA_ACR_SHIFTMODE_3			:= $0C
VIA_ACR_SHIFTMODE_4			:= $10
VIA_ACR_SHIFTMODE_5			:= $14
VIA_ACR_SHIFTMODE_6			:= $18
VIA_ACR_SHIFTMODE_7			:= $1C

VIA_ACR_T1_MASK				:= $C0
VIA_ACR_T1_CONT				:= $40