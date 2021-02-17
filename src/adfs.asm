
;; TODO:
; - version string etc for FAST IDE


; ACORN ADFS ROM SOURCE
; =====================
; ADFS ORIGINAL CODE BY HUGO TYSON COPYRIGHT ACORN COMPUTERS
; ASSEMBLY COMMENTARY COPYRIGHT J.G.HARSTON
; IDE DRIVERS BY J.G.HARSTON
; MMC DRIVERS BY HOGLET/ZORN/STARDOT COMMUNITY
; SCSI2 DRIVERS BY DOMINIC BEESLEY 2018
;
; Assemble the code by starting the build with one of the master include
; files to set up the defines for the required build. This code will
; build:
; ADFS Master SCSI v1.50r9
; ADFS Master IDE  v1.53r21
;  ADFS Master MMC
; Does not yet build correctly for BBC or Electron.


; OPTIMISE flag sets how hard to optimise
; 1 Use 65C12 coding where possible
; 	;; TODO : ASK JGH - there are a lot of 65c12 instructions included even
							;if this is 0 so I've added USE65C12 around those to turn the off for
							;BBC / Elk / 6502A builds but qualified with OPTIMISE in other places?
; 2 Subroutines for ReadCMOS, DiskSpeed, SetAttr, GetFilename, NextEntry, PointToCtrl
; 3 Rewritten disk error generation
; 4 Crunch OSARGS, BGET/BPUT update, CheckOpen
; 5 Tail optimise sector_address to side/track/sector, LoadFSM, RootSector
; 6 Merge *CAT/*EX, loop some code, crunch BGET return, FloppyORA_STEP_SET_FDC_CMD, CheckAddr, SectToCtrl

; Other options, set from launch file:
; TARGETOS		Target machine MOS
; FLOPPY		Include floppy drivers
; HD_SCSI		Build with SCSI drivers (only one possible)
; HD_SCSI2		Build with SCSI2 drivers (only one possible)
; HD_IDE		Build with IDE drivers (only one possible)
; HD_MMC		Build with MMC drivers (only one possible)
; FULL_INFO		Full *INFO
; FULL_ACCESS		Full OSFILE 1-4
; UNSUPPORTED_OSFILE	Unknown OSFILE returns A preserved
; PRESERVE_CONTEXT	Ctrl-Break doesn't lose context
; LARGE_DISK		Future development
; TRIM_REDUNDANT	Remove redundant code


; Testing 2016/04/09
;  TRIM_REDUNDANT works.
;  OPTIMISE=1 works (use 65c12 ops)
;  OPTIMISE=2 works (subroutines for major chunks)
;  OPTIMISE=3 works (rewritten disk error routine)
;  OPTIMISE=4 works (crunched OSARGS, BGET/BPUT, CheckOpen)
;  OPTIMISE=5 works (tail optimised sector_addr conversion, LoadFSM, RootSector)
;  OPTIMISE=6 testing, appears to work

ADFS_FS_NO=8
CHANNEL_RANGE_HI=&39
CHANNEL_RANGE_LO=&30


; Sanity check
; ------------
IF ((HD_SCSI AND 1) + (HD_SCSI2 AND 1) + (HD_IDE AND 1) + (HD_MMC AND 1)) <> 1
		error	"Cannot build for multiple device drivers or no HD_xx"
ENDIF

NMI=&0D00

;; MOS ZP regs
ZP_MOS_CURROM		= &F4
ZP_MOS_ESCFLAG 		= &FF

;; OS CALLS
OSBYTE			= &FFF4
OSCLI			= &FFF7
OSNEWL			= &FFE7
OSWRCH			= &FFEE
OSASCI			= &FFE3
OSARGS			= &FFDA

OSBYTE_77_CLOSE		= &77
OSBYTE_8F_ISSUE_SERV	= &8F
OSBYTE_A1_READ_CMOS	= &A1
OSBYTE_FF_RW_STARTOPT	= &FF
CMOS_ADFS		= &0B

IF TARGETOS > 1
CONFIG_BIT_FD_SPEED	= &01
ELSE
CONFIG_BIT_FD_SPEED	= &10
ENDIF

IF TARGETOS > 1
WKSP_BASE			= &C000
ELSE
WKSP_BASE			= &0E00
ENDIF

;;	 Workspace
;;	 =========
;;E00	 C000-FF Free Space Map sector 0
;;F00	 C100-FF Free Space Map sector 1
;;1000	 C200-FF Workspace
;;1100	 C300-FF Workspace
;;1200	 C400-FF Directory buffer
;;1300	 C500-FF Directory buffer
;;1400	 C600-FF Directory buffer
;;1500	 C700-FF Directory buffer
;;1600	 C800-FF Directory buffer
;;1700	 C900-FF Random access buffer 1 - also *CDIR buffer
;;1800	 CA00-FF Random access buffer 2
;;1900	 CB00-FF Random access buffer 3
;;2000	 CC00-FF Random access buffer 4
;;2100	 CD00-FF Random access buffer 5
;;
;;	 C200-14
;;	 C215-23 Disk access control block
;;	 C224-27
;;	 C228-2B
;;	 C22C-2F Current Selected Directory?
;;	 C230-33
;;	 C234-37 Current object sector
;;	 C238-3F
;;	 C240-51 Control block for commands translated to OSFILE calls
;;	 C262-6B Current object name
;;
;;	 C300-09 Current directory name
;;	 C30A-13 Current library name
;;	 C314-17 Current directory sector
;;	 C318-1B Library directory sector
;;	 C31C-1F Previous directory sector
;;	  byte 0/1/2 = sector
;;	  byte 3     = drive*32, &FF=unset
;;	 C320 - saved FLAGS
WKSP_ADFS_000_FSM_S0		= WKSP_BASE + &0000
WKSP_ADFS_100_FSM_S1		= WKSP_BASE + &0100
WKSP_ADFS_200			= WKSP_BASE + &0200
WKSP_ADFS_227_TUBE_XFER		= WKSP_BASE + &0227
WKSP_ADFS_22B			= WKSP_BASE + &022B
WKSP_ADFS_22C_CSD		= WKSP_BASE + &022C
WKSP_ADFS_237			= WKSP_BASE + &0237
WKSP_ADFS_300_CSDNAME		= WKSP_BASE + &0300
WKSP_ADFS_30A_LIBNAME		= WKSP_BASE + &030A

WKSP_ADFS_320_FLAGS_SAVE	= WKSP_BASE + &0320
WKSP_ADFS_400_DIR_BUFFER	= WKSP_BASE + &0400
WKSP_ADFS_405_DIR_START		= WKSP_ADFS_400_DIR_BUFFER + &05
WKSP_ADFS_409			= WKSP_ADFS_400_DIR_BUFFER + &09
WKSP_ADFS_500_DIR_BUFFER	= WKSP_BASE + &0500
WKSP_ADFS_600_DIR_BUFFER	= WKSP_BASE + &0600
WKSP_ADFS_700_DIR_BUFFER	= WKSP_BASE + &0700
WKSP_ADFS_800_DIR_BUFFER	= WKSP_BASE + &0800
WKSP_ADFS_800_DIR_C0		= WKSP_ADFS_800_DIR_BUFFER + &C0
WKSP_ADFS_800_DIR_D9		= WKSP_ADFS_800_DIR_BUFFER + &D9
WKSP_ADFS_900_RND_BUFFER	= WKSP_BASE + &0900
WKSP_ADFS_A00_RND_BUFFER	= WKSP_BASE + &0A00
WKSP_ADFS_B00_RND_BUFFER	= WKSP_BASE + &0B00
WKSP_ADFS_C00_RND_BUFFER	= WKSP_BASE + &0C00
WKSP_ADFS_D00_RND_BUFFER	= WKSP_BASE + &0D00
WKSP_ADFS_E00_END		= WKSP_BASE + &0E00

WKSP_ADFS_201			= WKSP_BASE + &0201
WKSP_ADFS_202			= WKSP_BASE + &0202
WKSP_ADFS_203			= WKSP_BASE + &0203
WKSP_ADFS_204			= WKSP_BASE + &0204
WKSP_ADFS_208			= WKSP_BASE + &0208
WKSP_ADFS_20C			= WKSP_BASE + &020C
WKSP_ADFS_20D			= WKSP_BASE + &020D
WKSP_ADFS_20E			= WKSP_BASE + &020E
WKSP_ADFS_210			= WKSP_BASE + &0210
WKSP_ADFS_211			= WKSP_BASE + &0211
WKSP_ADFS_214			= WKSP_BASE + &0214
WKSP_ADFS_215_DSKOPSAV_RET	= WKSP_BASE + &0215
WKSP_ADFS_216_DSKOPSAV_MEMADDR	= WKSP_BASE + &0216
WKSP_ADFS_21A_DSKOPSAV_CMD	= WKSP_BASE + &021A
WKSP_ADFS_21B_DSKOPSAV_SEC	= WKSP_BASE + &021B				; big endian!
WKSP_ADFS_21E_DSKOPSAV_SECCNT	= WKSP_BASE + &021E
WKSP_ADFS_21F_DSKOPSAV_CTL	= WKSP_BASE + &021F
WKSP_ADFS_220_DSKOPSAV_XLEN	= WKSP_BASE + &0220				; little endian!
WKSP_ADFS_224			= WKSP_BASE + &0224
WKSP_ADFS_228			= WKSP_BASE + &0228
WKSP_ADFS_229			= WKSP_BASE + &0229
WKSP_ADFS_22A			= WKSP_BASE + &022A
WKSP_ADFS_22D			= WKSP_BASE + &022D
WKSP_ADFS_22E			= WKSP_BASE + &022E
WKSP_ADFS_22F			= WKSP_BASE + &022F
WKSP_ADFS_230			= WKSP_BASE + &0230
WKSP_ADFS_233			= WKSP_BASE + &0233
WKSP_ADFS_234			= WKSP_BASE + &0234
WKSP_ADFS_235			= WKSP_BASE + &0235
WKSP_ADFS_236			= WKSP_BASE + &0236
WKSP_ADFS_238			= WKSP_BASE + &0238
WKSP_ADFS_23A			= WKSP_BASE + &023A
WKSP_ADFS_23B			= WKSP_BASE + &023B
WKSP_ADFS_23C			= WKSP_BASE + &023C
WKSP_ADFS_23D			= WKSP_BASE + &023D
WKSP_ADFS_23E			= WKSP_BASE + &023E
WKSP_ADFS_23F			= WKSP_BASE + &023F
WKSP_ADFS_240			= WKSP_BASE + &0240
WKSP_ADFS_241			= WKSP_BASE + &0241
WKSP_ADFS_242			= WKSP_BASE + &0242
WKSP_ADFS_243			= WKSP_BASE + &0243
WKSP_ADFS_246			= WKSP_BASE + &0246
WKSP_ADFS_247			= WKSP_BASE + &0247
WKSP_ADFS_248			= WKSP_BASE + &0248
WKSP_ADFS_249			= WKSP_BASE + &0249
WKSP_ADFS_24A			= WKSP_BASE + &024A
WKSP_ADFS_24B			= WKSP_BASE + &024B
WKSP_ADFS_24C			= WKSP_BASE + &024C
WKSP_ADFS_24D			= WKSP_BASE + &024D
WKSP_ADFS_24F			= WKSP_BASE + &024F
WKSP_ADFS_250			= WKSP_BASE + &0250
WKSP_ADFS_252			= WKSP_BASE + &0252
WKSP_ADFS_253			= WKSP_BASE + &0253
WKSP_ADFS_254			= WKSP_BASE + &0254
WKSP_ADFS_25D			= WKSP_BASE + &025D
WKSP_ADFS_25E			= WKSP_BASE + &025E
WKSP_ADFS_25F			= WKSP_BASE + &025F
WKSP_ADFS_260			= WKSP_BASE + &0260
WKSP_ADFS_261			= WKSP_BASE + &0261
WKSP_ADFS_262			= WKSP_BASE + &0262
WKSP_ADFS_263			= WKSP_BASE + &0263
WKSP_ADFS_26C			= WKSP_BASE + &026C
WKSP_ADFS_26F			= WKSP_BASE + &026F
WKSP_ADFS_270			= WKSP_BASE + &0270
WKSP_ADFS_273			= WKSP_BASE + &0273
WKSP_ADFS_274			= WKSP_BASE + &0274
WKSP_ADFS_27E			= WKSP_BASE + &027E
WKSP_ADFS_27F			= WKSP_BASE + &027F
WKSP_ADFS_280			= WKSP_BASE + &0280
WKSP_ADFS_289			= WKSP_BASE + &0289
WKSP_ADFS_28C			= WKSP_BASE + &028C
WKSP_ADFS_28D			= WKSP_BASE + &028D
WKSP_ADFS_291			= WKSP_BASE + &0291
WKSP_ADFS_292			= WKSP_BASE + &0292
WKSP_ADFS_293			= WKSP_BASE + &0293
WKSP_ADFS_294			= WKSP_BASE + &0294
WKSP_ADFS_295			= WKSP_BASE + &0295
WKSP_ADFS_296			= WKSP_BASE + &0296
WKSP_ADFS_297			= WKSP_BASE + &0297
WKSP_ADFS_298			= WKSP_BASE + &0298
WKSP_ADFS_29A			= WKSP_BASE + &029A
WKSP_ADFS_29B			= WKSP_BASE + &029B
WKSP_ADFS_29C			= WKSP_BASE + &029C
WKSP_ADFS_29D			= WKSP_BASE + &029D
WKSP_ADFS_29E			= WKSP_BASE + &029E
WKSP_ADFS_29F			= WKSP_BASE + &029F
WKSP_ADFS_2A0			= WKSP_BASE + &02A0
WKSP_ADFS_2A1			= WKSP_BASE + &02A1
WKSP_ADFS_2A2			= WKSP_BASE + &02A2
WKSP_ADFS_2A3			= WKSP_BASE + &02A3
WKSP_ADFS_2A4			= WKSP_BASE + &02A4
WKSP_ADFS_2A5			= WKSP_BASE + &02A5
WKSP_ADFS_2A6			= WKSP_BASE + &02A6
WKSP_ADFS_2A7			= WKSP_BASE + &02A7
WKSP_ADFS_2A8			= WKSP_BASE + &02A8
WKSP_ADFS_2A9			= WKSP_BASE + &02A9
WKSP_ADFS_2AA			= WKSP_BASE + &02AA
WKSP_ADFS_2AB			= WKSP_BASE + &02AB
WKSP_ADFS_2AC			= WKSP_BASE + &02AC
WKSP_ADFS_2AD			= WKSP_BASE + &02AD
WKSP_ADFS_2B4			= WKSP_BASE + &02B4
WKSP_ADFS_2B5			= WKSP_BASE + &02B5
WKSP_ADFS_2B6			= WKSP_BASE + &02B6
WKSP_ADFS_2B7			= WKSP_BASE + &02B7
WKSP_ADFS_2B8			= WKSP_BASE + &02B8
WKSP_ADFS_2B9			= WKSP_BASE + &02B9
WKSP_ADFS_2BA			= WKSP_BASE + &02BA
WKSP_ADFS_2BB			= WKSP_BASE + &02BB
WKSP_ADFS_2BC			= WKSP_BASE + &02BC
WKSP_ADFS_2BF			= WKSP_BASE + &02BF
WKSP_ADFS_2C0			= WKSP_BASE + &02C0
WKSP_ADFS_2C1			= WKSP_BASE + &02C1
WKSP_ADFS_2C2			= WKSP_BASE + &02C2
WKSP_ADFS_2C3			= WKSP_BASE + &02C3
WKSP_ADFS_2C8			= WKSP_BASE + &02C8
WKSP_ADFS_2C9			= WKSP_BASE + &02C9
WKSP_ADFS_2CA			= WKSP_BASE + &02CA
WKSP_ADFS_2CB			= WKSP_BASE + &02CB
WKSP_ADFS_2CC			= WKSP_BASE + &02CC
WKSP_ADFS_2CD			= WKSP_BASE + &02CD
WKSP_ADFS_2CE			= WKSP_BASE + &02CE
WKSP_ADFS_2CF			= WKSP_BASE + &02CF
WKSP_ADFS_2D0_ERR_SECTOR	= WKSP_BASE + &02D0	; little endian!
;;WKSP_ADFS_2D0_ERR_SECTOR+1			= WKSP_BASE + &02D1
;;WKSP_ADFS_2D2			= WKSP_BASE + &02D2
WKSP_ADFS_2D3_ERR_CODE		= WKSP_BASE + &02D3
WKSP_ADFS_2D4			= WKSP_BASE + &02D4
WKSP_ADFS_2D5_CUR_CHANNEL			= WKSP_BASE + &02D5
WKSP_ADFS_2D6			= WKSP_BASE + &02D6
WKSP_ADFS_2D7_SHADOW_SAVE	= WKSP_BASE + &02D7
WKSP_ADFS_2D8			= WKSP_BASE + &02D8
WKSP_ADFS_2D9			= WKSP_BASE + &02D9
WKSP_ADFS_2E0			= WKSP_BASE + &02E0
WKSP_ADFS_2E1			= WKSP_BASE + &02E1
WKSP_ADFS_2E2			= WKSP_BASE + &02E2
WKSP_ADFS_2E3_ERR_NO			= WKSP_BASE + &02E3
WKSP_ADFS_2E4			= WKSP_BASE + &02E4
WKSP_ADFS_2E5			= WKSP_BASE + &02E5
WKSP_ADFS_2E6			= WKSP_BASE + &02E6
WKSP_ADFS_2E7_STKSAVE		= WKSP_BASE + &02E7
WKSP_ADFS_2E8_FDC_CMD_STEP			= WKSP_BASE + &02E8
WKSP_ADFS_2FE			= WKSP_BASE + &02FE
WKSP_ADFS_313			= WKSP_BASE + &0313
WKSP_ADFS_314			= WKSP_BASE + &0314
WKSP_ADFS_315			= WKSP_BASE + &0315
WKSP_ADFS_316			= WKSP_BASE + &0316
WKSP_ADFS_317_CURDRV		= WKSP_BASE + &0317
WKSP_ADFS_318			= WKSP_BASE + &0318
WKSP_ADFS_319			= WKSP_BASE + &0319
WKSP_ADFS_31A			= WKSP_BASE + &031A
WKSP_ADFS_31B			= WKSP_BASE + &031B
WKSP_ADFS_31C			= WKSP_BASE + &031C
WKSP_ADFS_31D			= WKSP_BASE + &031D
WKSP_ADFS_31E			= WKSP_BASE + &031E
WKSP_ADFS_31F			= WKSP_BASE + &031F
WKSP_ADFS_321			= WKSP_BASE + &0321
WKSP_ADFS_322			= WKSP_BASE + &0322
WKSP_ADFS_331			= WKSP_BASE + &0331
WKSP_ADFS_332			= WKSP_BASE + &0332
WKSP_ADFS_333_LASTACCDRV	= WKSP_BASE + &0333
WKSP_ADFS_334			= WKSP_BASE + &0334
WKSP_ADFS_33E			= WKSP_BASE + &033E
WKSP_ADFS_348			= WKSP_BASE + &0348
WKSP_ADFS_352			= WKSP_BASE + &0352
WKSP_ADFS_35C			= WKSP_BASE + &035C
WKSP_ADFS_366			= WKSP_BASE + &0366
WKSP_ADFS_370			= WKSP_BASE + &0370
WKSP_ADFS_37A			= WKSP_BASE + &037A
WKSP_ADFS_383			= WKSP_BASE + &0383
WKSP_ADFS_384			= WKSP_BASE + &0384
WKSP_ADFS_38E			= WKSP_BASE + &038E
WKSP_ADFS_398			= WKSP_BASE + &0398
WKSP_ADFS_3A2			= WKSP_BASE + &03A2
WKSP_ADFS_3AC_CH_FLAGS		= WKSP_BASE + &03AC
CH_FLAGS_EOF			= $08

WKSP_ADFS_3B6			= WKSP_BASE + &03B6
WKSP_ADFS_3C0			= WKSP_BASE + &03C0
WKSP_ADFS_3CA			= WKSP_BASE + &03CA
WKSP_ADFS_3D4			= WKSP_BASE + &03D4
WKSP_ADFS_3DE			= WKSP_BASE + &03DE
WKSP_ADFS_3E8			= WKSP_BASE + &03E8
WKSP_ADFS_3F2			= WKSP_BASE + &03F2


;;
;; C3AC-B3 open channel flags
;;


;; User Disk Access
;; ================
;; Do a disk access using SCSI API. Control block at &C215-&C224
;;
;;    Addr Ctrl
;;   &C215  Returned result
;;   &C216  Addr0
;;   &C217  Addr1
;;   &C218  Addr2
;;   &C219  Addr3
;;   &C21A  Command
;;   &C21B  Drive+Sector b16-b20
;;   &C21C  Sector b8-b15
;;   &C21D  Sector b0-b7
;;   &C21E  Sector Count
;;   &C21F  -
;;   &C220  Length0
;;   &C221  Length1
;;   &C222  Length2
;;   &C223  Length3
;;   &C224

ZP_ADFS_C2_SAVE_Y		= &C2
ZP_ADFS_C3_SAVE_X		= &C3

ZP_ADFS_HD_STATUS		= &CC
ZP_ADFS_CF_CHANNEL_OFFS		= &CF


; FS ZP variables
;; ZP_ADFS_FLAGS (&CD) ADFS status flag
;; --------------------
ZP_ADFS_FLAGS			= &CD
;; b7 Tube present
ADFS_FLAGS_TUBE_PRESENT		= &80
;; b6 Tube being used
ADFS_FLAGS_TUBE_INUSE		= &40
;; b5 Hard Drive present
ADFS_FLAGS_HD_PRESENT		= &20
;; b4 FSM in memory inconsistent/being loaded
ADFS_FLAGS_FSM_INCONSISTENT	= &10
;; b3 (not documented, unsure)
ADFS_FLAGS_WTF			= &08
;; b2 *OPT1 setting
ADFS_FLAGS_OPT1			= &04
;; b1 Bad Free Space Map
ADFS_FLAGS_FSM_BAD		= &02
;; b0 Files being ensured
ADFS_FLAGS_ENSURING		= &01

ZP_ADFS_RETRY_CTDN		= &CE

; drive control flags (some set below in machine specific section)
FDCDS0 				= &01
FDCDS1 				= &02

IF USE65C12
		CPU	1				; 65c12
ELSE
		CPU	0				; 6502
ENDIF
; Target-specific equates
; -----------------------
IF   TARGETOS=0
  VERBASE=&100		; Electron
  HDDBASE=&FC40		; Hard drive controller
  FDCBASE=&FCC4		; Floppy controller
  DRVSEL =FDCBASE-4	; Drive control register
  FDCRES =&20		; Reset FDC
  FDCSIDE=&04		; Side select
  ROMSEL =&FE05		; ROM select register
  VIABASE=&FC60		; 6522 VIA
  TUBEIO =&FCE5		; Tube data port
  TUBEIOSTAT =&FCE4
  FILEBLK=&02E2		; OSFILE control block
  WS=&E00-WKSP_ADFS_000_FSM_S0		; Offset to workspace from WKSP_ADFS_000_FSM_S0
ELIF TARGETOS=1 OR TARGETOS=2
  VERBASE=&130		; BBC B, BBC B+
  HDDBASE=&FC40		; Hard drive controller
  FDCBASE=&FE84		; Floppy controller
  DRVSEL =FDCBASE-4	; Drive control register
  FDCRES =&20		; Reset FDC
  FDCSIDE=&04		; Side select
  ROMSEL =&FE30		; ROM select register
  VIABASE=&FE60		; 6522 VIA
  TUBEIO =&FEE5		; Tube data port
  TUBEIOSTAT = &FEE4
  FILEBLK=&02EE	  ; OSFILE control block
  WS=&E00-WKSP_ADFS_000_FSM_S0		; Offset to workspace from WKSP_ADFS_000_FSM_S0
ELIF TARGETOS>2
  VERBASE=&150		; Master
  HDDBASE=&FC40		; Hard drive controller
  FDCBASE=&FE28		; Floppy controller
  DRVSEL =FDCBASE-4	; Drive control register
  FDCRES =&04		; Reset FDC
  FDCSIDE=&10		; Side select
  ROMSEL =&FE30		; ROM select register
  VIABASE=&FE60		; 6522 VIA
  TUBEIO =&FEE5		; Tube data port
  TUBEIOSTAT = &FEE4
  FILEBLK=&02EE		; OSFILE control block
  WS=0			; Offset to workspace from WKSP_ADFS_000_FSM_S0
ENDIF

FDC_CMD 		= FDCBASE
FDC_TRACK		= FDCBASE+1
FDC_SEC			= FDCBASE+2
FDC_DATA		= FDCBASE+3

; HD INTERFACE specifics
IF HD_IDE
	IDE_DATA 	= HDDBASE + 0
	IDE_ERROR	= HDDBASE + 1
	IDE_SEC_CT	= HDDBASE + 2
	IDE_SEC_NO	= HDDBASE + 3
	IDE_CYL_NO_LO	= HDDBASE + 4
	IDE_CYL_NO_HI	= HDDBASE + 5
	IDE_DRVHEAD	= HDDBASE + 6
	IDE_STATUS	= HDDBASE + 7
ELIF HD_SCSI
	SCSI_DATA 	= HDDBASE + 0
	SCSI_STATUS	= HDDBASE + 1
	SCSI_SELECT	= HDDBASE + 2
	SCSI_IRQEN	= HDDBASE + 3

	SCSI_STATUS_BIT_CnD		= &80			; 1 for command 0 for data
	SCSI_STATUS_BIT_InO		= &40			; 0 for I->T 1 for T->I
	SCSI_STATUS_BIT_REQ		= &20			; 1 for data ready
	SCSI_STATUS_BIT_IF		= &10			; 1 when interrupt pending
	SCSI_STATUS_BIT_BUSY	 	= &02			; 1 when SCSI bus BUSY asserted
	SCSI_STATUS_BIT_MSG	 	= &01			; 1 when SCSI bus MSG asserted


ELIF HD_MMC

ELIF HD_SCSI2
	; The host adapter is always ID=7!
	SCSI2_INITIATOR_ID		=	7
	SCSI2_INITIATOR_ID_BITS		=	1<<SCSI2_INITIATOR_ID

	SCSI2_DATA_0			=	HDDBASE + 0	; live data bus lines

	SCSI2_INIT_CMD_1		=	HDDBASE + 1	; initiator command reg
	S2_INIT_CMD_ASSERT_DATA		=	&01
	S2_INIT_CMD_ASSERT_nATN		=	&02
	S2_INIT_CMD_ASSERT_nSEL		=	&04
	S2_INIT_CMD_ASSERT_nBSY		=	&08
	S2_INIT_CMD_ASSERT_nACK		=	&10
	S2_INIT_CMD_ARB_LOST		=	&20
	S2_INIT_CMD_ARB_PROG		=	&40
	S2_INIT_CMD_ASSERT_nRST		=	&80

	SCSI2_MODE_2			=	HDDBASE + 2
	S2_MODE_ARBITRATE		=	&01
	S2_MODE_DMA			=	&02
	S2_MODE_MONITOR_BSY		=	&04
	S2_MODE_IE_EOP			=	&08
	S2_MODE_IE_PAR			=	&10
	S2_MODE_PARCHECK		=	&20
	S2_MODE_TARGET			=	&40

	SCSI2_TARGET_CMD_3		=	HDDBASE + 3
	S2_TARG_CMD_ASSERT_InO		=	&01
	S2_TARG_CMD_ASSERT_CnD		=	&02
	S2_TARG_CMD_ASSERT_nMSG		=	&04
	S2_TARG_CMD_ASSERT_nREQ		=	&08
	S2_TARG_CMD_ASSERT_LASTBYTE	=	&80

	SCSI2_BUS_STATUS_4		=	HDDBASE + 4
	S2_BUS_nDBP			=	&01
	S2_BUS_nSEL			=	&02
	S2_BUS_InO			=	&04
	S2_BUS_CnD			=	&08
	S2_BUS_nMSG			=	&10
	S2_BUS_nREQ			=	&20
	S2_BUS_nBSY			=	&40
	S2_BUS_nRST			=	&80

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
	S2_BUS_PHASE_MASK 		=	(S2_BUS_nMSG OR S2_BUS_CnD OR S2_BUS_InO)
												; ==		targetcmd
	S2_BUS_PHASE_DATAOUT		=	0						; 00			0
	S2_BUS_PHASE_DATAIN		=	S2_BUS_InO					; 04			1
	S2_BUS_PHASE_CMDOUT		=	S2_BUS_CnD					; 08			2
	S2_BUS_PHASE_STATIN		=	(S2_BUS_CnD OR S2_BUS_InO)			; 0C			3
	S2_BUS_PHASE_MSGOUT		=	(S2_BUS_nMSG OR S2_BUS_CnD)			; 18			6
	S2_BUS_PHASE_MSGIN		=	(S2_BUS_nMSG OR S2_BUS_CnD OR S2_BUS_InO)	; 1C			7
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
ENDIF

VERSION=VERBASE + (PRESERVE_CONTEXT AND 1) + (HD_IDE AND 2) + (HD_MMC AND 6) + (HD_SCSI2 AND 4)
; Version number x.yz
;		  1.0z = Electron
;		  1.3z = BBC B/B+
;		  1.5z = Master
;	      z=%abcd
;		  |||+---preserve context on break and various bugfixes
;		  |00----SCSI drivers
;		  |01----IDE drivers
;		  |10----reserved
;		  |11----User port MMC drivers
;		  +------reserved

; ROM HEADER
; ==========
ORG &8000
.L8000		EQUB	&00,&00,&00			; No language entry
		jmp	ServiceCallHandlerL9ACE		; Jump to service handler
		EQUB	&82				; Service ROM, 6502 code
		EQUB	L8017-L8000			; Offset to (C) string
		EQUB	VERSION AND &FF			; Binary version number
		EQUS	"Acorn ADFS",0			; ROM Title
		EQUB	(VERSION DIV 256)+48		; Version string
IF TARGETOS <=1
		EQUB	'.'
ENDIF
		EQUB	((VERSION AND &F0)DIV 16)+48
		EQUB	(VERSION AND &0F)+48
.L8017		EQUB	&00				; Copyright string
IF HD_SCSI2
		EQUS	"(C)2018 Dossy",0
ELIF   HD_MMC
		EQUS	"(C)2016",0
ELIF HD_IDE
IF HD_IDE_FAST
		EQUS	"(C)2021 FAST",0
ELSE
IF TARGETOS = 0
		EQUS	"(C)1983 Acorn", 0		; TODO: Ask JGH?
ELIF TARGETOS = 1
		EQUS	"(C)2005 Acorn",0
ELSE
		EQUS	"(C)2005",0
ENDIF ; TARGETOS
ENDIF ; IDE_FASE
ELSE
IF TARGETOS > 2
		EQUS	"(C)1984",0
ELSE
		EQUS	"(C)1983 Acorn",0
ENDIF
ENDIF


; Claim Tube if present
; ---------------------
.TUBE_CLAIM_IF_PRESENT					; L8020 / L8027
{
		ldy	#&04
		bit	ZP_ADFS_FLAGS
		bpl	L8039				; Exit with no Tube present
._lp
		lda	(&B0),Y				; Copy address to &C227-2A
		sta	WKSP_ADFS_227_TUBE_XFER - 1,Y
		dey
		bne	_lp
IF USE65C12=TRUE
		lda	#ADFS_FLAGS_TUBE_INUSE
		tsb	ZP_ADFS_FLAGS			; Flag Tube being used
ELSE
		lda	ZP_ADFS_FLAGS
		ora	#ADFS_FLAGS_TUBE_INUSE
		sta	ZP_ADFS_FLAGS
ENDIF
}
.L8032
		lda	#&C4				; ADFS Tube ID=&04, &C0=Claim
		jsr	&0406				; Claim Tube
		bcc	L8032				; Loop until claim successful
.L8039		rts


; Release Tube if used, and restore Screen settings
; -------------------------------------------------
.TubeRelease						; L803A
		bit	ZP_ADFS_FLAGS
		bvc	L8047				; Tube not being used
		lda	#&84				; ADFS Tube ID=&04, &80=Release
		jsr	&0406				; Release Tube
IF USE65C12
		lda	#ADFS_FLAGS_TUBE_INUSE
		trb	ZP_ADFS_FLAGS			; Reset Tube being used flag
ELSE
		php
		sei
		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_TUBE_INUSE EOR &FF
		sta	ZP_ADFS_FLAGS
		plp
ENDIF
.L8047
IF TARGETOS > 1
		lda	WKSP_ADFS_2D7_SHADOW_SAVE	; Screen memory used?
		beq	L804F				; Exit if screen unchanged
		sta	&FE34				; Restore screen setting
.L804F		stz	WKSP_ADFS_2D7_SHADOW_SAVE	; Clear screen flag
ENDIF
		rts

IF TARGETOS > 1
; Check for screen memory
; -----------------------
; Put shadow screen memory into main memory if I/O address specifies &FFFExxxx
.CheckAndPageInShadowScreen				; L8053
		phy					; Save Y
		ldy	&FE34				; Get current Screen setting
		sty	WKSP_ADFS_2D7_SHADOW_SAVE			; Save it
		inx					; Address=&FFxxxxxx?
		bne	L806D				; Not I/O memory, exit
		cmp	#&FE				; Address=&FFFExxxx?
		bne	L806D				; Not screen memory, exit
		tya					; Get current screen state into A
		ror	A				; Move to Cy
		lda	#&04
		trb	&FE34				; Put normal RAM in memory
		bcc	L806D				; Exit if shadow screen being displayed
		tsb	&FE34				; Put shadow RAM in memory
.L806D		ply					; Restore Y
		rts
ENDIF


;; DRIVE ACCESS ROUTINES
;; =====================
;; This is the drive access subsystem. Access to drives 4 to 7 access
;; floppy drives 0 to 3 with the 1770 FDC. Access to drives 0 to 3 access
;; hard drives 0 to 3 if a hard drive interface is present. If there is
;; no hard drive interface, access to drives 0 to 3 accesses floppy drives
;; 0 to 3.
;;
;; Read hard drive status. Waits for status value to settle before returning
;; -------------------------------------------------------------------------
IF HD_MMC
;; Drive status is not used in the SD Code
ENDIF
IF HD_IDE
.IDE_GetStatus	
{	
		php
.lp		lda	IDE_STATUS			; Get IDE status
		sta	ZP_ADFS_HD_STATUS		; Save this value
		lda	IDE_STATUS			; Get IDE status
		cmp	ZP_ADFS_HD_STATUS		; Compare with previous status
		bne	lp				; Loop until status stays same
		plp
		rts
}
ENDIF
IF HD_SCSI
.SCSI_GetStatus	
{	
		php
.lp		lda	SCSI_STATUS			; Get SCSI status
		sta	ZP_ADFS_HD_STATUS		; Save this value
		lda	SCSI_STATUS			; Get SCSI status
		cmp	ZP_ADFS_HD_STATUS		; Compare with previous status
		bne	lp				; Loop until status stays same
		plp
		rts
}
ENDIF

IF HD_IDE
.X807E		rts
;      NOP
;      NOP
;      NOP
;      RTS
ENDIF

IF HD_IDE
IF TARGETOS > 0
.ReadBreak
		lda	&028D
		and	#&01
		rts
.WaitForData
		pha					; Balance stack
.WaitForLp
		pla
		lda	IDE_STATUS			; Get status
		pha
		and	#8
		beq	WaitForLp			; Loop until data ready
		pla					; Return status
		rts
ELSE ; TARGETOS = 0
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
.WaitForData
	LDA IDE_STATUS	 ;;  Loop until data ready
	AND #8
	BEQ WaitForData
	RTS
;; TODO: ASK JGH - why the larger/slower version?
;; TODO: Check this bug fix is right
ENDIF ; TARGETOS = 0
ENDIF ; HD_IDE

IF HD_MMC
IF TARGETOS > 0 
.ReadBreak
		lda	&028D
		and	#&01
		rts
.WaitForData
		rts
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
ELSE ; TARGETOS = 0
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
.WaitForData
	rts
	nop
	nop
	nop
	nop
	nop
	nop
ENDIF ; TARGETOS=0
ENDIF ; HD_MMC

IF HD_IDE OR HD_MMC
.starMOUNTck
		jsr	starMOUNT				; Do *MOUNT, then reselect ADFS
IF TARGETOS = 0
		jmp	L9B4C
ELSE
		jmp	L9B50
ENDIF
ENDIF
IF HD_IDE AND TARGETOS >= 1
		EQUB	&F9
ENDIF

IF HD_SCSI
; Set SCSI to command mode
; ------------------------
.SCSI_StartCommand					; L807E
		ldy	#&00				; Useful place to set Y=0
.SCSI_StartCommand2		
		lda	#&01
		pha					; Save data value
.L8083		jsr	SCSI_GetStatus			; Get SCSI status
		and	#&02				; BUSY?
		bne	L8083				; Loop until not BUSY
		pla					; Get data value back
		sta	SCSI_DATA			; Write to SCSI data
		sta	SCSI_SELECT			; Write to SCSI select to strobe it
.L8091		jsr	SCSI_GetStatus			; Get SCSI status
		and	#&02				; BUSY?
		beq	L8091				; Loop until BUSY
ENDIF



.L8098rts	rts

; Initialise retries value
; ------------------------
.CommandSetRetries					; L8099	
		lda	WKSP_ADFS_200			; Get default retries
		sta	ZP_ADFS_RETRY_CTDN		; Set current retries
.L809Erts	rts
;;
;;
.L809F		jmp	ErrorEscapeACKInvalidReloadFSM				; Jump to 'Escape' error
;;
;;
;; Access a drive using SCSI protocol
;; ==================================
;; Transfer up to &FF00 bytes at a time
;; XY=>control block:
;;   XY+ 0  Flag on entry, Returned result on exit
;;   XY+ 1  Addr0
;;   XY+ 2  Addr1
;;   XY+ 3  Addr2
;;   XY+ 4  Addr3
;;   XY+ 5  Command
;;   XY+ 6  Drive+Sector b16-19
;;   XY+ 7  Sector b8-b15
;;   XY+ 8  Sector b0-b7
;;   XY+ 9  Sector Count
;;   XY+10  -
;;   XY+11  Length0
;;   XY+12  Length1
;;   XY+13  Length2
;;   XY+14  Length3
;;   XY+15
;;
;; On exit: A=result. 0=OK, <>0=error, with ADFS error block filled in
;; ADFS Error Information:
;;   &C2D0 Sector b0-b7
;;   &C2D1 Sector b8-b15
;;   &C2D2 Sector b16-b19 and Drive
;;   &C2D3 SCSI error number
;;   &C2D4 Channel number if &C2D3.b7=1
;;
.CommandExecXY						; L80A2	
		jsr	WaitEnsuring			; Wait for ensuring to complete
		stx	&B0
		sty	&B1				; &B0/1=>control block
		jsr	CheckDirLoaded			; Check if directory loaded
		ldy	#&05
		lda	(&B0),Y				; Get Command
		cmp	#&2F				; Verify?
		beq	CommandExecSkStartExec		; Jump directly to do it
		cmp	#&1B				; Park?
		beq	CommandExecSkStartExec		; Jump directly to do it
		jsr	CommandSetRetries		; Set number of retries
		bpl	L80D7				; Jump into middle of retry loop (always?!?)
;;
;; This loop tries to access a drive. If the action returns 'Not ready' it
;; retries a number of times, allowing interuption by an Escape event.
;;
.CommandExecRetryLp		
		jsr	CommandExecSkStartExec		; Do the specified command
IF (HD_IDE OR HD_MMC) AND TARGETOS > 0			; TODO : rationalise
		beq	L809Erts			; Exit if ok
ELSE
		beq	L8098rts			; Exit if ok
ENDIF
IF HD_SCSI2 ; TODO: bodge - sort out error numbers!
		cmp	#&08				; Not ready?
ELSE
		cmp	#&04				; Not ready?
ENDIF
		bne	L80D7				; Skip past if result<>Not ready
;;			    If Drive not ready, pause a bit
IF HD_SCSI2
		ldy	#&01				; Loop 25*256*256 times
ELSE
		ldy	#&19				; Loop 25*256*256 times
ENDIF
.L80C8		bit	ZP_MOS_ESCFLAG			; Escape pressed?
		bmi	L809F				; Abort with Escape error (shouldn't this return Abort?)
		sec
		sbc	#&01
		bne	L80C8				; Loop 256 times with A
		dex
		bne	L80C8				; Loop 256 times with X
		dey
		bne	L80C8				; Loop 25 times with Y
;;
.L80D7		
		cmp	#&40				; Result=Write protected?
		beq	CommandExecSkStartExec		; Abort immediately
		dec	ZP_ADFS_RETRY_CTDN		; Dec number of retries
		bpl	CommandExecRetryLp		; Jump to try again
;;			    Drop through to try once last time
;;
;; Try to access a drive
;; ---------------------
.CommandExecSkStartExec
IF TARGETOS > 1
		ldy	#&04
		lda	(&B0),Y				; Get Addr3
		tax					; X=Addr3 - I/O or Language
		dey
		lda	(&B0),Y				; Get Addr2 - Screen bank
		jsr	CheckAndPageInShadowScreen				; Set I/O and Screen settings
ENDIF
;;
;; No hard drive present, drive 0 to 7 map onto floppies 0 to 3.
;; When hard drives are present, drives 4 to 7 map onto floppies 0 to 3.
;;
IF FLOPPY
		lda	ZP_ADFS_FLAGS			; Get ADFS I/O status
		and	#ADFS_FLAGS_HD_PRESENT		; Hard drive present?
		bne	HD_Command			; Jump when hard drive present
;;
;; Access a floppy drive
;; ---------------------
.CommandExecFloppyOp		
		jsr	DoFloppySCSICommandIND		; Do floppy operation
		beq	L8110				; Completed ok
		pha					; Save result
IF OPTIMISE<6
		ldy	#&06				; Update ADFS error infomation
		lda	(&B0),Y				; Get Drive+Sector b16-b19
		ora	WKSP_ADFS_317_CURDRV		; OR with current drive
ELSE
		jsr	GetDrive
ENDIF
		sta	WKSP_ADFS_2D0_ERR_SECTOR+2	; Store
		iny
		lda	(&B0),Y				; Get Sector b8-b15
		sta	WKSP_ADFS_2D0_ERR_SECTOR+1
		iny
		lda	(&B0),Y				; Get Sector b0-b7
		sta	WKSP_ADFS_2D0_ERR_SECTOR
		pla					; Restore result
		sta	WKSP_ADFS_2D3_ERR_CODE		; Store
.L8110		rts
ENDIF
IF HD_MMC
							;Do an MMC data transfer
							;-----------------------
		include	"MMC_Driver.asm"
ENDIF
IF HD_IDE
	IF HD_IDE_FAST
		include "IDE_Driver_Fast.asm"
	ELSE
		include "IDE_Driver.asm"
	ENDIF
ENDIF
IF HD_SCSI
		include "SCSI_Driver.asm"
ENDIF
IF HD_SCSI2
		include "SCSI2_Driver.asm"
ENDIF





;; Do disk access from control block in workspace
;; ==============================================
.L82AA		ldx	#<WKSP_ADFS_215_DSKOPSAV_RET			; Point to control block at &C215
		ldy	#>WKSP_ADFS_215_DSKOPSAV_RET
.L82AE		jsr	CommandExecXY				; Do a disk operation
		bne	GenerateError				; Jump ahead with error
		rts					; Exit if OK

.L82B4		lda	WKSP_ADFS_22F
		sta	WKSP_ADFS_317_CURDRV
		jmp	L8BE2				; Not Found error

; Translate some disk results into their own error message
; ========================================================
; Return results are &00 for ok, &00+xx for HDD, &40+xx for FDD
; &00    - Ok
; &00+xx - hard drive error
; &40+xx - floppy error
;	&40 Write protected (FDC status &40)
; &01	No Master Boot Record (disk not formatted)
; &02	Drive door open/seek error
; &03	Write fault
; &04	Drive not ready
; &05	Malformed command
; &06	Track 0 not found
;	&48 CRC error (FDC status &08)
; &10 / &50 Sector not found (FDC status &10)
; &11	Data CRC error
; &12	Data block not found
; &19	Bad track found
; &1C	No ADFS partitions (bad disk format)
; &20 / &60 Bad controller command
; &21 / &61 Bad disc address (beyond end of disk)
; &22 / &62 unused
; &23 / &63 Volume error
; &24 / &64 Bad arguments to controller
; &25 / &65 Bad drive number
; &26 / &66
; &27 / &67 Unsupported controller command
; &28	Media changed
; &2F / &6F Abort (Escape)
;	&7F Unknown result
; See the BeebWiki for full info
;
IF OPTIMISE<3
.GenerateError						; L82BD	
		cmp	#&25				; Hard drive error &25 (Bad drive)?
		beq	L82B4				; Jump to give 'Not found' error
		cmp	#&65				; Floppy error &25 (Bad drive)?
		beq	L82B4				; Jump to give 'Not found' error
		cmp	#&6F				; Floppy error &2F (Abort)?
		bne	L82DC				; If no, report a disk error
;;
IF TARGETOS > 1		; TODO: not sure this is becessary
.ErrorEscapeACKInvalidReloadFSM		
		jsr	InvalidateFSMandDIR		; Invalidate FSM and DIR in memory
.ErrorEscapeACKReloadFSM		
		lda	#&7E
		jsr	OSBYTE				; Acknowledge Escape state
		jsr	ReloadFSMandDIR_ThenBRK		; Reload FSM and DIR, generate an error		
ELSE
.ErrorEscapeACKInvalidReloadFSM	
IF TARGETOS<>0 OR NOT(HD_SCSI)
		lda	#&7E
		jsr	OSBYTE				; Acknowledge Escape state
ENDIF
		jsr	InvalidateFSMandDIR		; Invalidate FSM and DIR in memory
		jsr	ReloadFSMandDIR_ThenBRK			; Reload FSM and DIR, generate an error
ENDIF
		EQUB	&11				; ERR=17
		EQUS	"Escape"			; REPORT="Escape"
		EQUB	&00
;;
.L82DC		cmp	#&04				; Hard drive error &04 (Not ready)?
		bne	L82F4				; No, try other errors
		jsr	ReloadFSMandDIR_ThenBRK			; Generate an error "Drive not ready"
		EQUB	&CD				; ERR=205
		EQUS	"Drive not ready"
		EQUB	&00
;;
.L82F4		cmp	#&40				; Floppy drive error &10 (WRPROT)?
		beq	L830B				; Jump to report "Disk protected"
							;All other results, give generic
							;error message
		jsr	L89D8				; Load FSM and root directory
		tax
		jsr	GenerateErrorSuffX				; Generate error with number in X
		EQUB	&C7				; ERR=199
		EQUS	"Disc error"
		EQUB	&00
;;
.L830B		jsr	L834E				; Do something, then generate an error
		EQUB	&C9				; ERR=201
		EQUS	"Disc protected"
		EQUB	&00
ELSE
.GenerateError		pha					; Save disk error number for later
		and	#&3F				; Drop HDD/FDD flag from bit 6
		beq	L830B				; &40->&00-> Disc write protected
; If there is space, add things like MMC card not formatted, No ADFS partition, etc.
		cmp	#&25				; Bad drive
		beq	L82B4				; Jump to give 'Not found' error
		cmp	#&2F
		beq	ErrorEscapeACKInvalidReloadFSM				; Abort -> Escape
							;All other results, give generic error message
		jsr	L89D8				; Load FSM and root directory
	IF USE65C12
		plx					; Get disk error number back
	ELSE
		pla
		tax
	ENDIF
		jsr	GenerateErrorSuffX				; Generate error with number in X
		EQUB	&C7				; ERR=199
		EQUS	"Disc error"
		EQUB	&00
IF TARGETOS > 1
.ErrorEscapeACKInvalidReloadFSM		jsr	InvalidateFSMandDIR				; Invalidate FSM and DIR in memory
.ErrorEscapeACKReloadFSM		lda	#&7E
		jsr	OSBYTE				; Acknowledge Escape state
		jsr	ReloadFSMandDIR_ThenBRK				; Reload FSM and DIR, generate an error
ELSE
	; beeb acks later shome mishtake?
.ErrorEscapeACKInvalidReloadFSM		lda	#&7E
		jsr	OSBYTE				; Acknowledge Escape state
		jsr	InvalidateFSMandDIR				; Invalidate FSM and DIR in memory
		jsr	ReloadFSMandDIR_ThenBRK				; Reload FSM and DIR, generate an error		
ENDIF
		EQUB	&11				; ERR=17
		EQUS	"Escape"
		EQUB	&00
.L830B		jsr	L834E				; Do something, then generate an error
		EQUB	&C9				; ERR=201
		EQUS	"Disc protected"
		EQUB	&00
ENDIF
;
IF HD_IDE
.TubeStore
		jsr	TSDelay				; JSR/RTS delay
IF TARGETOS = 0
		bne	GenerateError
		rts
.TSDelay
		jsr	_lelk831B
		rts

ELSE
		sta	TUBEIO				; Send to Tube
.TSDelay
		rts
	IF NOT(HD_IDE_FAST)
		EQUB	0,0,0
	ENDIF
ENDIF
ENDIF
IF HD_SCSI
.SCSI_SendCMDByte
		jsr	L8324				; Wait until not busy, then write command to command register
		bne	GenerateError				; If not Ok, generate disk error
		rts
.L8324		jsr	SCSI_send_byteA			; This code cannot be inlined or JMPed as
		rts					; SCSI_send_byteA changes stack
ENDIF


;; Wait until any ensuring completed
;; =================================
IF HD_MMC OR HD_IDE
.WaitEnsuring						; L8328
		lda	ZP_ADFS_FLAGS			; Get ADFS status byte
		and	#(ADFS_FLAGS_ENSURING)EOR&FF	; Drop 'ensuring' bit
		sta	ZP_ADFS_FLAGS			; Update ADFS status byte
		rts
ENDIF
IF HD_IDE
IF TARGETOS = 0
._lelk830C
		bne	WaitEnsuring
		rts
ELSE ; TARGETOS > 0
		EQUB	0,0,0
ENDIF ; TARGETOS > 0
ENDIF ; HD_IDE
IF HD_SCSI OR HD_SCSI2
.WaitEnsuring						; L8328
		lda	#ADFS_FLAGS_ENSURING		; Prepare to look at bit 0
		php					; Save IRQ disable
		cli					; Enable IRQs for a moment
		plp					; Restore IRQ disable
		bit	ZP_ADFS_FLAGS			; Check 'Files ensuring'
		bne	WaitEnsuring			; Loop back if set
		rts
ENDIF ;  HD_SCSI OR HD_SCSI2

;; Wait until hard drive ready to respond
;; --------------------------------------
IF HD_MMC
ENDIF
IF HD_IDE
.IDE_WaitforReq
{
		php					; Get IDE status
.lp		jsr	IDE_GetStatus
		and	#&C0				; Wait for IDE not busy and ready
		cmp	#&40
		bne	lp
		plp
		rts
}
IF TARGETOS = 0
._lelk831B
		jsr	IDE_WaitforReq
		bvs	_lelk8326
		sta	IDE_DATA
		lda	#&00
		rts
._lelk8326
		pla
		pla
		jmp	CommandDone
ELSE ; TARGETOS > 0
		EQUB	0,0,0,0,0,0,0,0
		EQUB	0,0,0
ENDIF ; TARGETOS > 0
ENDIF ; HD_IDE

IF HD_SCSI
.SCSI_WaitforReq		
{
		pha					; Save A
.lp		jsr	SCSI_GetStatus			; Get SCSI status
		and	#&20				; Check REQUEST
		beq	lp				; Loop until REQUEST set
		pla					; Restore A
		bit	ZP_ADFS_HD_STATUS		; Set flags from SCSI status
		rts
}

.SCSI_send_byteA		
		jsr	SCSI_WaitforReq			; Wait until SCSI ready
		bvs	L8349				; Wrong phase i.e. SCSI wants to do data in not out!
							; WRONG?: SCSI not responding, drop return and return result=UNKNOWN
		sta	SCSI_DATA
		lda	#&00				; Return Ok
		rts
.L8349		pla					; Drop return address
		pla
		jmp	CommandDone			; Jump to get result and return
ELSE
IF TARGETOS <> 0
		EQUB	0,0,0,0,0
ENDIF ; TARGETOS <> 0
ENDIF

; Generate an error
; =================
; Fairly complicated routine that checks various bits of context to create an
; explanatory error message.
; 'Error message'
; +' XX at :D/SSSSSS' if passed non-zero in X
; +' on channel NNN' if a channel is being used
; Allows up to 'Error message XX at :D/SSSSSS on channel NNN'
;

; Do something, then reload FSM+DIR and generate an error
; -------------------------------------------------------
.L834E		ldx	WKSP_ADFS_22F
		inx
		bne	ReloadFSMandDIR_ThenBRK
		ldx	WKSP_ADFS_22E
		inx
		bne	L8365
		ldy	#&02
.L835C		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	L835C
.L8365		lda	WKSP_ADFS_317_CURDRV
		sta	WKSP_ADFS_22F

; Reload FSM+DIR and generate an error
; ------------------------------------
.ReloadFSMandDIR_ThenBRK		
		jsr	L89D8				; Reload FSM and DIR if needed
IF NOT(TRIM_REDUNDANT)
IF USE65C12
		lda	#ADFS_FLAGS_FSM_INCONSISTENT	; Clear 'FSM inconsistant' flag
		trb	ZP_ADFS_FLAGS			; This gets done anyway in a bit
ELSE
		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_FSM_INCONSISTENT EOR &FF
		sta	ZP_ADFS_FLAGS
ENDIF
ENDIF

; Generate an error with no suffix
; --------------------------------
.GenerateErrorNoSuff					; L8372
		ldx	#&00				; X=&00 for no error suffix

; Generate an error with suffix number if X<>0
; --------------------------------------------
.GenerateErrorSuffX					; L8374	
		pla					; Pop return address
		sta	&B2
		pla
		sta	&B3
IF USE65C12
		lda	#ADFS_FLAGS_FSM_INCONSISTENT
		trb	ZP_ADFS_FLAGS			; Clear 'FSM inconsistent' flag
ELSE
		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_FSM_INCONSISTENT EOR &FF
		sta	ZP_ADFS_FLAGS
ENDIF
		ldy	#&00
.L8380		iny
		lda	(&B2),Y				; Copy error to error block at &100
		sta	&0100,Y
		bne	L8380
		txa
		beq	GenerateErrorSkNoSuff		; No suffix needed
		lda	#&20
		sta	&0100,Y				; Add a space
		txa
IF OPTIMISE<3
; This initially looks like a bug, if X=&30-&39 it inserts in decimal as though
; it's a channel number, but then continues to append disk error information.
; This is done for 'Data lost, channel NNN at :D/SSSSSS' which could even
; become 'Data lost, channel NNN at :D/SSSSSS on channel NNN'. Would be better
; to generate the 'Data lost' error as a channel error.
		cmp	#CHANNEL_RANGE_LO
		bcs	L839B				; &30+, jump to check if channel number
.L8395		jsr	L8451				; Insert disk error as hex number
		jmp	L83A2
.L839B		cmp	#&3A
		bcs	L8395				; &3A+, not a channel number, jump back
		jsr	L846D				; Insert number in decimal
ELSE
		jsr	L8451				; Insert disk error as hex number
ENDIF
.L83A2		ldx	#&04
.L83A4		iny
		lda	L8440,X				; Insert ' at :'
		sta	&0100,Y
		dex
		bpl	L83A4
		lda	WKSP_ADFS_2D0_ERR_SECTOR+2	; Get drive last used
		asl	A
		rol	A
		rol	A
		rol	A
		jsr	L8462				; Convert to digit (ORA #&48 would do here)
		iny
		sta	&0100,Y				; Insert into error block
		lda	#&2F
		iny
		sta	&0100,Y				; Insert '/'
		lda	WKSP_ADFS_2D0_ERR_SECTOR+2	; Get sector last used
		and	#&1F				; Remove drive bits
		ldx	#&02
		bne	L83CE
.L83CB		lda	WKSP_ADFS_2D0_ERR_SECTOR,X	; Get sector
.L83CE		jsr	L8451				; Store in error block in hex
		dex
		bpl	L83CB				; Loop for 2+3 bytes
		iny
		lda	#&00
		sta	&0100,Y				; Store terminating &00
.GenerateErrorSkNoSuff		
		lda	WKSP_ADFS_2D5_CUR_CHANNEL			; Get channel being used
		beq	L840F				; Random access not being used, generate the error
		ldx	#&0B
		dey					; Step back to overwrite terminator
.L83E2		lda	L8445,X				; Insert ' on channel '
		iny
		sta	&0100,Y
		dex
		bpl	L83E2
		lda	WKSP_ADFS_2D5_CUR_CHANNEL			; Get channel
		jsr	L846D				; Insert channel number in decimal
IF USE65C12
		phy					; Save offset into error block
ELSE
		tya
		pha
ENDIF
		lda	#&C6

IF TARGETOS > 1
		sta	WKSP_ADFS_2D9
ELSE
		sta	WKSP_ADFS_2D8
ENDIF

		jsr	L84C4				; OSBYTE &C6, read Exec and Spool handles
		cpx	WKSP_ADFS_2D5_CUR_CHANNEL			; Error while using Exec channel?
		php
		ldx	#<strExecAbbrev			; Point to '*Exec'
		plp
		beq	L840B				; Yes, jump to close Exec file
		cpy	WKSP_ADFS_2D5_CUR_CHANNEL			; Error while using Spool channel?
		bne	L840E				; No, jump to finish error
		ldx	#<strSpoolAbbrev		; Point to '*Spool'
.L840B		jsr	OSCLIatX			; Close Exec or Spool file
.L840E
IF USE65C12
		ply					; Get offset into error block back
ELSE
		pla
		tay
ENDIF
.L840F		lda	WKSP_ADFS_2CE			; Get workspace checksum
		bne	L8417				; Not &00, finish the error
		jsr	LA7D4				; Recalculate and update workspace checksum
.L8417		lda	#&00
		sta	&0100				; Insert BRK
		sta	&0101,Y				; Insert error terminator
		jsr	TubeRelease				; Release Tube, restore screen memory
		lda	&0101				; Get error number
		cmp	#&C7				; Is it 'Disc error'?
		bne	L843D				; No, execute the error
IF TARGETOS > 1
		dec	A
		jsr	L84C4				; OSBYTE &C6, read Exec and Spool handles
IF USE65C12
		phy					; Save Spool handle
ELSE
		tay
		pha
ENDIF
		txa					; Get Exec handle in A
ENDIF
IF TARGETOS > 1
		ldx	#<strExecAbbrev			; Point to '*Exec'
		jsr	ckAisCha_OSCLIatX		; Close if *EXEC handle
		pla					; Get Spool handle back
		ldx	#<strSpoolAbbrev		; Point to '*Spool'
		jsr	ckAisCha_OSCLIatX		; Close if *SPOOL handle
ELSE
		ldx	#<strSpoolAbbrev		; Point to '*Spool'
		jsr	OSCLIatX			; Close if *EXEC handle
		ldx	#<strExecAbbrev			; Point to '*Exec'
		jsr	OSCLIatX			; Close if *SPOOL handle
ENDIF
		jsr	InvalidateFSMandDIR
.L843D		jmp	&0100

.L8440		EQUS	": ta "
.L8445		EQUS	" lennahc no "

; Insert hex number into error block
; ----------------------------------
.L8451		pha
		lsr	A
		lsr	A
		lsr	A
		lsr	A
		jsr	L845A
		pla
.L845A		jsr	L8462
		iny
		sta	&0100,Y
		rts
;;
.L8462		and	#&0F
		ora	#'0'
		cmp	#&3A
		bcc	L846C
		adc	#&06
.L846C		rts

; Insert decimal number into error block
; --------------------------------------
.L846D		bit	L8483				; Set V
		ldx	#100				; 100's
		jsr	L847D
		ldx	#10				; 10's
		jsr	L847D
		clv
		ldx	#1				; units
.L847D		php
		stx	&B3
		ldx	#'0'-1
		sec
.L8483		inx
		sbc	&B3
		bcs	L8483
		adc	&B3
		plp
		pha
		txa
		bvc	L8494
		cmp	#'0'
		beq	L8498
		clv
.L8494		iny
		sta	&0100,Y
.L8498		pla
		rts
;;
.InvalidateFSMandDIR		ldx	#&0C
		lda	#&FF
.L849E		sta	WKSP_ADFS_22C_CSD - 1,X
		sta	WKSP_ADFS_314 - 1,X
		dex
		bne	L849E
		jsr	LA189
		jsr	LA189
		ldy	#&00
		tya
.L84B0		sta	WKSP_ADFS_100_FSM_S1,Y
		sta	WKSP_ADFS_000_FSM_S0,Y
		sta	WKSP_ADFS_400_DIR_BUFFER,Y
		iny
		bne	L84B0
.L84BC		rts
;;
.strExecAbbrev						; L84BD
		EQUS	"E."				; Abbreviation of 'Exec'
		EQUB	&0D
;;
.strSpoolAbbrev
		EQUS	"SP."				; Abbreviation of 'Spool'
		EQUB	&0D
IF (strExecAbbrev AND &FF00) <> (strSpoolAbbrev AND &FF00)
		error	"Exec/Spool table run over page boundary"
ENDIF

; OSBYTE READ
; -----------
.L84C4		ldy	#&FF
.L84C6		ldx	#&00
		jmp	OSBYTE				; Osbyte A,&00,&FF

; Close Spool or Exec if ADFS channel
; -----------------------------------
IF TARGETOS > 1
.ckAisCha_OSCLIatX					; L84CB
		cmp	#CHANNEL_RANGE_LO		; Check against lowest ADFS handle
		bcc	L84BC				; Exit if not ADFS
		cmp	#CHANNEL_RANGE_HI+1		; Check against highest ADFS handle
		bcs	L84BC				; Exit if not ADFS
ENDIF
.OSCLIatX						; L84D3
		ldy	#>strExecAbbrev			; Point to *Spool or *Exec
		jmp	OSCLI				; Jump to close via MOS
;;
.L84D8		EQUS	&0D, "SEY"
.L84DC		EQUS	&00, "Hugo"
;;
.L84E1		lda	WKSP_ADFS_237
		ora	WKSP_ADFS_237 + 1
		ora	WKSP_ADFS_237 + 2
		bne	L84ED
		rts

.L84ED		ldx	#&00
.L84EF		cpx	WKSP_ADFS_100_FSM_S1 + &FE
		bcs	L8526
		inx
		inx
		inx
		stx	&B2
		ldy	#&02
.L84FB		dex
		lda	WKSP_ADFS_000_FSM_S0,X
		cmp	WKSP_ADFS_234,Y
		bcs	L8508
		ldx	&B2
IF USE65C12
		bra	L84EF
ELSE
		bne	L84EF
ENDIF

;;
.L8508		bne	L850D
		dey
		bpl	L84FB
.L850D		ldx	&B2
		dex
		dex
		dex
		stx	&B2
		clc
		php
		ldy	#&00
.L8518		plp
		lda	WKSP_ADFS_234,Y
		adc	WKSP_ADFS_237,Y
		php
		cmp	WKSP_ADFS_000_FSM_S0,X
		beq	L8529
		plp
.L8526		jmp	L85B3

.L8529		inx
		iny
		cpy	#&03
		bne	L8518
		plp
		ldx	&B2
		beq	L8596
		clc
		php
		ldy	#&00
.L8538		plp
		lda	WKSP_ADFS_000_FSM_S0 - 3,X
		adc	WKSP_ADFS_100_FSM_S1 - 3,X
		php
		cmp	WKSP_ADFS_234,Y
		beq	L854A
		ldx	&B2
IF USE65C12
		pla
		bra	L8596
ELSE
		plp
		jmp	L8596
ENDIF
;;
.L854A		inx
		iny
		cpy	#&03
		bne	L8538
		plp
		ldx	&B2
		ldy	#&00
		clc
		php
.L8557		plp
		lda	WKSP_ADFS_000_FSM_S0 + &FD,X
		adc	WKSP_ADFS_237,Y
		sta	WKSP_ADFS_000_FSM_S0 + &FD,X
		php
		inx
		iny
		cpy	#&03
		bne	L8557
		plp
		ldy	#&02
		ldx	&B2
		clc
.L856E		lda	WKSP_ADFS_000_FSM_S0 + &FD,X
		adc	WKSP_ADFS_100_FSM_S1,X
		sta	WKSP_ADFS_000_FSM_S0 + &FD,X
		inx
		dey
		bpl	L856E
.L857B		cpx	WKSP_ADFS_100_FSM_S1 + &FE
		bcs	L858F
		lda	WKSP_ADFS_100_FSM_S1,X
		sta	WKSP_ADFS_100_FSM_S1 - 3,X
		lda	WKSP_ADFS_000_FSM_S0,X
		sta	WKSP_ADFS_000_FSM_S0 - 3,X
		inx
		bne	L857B
.L858F		dex
		dex
		dex
		stx	WKSP_ADFS_100_FSM_S1 + &FE
		rts
;;
.L8596
		ldy	#&00
		clc
		php
.L859A		lda	WKSP_ADFS_234,Y
		sta	WKSP_ADFS_000_FSM_S0,X
		plp
		lda	WKSP_ADFS_100_FSM_S1,X
		adc	WKSP_ADFS_237,Y
		sta	WKSP_ADFS_100_FSM_S1,X
		php
		iny
		inx
		cpy	#&03
		bne	L859A
		plp
		rts
;;
.L85B3		ldx	&B2
		beq	L85EB
		clc
		php
		ldy	#&00
.L85BB		plp
		lda	WKSP_ADFS_000_FSM_S0 - 3,X
		adc	WKSP_ADFS_100_FSM_S1 - 3,X
		php
		cmp	WKSP_ADFS_234,Y
		beq	L85CB
		plp
IF USE65C12
		bra	L85EB
ELSE
		jmp	L85EB
ENDIF
;;
.L85CB		inx
		iny
		cpy	#&03
		bne	L85BB
		plp
		ldy	#&00
		ldx	&B2
		clc
		php
.L85D8		plp
		lda	WKSP_ADFS_000_FSM_S0 + &FD,X
		adc	WKSP_ADFS_237,Y
		sta	WKSP_ADFS_000_FSM_S0 + &FD,X
		php
		inx
		iny
		cpy	#&03
		bne	L85D8
		plp
		rts
;;
.L85EB		lda	WKSP_ADFS_100_FSM_S1 + &FE	; Pointer to end of FSM
		cmp	#&F6
		bcc	L85FF
		jsr	L834E
		EQUB	&99				; ERR=153
		EQUS	"Map full"
		EQUB	&00
;;
.L85FF		ldx	WKSP_ADFS_100_FSM_S1 + &FE
.L8602		cpx	&B2
		beq	L8615
		dex
		lda	WKSP_ADFS_000_FSM_S0,X
		sta	WKSP_ADFS_000_FSM_S0 + 3,X
		lda	WKSP_ADFS_100_FSM_S1,X
		sta	WKSP_ADFS_100_FSM_S1 + 3,X
IF USE65C12
		bra	L8602
ELSE
		jmp	L8602
ENDIF

;;
.L8615		ldy	#&00
.L8617		lda	WKSP_ADFS_234,Y
		sta	WKSP_ADFS_000_FSM_S0,X
		lda	WKSP_ADFS_237,Y
		sta	WKSP_ADFS_100_FSM_S1,X
		inx
		iny
		cpy	#&03
		bne	L8617
		lda	WKSP_ADFS_100_FSM_S1 + &FE	; Point to end of FSM
		adc	#&02				; Add 3 (2+Cy) to point to next entry
		sta	WKSP_ADFS_100_FSM_S1 + &FE	; Update pointer to end of FSM
.L8631		rts
;;
.L8632		ldx	#&00
		stx	WKSP_ADFS_25D
		stx	WKSP_ADFS_25E
		stx	WKSP_ADFS_25F
.L863D		cpx	WKSP_ADFS_100_FSM_S1 + &FE
		beq	L8631
		ldy	#&00
		clc
		php
.L8646		plp
		lda	WKSP_ADFS_100_FSM_S1,X
		adc	WKSP_ADFS_25D,Y
		sta	WKSP_ADFS_25D,Y
		php
		iny
		inx
		cpy	#&03
		bne	L8646
		plp
IF USE65C12 AND OPTIMISE >= 1
		bra	L863D
ELSE
		jmp	L863D
ENDIF
;;
.L865B		ldx	#&FF
		stx	&B3
		inx
.L8660		cpx	WKSP_ADFS_100_FSM_S1 + &FE
		bcc	L86E1
		ldx	&B3
		cpx	#&FF
		bne	L86A5
		jsr	L8632
		ldy	#&00
		ldx	#&02
		sec
.L8673		lda	WKSP_ADFS_25D,Y
		sbc	WKSP_ADFS_23D,Y
		iny
		dex
		bpl	L8673
		bcs	L868D
.L867F		jsr	L834E				; Generate error
		EQUB	&C6				; ERR=198
		EQUS	"Disc full"
		EQUB	&00
;;
.L868D		jsr	L834E				; Generate error
		EQUB	&98				; ERR=152

IF PRESERVE_CONTEXT AND (HD_SCSI OR HD_SCSI2)
		EQUS	"Needs COMPACT"
		EQUB	&00
.ReadBreak
		jsr	L9A88
		and	#&01
		rts
ELSE
		EQUS	"Compaction required"
		EQUB	&00
ENDIF
;;
.L86A5		ldy	#&02
.L86A7		dex
		lda	WKSP_ADFS_000_FSM_S0,X
		sta	WKSP_ADFS_23A,Y
		dey
		bpl	L86A7
		iny
		ldx	&B3
		clc
		php
.L86B6		plp
		lda	WKSP_ADFS_000_FSM_S0 - 3,X
		adc	WKSP_ADFS_240 - 3,Y
		sta	WKSP_ADFS_000_FSM_S0 - 3,X
		php
		inx
		iny
		cpy	#&03
		bne	L86B6
		plp
		ldy	#&00
		ldx	&B3
		sec
		php
.L86CE		plp
		lda	WKSP_ADFS_100_FSM_S1 - 3,X
		sbc	WKSP_ADFS_240 - 3,Y
		sta	WKSP_ADFS_100_FSM_S1 - 3,X
		php
		inx
		iny
		cpy	#&03
		bne	L86CE
		plp
		rts
;;
.L86E1		ldy	#&02
		inx
		inx
		inx
		stx	&B2
.L86E8		dex
		lda	WKSP_ADFS_100_FSM_S1,X
		cmp	WKSP_ADFS_23D,Y
		bcc	L872C
		bne	L8723
		dey
		bpl	L86E8
		ldx	&B2
		ldy	#&02
.L86FA		dex
		lda	WKSP_ADFS_000_FSM_S0,X
		sta	WKSP_ADFS_23A,Y
		dey
		bpl	L86FA
		ldx	&B2
.L8706		cpx	WKSP_ADFS_100_FSM_S1 + &FE
		bcs	L871A
		lda	WKSP_ADFS_000_FSM_S0,X
		sta	WKSP_ADFS_000_FSM_S0 - 3,X
		lda	WKSP_ADFS_100_FSM_S1,X
		sta	WKSP_ADFS_100_FSM_S1 - 3,X
		inx
		bne	L8706
.L871A		lda	WKSP_ADFS_100_FSM_S1 + &FE
		sbc	#&03
		sta	WKSP_ADFS_100_FSM_S1 + &FE
		rts
;;
.L8723		ldx	&B3
		inx
		bne	L872C
		lda	&B2
		sta	&B3
.L872C		ldx	&B2
		jmp	L8660
;;
.L8731		inc	&B4
		bne	L8737
		inc	&B5
.L8737		rts

;;
.L8738		jsr	LA50D
		jsr	L8D79
		ldy	#&00
		sty	WKSP_ADFS_2C0
.L8743		lda	(&B4),Y
		and	#&7F
		cmp	#'.'				; dot
		beq	L8753
		cmp	#'"'				; quote
		beq	L8753
		cmp	#' '				; space
		bcs	L8755
.L8753		ldx	#&00
.L8755		rts
;;
.L8756		ldy	#&0A
.L8758		jsr	L8743
		beq	L876D
		dey
		bpl	L8758
;;
.L8760		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&CC				; ERR=204
		EQUS	"Bad name"
		EQUB	&00
;;
.L876D		ldy	#&09
.L876F		lda	(&B6),Y
		and	#&7F
		sta	WKSP_ADFS_262,Y
		dey
		bpl	L876F
		iny
		ldx	#&00
.L877C		cpx	#&0A
		bcs	L87C1
		lda	WKSP_ADFS_262,X
		cmp	#&21
		bcc	L87C1
		ora	#&20
		sta	WKSP_ADFS_22B
		cpy	#&0A
		bcs	L87AB
		jsr	L8743
		beq	L87B0
		cmp	#&2A
		beq	L87D1
		cmp	#&23
		beq	L87A6
		ora	#&20
		cmp	WKSP_ADFS_22B
		bcc	L87B0
		bne	L87AA
.L87A6		inx
		iny
		bne	L877C
.L87AA		rts
;;
.L87AB		jsr	L8743
		bne	L8760
.L87B0		jsr	L8743
		cmp	#&23
		beq	L87CE
		cmp	#&2A
		beq	L87CE
		dey
		bpl	L87B0
		cmp	#&FF
		rts
;;
.L87C1		cpy	#&0A
		beq	L87AA
		jsr	L8743
		beq	L87AA
		cmp	#&2A
		beq	L87D1
.L87CE		cmp	#&00
		rts
;;
.L87D1		iny
.L87D2		lda	WKSP_ADFS_262,X
		and	#&7F
		cmp	#&21
		bcc	L87F4
		cpx	#&0A
		bcs	L87F4
IF USE65C12
		phx
		phy
ELSE
		txa
		pha
		tya
		pha
ENDIF
		jsr	L877C
		beq	L87EE
IF USE65C12
		ply
		plx
ELSE
		pla
		tay
		pla
		tax
ENDIF
		inx
		bne	L87D2
.L87EB		cpx	#&00
		rts
;;
.L87EE		pla
		pla
.L87F0		lda	#&00
		sec
		rts
;;
.L87F4		cpy	#&0A
		bcs	L87F0
		lda	(&B4),Y
		cmp	#&21
		bcc	L87F0
		cmp	#&2E
		beq	L87F0
		cmp	#&22
		beq	L87F0
		cmp	#&2A
		beq	L87D1
		bne	L87EB

.L880C		jsr	LA50D
		jsr	L93CC
		jsr	LA714
.L8815
IF USE65C12 AND OPTIMISE >= 1
		lda	(&B6)				; Get first byte of directory entry
ELSE
		ldy	#&00
		lda	(&B6),Y				; Get first byte of directory entry
ENDIF
		beq	L882E				; End of directory
		jsr	L8756				; Check entry is valid
		beq	L8830
		bcc	L8830
IF OPTIMISE<2
		lda	&B6				; Step to next entry
		adc	#&19				; &B6/7=&B6/7+26 (25+Cy)
		sta	&B6
		bcc	L8815
		inc	&B7
		bne	L8815
ELSE
		jsr	NextEntry
IF USE65C12
		bra	L8815
ELSE
		jmp	L8815
ENDIF
ENDIF
.L882E		cmp	#&0F
.L8830		rts

; Control block to load FSM
; -------------------------
.L8831		EQUB	&01				; Result=&01, Disk not formatted
		EQUW	WKSP_ADFS_000_FSM_S0		; Load to &FFFFC000
		EQUW	&FFFF
		EQUB	&08				; Action=Read
		EQUB	&00				; Sector=&000000
		EQUB	&00
		EQUB	&00
		EQUB	&02				; Number=2
.L883B		EQUB	&00				; &00=use sector count

; Control block to load '$'
; -------------------------
.L883C		EQUB	&01				; Result=&01, Disk not formatted
		EQUW	WKSP_ADFS_400_DIR_BUFFER
		EQUW	&FFFF
		EQUB	&08				; Action=Read
		EQUB	&00				; Sector=&000002
		EQUB	&00
		EQUB	&02
		EQUB	&05				; Number=5
		EQUB	&00				; &00=use sector count
;;
;; Check drive character
.L8847		cmp	#'0'
		bcc	L886D				; <'0' - error
		cmp	#'8'
		bcc	L885A				; '0'-'7' - Ok
		ora	#&20				; For to lower case
		cmp	#'a'				; <'A' - error
		bcc	L886D
		cmp	#'h'+1
		bcs	L886D				; >'H' - error

IF USE65C12
		dec	A				; Convert 'A'-'H' to '0' to '7'
ELSE
		sbc	#0
ENDIF

.L885A		pha
IF FLOPPY
		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_HD_PRESENT		; Hard drive present?
		bne	L8865
		pla					; No hard drive, reduce drive
		and	#&03				; number to 0-3
		pha
ENDIF
.L8865		pla
		and	#&07				; Drop top bits to get 0-7 (or 0-3)
		lsr	A				; Move to top three bits
		ror	A
		ror	A
		ror	A
		rts
;;
.L886D		jmp	L8760

;;
.L8870		jsr	L8738
		beq	L886D
.L8875		jsr	L8738
		beq	L8899
		cmp	#&3A
		bne	L88EF
		jsr	L8731
		ldx	WKSP_ADFS_22F
		inx
		bne	L888D
		lda	WKSP_ADFS_317_CURDRV
		sta	WKSP_ADFS_22F
.L888D		jsr	L8743
		jsr	L8847
		sta	WKSP_ADFS_317_CURDRV
.L8896		jsr	L8731
.L8899		ldx	WKSP_ADFS_317_CURDRV		; Get current drive
		inx					; If &FF, no directory loaded
		bne	L88AD
IF TARGETOS <= 1
		stx	WKSP_ADFS_317_CURDRV		; Store in current drive
ELSE
IF FLOPPY
		lda	ZP_ADFS_FLAGS			; Get ADFS status byte
		and	#ADFS_FLAGS_HD_PRESENT		; Hard drive present?
		beq	L88AA				; Jump if no hard drive
ENDIF
		lda	WKSP_ADFS_2D8			; Get CMOS byte RAM copy
		and	#&80				; Get hard drive flag
.L88AA		sta	WKSP_ADFS_317_CURDRV		; Store in current drive
ENDIF



.L88AD
IF USE65C12
		lda	#ADFS_FLAGS_FSM_INCONSISTENT
		tsb	ZP_ADFS_FLAGS			; Set 'FSM inconsistant' flag
ELSE
		lda	ZP_ADFS_FLAGS
		ora	#ADFS_FLAGS_FSM_INCONSISTENT
		sta	ZP_ADFS_FLAGS
ENDIF
IF OPTIMISE<5
		ldx	#<L8831				; Point to 'load FSM' control block
		ldy	#>L8831
		jsr	L82AE				; Load FSM
ELSE
		jsr	LoadFSM
ENDIF
IF USE65C12
		lda	#ADFS_FLAGS_FSM_INCONSISTENT
		trb	ZP_ADFS_FLAGS			; Clear 'FSM inconsistant' flag
ELSE
		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_FSM_INCONSISTENT EOR &FF
		sta	ZP_ADFS_FLAGS
ENDIF
		lda	WKSP_ADFS_22E
		bpl	L88CC
		ldy	#&02
.L88C3		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	L88C3
.L88CC		ldy	#>L883C				; Point to 'load root' control block
		ldx	#<L883C
		jsr	L82AE				; Load '$'
		lda	#&02
		sta	WKSP_ADFS_314			; Set CURR to &000002 - '$'
IF USE65C12 AND OPTIMISE >= 1
		stz	WKSP_ADFS_315
		stz	WKSP_ADFS_316
ELSE
		lda	#&00
		sta	WKSP_ADFS_315
		sta	WKSP_ADFS_316
ENDIF
		jsr	LB4B9
		ldy	#&00
		jsr	L8743
		cmp	#&2E
		bne	L8910
		jsr	L8731
.L88EF		ldy	#&00
		jsr	L8743
		and	#&FD
		cmp	#&24				; Is it '$' or '&'
		beq	L8896				; Reference to ROOT or URD
		jsr	LB546
.L88FD		jsr	L9456
		bne	L892A
		iny
		sty	WKSP_ADFS_2A2
		jsr	L8743
		cmp	#&2E
		bne	L892F
		jmp	L8997
;;
.L8910		lda	#&24
		sta	WKSP_ADFS_262
		lda	#&0D
		sta	WKSP_ADFS_263
		lda	#<L94D3
		sta	&B6
		lda	#>L94D3
		sta	&B7
		lda	#&02
		sta	WKSP_ADFS_2C0
		lda	#&00
		rts
;;
.L892A		jsr	L880C
		beq	L893F
.L892F		rts
;;

.L8930
IF TARGETOS <= 1

							;TODO: !!!!!!!!!!!!!!!!!!! blammed in from adfs130 check JSR 0000 !!!
		lda	$B4				; 8905 A5 B4                    ..
		pha					; 8907 48                       H
		lda	$B5				; 8908 A5 B5                    ..
		pha					; 890A 48                       H
		tya					; 890B 98                       .
		clc					; 890C 18                       .
		adc	$B4				; 890D 65 B4                    e.
		sta	$B4				; 890F 85 B4                    ..
		lda	#$00				; 8911 A9 00                    ..
		adc	$B5				; 8913 65 B5                    e.
		sta	$B5				; 8915 85 B5                    ..
		jsr	LA50D				; 8917 20 CF A4                  ..
		lda	$B4				; 891A A5 B4                    ..
		sta	$10D6				; 891C 8D D6 10                 ...
		lda	$B5				; 891F A5 B5                    ..
		sta	$10D7				; 8921 8D D7 10                 ...
		pla					; 8924 68                       h
		sta	$B5				; 8925 85 B5                    ..
		pla					; 8927 68                       h
		sta	$B4				; 8928 85 B4
ENDIF


		ldx	#&01
		ldy	#&03
		lda	(&B6),Y				; Check 'D' bit
		bpl	L8939				; Not a directory, return X=1
		inx					; Directory, return X=2
.L8939		stx	WKSP_ADFS_2C0
		lda	#&00
		rts
;;
.L893F		ldy	#&00
.L8941		jsr	L8743
		cmp	#&21
		bcc	L8930
		cmp	#&22
		beq	L8930
		cmp	#&2E
		beq	L8953
		iny
		bne	L8941
.L8953		sty	WKSP_ADFS_2A2
.L8956		ldy	#&03
		lda	(&B6),Y				; Check 'D' bit
		bmi	L897B				; Directory, jump to check bit 9
		jsr	L8964
		beq	L8956
.L8961		lda	#&FF
		rts

; Step to next directory entry
; ----------------------------
; Directory pointer at &B6/7=&B6/7+26
IF OPTIMISE>=2
.NextEntry
		lda	#&1A
.NextEntryA
		clc
		adc	&B6
		sta	&B6
		bcc	NextEntryDone
		inc	&B7
.NextEntryDone
IF USE65C12
		lda	(&B6)				; Check first byte of entry
ELSE
		ldy	#&00
		lda	(&B6),Y				; Check first byte of entry
ENDIF
		rts
ENDIF

.L8964
IF OPTIMISE<2
		clc					; Step to next directory entry
		lda	&B6				; &B6/7=&B6/7+26
		adc	#&1A
		sta	&B6
		bcc	L896F
		inc	&B7
.L896F		ldy	#&00
		lda	(&B6),Y				; Check first byte of entry
ELSE
		jsr	NextEntry			; Step to next entry, return EQ if at end
ENDIF
		beq	L8961				; &00 - end of directory
		jsr	L8756				; Check directory entry is valid
		bne	L8964				; Step to next entry
		rts

.L897B		ldy	#&09
		lda	(&B6),Y				; Check access bit 9
		bpl	L8997				; Not set
		and	#&7F
		sta	(&B6),Y				; Remove the bit
		jsr	L8F91				; Write directory to disk
.L8988		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&B0				; ERR=176
		EQUS	"Bad rename"
		EQUB	&00

.L8997		lda	WKSP_ADFS_2A2
		sec
		adc	&B4
		sta	&B4
		bcc	L89A3
		inc	&B5
.L89A3		lda	WKSP_ADFS_22E
IF USE65C12
		inc	A
ELSE
		cmp	#&FF
ENDIF
		bne	L89B4
		ldy	#&02
.L89AB		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	L89AB
.L89B4
IF OPTIMISE<5
		ldx	#&0A
.L89B6		lda	L883C,X				; Get byte from 'load $' control block
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X			; Store into workspace control block
		dex
		bpl	L89B6
ELSE
		jsr	RootSector
ENDIF
		ldx	#&02
		ldy	#&16				; Point to object's SECT entry
.L89C3		lda	(&B6),Y				; Copy object's SECT entry to workspace
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC,X			; Workspace control block is now a
		sta	WKSP_ADFS_2FE,Y			; 'load directory' control block
		iny
		dex
		bpl	L89C3
		jsr	L82AA				; Do disk access, load the directory
		jmp	L88FD				; Jump to parse next path component

IF OPTIMISE>=5
.RootSector
		ldx	#&0A
.RootSecLp
		lda	L883C,X				; Get byte from 'load $' control block
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X			; Store into workspace control block
		dex
		bpl	RootSecLp
		rts
ENDIF

.L89D5		lda	WKSP_ADFS_2C0
.L89D8		pha
		lda	WKSP_ADFS_22F
		cmp	#&FF
		beq	L89EF
		sta	WKSP_ADFS_317_CURDRV
		lda	#&FF
		sta	WKSP_ADFS_22F
IF OPTIMISE<5
		ldx	#<L8831				; Point to 'load FSM' control block
		ldy	#>L8831
		jsr	L82AE				; Load FSM
ELSE
		jsr	LoadFSM
ENDIF
.L89EF		lda	WKSP_ADFS_22E
		cmp	#&FF
		beq	L8A22
IF OPTIMISE<5
		tax
		ldy	#&0A
.L89F9		lda	L883C,Y				; Copy parameter block to load '$'
		sta	WKSP_ADFS_215_DSKOPSAV_RET,Y			; Copy parameters to &C215
		dey
		bpl	L89F9
		stx	WKSP_ADFS_316			; Modify control block to be
		stx	WKSP_ADFS_21B_DSKOPSAV_SEC			; 'load directory' control block
ELSE
		tay
		jsr	RootSector			; Copy parameters to &C215
		sty	WKSP_ADFS_316			; Modify control block to be
		sty	WKSP_ADFS_21B_DSKOPSAV_SEC			; 'load directory' control block
ENDIF
		lda	WKSP_ADFS_22D
		sta	WKSP_ADFS_315
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+1
		lda	WKSP_ADFS_22C_CSD
		sta	WKSP_ADFS_314
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+2
		lda	#&FF
		sta	WKSP_ADFS_22E
		jsr	L82AA				; Do disk access, load the directory
.L8A22		lda	ZP_ADFS_FLAGS
		sta	WKSP_ADFS_320_FLAGS_SAVE
		jsr	GetWkspAddr_BA			; Get WS address in &BA
		ldy	#&FB
.L8A2C		lda	WKSP_ADFS_300_CSDNAME,Y			; Copy workspace to private
		sta	(&BA),Y
		dey
		bne	L8A2C
		lda	WKSP_ADFS_300_CSDNAME
		sta	(&BA),Y
		jsr	StoreWkspChecksumBA_Y		; Reset workspace checksum
		ldx	&B8
		ldy	&B9
		pla
.L8A41		rts


;;
;; Do a disk access, and generate an error on failure
;; --------------------------------------------------
.L8A42		jsr	L8A4A				; Do disk access
		beq	L8A41				; No error, exit
		jmp	GenerateError				; Generate disk error

;; Do a disk access and return the result
;; --------------------------------------
.L8A4A		lda	WKSP_ADFS_21A_DSKOPSAV_CMD	; Get command
		cmp	#&08				; Read?
		beq	L8A68				; Jump forward with Read
		lda	WKSP_ADFS_220_DSKOPSAV_XLEN	; If Length0=0?
		beq	L8A68				; Whole number of sectors
;;
;; Adjust the Length to be a whole number of sectors for writing
;;
		lda	#&0
		sta	WKSP_ADFS_220_DSKOPSAV_XLEN
		inc	WKSP_ADFS_220_DSKOPSAV_XLEN+1
		bne	L8A68
		inc	WKSP_ADFS_220_DSKOPSAV_XLEN+2
		bne	L8A68
		inc	WKSP_ADFS_220_DSKOPSAV_XLEN+3
;;
;; Length is now a whole number of sectors, a whole multiple of 256 bytes
;;
.L8A68		ldx	#<WKSP_ADFS_215_DSKOPSAV_RET
		ldy	#>WKSP_ADFS_215_DSKOPSAV_RET	; XY=>control block
		lda	#&FF
		sta	WKSP_ADFS_21E_DSKOPSAV_SECCNT	; Set initial sector count to &FF
;;
;; Transfer batches of &FF00 bytes until less than 64K left
;; --------------------------------------------------------
.L8A71		lda	WKSP_ADFS_220_DSKOPSAV_XLEN+3
		ora	WKSP_ADFS_220_DSKOPSAV_XLEN+2	; Get Length2+Length3
		beq	L8ABC				; Jump if remaining length<64K
;;
		jsr	CommandExecXY			; Do a transfer
		bne	L8ACE				; Exit with any error
		lda	#&FF				; Update address
		clc					; Addr=Addr+&0000FF00
		adc	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1; Addr1=Addr1+&FF
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
		bcc	L8A91				; No overflow
		inc	WKSP_ADFS_216_DSKOPSAV_MEMADDR+2; Addr2=Addr2+1
		bne	L8A91				; No overflow
		inc	WKSP_ADFS_216_DSKOPSAV_MEMADDR+3; Addr3=Addr3+1
;;
.L8A91		lda	#&FF				; Update sector
		clc
		adc	WKSP_ADFS_21B_DSKOPSAV_SEC+2	; Sector=Sector+&FF
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+2	; Sector0=Sector0+&FF
		bcc	L8AA4				; No overflow
		inc	WKSP_ADFS_21B_DSKOPSAV_SEC+1	; Sector1=Sector1+1
		bne	L8AA4				; No overflow
		inc	WKSP_ADFS_21B_DSKOPSAV_SEC	; Sector2=Sector2+1
;;
.L8AA4		lda	WKSP_ADFS_220_DSKOPSAV_XLEN+1	; Update length
		sec
		sbc	#&FF				; Length=Length-&0000FF00
		sta	WKSP_ADFS_220_DSKOPSAV_XLEN+1	; Length1=Length1-&FF
		bcs	L8A71				; No overflow
		lda	WKSP_ADFS_220_DSKOPSAV_XLEN+2	; Get Length2
		bne	L8AB7				; No need to decrement
		dec	WKSP_ADFS_220_DSKOPSAV_XLEN+3	; Length3=Length3-1
.L8AB7		dec	WKSP_ADFS_220_DSKOPSAV_XLEN+2	; Length2=Length2-1
IF USE65C12
		bra	L8A71				; Loop back for another &FF00 bytes
ELSE
		bcc	L8A71
ENDIF

;;
;; There is now less than 64K to transfer
;; --------------------------------------
.L8ABC		lda	WKSP_ADFS_220_DSKOPSAV_XLEN+1			; Get Length1
		beq	L8AC9				; Now less than 256 bytes to go
		sta	WKSP_ADFS_21E_DSKOPSAV_SECCNT			; Set Sector Count
		jsr	CommandExecXY			; Do this transfer
		bne	L8ACE				; Exit with any error
;;
.L8AC9		lda	WKSP_ADFS_220_DSKOPSAV_XLEN			; Get Length0
		bne	L8ACF				; Jump to deal with any leftover bytes
.L8ACE		rts
;;
;; There are now less than 256 bytes left, must be reading
;; -------------------------------------------------------
.L8ACF		sta	WKSP_ADFS_21E_DSKOPSAV_SECCNT			; Store Length0 in Sector Count
		lda	WKSP_ADFS_220_DSKOPSAV_XLEN+1			; Get last length transfered
		clc
		adc	WKSP_ADFS_21B_DSKOPSAV_SEC+2			; Add to Sector0
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+2			; Store in Sector0
		bcc	L8AE6
		inc	WKSP_ADFS_21B_DSKOPSAV_SEC+1			; Increment Sector1
		bne	L8AE6
		inc	WKSP_ADFS_21B_DSKOPSAV_SEC			; Increment Sector2
.L8AE6		lda	WKSP_ADFS_220_DSKOPSAV_XLEN+1			; Get Length1
		clc
		adc	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1			; Add to Addr1
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1			; Store Addr1
		bcc	L8AFA
		inc	WKSP_ADFS_216_DSKOPSAV_MEMADDR+2			; Increment Addr2
		bne	L8AFA
		inc	WKSP_ADFS_216_DSKOPSAV_MEMADDR+3			; Increment Addr3
.L8AFA		jsr	WaitEnsuring			; Wait for ensuring to finish
		jsr	CommandSetRetries		; Initialise retries
.L8B00		jsr	L8B09				; Call to load data
		beq	L8ACE				; All ok, so exit
		dec	ZP_ADFS_RETRY_CTDN		; Decrement retries
		bpl	L8B00				; Loop to try again
;;			    Fall through to try once more
.L8B09		ldx	#<WKSP_ADFS_215_DSKOPSAV_RET			; Point to control block
		ldy	#>WKSP_ADFS_215_DSKOPSAV_RET
		stx	&B0
		sty	&B1
IF TARGETOS > 1
		ldx	WKSP_ADFS_216_DSKOPSAV_MEMADDR+3			; Get Addr3
		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR+2			; Get Addr2
		jsr	CheckAndPageInShadowScreen				; Check for shadow screen memory
ENDIF
		lda	WKSP_ADFS_317_CURDRV		; Get current drive
		ora	WKSP_ADFS_21B_DSKOPSAV_SEC			; OR with drive number
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC			; Store back into control block
		sta	WKSP_ADFS_333_LASTACCDRV
IF FLOPPY
		lda	ZP_ADFS_FLAGS			; Get ADFS status byte
		and	#ADFS_FLAGS_HD_PRESENT		; Hard drive present?
		bne	HD_CommandPartialSector		; Jump ahead if so
.FloppyPartialSector		
		lda	WKSP_ADFS_21B_DSKOPSAV_SEC
		ora	WKSP_ADFS_317_CURDRV
		sta	WKSP_ADFS_2D0_ERR_SECTOR+2
		lda	WKSP_ADFS_21B_DSKOPSAV_SEC+1
		sta	WKSP_ADFS_2D0_ERR_SECTOR+1
		lda	WKSP_ADFS_21B_DSKOPSAV_SEC+2
		sta	WKSP_ADFS_2D0_ERR_SECTOR
		jsr	LACE6				; Look for an unmodified buffer
		sta	WKSP_ADFS_204,X			; Clear buffer
		txa
		lsr	A				; Divide by 4 to get buffer address
		lsr	A
		adc	#>(WKSP_BASE + &900)		; Point to some workspace at &C900+x
		jmp	ExecFloppyPartialSectorBufIND	; Jump to load partial sector via buffer
		; TODO: Investigate - it might be better to always do a buffered read like this (for HD)
		; code would be smaller and most likely faster
ENDIF

IF NOT(HD_SCSI2)
;;
;; Get bytes from a partial sector from a hard drive
;; -------------------------------------------------
.HD_CommandPartialSector		
		lda	WKSP_ADFS_333_LASTACCDRV	; Get drive number
IF FLOPPY
		bmi	FloppyPartialSector				; Jump back with floppies
ENDIF
IF HD_IDE AND NOT(TRIM_REDUNDANT)
		jsr	X807E				; Leftover dummy call
ENDIF
IF HD_SCSI
		jsr	SCSI_StartCommand		; Set SCSI to command mode
ENDIF
		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR
		sta	&B2
		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
		sta	&B3				; &B2/3=address b0-b15
		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR+2; Get Addr2
		cmp	#&FE
		bcc	L8B6E				; Addr<&FFFE0000, language space
		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR+3; Get Addr3

IF USE65C12
		inc	A
ELSE
		cmp	#&FF
ENDIF

		beq	L8B71				; Address &FFxxxxxx, use I/O memory
.L8B6E		jsr	TUBE_CLAIM_IF_PRESENT		; Claim Tube
.L8B71		lda	WKSP_ADFS_21E_DSKOPSAV_SECCNT	; Get byte count (in Sector Count)
		tax					; Pass to X
		lda	#&01
		sta	WKSP_ADFS_21E_DSKOPSAV_SECCNT	; Set Sector Count to 1
		lda	#&08
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD	; Command &08 - Read
IF HD_MMC
		jsr	MMC_BEGIN			; Initialize the card, if not already initialized
		bne	PartError			; Couldn't initialise
		clc					; C=0 for reads
		jsr	MMC_SetupRW			; Set up SD card command block
		jsr	setCommandAddress
		bne	PartError			; Bad drive or sector
ENDIF
IF HD_IDE
		txa
		pha					; Load a partial sector
		jsr	SetGeometry			; Pass sector address to IDE
		jsr	SetSector
		pla
		tax
		nop
		nop
		nop
ENDIF
IF HD_SCSI
		ldy	#&00
.L8B81		lda	WKSP_ADFS_21A_DSKOPSAV_CMD,Y
		jsr	SCSI_send_byteA			; Send control block to SCSI
		iny
		cpy	#&06
		bne	L8B81
ENDIF
		bit	ZP_ADFS_FLAGS			; Check Tube flags
		bvc	L8B9B				; Tube not being used, jump ahead
IF USE65C12
		phx					; Save byte count in X
ELSE
		txa
		pha
ENDIF
		ldx	#<WKSP_ADFS_227_TUBE_XFER
		ldy	#>WKSP_ADFS_227_TUBE_XFER
		lda	#&01
		jsr	&0406				; Set Tube transfer address
IF USE65C12
		plx					; Get byte count back
ELSE
		pla
		tax
ENDIF
.L8B9B
IF HD_MMC
		phx
		jsr	MMC_StartRead
		bne	PartError			; Error occured
		plx
		phx
		jsr	MMC_ReadX
		pla
		eor	#&FF				; Calculate 256 - bytecount
		tay
		iny
		jsr	MMC_Clocks			; ignore rest of sector
		jsr	MMC_Clocks			; twice, as sectors are stretched to 512 bytes
		jsr	MMC_16Clocks			; ignore CRC
		lda	#0				; If we've got to here no error occured
.PartError
							;Jump to L81AD to release and return result
ELSE
		ldy	#&00				; Fetch 256 bytes
IF HD_IDE
		jsr	IDE_WaitforReq			; Wait for drive ready
		bmi	L8BBB				; Jump ahead if switched to write
ENDIF
IF HD_SCSI
		jsr	SCSI_WaitforReq			; Wait for drive ready
		bmi	L8BBB				; Jump ahead if switch to command (i.e. status byte ready...)
ENDIF
.L8BA2		
IF HD_SCSI
		lda	SCSI_DATA			; Get byte from hard drive
ENDIF
IF HD_IDE
		lda	IDE_DATA			; Get byte from hard drive
ENDIF

		cpx	#&00				; No more bytes left?
		beq	L8BB8				; Jump to ignore extra bytes
		bit	ZP_ADFS_FLAGS			; Tube or I/O?
		bvc	L8BB5				; Jump to read to I/O memory
IF HD_IDE AND TARGETOS >= 1				; TODO: Ask JGH why different for Elk, IDE, SCSI?
		jsr	TubeDelay			; Longer delay
ELSE
		jsr	TubeDelay2			; Pause a bit
ENDIF
IF TARGETOS = 0 AND NOT(HD_SCSI)
		sbc	$EDED				; TODO: Reinstate tube code for AP5?
ELSE
		sta	TUBEIO				; Send to Tube
ENDIF ; TARGETOS = 0
		bvs	L8BB7				; Jump ahead to loop back
.L8BB5		sta	(&B2),Y				; Store byte to I/O
.L8BB7		dex					; Decrement byte count
.L8BB8		iny					; Next byte to fetch
		bne	L8BA2				; Loop for all 256 bytes
ENDIF
;;
.L8BBB		jmp	CommandDone			; Jump get result and return

ELSE ; SCSI2
.HD_CommandPartialSector
IF FLOPPY
		lda	WKSP_ADFS_333_LASTACCDRV	; Get drive number
		bmi	FloppyPartialSector				; Jump back with floppies
ENDIF
		jmp	SCSI2_CommandPartialSector
ENDIF ; not SCSI2

;;
.L8BBE		jsr	L8870
		beq	L8BCA
		bne	L8BD2
.L8BC5		jsr	L8964
		bne	L8BD2
.L8BCA		ldy	#&03
		lda	(&B6),Y
		bmi	L8BC5
.L8BD0		lda	#&00
.L8BD2		rts
;;
;; If name is '^' or '@', Bad name, otherwise Not found.
;; -----------------------------------------------------
.L8BD3
IF USE65C12 AND OPTIMISE > 1
		lda	(&B4)				; Get first character
ELSE
		ldy	#&00
		lda	(&B4),Y				; Get first character
ENDIF
		cmp	#&5E				; Is it '^' - parent directory
		bne	L8BDE				; No, skip past
.L8BDB		jmp	L8760				; Jump to give 'Bad name'
;;
.L8BDE		cmp	#'@'				; Is it '@' - current directory
		beq	L8BDB				; Jump to give 'Bad name'
.L8BE2		jsr	ReloadFSMandDIR_ThenBRK				; Otherwise, give 'Not found'
		EQUB	&D6				; ERR=210
		EQUS	"Not found"
		EQUB	&00
;;
;; Search for object, give error if 'E' set
;; ========================================
.L8BF0		jsr	L8FE8				; Search for object
		bne	L8BD2				; Not found, return NE
		ldy	#&04
		lda	(&B6),Y				; Check 'E' bit
		bpl	L8BD0				; Not 'E', return EQ for found
.L8BFB		jsr	ReloadFSMandDIR_ThenBRK				; Error 'Access violation'
		EQUB	&BD				; ERR=189
		EQUS	"Access violation"
		EQUB	&00

;; OSFILE &FF - LOAD
;; =================
.L8C10		jsr	L8BBE
		bne	L8BD3
IF USE65C12 AND OPTIMISE > 1
		lda	(&B6)				; Check 'R' bit
ELSE
		ldy	#&00				; Point to first byte of directory entry
		lda	(&B6),Y				; Check 'R' bit
ENDIF
		bpl	L8BFB				; No 'R', jump to error
.L8C1B		ldy	#&06				; Point to control block
		lda	(&B8),Y				; Get file/addr flag
		bne	L8C2E				; <>&00, load to file's address
		dey					; &00, load to supplied address
.L8C22		lda	(&B8),Y				; Copy load address from control block
		sta	WKSP_ADFS_214,Y
		dey
		cpy	#&01
		bne	L8C22
		beq	L8C3B
.L8C2E		ldx	#&04
		ldy	#&0D
.L8C32		lda	(&B6),Y
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X
		dey
		dex
		bne	L8C32
.L8C3B		lda	#&01
		sta	WKSP_ADFS_215_DSKOPSAV_RET			; Set flag byte to 1
		lda	#&08
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD			; Command 'read'
IF USE65C12 AND OPTIMISE > 1
		stz	WKSP_ADFS_21F_DSKOPSAV_CTL
ELSE
		lda	#&00
		sta	WKSP_ADFS_21F_DSKOPSAV_CTL
ENDIF
		ldy	#&16
		ldx	#&03
.L8C4E		lda	(&B6),Y
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD,X			; Copy sector start
		iny
		dex
		bne	L8C4E
		ldy	#&15
		ldx	#&04
.L8C5B		lda	(&B6),Y
		sta	WKSP_ADFS_21F_DSKOPSAV_CTL,X			; Copy length
		dey
		dex
		bne	L8C5B
		jsr	L8A42
.L8C67		jsr	L8C6D
		jmp	L89D5
;;
.L8C6D		jsr	L9501				; Print info if *OPT1 set
;;
;; Copy file info to control block
;; -------------------------------
.L8C70		ldy	#&15				; Top byte of length
		ldx	#&0B				; 11+1 bytes to copy
.L8C74		lda	(&B6),Y				; Copy length/exec/load
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X			; to workspace
		dey
		dex
		bpl	L8C74				; Loop for 12 bytes
		ldy	#&0D
		ldx	#&0B
.L8C81		lda	WKSP_ADFS_215_DSKOPSAV_RET,X			; Copy from workspace
		sta	(&B8),Y				; to control block
		dey
		dex
		bpl	L8C81				; Loop for 12 bytes
IF FULL_ACCESS
		ldy	#&08
.RdLp
		cpy	#4				; Read full access byte
		bne	RdNotE
		dey
		dey
.RdNotE
		lda	(&B6),Y
		asl	A
		rol	WKSP_ADFS_22B
		cpy	#4
		beq	RdIsE
		cpy	#2
		bne	RdNext
		iny
		iny
		bne	RdNotE
.RdIsE
		dey
		dey
.RdNext
		dey
		bpl	RdLp
		lda	WKSP_ADFS_22B
		ldy	#&0E
		sta	(&B8),Y
		rts
IF NOT(TRIM_REDUNDANT)
		nop
		nop
ENDIF
ELSE	; FULL ACCESS
		lda	#&00
		sta	WKSP_ADFS_22B			; Clear byte for access
		ldy	#&02				; Point to 'L' bit
.L8C91		lda	(&B6),Y
		asl	A
		rol	WKSP_ADFS_22B			; Copy LWR into WKSP_ADFS_22B
		dey
		bpl	L8C91
		lda	WKSP_ADFS_22B			; A=00000LWR
		ror	A				; A=000000LW Cy=R
		ror	A				; A=R000000L Cy=W
		ror	A				; A=WR000000 Cy=L
		php					; Save 'L'
		lsr	A				; A=0WR00000
		plp					; Get 'L'
		ror	A				; A=L0WR0000
		sta	WKSP_ADFS_22B			; Store back in workspace
		lsr	A
		lsr	A
		lsr	A
		lsr	A
		ora	WKSP_ADFS_22B			; A=L0WRL0WR
		ldy	#&0E
		sta	(&B8),Y				; Store access byte in control block
		rts
ENDIF

;;
;; OSFILE &05 - Read Info
;; ======================
;; &B8/9=>control block, &B4/5=>filename
;;
.L8CB3
IF NOT(TRIM_REDUNDANT)
		ldy	#&00				; Copy filename address again
		lda	(&B8),Y
		sta	&B4
		iny
		lda	(&B8),Y
		sta	&B5
ENDIF
		jsr	L8FE8				; Search for object
		bne	L8CD1
		ldy	#&04
		lda	(&B6),Y				; Get 'E' bit
		bpl	L8CCE				; 'E' not set, jump
		lda	#&FF				; 'E' set, filetype &FF
IF FULL_ACCESS
		sta	WKSP_ADFS_2C0
ELSE
		jmp	L89D8
ENDIF
;;
.L8CCE		jsr	L8C70
.L8CD1		jmp	L89D5
;;
.L8CD4
IF OPTIMISE<2
		ldy	#&00				; Copy filename pointer to &B4/5
		lda	(&B8),Y				; Control+0
		sta	&B4
		iny
		lda	(&B8),Y				; Control+1
		sta	&B5
ELSE
		jsr	GetFilename			; Copy filename pointer to &B4/5
ENDIF
.L8CDE		jsr	L8DC8
		jsr	L8FE8
		beq	L8CEC
		jsr	L9456
		beq	L8D01
.L8CEC		rts
;;
.L8CED		jsr	L8CD4
		beq	L8D1B
		bne	L8CF9
.L8CF4		jsr	L8CD4
		beq	L8D12
.L8CF9		ldy	#&00
.L8CFB		lda	(&B4),Y				; Get filename character
		cmp	#&2E				; Is it '.'
		bne	L8D04				; Not a '.'
.L8D01		jmp	L8BD3				; Jump to give 'Bad name' error
;;
.L8D04		cmp	#&21
		bcc	L8D0F				; spc or ctrl, end of filename
		cmp	#&22
		beq	L8D0F				; quote, end of filename
		iny					; Step to next character
	IF HD_SCSI AND TARGETOS=0
		cpy	#$0A				; TODO: work out why!
	ENDIF

		bne	L8CFB				; Check next character
.L8D0F		lda	#&11
		rts
;;
;; Check if I can save on top of this entry
;; ----------------------------------------
.L8D12		ldy	#&03
		lda	(&B6),Y				; Check 'D' bit
		bpl	L8D1B				; Not a directory
		jmp	L95AB				; Jump to 'Already exists' error
;;
.L8D1B		ldy	#&02
		lda	(&B6),Y				; Check 'L' bit
		bpl	L8D2C				; Not locked, jump to check if open
		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&C3				; ERR=195
		EQUS	"Locked"
		EQUB	&00


; Check if file open, can't change an open file
; ---------------------------------------------
; CheckOpenAll - Checks channel flags b0-b7
; CheckOpen    - Check channel flags by ANDing with A
; Generates an error if an open channel matches object
; Returns X=0, EQ if no open channels matches object
;
.L8D2C
.CheckOpenAll
IF OPTIMISE>=4
		lda	#&FF				; Check b7-b0 of &C3AC,X
ENDIF
.CheckOpen
		ldx	#&09				; 9+1 channels to check
.L8D2E
IF OPTIMISE<4
		lda	WKSP_ADFS_3AC_CH_FLAGS,X			; Check if channel flags are &00
ELSE
		pha					; Save check mask
		and	WKSP_ADFS_3AC_CH_FLAGS,X			; Mask with channel flags
ENDIF
		beq	L8D74
		lda	WKSP_ADFS_3B6,X
		and	#&E0
		cmp	WKSP_ADFS_317_CURDRV
		bne	L8D74
		lda	WKSP_ADFS_3E8,X
		cmp	WKSP_ADFS_314
		bne	L8D74
		lda	WKSP_ADFS_3DE,X
		cmp	WKSP_ADFS_315
		bne	L8D74
		lda	WKSP_ADFS_3D4,X
		cmp	WKSP_ADFS_316
		bne	L8D74
		ldy	#&19
		lda	(&B6),Y
		cmp	WKSP_ADFS_3F2,X
		bne	L8D74
.L8D5E		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&C2				; ERR=194
		EQUS	"Can't - File open"
		EQUB	&00
.L8D74
IF OPTIMISE>=4
		pla					; Get check mask back
ENDIF
		dex
		bpl	L8D2E				; Loop through all channels
		inx					; Return with X=&00, EQ
		rts

.L8D79		ldy	#&00
		jsr	L8743
		bne	L8D85
		cmp	#'.'				; '.'
		beq	L8DE6
		rts
;;
.L8D85		cmp	#':'
		bne	L8D98
		iny
.L8D8A		iny
		jsr	L8743
		bne	L8DE6
		cmp	#'.'				; '.' - directory seperator
		bne	L8DE0
		iny
		jsr	L8DE1
.L8D98		and	#&FD
		cmp	#'$'				; '$' - root
		beq	L8D8A
.L8D9E		jsr	L8DE1
		cmp	#'^'				; '^' - parent
		beq	L8DA9
		cmp	#'@'				; '@' - current directory
		bne	L8DB6
.L8DA9		iny
		jsr	L8743
		bne	L8DE6
.L8DAF		cmp	#'.'				; '.'
		bne	L8DE0
		iny
IF USE65C12
		bra	L8D9E
ELSE
		bne	L8D9E
ENDIF
;;
.L8DB6		jsr	L8743
		beq	L8DAF
	IF TARGETOS = 0 AND HD_SCSI
		cmp	#&7F
		beq	L8DE6
		cmp	#'^'
		beq	L8DE6
		cmp	#'@'
		beq	L8DE6
		cmp	#':'
		beq	L8DE6
		and	#&FD
		cmp	#'$'
		beq	L8DE6
	ELSE
		ldx	#&05
.L8DBD		cmp	L8DF8,X
		beq	L8DE6
		dex
		bpl	L8DBD
	ENDIF
		iny
		bne	L8DB6
.L8DC8		jsr	L8D79
.L8DCB		lda	(&B4),Y				; Get character
		and	#&7F
		cmp	#'*'				; '*' - wildcard
		beq	L8DE9
		cmp	#'#'				; '#' - wildcard
		beq	L8DE9
		cmp	#'.'				; '.' - directory seperator
		beq	L8DE0
		dey
		cpy	#&FF
		bne	L8DCB
.L8DE0		rts
;;
.L8DE1		jsr	L8743
		bne	L8DE0
.L8DE6		jmp	L8760
;;
.L8DE9		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&FD				; ERR=253
		EQUS	"Wild cards"
		EQUB	&00
IF TARGETOS<>0 OR HD_SCSI = 0
.L8DF8		EQUS	&7F, "^@:$&"			; Directory characters
ENDIF
.L8DFE		jsr	L8CF4
.L8E01		bne	L8E24
.L8E03		ldx	#&02
		ldy	#&12
		lda	(&B6),Y
		cmp	#&01
.L8E0B		iny
		lda	#&00
		adc	(&B6),Y
		sta	WKSP_ADFS_224,Y
		dex
		bpl	L8E0B
		ldy	#&18
		ldx	#&02
.L8E1A		lda	(&B6),Y
		sta	WKSP_ADFS_234,X
		dey
		dex
		bpl	L8E1A
		rts
;;
.L8E24		lda	WKSP_ADFS_800_DIR_BUFFER + &B1
		beq	L8E36
		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&B3				; ERR=179
		EQUS	"Dir full"
		EQUB	&00
;;
.L8E36
		lda	&B4
		sta	WKSP_ADFS_227_TUBE_XFER
		lda	&B5
		sta	WKSP_ADFS_227_TUBE_XFER + 1
		lda	#<(WKSP_ADFS_800_DIR_BUFFER + &B1)				; &B4/5=>&C8B1
		sta	&B4
		lda	#>(WKSP_ADFS_800_DIR_BUFFER + &B1)
		sta	&B5
		ldy	#&1A
		ldx	#&06
		lda	#&00
.L8E4E		sta	WKSP_ADFS_233,X
		dex
		bne	L8E4E
.L8E54		lda	(&B4,X)
		sta	(&B4),Y
		lda	&B4
		cmp	&B6
		bne	L8E64
		lda	&B5
		cmp	&B7
		beq	L8E6F
.L8E64		lda	&B4
		bne	L8E6A
		dec	&B5
.L8E6A		dec	&B4
		jmp	L8E54
;;
.L8E6F		lda	WKSP_ADFS_227_TUBE_XFER
		sta	&B4
		lda	WKSP_ADFS_227_TUBE_XFER + 1
		sta	&B5
		rts
;;
.L8E7A		ldy	#&09
.L8E7C		lda	(&B4),Y				; Get character
		and	#&7F
		cmp	#'!'
		bcc	L8E88				; SPC or CTRL, end of string
		cmp	#'"'
		bne	L8E8A				; QUOTE, end of string
.L8E88		lda	#&0D
.L8E8A		cpy	#&02
		bcs	L8E90
		ora	#&80
.L8E90		sta	(&B6),Y
		dey
		bpl	L8E7C
		rts
;;
.L8E96		ldy	#&11
.L8E98		lda	(&B8),Y
		sta	WKSP_ADFS_215_DSKOPSAV_RET,Y
		dey
		bpl	L8E98
		ldy	#&12
		sec
		ldx	#&03
.L8EA5		lda	WKSP_ADFS_211,Y
		sbc	WKSP_ADFS_20D,Y
		sta	(&B6),Y
		iny
		dex
		bpl	L8EA5
		ldy	#&0A
.L8EB3		lda	WKSP_ADFS_20D,Y
		sta	(&B6),Y
		iny
		cpy	#&12
		bne	L8EB3
		lda	&B6
		pha
		lda	&B7
		pha

.L8EC3		lda	#<(WKSP_ADFS_400_DIR_BUFFER + &05)				; Point to start of directory at &C405
		sta	&B6
		lda	#>(WKSP_ADFS_400_DIR_BUFFER + &05)
		sta	&B7
.L8ECB
IF USE65C12 AND OPTIMISE > 1
		lda	(&B6),Y				; Get first byte of directory entry
ELSE
		ldy	#&00
		lda	(&B6),Y				; Get first byte of directory entry
ENDIF
		beq	L8EF8				; &00 - end of directory
.L8ECF		ldy	#&19				; Point to object's sequence number
		lda	(&B6),Y
		cmp	WKSP_ADFS_800_DIR_BUFFER + &FA
		beq	L8EE7
IF OPTIMISE<2
		clc					; Step to next entry
		lda	&B6				; &B6/7=&B6/7+26
		adc	#&1A
		sta	&B6
		bcc	L8ECB
		inc	&B7
		bcs	L8ECB
ELSE
		jsr	NextEntry			; Step to next entry
IF USE65C12
		bra	L8ECB				; Loop back
ELSE
		jmp	L8ECB				; Loop back
ENDIF
ENDIF

.L8EE7		lda	WKSP_ADFS_800_DIR_BUFFER + &FA
		clc
		sed
		adc	#&01
		cld
		sta	WKSP_ADFS_800_DIR_BUFFER + &FA	; Store checksum at end of dir
		sta	WKSP_ADFS_400_DIR_BUFFER	; Store checksum at start of dir
IF USE65C12 AND OPTIMISE >= 1
		bra	L8EC3
ELSE
		jmp	L8EC3
ENDIF
;;
.L8EF8		pla					; Save dir entry pointer
		sta	&B7
		pla
		sta	&B6
		ldy	#&19
		lda	WKSP_ADFS_800_DIR_BUFFER + &FA
		sta	(&B6),Y
		lda	#&01
		sta	WKSP_ADFS_215_DSKOPSAV_RET
		ldx	#&04
.L8F0C		lda	WKSP_ADFS_21E_DSKOPSAV_SECCNT,X
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X
		dex
		bne	L8F0C
		lda	#&0A
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD
IF USE65C12 AND OPTIMISE >=1
		stz	WKSP_ADFS_21E_DSKOPSAV_SECCNT
		stz	WKSP_ADFS_21F_DSKOPSAV_CTL
ELSE
		lda	#&00
		sta	WKSP_ADFS_21E_DSKOPSAV_SECCNT
		lda	#&00
		sta	WKSP_ADFS_21F_DSKOPSAV_CTL
ENDIF
		ldy	#&12
.L8F26		lda	(&B6),Y
		sta	WKSP_ADFS_20E,Y
		iny
		cpy	#&16
		bne	L8F26
		ldy	#&12
		lda	(&B6),Y
		cmp	#&01
		ldx	#&02
.L8F38		lda	#&00
		iny
		adc	(&B6),Y
		sta	WKSP_ADFS_22A,Y
		dex
		bpl	L8F38
		bcc	L8F48
		jmp	L867F
;;
.L8F48		ldy	#&16
		lda	#&FF
		sta	(&B6),Y
		iny
		sta	(&B6),Y
		iny
		sta	(&B6),Y
		jmp	L84E1
;;
.L8F57		jsr	L8DFE
		jsr	L8E7A
.L8F5D		jsr	L8E96
		jsr	L865B
.L8F63		ldy	#&18
		ldx	#&02
.L8F67		lda	WKSP_ADFS_23A,X
		sta	(&B6),Y
		dey
		dex
		bpl	L8F67
		ldx	#&02
		ldy	#&06
.L8F74		lda	WKSP_ADFS_23A,X
		sta	WKSP_ADFS_215_DSKOPSAV_RET,Y
		iny
		dex
		bpl	L8F74
		rts
;;
.L8F7F		jsr	L8F57
		jsr	L8A42
IF USE65C12 AND OPTIMISE >= 1
		bra	L8F8B
ELSE
		jmp	L8F8B
ENDIF
;;
.L8F88		jsr	L8F57
.L8F8B		jsr	L8F91
		jmp	L8C67

;;
.L8F91		jsr	LA714
		jsr	L9012
IF OPTIMISE<5
		ldx	#&0A
.L8F99		lda	L883C,X				; Copy control block to load '$'
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X
		dex
		bpl	L8F99
ELSE
		jsr	RootSector
ENDIF
		lda	#&0A				; Change action to 'Write'
IF OPTIMISE<6
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD			; Update action
		lda	WKSP_ADFS_314			; Change sector to new dir to create
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+2
		lda	WKSP_ADFS_315
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+1
		lda	WKSP_ADFS_316
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC
ELSE
		jsr	SectorToControl
ENDIF
		jsr	L82AA
		lda	WKSP_ADFS_317_CURDRV
		jsr	LB5C5				; X=(A DIV 16)
		lda	WKSP_ADFS_100_FSM_S1 + &FC
		sta	WKSP_ADFS_322,X
IF TARGETOS=0 AND HD_SCSI
		lda	&0295				; TODO: should this be all elks?
ELSE
		lda	&FE44				; System VIA Latch Lo
ENDIF
		sta	WKSP_ADFS_321,X
		sta	WKSP_ADFS_100_FSM_S1 + &FB
		jsr	L9065				; Calculate FSM checksums
		stx	WKSP_ADFS_000_FSM_S0 + &FF	; Store sector 0 checksum
		sta	WKSP_ADFS_100_FSM_S1 + &FF	; Store sector 1 checksum
		ldx	#<L907A				; Point to 'save FSM' control block
		ldy	#>L907A
		jsr	L82AE				; Save FSM
IF USE65C12
		lda	#ADFS_FLAGS_FSM_INCONSISTENT
		trb	ZP_ADFS_FLAGS			; Set 'FSM loaded' flag
ELSE
		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_FSM_INCONSISTENT EOR &FF
		sta	ZP_ADFS_FLAGS
ENDIF
		lda	#&00
		rts

IF OPTIMISE>=6
.SectorToControl
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD			; Update action
		lda	WKSP_ADFS_314			; Change sector to new dir to create
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+2
		lda	WKSP_ADFS_315
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+1
		lda	WKSP_ADFS_316
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC
		rts
.GetDrive
		ldy	#&06
.GetDriveY
		lda	(&B0),Y
		ora	WKSP_ADFS_317_CURDRV
		rts
ENDIF

.L8FE8		jsr	L8870
		php
		pha					; Save registers
		jsr	L8FF3				; Check loaded FSM
		pla					; Restore registers
		plp
.L8FF2		rts
;;
;; Check Free Space Map consistancy
;; ================================
.L8FF3
IF TARGETOS = 0	AND NOT(HD_SCSI)			; TODO: ASK JGH - this looks like debugging stuff left in?
		rts
		EQUB	&09, &90
ELSE
		jsr	L9012				; Check for overlapping FSM entries
ENDIF
		jsr	L9065				; Add up
		cmp	WKSP_ADFS_100_FSM_S1 + &FF	; Does sector 1 sum match?
		bne	L9003				; No, jump to give error
		cpx	WKSP_ADFS_000_FSM_S0 + &FF	; Does sector 0 sum match?
		beq	L8FF2				; Yes, exit
.L9003		jsr	L834E				; Generate error
		EQUB	&A9				; ERR=169
		EQUS	"Bad FS map"
		EQUB	&00
;;
;; Check Free Space Map doesn't have overlapping entries
;; -----------------------------------------------------
.L9012		ldx	WKSP_ADFS_100_FSM_S1 + &FE	; Get pointer to end of FSM
		beq	L8FF2				; Pointer=0, disk completely full, exit
IF NOT(LARGE_DISK)
		lda	#&00				; Seed the sum with zero
ENDIF
.L9019
IF NOT(LARGE_DISK)
		ora	WKSP_ADFS_000_FSM_S0 - 1,X	; Merge with high byte of final free space
		ora	WKSP_ADFS_100_FSM_S1 - 1,X	; Merge with high byte of final length
ENDIF
		dex					; Check FSM end pointer is multiple of 3
		beq	L9003				; Jump to error if end pointer 3n+2
		dex
		beq	L9003				; Jump to error if end pointer 3n+1
		dex
		bne	L9019				; Multiple of three, check next entry
IF NOT(LARGE_DISK)
		and	#&E0				; Get "drive" bits
		bne	L9003				; If any set, map entry too big
ENDIF
		ldx	WKSP_ADFS_100_FSM_S1 + &FE	; Get pointer to end of FSM
		cpx	#&06				; Are there two or more entries?
		bcc	L8FF2				; Exit if only one FSM entry
		ldx	#&03				; Point to first entry minus 3
.L9035		ldy	#&02				; Three bytes per entry
		clc					; Clear carry
.L9038		lda	WKSP_ADFS_000_FSM_S0 - 3,X	; Get FSM entry start sector
		adc	WKSP_ADFS_100_FSM_S1 - 3,X	; Add FSM entry length
		pha					; Save byte
		inx					; Point to next byte
		dey
		bpl	L9038				; Loop for three bytes
		bcs	L9003				; Start+Length overflowed, give error
		ldy	#&02				; Three bytes per entry
.L9047		pla					; Get start+length byte
		dex
		cmp	WKSP_ADFS_000_FSM_S0,X		; Check against next entry start
		bcc	L9055				; Hole in FSM, check next byte
		bne	L9003				; Entry overlaps, give error
		dey
		bpl	L9047				; Loop for three bytes
		bmi	L9003				; Entry overlaps, give error
.L9055		pla					; Get next byte
		dex
		dey
		bpl	L9055
		pha
		inx
		inx
		inx
		inx					; Point to next entry
		cpx	WKSP_ADFS_100_FSM_S1 + &FE	; Check against end of FSM
		bcc	L9035				; Loop for all entries
		rts
;;
;; Add up FSM
;; ----------
.L9065		clc					; Clear carry
		ldy	#&FF				; Point to &xxFE
		tya					; Initialise A with -1
.L9069		adc	WKSP_ADFS_000_FSM_S0 - 1,Y	; Add sector 0 bytes &FE to &00
		dey
		bne	L9069				; Loop for all bytes
		tax					; Save result in X
		dey					; Reset Y to &FF again
		tya					; Initialise A with -1
		clc					; Clear carry
.L9073		adc	WKSP_ADFS_000_FSM_S0 + &FF,Y	; Add sector 1 bytes from &FE to &00
		dey
		bne	L9073				; Loop for all bytes
		rts
;;
;; Control block to save FSM
.L907A		EQUB	&01				; Result=&01, Disk not formatted
		EQUW	WKSP_ADFS_000_FSM_S0		; Save from &FFFFC000
		EQUW	&FFFF
		EQUB	&0A				; Action=Write
		EQUB	&00				; Sector=&000000
		EQUB	&00
		EQUB	&00
		EQUB	&02				; Number=&02
		EQUB	&00				; &00=use sector count
;;
;; OSFILE &01-&03 - Write Info
;; ===========================
.L9085		sta	WKSP_ADFS_220_DSKOPSAV_XLEN+3			; Save function
IF FULL_ACCESS
		jsr	L8FE8				; Search for object
ELSE
		jsr	L8BF0				; Search for non-'E' object
ENDIF
		beq	L9090				; Jump if file found
		lda	#&00				; Return 'no file'
		rts
;;
;; Write Info - file found
;; -----------------------
;; (&B6)=>file info, (&B8)=>control block
.L9090		lda	WKSP_ADFS_220_DSKOPSAV_XLEN+3			; Get OSFILE function
		cmp	#&03
		beq	L90B8				; Jump past with Exec
		ldy	#&05
		ldx	#&03
.L909B		lda	(&B8),Y
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X
		dey
		dex
		bpl	L909B
		ldy	#&0D
		ldx	#&03
.L90A8		lda	WKSP_ADFS_215_DSKOPSAV_RET,X
		sta	(&B6),Y
		dey
		dex
		bpl	L90A8
		lda	WKSP_ADFS_220_DSKOPSAV_XLEN+3
		cmp	#&02
		beq	L9104
.L90B8		ldy	#&09
		ldx	#&03
.L90BC		lda	(&B8),Y
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X
		dey
		dex
		bpl	L90BC
		ldy	#&11
		ldx	#&03
.L90C9		lda	WKSP_ADFS_215_DSKOPSAV_RET,X
		sta	(&B6),Y
		dey
		dex
		bpl	L90C9
		ldx	WKSP_ADFS_220_DSKOPSAV_XLEN+3
		dex
		bne	L9104
;;
.L90D8		ldy	#&0E
		lda	(&B8),Y				; Get access byte
		sta	WKSP_ADFS_22B
IF FULL_ACCESS
		ldy	#8
.WrLp
		cpy	#4				; Write full access byte
		bne	WrNotE
		dey
		dey
.WrNotE
		lda	(&B6),Y
		asl	A
		rol	WKSP_ADFS_22B
		ror	A
		sta	(&B6),Y
		cpy	#4
		beq	WrIsE
		cpy	#2
		bne	WrNext
		iny
		iny
		bne	WrNotE
.WrIsE
		dey
		dey
.WrNext
		dey
		bpl	WrLp
IF NOT(TRIM_REDUNDANT)
		nop
		nop
		nop
ENDIF
ELSE
		ldy	#&03
		lda	(&B6),Y				; Check 'D' bit
		bpl	L90F2				; Jump if a file
		lsr	WKSP_ADFS_22B
		lsr	WKSP_ADFS_22B
.L90EB		lsr	WKSP_ADFS_22B			; Move 'L' bit down to b0
		ldy	#&02				; Point to 'L' bit
		bpl	L90F4
;;
.L90F2		ldy	#&00				; Point to 'R' bit
;;
.L90F4		lda	(&B6),Y				; Get filename byte
		asl	A				; Drop access bit
		lsr	WKSP_ADFS_22B			; Get supplied access bit
		ror	A				; Move into filename byte
		sta	(&B6),Y				; Store in object info
		iny					; Step to next byte
		cpy	#&02
		bcc	L90F4				; Loop until RW done
		beq	L90EB				; 'L' bit, move source down one more bit
ENDIF
.L9104		jsr	L8F91				; RWL done, store catalogue entry
		jmp	L8CCE
;;
;; OSFILE &04 - Write Attributes
;; =============================
IF FULL_ACCESS
.L910A		jsr	L8FE8
ELSE
.L910A		jsr	L8BF0
ENDIF
		beq	L90D8
		lda	#&00
		rts

;; A leftover from BBC '*DELETE', Master enters via OSFILE
;;TODO: put back for SCSI2
IF (NOT(TRIM_REDUNDANT) OR TARGETOS<3) AND NOT(HD_SCSI2)
.starREMOVE
		jsr	LA50D				; Skip spaces, etc
		lda	&B4				; &C240/1 = filename pointer in &B4/5
		sta	WKSP_ADFS_240
		lda	&B5
		sta	WKSP_ADFS_241
		lda	#<WKSP_ADFS_240			; &B8/9=>&C240, workspace control block
		sta	&B8
		lda	#>WKSP_ADFS_240
		sta	&B9				; Fall through into Delete
ENDIF

;; OSFILE &06 - Delete
;; ===================
.L9127		jsr	L8CD4
		beq	L9131
		lda	#&00
		jmp	L89D8

;;
.L9131		jsr	L8D1B
		ldy	#&03
		lda	(&B6),Y				; Check 'D' bit
		bpl	L9177				; Jump if not a directory
		ldy	#&03
.L913C		lda	WKSP_ADFS_22C_CSD,Y
		sta	WKSP_ADFS_230,Y
		dey
		bpl	L913C
		lda	#&FF
		sta	WKSP_ADFS_22E
		sta	WKSP_ADFS_22F
		jsr	L9486
		lda	WKSP_ADFS_400_DIR_BUFFER + &05
		php
		jsr	L89D8
		ldy	#&03
.L9159		lda	WKSP_ADFS_230,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	L9159
		plp
		beq	L9177
		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&B4				; ERR=180
		EQUS	"Dir not empty"
		EQUB	&00
;;
.L9177
IF OPTIMISE<4
		ldy	#&12
		ldx	#&02
		lda	(&B6),Y
		cmp	#&01
.L917F		iny
		lda	#&00
		adc	(&B6),Y
		sta	WKSP_ADFS_224,Y
		dex
		bpl	L917F
		ldy	#&18
		ldx	#&02
.L918E		lda	(&B6),Y
		sta	WKSP_ADFS_234,X
		dey
		dex
		bpl	L918E
ELSE
		jsr	L8E03
ENDIF
		ldy	#&03
		lda	(&B6),Y				; Get 'D' bit
		bpl	L921B				; Not a directory
		ldx	WKSP_ADFS_22F			; Get object drive
		cpx	#&FF
		beq	L91A9				; Drive=&FF
		cpx	WKSP_ADFS_317_CURDRV			; Compare with current drive
		bne	L91CB				; Not on current drive, can't be CSD
.L91A9		ldx	#&02
.L91AB		lda	WKSP_ADFS_234,X			; Get object sector
		cmp	WKSP_ADFS_22C_CSD,X		; Compare with CSD sector
		bne	L91CB				; No match, jump to check for LIB
		dex
		bpl	L91AB
		jsr	ReloadFSMandDIR_ThenBRK				; Object is CSD, can't delete it
		EQUB	&96				; ERR=150
		EQUS	"Can't delete CSD"
		EQUB	&00
;;
.L91CB		lda	WKSP_ADFS_317_CURDRV			; Get current drive
		cmp	WKSP_ADFS_31B			; Compare with LIB drive
		bne	L91F9				; Not on current drive
		ldx	#&02
.L91D5		lda	WKSP_ADFS_234,X			; Get object sector
		cmp	WKSP_ADFS_318,X			; Compare with LIB sector
		bne	L91F9				; No match, jump to ch
		dex
		bpl	L91D5
		jsr	ReloadFSMandDIR_ThenBRK				; Object is LIB, can't delete it
		EQUB	&97				; ERR=151
		EQUS	"Can't delete Library"
		EQUB	&00
;;
.L91F9		lda	WKSP_ADFS_317_CURDRV			; Get current drive
		cmp	WKSP_ADFS_31F			; Compare with Previous drive
		bne	L921B				; Different drive
		ldx	#&02
.L9203		lda	WKSP_ADFS_234,X			; Get object sector
		cmp	WKSP_ADFS_31C,X			; Compare with Previous Directory sector
		bne	L921B				; No match, jump to exit
		dex
		bpl	L9203
		lda	#&02
		sta	WKSP_ADFS_31C			; Set Previous Directory to $
IF USE65C12 AND OPTIMISE >= 1
		stz	WKSP_ADFS_31D
		stz	WKSP_ADFS_31E
ELSE
		lda	#&00
		sta	WKSP_ADFS_31D
		sta	WKSP_ADFS_31E
ENDIF
.L921B		ldy	#&04
		lda	(&B6),Y				; Check 'E' bit
		bmi	L9224				; Jump if 'E' set
		jsr	L8C70
.L9224		ldy	#&1A
		ldx	#&00
.L9228		lda	(&B6),Y
		sta	(&B6,X)
		inc	&B6
		bne	L9232
		inc	&B7
.L9232		lda	&B6
		cmp	#&BB
		bne	L9228
		lda	&B7
		cmp	#>WKSP_ADFS_800_DIR_BUFFER
		bne	L9228
		jsr	L84E1
		jsr	L8F91
		jmp	L89D5
;;
;;
;; OSFILE
;; ======
;; A=function, XY=>control block
;; -----------------------------
.my_OSFILE		stx	&B8				; Store pointer to control block
		sty	&B9
		tay					; Y=function
IF USE65C12 AND OPTIMISE >=1 AND NOT(HD_MMC)
		stz	WKSP_ADFS_2D5_CUR_CHANNEL
ELSE
		ldx	#&00
		stx	WKSP_ADFS_2D5_CUR_CHANNEL			; Clear last channel used
ENDIF
		asl	A				; Index into dispatch table
		tax
		inx
		inx
IF UNSUPPORTED_OSFILE
		tya					; Unsupported calls should return A preserved
		nop
ELSE
		bmi	L9270				; <&FF, return with A=func*2
ENDIF
		cpx	#&12
		bcs	L9270				; >&07, return with A=func*2 (A=func with bugfix)
		lda	L9271+1,X			; Get dispatch address-1
		pha					; Stack high byte of address-1
		lda	L9271+0,X
		pha					; Stack low byte of address-1
IF USE65C12
		phy					; Stack function
ELSE
		tya
		pha
ENDIF
IF OPTIMISE<2
		ldy	#&00				; Get filename address
		lda	(&B8),Y
		sta	&B4
		iny
		lda	(&B8),Y
		sta	&B5				; &B4/5=>filename
ELSE
		jsr	GetFilename
ENDIF
		pla					; Get function to A
.L9270		rts					; Jump to subroutine

IF OPTIMISE>=2
; Get filename address from control block to &B4/5
; ------------------------------------------------
.GetFilename
IF USE65C12 AND OPTIMISE >= 1
		lda	(&B8)				; Get filename address
		sta	&B4
		ldy	#&01
ELSE
		ldy	#&00				; Get filename address
		lda	(&B8),Y
		sta	&B4
		iny
ENDIF
		lda	(&B8),Y
		sta	&B5				; &B4/5=>filename
		rts
ENDIF

; On dispatch, (&B8)=>control block, (&B4)=>filename, A=function, Y=1, X=corrupted
; Subroutine should return A=filetype, XY=>control block

; OSFILE Dispatch Block
; =====================
.L9271		EQUW	L8C10-1				; &FF - LOAD
		EQUW	L8F7F-1				; &00 - SAVE
		EQUW	L9085-1				; &01 - Write Info
		EQUW	L9085-1				; &02 - Write Load
		EQUW	L9085-1				; &03 - Write Exec
		EQUW	L910A-1				; &04 - Write Attrs
		EQUW	L8CB3-1				; &05 - Read Info
		EQUW	L9127-1				; &06 - Delete
		EQUW	L8F88-1				; &07 - Create
;;
.L9283		tax
		lda	#>L9FB1
		sta	&B7
		lda	L9E95,X
		sta	&B6
		ldx	#&0C
;;
.L928F		ldy	#&00
.L9291		lda	(&B6),Y
		and	#&7F
		cmp	#&20
		bcc	L92A1
		jsr	L92CB
		iny
		dex
		bne	L9291
		rts
;;
.L92A1		jsr	LA036
		dex
		bne	L92A1
		rts
;;
.L92A8		pla
		sta	&B6
		pla
		sta	&B7
		ldy	#&01
.L92B0		lda	(&B6),Y
		bmi	L92BA
		jsr	L92CB
		iny
		bne	L92B0
.L92BA		and	#&7F
		jsr	L92CB
		tya
		clc
		adc	&B6
		tay
		lda	#&00
		adc	&B7
		pha					; Push address to stack
IF USE65C12
		phy
ELSE
		tya
		pha
ENDIF
		rts					; Jump to address via stack
;;
.L92CB		pha
IF USE65C12 AND OPTIMISE > 1
		phx
ELSE
		txa
		pha
ENDIF
		lda	&B6
		pha
		lda	&B7
		pha
		tsx
		lda	&0104,X
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSASCI
ENDIF
		pla
		sta	&B7
		pla
		sta	&B6
IF USE65C12 AND OPTIMISE > 1
		plx
ELSE
		pla
		tax
ENDIF
		pla
		rts
;;
;; Print filename, access, cycle number
;; ====================================
.L92E5		ldx	#&0A				; Print 10 characters
		jsr	L928F				; Print filename at (&B6)
		jsr	LA036				; Print a space
		ldy	#&04				; Point to access bits
IF FULL_INFO
		ldx	#&04				; Allow four characters padding
ELSE
		ldx	#&03				; Allow three characters padding
ENDIF
.L92F1		lda	(&B6),Y				; Get access bit
		rol	A
		bcc	L92FD				; Not set, step to next one
		lda	L931D,Y				; Get access character
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSWRCH
ENDIF
		dex					; Dec. padding needed
;;
.L92FD		dey					; Step to next access bit
		bpl	L92F1				; Loop until <0
.L9300		dex					; Dec. padding needed
		bmi	L9309				; All done
		jsr	LA036				; Print a space
IF USE65C12 AND OPTIMISE >= 1
		bra	L9300				; Loop to print padding
ELSE
		jmp	L9300				; Loop to print padding
ENDIF
;;
.L9309		lda	#&28
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSWRCH
ENDIF
		ldy	#&19
		lda	(&B6),Y				; Get cycle number
		jsr	L9322				; Print it
		lda	#&29
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSWRCH
ENDIF							; ; Print ')'
IF FULL_INFO
		lda	#&20				; Finish with a space
		rts
ELSE
		jmp	LA036				; Finish with a space
ENDIF
;;
;; Access characters
;; =================
.L931D		EQUS	"RWLDE"

; Print hex
; =========
.L9322		pha
		lsr	A
		lsr	A
		lsr	A
		lsr	A
		jsr	L932B
		pla
.L932B		jsr	L8462
IF 	TARGETOS > 1
		jmp	LA03C
ELSE
		jmp	OSWRCH
ENDIF

; Print catalogue header
; ======================
.L9331		jsr	LA714
		lda	#<WKSP_ADFS_800_DIR_D9		; &B6/7=>&C8D9
		sta	&B6
		lda	#>WKSP_ADFS_800_DIR_D9
		sta	&B7
		ldx	#&13
		jsr	L928F
		jsr	L92A8
		EQUB	&20, &A8			; Print " ("
		lda	WKSP_ADFS_800_DIR_BUFFER + &FA
		jsr	L9322
		jsr	L92A8
		EQUS	")",&0D,"Drive",&BA
		lda	WKSP_ADFS_317_CURDRV			; Get current drive
		asl	A
		rol	A
		rol	A
		rol	A
		adc	#'0'				; Convert to digit
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSWRCH
ENDIF							; Display digit
		lda	#<L9A68				; &B6/7=>L9A68, a zero byte
		sta	&B6
		lda	#>L9A68
		sta	&B7
		ldx	#&0D				; 13 characters to print
		jsr	L928F				; Print 13 spaces as &B6/7=>&00
		jsr	L92A8
		EQUS	"Option", &A0
		lda	WKSP_ADFS_100_FSM_S1 + &FD	; Get boot option
		jsr	L9322				; Print in hex
		jsr	L92A8
		EQUB	&20, &A8			; Print " ("
		ldx	WKSP_ADFS_100_FSM_S1 + &FD	; Get boot option
		lda	L9426,X				; Get low byte of address of option string
		sta	&B6
		lda	#>L9436				; Get high byte of address of option strings
		sta	&B7				; &B6/7=>option string
		ldx	#&04				; Four characters to print
		jsr	L928F				; Print the string at &B6/7
		jsr	L92A8
		EQUS	")",&0D,"Dir.",&A0
		lda	#<WKSP_ADFS_300_CSDNAME		; &B6/7=>&C300, directory name
		sta	&B6
		lda	#>WKSP_ADFS_300_CSDNAME
		sta	&B7
		ldx	#&0A				; 10 characters to print
		jsr	L928F				; Print the string at &B6/7
		jsr	L92A8
		EQUS	"     Lib.",&A0
		lda	#<WKSP_ADFS_30A_LIBNAME			; Point to &C30A, library name
		sta	&B6
		lda	#>WKSP_ADFS_30A_LIBNAME
		sta	&B7
		ldx	#&0A
		jsr	L928F
		jsr	L92A8
		EQUB	&0D,&8D				; Print two newlines
.L93CC		lda	#<WKSP_ADFS_405_DIR_START	; Point directory pointer to start of directory
		sta	&B6
		lda	#>WKSP_ADFS_405_DIR_START
		sta	&B7
		rts

;;
;; FSC 5 - *CAT
;; ============
.L93D5		jsr	LA50D
		jsr	L9478
.L93DB		jsr	L9331				; Print catalogue header
		lda	#&04
		sta	WKSP_ADFS_22B			; Display in four columns

.L93E3
IF USE65C12 AND OPTIMISE >= 1
		lda	(&B6)				; Check first byte of entry
ELSE
		ldy	#&00
		lda	(&B6),Y				; Check first byte of entry
ENDIF
		beq	L940C				; &00 - end of directory
.L93E9		jsr	L92E5				; Print filename, access, cycle
		dec	WKSP_ADFS_22B			; Decrement number of columns
		bne	L93FC				; Not done four columns yet
		lda	#&04
		sta	WKSP_ADFS_22B			; Reset to four columns
IF TARGETOS > 1
		jsr	LA03A
ELSE
		jsr	OSNEWL
ENDIF							; Print newline without spooling
IF USE65C12 AND OPTIMISE >= 1
		bra	L93FF				; Step to next entry
ELSE
		jmp	L93FF				; Step to next entry
ENDIF

.L93FC		jsr	LA036				; Print a space without spooling
.L93FF
IF OPTIMISE<2
		clc					; Step to next entry
		lda	&B6				; &B6/7=&B6/7+26
		adc	#&1A
		sta	&B6
		bcc	L93E3
		inc	&B7
		bcs	L93E3
ELSE
		jsr	NextEntry			; Step to next entry
		bne	L93E9				; Not end of directory, loop back
ENDIF

.L940C		lda	WKSP_ADFS_22B
		cmp	#&04
		beq	L9423
		lda	#&86
		jsr	OSBYTE				; Read POS/VPOS
		txa					; Check POS
		bne	L9420				; POS>0, skip past
		lda	#&0B				; POS=0, do VDU 11 to adjust print position
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSWRCH
ENDIF
.L9420
IF TARGETOS > 1
		jsr	LA03A				; Print final newline
ELSE
		jsr	OSNEWL
ENDIF

.L9423		jmp	L89D8

.L9426		EQUB	<L942A, <L942E, <L9432, <L9436
.L942A		EQUS	"Off "
.L942E		EQUS	"Load"
.L9432		EQUS	"Run "
.L9436		EQUS	"Exec"
IF (L942A AND &FF00)<>(L9436 AND &FF00)
							;TODO reinstate this!!!
		print	"Option strings run over page boundary"
ENDIF
;;
;; FSC 9 - *EX
;; =============
IF OPTIMISE>=6
.CatOrEx
		beq	L93DB				; = &00 -> do CAT
		bne	L943D				; <>&00 -> do EX
ENDIF
.starEX		
		jsr	L9478
.L943D		jsr	L9331				; Print catalogue header
.L9440
IF USE65C12 AND OPTIMISE >= 1
		lda	(&B6)				; Check first byte of directory entry
ELSE
		ldy	#&00
		lda	(&B6),Y				; Check first byte of directory entry
ENDIF
		beq	L9423				; &00 - end of directory
.L9446		jsr	L9508				; Print info for this entry
IF OPTIMISE<2
		clc					; Step to next entry
		lda	&B6				; &B6/7=&B6/7+26
		adc	#&1A
		sta	&B6
		bcc	L9440
		inc	&B7
IF USE65C12
		bra	L9440
ELSE
		bcs	L9440
ENDIF
ELSE
		jsr	NextEntry			; Step to next entry
IF USE65C12 AND OPTIMISE >= 1
		bra	L9440				; Loop back
ELSE
		jmp	L9440				; Loop back
ENDIF
ENDIF

.L9456		ldy	#&00				; Point to first character, prepare Y=0 for later
		lda	(&B4),Y				; Get first character of filename
		and	#&7F
		cmp	#'^'				; '^' - parent
		bne	L946A
		lda	#<WKSP_ADFS_800_DIR_C0		; Point &B6/7 to &C8C0
		sta	&B6
		lda	#>WKSP_ADFS_800_DIR_C0
		sta	&B7
		bne	L9476
.L946A		cmp	#'@'				; '@' - current directory
		bne	L9477				; Exit with NE, not '^' or '@'
		lda	#<WKSP_ADFS_2FE			; Point &B6/7 to &C2FE
		sta	&B6
		lda	#>WKSP_ADFS_2FE
		sta	&B7
.L9476		tya					; Exit with A=&00, EQ for '^' or '@'
.L9477		rts					; Exit with Y=0, EQ if '^' or '@' found
;;
.L9478		ldy	#&00				; Caller may need this
		lda	(&B4),Y				; Get first character of filename
		cmp	#&21
		bcs	L9486
		ldx	WKSP_ADFS_317_CURDRV			; Get current drive
		inx					; If &FF, no directory loaded
		bne	L9477
.L9486		jsr	L8875
		bne	L9499
.L948B		ldy	#&03
		lda	(&B6),Y				; Check 'D' bit
		bmi	L949E				; Jump if directory
		jsr	L8964
		beq	L948B
.L9496		jmp	L8BE2				; Jump to 'Not found' error
;;
.L9499		jsr	L9456
		bne	L9496
.L949E		ldy	WKSP_ADFS_22E
		iny
		bne	L94AF
		ldy	#&02
.L94A6		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	L94A6
.L94AF
IF OPTIMISE<5
		ldx	#&0A
.L94B1		lda	L883C,X
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X
		dex
		bpl	L94B1
ELSE
		jsr	RootSector
ENDIF
		ldx	#&02
		ldy	#&16
.L94BE		lda	(&B6),Y
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC,X
		sta	WKSP_ADFS_2FE,Y
		iny
		dex
		bpl	L94BE
		lda	&B7
		cmp	#>L94D3				; Is it fake '$' entry?
		beq	L9507				; Yes, exit
		jmp	L82AA				; No, load FSM and root
;;
;; Fake entry for '$'
;; ==================
.L94D3		EQUB	&A4
		EQUB	&0D
		EQUB	&8D
		EQUB	&8D
		EQUB	&0D
		EQUB	&0D
		EQUB	&0D
		EQUB	&0D
		EQUB	&0D
		EQUB	&0D
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&05
		EQUB	&00
		EQUB	&00
		EQUB	&02
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&00
;;
;; FSC 10 - *INFO
;; ==============
.starINFO		
		jsr	L8FE8				; Search for object
		beq	L94F6				; Object not found
		jmp	L8BD3				; Error 'File not found' or 'Bad name'
;;
.L94F6		jsr	L9508				; Display full info on this entry
		jsr	L8964
		beq	L94F6				; Jump back to display more
		jmp	L89D8

;; Display file info if *OPT1 set
.L9501		lda	ZP_ADFS_FLAGS			; Get ADFS status byte
		and	#ADFS_FLAGS_OPT1		; Check *OPT1 setting
		bne	L9508				; *OPT1,1 - display file info
.L9507		rts

; *INFO - Print full info on an entry
; -----------------------------------
.L9508		jsr	L92E5				; Print filename
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSWRCH
ENDIF							; ; Print another space
;
IF NOT(FULL_INFO)
		ldy	#&04
		lda	(&B6),Y				; Get 'E' bit
		bmi	L9543				; If 'E' set, jump to finish
		dey
		lda	(&B6),Y				; Get 'D' bit
		rol	A				; Rotate into Carry
		ldx	#&0A				; X=10, Y=13
		ldy	#&0D
		bcc	L9522				; Jump if file
		ldx	#&17				; X=23, Y=24 if directory
		ldy	#&18				; Just print sector start
ENDIF
;
IF FULL_INFO AND NOT(TRIM_REDUNDANT)
		jmp	L951E
		EQUB	0,0,0,0,0,0,0
		EQUB	0,0,0,0,0,0
.L951E		ldx	#&0A				; X=display column 10
		ldy	#&0D				; Y=offset to top byte of load address
ENDIF
;
IF FULL_INFO AND TRIM_REDUNDANT
		ldx	#&0A				; X=display column 10
		ldy	#&0D				; Y=offset to top byte of load address
ENDIF
.L9522		cpx	#&16
		beq	L952B				; Finish at display column 22
		lda	(&B6),Y				; Get load/exec/len/sec byte
		jsr	L9322				; Print it
.L952B		txa
		and	#&03
		cmp	#&01
		bne	L953D
		jsr	LA036				; Print a space
		jsr	LA036				; Print a space
		txa
		clc
		adc	#&05
		tay
.L953D		dey
		inx
		cpx	#&1A
		bne	L9522
.L9543
IF TARGETOS > 1
		jmp	LA03A				; Print newline
ELSE
		jmp	OSNEWL
ENDIF
;;
.starDIR		jsr	L9486
		ldy	#&09
.L954B		lda	WKSP_ADFS_800_DIR_BUFFER + &CC,Y
		sta	WKSP_ADFS_300_CSDNAME,Y
		dey
		bpl	L954B
		lda	WKSP_ADFS_22F
		cmp	#&FF
		bne	L955E
		lda	WKSP_ADFS_317_CURDRV
.L955E		sta	WKSP_ADFS_31F
		ldy	#&02
.L9563		lda	WKSP_ADFS_22C_CSD,Y
		sta	WKSP_ADFS_31C,Y
		dey
		bpl	L9563
		lda	#&FF
		sta	WKSP_ADFS_22E
		sta	WKSP_ADFS_22F
		jmp	L89D8
;;
.starCDIR		lda	#&FF
		ldy	#&00
		jsr	my_OSARGS
		ldx	#&0F
.L9580		lda	L9639,X				; Copy an OSFILE control block to workspace
		sta	WKSP_ADFS_242,X
		dex
		bpl	L9580
		lda	&B4				; &C240/1=filename pointer
		sta	WKSP_ADFS_240
		lda	&B5
		sta	WKSP_ADFS_241
IF OPTIMISE<2
		lda	#<WKSP_ADFS_240			; &B8/9=>&C240
		sta	&B8
		lda	#>WKSP_ADFS_240
		sta	&B9
ELSE
		jsr	PointToCtrl			; &B8/9=>&C240, control block in workspace
ENDIF
		jsr	L8DFE
		ldy	#&09
		lda	WKSP_ADFS_237
		ora	WKSP_ADFS_237 + 1
		ora	WKSP_ADFS_237 + 2
		beq	L95BE
.L95AB		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&C4				; ERR=196
		EQUS	"Already exists"
		EQUB	&00

IF OPTIMISE>=2
.PointToCtrl
		lda	#<WKSP_ADFS_240		; Point &B8/9=>&C240, control block in workspace
		sta	&B8
		lda	#>WKSP_ADFS_240
		sta	&B9
		rts
ENDIF

.L95BE		lda	(&B4),Y				; Get filename character
		and	#&7F
		cmp	#&22
		beq	L95CA
		cmp	#&21
		bcs	L95CC
.L95CA		lda	#&0D
.L95CC		sta	(&B6),Y
		dey
		bpl	L95BE
		jsr	L8F5D
		ldy	#&03				; Point to 'D' bit
.L95D6
IF OPTIMISE<2
		lda	(&B6),Y				; Set attribute bit
		ora	#&80
		sta	(&B6),Y
ELSE
		jsr	SetAttr				; Set attribute bit
ENDIF
		dey
		cpy	#&01
		bne	L95D6
		dey
IF OPTIMISE<2
		lda	(&B6),Y				; Set attribute bit
		ora	#&80
		sta	(&B6),Y
ELSE
		jsr	SetAttr				; Set attribute bit
ENDIF
		lda	#&00
		tax
		tay
.L95EC		sta	WKSP_ADFS_A00_RND_BUFFER + &00,X; Use random access buffers to create a new directory
		sta	WKSP_ADFS_900_RND_BUFFER + &00,X; Blank out the directory
		sta	WKSP_ADFS_B00_RND_BUFFER + &00,X
		sta	WKSP_ADFS_C00_RND_BUFFER + &00,X
		sta	WKSP_ADFS_D00_RND_BUFFER + &00,X
		inx
		bne	L95EC
		ldx	#&04
.L9600		lda	L84DC,X				; Copy 'Hugo' string into directory
		sta	WKSP_ADFS_900_RND_BUFFER + &00,X
		sta	WKSP_ADFS_D00_RND_BUFFER + &FA,X
		lda	WKSP_ADFS_314,X
		sta	WKSP_ADFS_D00_RND_BUFFER + &D6,X
		dex
		bpl	L9600
		ldx	#&00
.L9614		lda	(&B4),Y				; Copy directory name into new directory
		and	#&7F
		cmp	#'"'
		beq	L9620
		cmp	#'!'
		bcs	L9622
.L9620		lda	#&0D
.L9622		sta	WKSP_ADFS_D00_RND_BUFFER + &D9,X
		sta	WKSP_ADFS_D00_RND_BUFFER + &CC,X
		iny
		inx
		cpx	#&0A
		bne	L9614
		lda	#&0D
		sta	WKSP_ADFS_D00_RND_BUFFER + &D9,X
		jsr	L8A42				; Save the parent directory
		jmp	L8F8B				; Create the new directory

; Control block to create a directory
; -----------------------------------
; Saves block of memory, then munges access bit to make it into a directory
;
.L9639		EQUB	&00				; Load=&00000000
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&00				; Exec=&00000000
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUW	WKSP_ADFS_900_RND_BUFFER	; Start=&FFFFC900
		EQUW	&FFFF
		EQUW	WKSP_ADFS_E00_END		; End=&FFFFCE00
		EQUW	&FFFF
;;
.L9649		lda	WKSP_ADFS_22F
		cmp	WKSP_ADFS_317_CURDRV
		beq	L9654

IF USE65C12
		inc	A
ELSE
		cmp	#&FF
ENDIF

		bne	L966C
.L9654		ldy	#&02
.L9656		lda	WKSP_ADFS_2A2,Y
		cmp	WKSP_ADFS_22C_CSD,Y
		bne	L966C
		dey
		bpl	L9656
		ldy	#&02
.L9663		lda	WKSP_ADFS_2A8,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	L9663
.L966C		lda	WKSP_ADFS_31B
		cmp	WKSP_ADFS_317_CURDRV
		bne	L968C
		ldy	#&02
.L9676		lda	WKSP_ADFS_2A2,Y
		cmp	WKSP_ADFS_318,Y
		bne	L968C
		dey
		bpl	L9676
		ldy	#&02
.L9683		lda	WKSP_ADFS_2A8,Y
		sta	WKSP_ADFS_318,Y
		dey
		bpl	L9683
.L968C		lda	WKSP_ADFS_31F
		cmp	WKSP_ADFS_317_CURDRV
		bne	L96AC
		ldy	#&02
.L9696		lda	WKSP_ADFS_2A2,Y
		cmp	WKSP_ADFS_31C,Y
		bne	L96AC
		dey
		bpl	L9696
		ldy	#&02
.L96A3		lda	WKSP_ADFS_2A8,Y
		sta	WKSP_ADFS_31C,Y
		dey
		bpl	L96A3
.L96AC		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_WTF
		bne	L96B8
		jsr	L8F91
		jsr	LA992
.L96B8		lda	WKSP_ADFS_2A7
		ora	WKSP_ADFS_2A6
		ora	WKSP_ADFS_2A5
		bne	L96C4
		rts
;;
.L96C4		lda	WKSP_ADFS_2A7
		ora	WKSP_ADFS_2A6
		bne	L96D4
		lda	WKSP_ADFS_2A5
		cmp	WKSP_ADFS_261
		bcc	L96D7
.L96D4		lda	WKSP_ADFS_261
.L96D7		sta	WKSP_ADFS_21E_DSKOPSAV_SECCNT
		lda	WKSP_ADFS_260
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
		ldx	#&00
		stx	WKSP_ADFS_216_DSKOPSAV_MEMADDR
		dex
		stx	WKSP_ADFS_216_DSKOPSAV_MEMADDR+2
		stx	WKSP_ADFS_216_DSKOPSAV_MEMADDR+3
.L96EC		sec
		lda	WKSP_ADFS_2A5
		sbc	WKSP_ADFS_261
		sta	WKSP_ADFS_2A5
		lda	WKSP_ADFS_2A6
		sbc	#&00
		sta	WKSP_ADFS_2A6
		lda	WKSP_ADFS_2A7
		sbc	#&00
		sta	WKSP_ADFS_2A7
		bcs	L9711
		lda	WKSP_ADFS_2A5
		adc	WKSP_ADFS_261
		sta	WKSP_ADFS_21E_DSKOPSAV_SECCNT
.L9711		lda	#&08
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD
		lda	WKSP_ADFS_2A2
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+2
		lda	WKSP_ADFS_2A3
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+1
		lda	WKSP_ADFS_2A4
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC
		jsr	L82AA
		lda	#&0A
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD
		lda	WKSP_ADFS_2A8
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+2
		lda	WKSP_ADFS_2A9
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+1
		lda	WKSP_ADFS_2AA
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC
		jsr	L82AA
		lda	WKSP_ADFS_2A5
		ora	WKSP_ADFS_2A6
		ora	WKSP_ADFS_2A7
		beq	L9783
		lda	WKSP_ADFS_21E_DSKOPSAV_SECCNT
		cmp	WKSP_ADFS_261
		bne	L9783
		clc
		lda	WKSP_ADFS_2A2
		adc	WKSP_ADFS_261
		sta	WKSP_ADFS_2A2
		bcc	L976C
		inc	WKSP_ADFS_2A3
		bne	L976C
		inc	WKSP_ADFS_2A4
.L976C		clc
		lda	WKSP_ADFS_2A8
		adc	WKSP_ADFS_261
		sta	WKSP_ADFS_2A8
		bcc	L9780
		inc	WKSP_ADFS_2A9
		bne	L9780
		inc	WKSP_ADFS_2AA
.L9780		jmp	L96EC
;;
.L9783		lda	ZP_ADFS_FLAGS			; Check ADFS status byte
		and	#ADFS_FLAGS_WTF			; Check bit 3
		beq	L978A				; If clear, do something
		rts
;;
.L978A		lda	#>WKSP_ADFS_400_DIR_BUFFER	; page of dir buffer
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
		lda	#&08				; Change action to 'Read'
IF OPTIMISE<6
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD
		lda	WKSP_ADFS_314
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+2
		lda	WKSP_ADFS_315
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+1
		lda	WKSP_ADFS_316
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC
ELSE
		jsr	SectorToControl
ENDIF
		lda	#&05
		sta	WKSP_ADFS_21E_DSKOPSAV_SECCNT
		jmp	L82AE

.L97AE
IF USE65C12 AND OPTIMISE >= 1
		stz	WKSP_ADFS_2AB
		stz	WKSP_ADFS_2AC
		stz	WKSP_ADFS_2AD
ELSE
		lda	#&00
		sta	WKSP_ADFS_2AB
		sta	WKSP_ADFS_2AC
		sta	WKSP_ADFS_2AD
ENDIF
.L97B9		lda	#&FF
		sta	WKSP_ADFS_2A2
		sta	WKSP_ADFS_2A3
		sta	WKSP_ADFS_2A4
		jsr	L93CC
.L97C7
IF USE65C12 AND OPTIMISE >= 1
		lda	(&B6)				; Get first byte of directory entry
ELSE
		ldy	#&00
		lda	(&B6),Y				; Get first byte of directory entry
ENDIF
		bne	L97DC				; Not &00, not end of directory
.L97CD		lda	WKSP_ADFS_2A2
		and	WKSP_ADFS_2A3
		and	WKSP_ADFS_2A4
IF USE65C12
		inc	A
ELSE
		cmp	#&FF
ENDIF

		bne	L981E
		jmp	L8F91
;;
.L97DC		ldy	#&16
		ldx	#&02
		sec
.L97E1		lda	WKSP_ADFS_295,Y
		sbc	(&B6),Y
		iny
		dex
		bpl	L97E1
		bcs	L9811
		ldy	#&16
		ldx	#&02
		sec
.L97F1		lda	WKSP_ADFS_28C,Y
		sbc	(&B6),Y
		iny
		dex
		bpl	L97F1
		bcc	L9811
		ldy	#&16
		ldx	#&02
.L9800		lda	(&B6),Y
		sta	WKSP_ADFS_28C,Y
		iny
		dex
		bpl	L9800
		lda	&B6
		sta	&B4
		lda	&B7
		sta	&B5
.L9811
IF OPTIMISE<2
		lda	&B6				; Step to next entry
		clc					; &B6/7=&B6/7+26
		adc	#&1A
		sta	&B6
		bcc	L97C7
		inc	&B7
		bcs	L97C7
ELSE
		jsr	NextEntry			; Step to next entry
IF USE65C12 AND OPTIMISE >= 1
		bra	L97C7				; Loop back
ELSE
		jmp	L97C7				; Loop back
ENDIF
ENDIF
.L981E		lda	&B4
		sta	&B6
		lda	&B5
		sta	&B7
		ldy	#&02
.L9828		lda	WKSP_ADFS_2A2,Y
		sta	WKSP_ADFS_2AB,Y
		dey
		bpl	L9828
		ldx	#&00
		stx	&B2
.L9835		cpx	WKSP_ADFS_100_FSM_S1 + &FE
		bcc	L983D
		jmp	L97B9
;;
.L983D		inx
		inx
		inx
		stx	&B2
		ldy	#&02
.L9844		dex
		lda	WKSP_ADFS_000_FSM_S0,X
		cmp	WKSP_ADFS_2A2,Y
		bcs	L9851
		ldx	&B2
IF USE65C12
		bra	L9835
ELSE
		bne	L9835
ENDIF

;;
.L9851		bne	L9856
		dey
		bpl	L9844
.L9856		ldx	&B2
		cpx	#&06
		bcc	L986E
		ldy	#&00
		clc
		php
.L9860		plp
		lda	WKSP_ADFS_000_FSM_S0 - 6,X
		adc	WKSP_ADFS_100_FSM_S1 - 6,X
		php
		cmp	WKSP_ADFS_2A2,Y
		beq	L9871
		plp
.L986E		jmp	L97B9
;;
.L9871		inx
		iny
		cpy	#&03
		bne	L9860
		plp
		ldx	#&02
		ldy	#&12
		lda	(&B6),Y
		cmp	#&01
.L9880		iny
		lda	(&B6),Y
		adc	#&00
		sta	WKSP_ADFS_292,Y
		sta	WKSP_ADFS_22A,Y
		sta	WKSP_ADFS_224,Y
		lda	WKSP_ADFS_2A2,X
		sta	WKSP_ADFS_234,X
		dex
		bpl	L9880
		jsr	L84E1
		jsr	L865B
		ldx	#&02
		ldy	#&18
.L98A1		lda	WKSP_ADFS_23A,X
		sta	(&B6),Y
		sta	WKSP_ADFS_2A8,X
		dey
		dex
		bpl	L98A1
		jsr	L9649
		jmp	L97AE
;;
.L98B3		lda	#&00
		sta	&C0
		sta	WKSP_ADFS_253
		sta	WKSP_ADFS_254
		lda	#&02
		sta	WKSP_ADFS_252
		lda	#>WKSP_ADFS_D00_RND_BUFFER
		sta	&C1
		lda	#<L9941
		sta	&B4
		lda	#>L9941
		sta	&B5
.L98CE		jsr	L9486
		ldy	#&02
.L98D3		lda	WKSP_ADFS_252,Y
		sta	WKSP_ADFS_800_DIR_BUFFER + &D6,Y
		dey
		bpl	L98D3
		jsr	L97AE
		jsr	L93CC
.L98E2
IF USE65C12 AND OPTIMISE >= 1
		lda	(&B6)				; Check first byte of directory entry
ELSE
		ldy	#&00
		lda	(&B6),Y				; Check first byte of directory entry
ENDIF
		beq	L9913				; &00 - end of directory
.L98E8		ldy	#&03
		lda	(&B6),Y				; Check 'D' bit
		bpl	L9930				; Not a directory
		lda	&C0
		cmp	#&FE
		beq	L9913
		ldy	#&00
		lda	&B6
		sta	&B4
		sta	(&C0),Y
		inc	&C0
		lda	&B7
		sta	&B5
		sta	(&C0),Y
		inc	&C0
		ldx	#&02
.L9908		lda	WKSP_ADFS_314,X
		sta	WKSP_ADFS_252,X
		dex
		bpl	L9908
		bmi	L98CE
.L9913		lda	&C0
		beq	L993D
		lda	#<L9940
		sta	&B4
		lda	#>L9940
		sta	&B5
		jsr	L9486
		ldy	#&00
		dec	&C0
		lda	(&C0),Y
		sta	&B7
		dec	&C0
		lda	(&C0),Y
		sta	&B6
.L9930
IF OPTIMISE<2
		clc					; Step to next entry
		lda	&B6				; &B6/7=&B6/7+26
		adc	#&1A
		sta	&B6
		bcc	L98E2
		inc	&B7
IF USE65C12
		bra	L98E2
ELSE
		bcs	L98E2
ENDIF

ELSE
		jsr	NextEntry
IF USE65C12 AND OPTIMISE >= 1
		bra	L98E2				; Loop back
ELSE
		jmp	L98E2				; Loop back
ENDIF
ENDIF
.L993D		jmp	L89D8
;
.L9940		EQUS	"^"				; Path for *BACK
.L9941		EQUB	13
;;
;; *ACCESS
;; =======
.starACCESS		jsr	L8FE8				; Search for object
		beq	L9956				; Jump forward if found
		jmp	L8BD3				; Jump to 'Not found'/'Bad name'
;;
.L994A		ldy	#&02				; Clear existing LWR bits
.L994C		lda	(&B6),Y				; Clear access bit
		and	#&7F
		sta	(&B6),Y
		dey
		bpl	L994C
		rts
;;
.L9956		jsr	L994A				; Clear existing LWR bits, preserve ED bit
		ldy	#&04
		lda	(&B6),Y				; Check 'E' bit
IF FULL_ACCESS
;       BMI L999E        ;; Jump if 'E' file
;       DEY
		jsr	L999E
ELSE
		bmi	L996A				; Jump if 'E' file
		dey
ENDIF
		lda	(&B6),Y				; Get 'D' bit
		and	#&80
IF USE65C12 AND OPTIMISE >= 1
		ora	(&B6)				; Copy 'D' bit into 'R' bit
		sta	(&B6)				; Forces dirs to always have 'R'
ELSE
		ldy	#&00
		ora	(&B6),Y				; Copy 'D' bit into 'R' bit
		sta	(&B6),Y				; Forces dirs to always have 'R'
ENDIF

.L996A		sta	WKSP_ADFS_22B			; Store 'E' or 'D'+'R' bit
		ldy	#&00				; Step past filename
.L996F		lda	(&B4),Y				; Get filename character
		cmp	#' '
		bcc	L99C0
		beq	L997E
		cmp	#'"'
		beq	L997E
		iny
		bne	L996F
.L997E		lda	(&B4),Y
		cmp	#' '
		bcc	L99C0
		beq	L998A
		cmp	#'"'
		bne	L998D
.L998A		iny
		bne	L997E
;;
.L998D		lda	(&B4),Y				; Get access character
		and	#&DF				; Force to upper case
		bit	WKSP_ADFS_22B			; Check 'E'/'D' flag
		bmi	L99AA				; Jump past if already 'E' or 'D'
		cmp	#'E'				; Is character 'E'?
		bne	L99AA				; Jump past if not setting 'E'
IF FULL_ACCESS
		ldx	#4
		bne	L99CE
.L999E		lda	(&B6),Y
		and	#&7F
		sta	(&B6),Y
		dey
		rts
		EQUB	0,0,0,0
ELSE
		jsr	L994A				; Clear all other bits
		ldy	#&04				; Point to 'E' bit
IF OPTIMISE<2
		lda	(&B6),Y				; Set 'E' attribute bit
		ora	#&80
		sta	(&B6),Y
ELSE
		jsr	SetAttr				; Set 'E' attribute bit
ENDIF
		sta	WKSP_ADFS_22B			; Set 'E/D has been used' flag
		bmi	L99BD
ENDIF
;;
.L99AA		ldx	#&02				; Check if access character
.L99AC		cmp	L931D,X
		beq	L99CE				; Matching character
		bit	WKSP_ADFS_22B
		bmi	L99B9				; If 'E/D used' only check for setting 'L'
		dex
		bpl	L99AC				; Otherwise check all access characters
.L99B9		cmp	#&21
		bcc	L99C0
.L99BD		iny
		bne	L998D
.L99C0		jsr	L9501
		jsr	L8964
		beq	L9956
		jsr	L8F91
		jmp	L89D8
;;
.L99CE
IF USE65C12
		phy
ELSE
		tya
		pha
ENDIF
		txa
		tay
IF OPTIMISE<2
		lda	(&B6),Y				; Set access bit
		ora	#&80
		sta	(&B6),Y
ELSE
		jsr	SetAttr				; Set access bit
ENDIF
IF USE65C12
		ply
		bra	L99BD
ELSE
		pla
		tay
		bne	L99BD
ENDIF
IF OPTIMISE>=2
.SetAttr
		lda	(&B6),Y				; Set access bit
		ora	#&80
		sta	(&B6),Y
		rts
ENDIF

;;
.L99DA
IF TARGETOS > 1
		jsr	LA03A
ELSE
		jsr	OSNEWL
ENDIF
		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&92				; ERR=146
		EQUS	"Aborted"
		EQUB	&00
;;
.starDESTROY		lda	&B4				; Save filename pointer
		pha
		lda	&B5
		pha
IF OPTIMISE<2
		lda	#<WKSP_ADFS_240			; &B8/9=>&C240
		sta	&B8
		lda	#>WKSP_ADFS_240
		sta	&B9
ELSE
		jsr	PointToCtrl			; &B8/9=>&C240
ENDIF
		jsr	starINFO
		pla
		sta	&B5
		pla
		sta	&B4
		jsr	L92A8
IF OPTIMISE<1
		EQUS	"Destroy ?", &A0
ELSE
		EQUS	"Destroy?", &A0
ENDIF
		ldx	#&03
.L9A0F		jsr	&FFE0
		cmp	#' '
		bcc	L9A19
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSASCI
ENDIF
.L9A19		and	#&DF				; Force to upper case
		cmp	L84D8,X				; Compare with 'YES'
		bne	L99DA
		dex
		bpl	L9A0F
IF TARGETOS > 1
		jsr	LA03A
		stz	WKSP_ADFS_2D5_CUR_CHANNEL
ELSE
		jsr	OSNEWL
		inx
		stx	WKSP_ADFS_2D5_CUR_CHANNEL
ENDIF

.L9A29		lda	&B4
		pha
		lda	&B5
		pha
IF TARGETOS > 1
		bit	ZP_MOS_ESCFLAG
		bpl	L9A36
		jmp	ErrorEscapeACKReloadFSM				; Jump to give 'Escape' error
ELSE
		jsr	L8FE8
		bne	L9A47
		jsr	L9131
		pla
		sta	&B5
		pla
		sta	&B4
		jmp	L9A29
ENDIF
;;
IF TARGETOS > 1
.L9A36
		jsr	L8FE8
		bne	L9A47
		jsr	L9131
		pla
		sta	&B5
		pla
		sta	&B4
IF USE65C12 AND OPTIMISE >= 1
		bra	L9A29
ELSE
		jmp	L9A29
ENDIF
ENDIF

;;
.L9A47		pla
		pla
		jmp	L89D8
;;
.L9A4C		jmp	(&021E)
;;
;;
;; Default context
;; ===============
.L9A4F		EQUS	&24				; csd="$"
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUS	&24				; lib="$"
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&20
		EQUB	&02				; csd=2
		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&02				; lib=2
.L9A68		EQUB	&00
		EQUB	&00
		EQUB	&00
		EQUB	&02				; back=2


; Check if hard drive hardware present
; ====================================
; On entry: none
; On exit:  EQ  - hard drive present
;	    NE  - no hard drive present
;	    A,X,Y allowed to be corrupted
IF HD_MMC
.HD_InitDetectBoot
.HD_InitDetect		
		stz	mmcstate%			; mark the mmc system as un-initialized
		jmp	initializeDriveTable
							;Returns EQ=Ok, NE=not present or no ADFS partitions
ENDIF
IF HD_IDE
IF TARGETOS = 0
.HD_InitDetectBoot
.HD_InitDetect		
		lda	IDE_STATUS
		clc
		adc	#1
		beq	_lelk9A6E
		lda	#00
		rts
._lelk9A6E	sec
		sbc	#1
		rts
		nop
		nop
		nop
		nop
		nop
		nop
ELSE
.HD_InitDetectBoot
.HD_InitDetect	
		ldx	IDE_STATUS			; &FF - absent, <>&FF - present
		inx					; &00 - absent, <>&00 - present
		beq	DriveNotPresent
		lda	#0				; EQ - present
		rts
.DriveNotPresent
		dex					; NE - absent
		rts
		EQUB	0,0,0,0,0,0,0,0
IF TARGETOS = 1
		EQUB	0,0
ENDIF ; TAEGETOS = 1
ENDIF ; TARGETOS <> 0
ENDIF ; HD_IDE
IF HD_SCSI
.HD_InitDetectBoot
.HD_InitDetect
		lda	#&5A
		jsr	L9A75
		bne	L9A7E
		lda	#&A5
.L9A75		sta	SCSI_DATA
IF USE65C12
		stz	SCSI_IRQEN
ELSE
		ldx	#0
		stx	SCSI_IRQEN
ENDIF
		cmp	SCSI_DATA
.L9A7E		rts
ENDIF

IF HD_SCSI2
.HD_InitDetect
		sec
		bcs	HD_InitDetect2
.HD_InitDetectBoot
		clc	
.HD_InitDetect2
		jsr	scsi2_init2
		bne	L9A7E
		bcs	L9A7E
		php
		sei					; disable interrupts as the reset will generate one!
		ldx	#$80
		stx	SCSI2_INIT_CMD_1
		ldx	#0
		stx	SCSI2_INIT_CMD_1
		stx	SCSI2_TARGET_CMD_3
		stx	SCSI2_SELECT_ENABLE_4
;		txa
		bit	SCSI2_IRQRESET			
		plp
		rts

.scsi2_init2
		lda	#0
		jsr	L9A75
		bne	L9A7E
		lda	#S2_MODE_PARCHECK
.L9A75		sta	SCSI2_MODE_2
		cmp	SCSI2_MODE_2
.L9A7E		rts
ENDIF


IF TARGETOS > 1
;;
;;
.L9A7F		lda	#&A1				; Read CMOS
		ldx	#&0B				; Location 11 - ADFS settings
		jsr	OSBYTE				; Read CMOS byte
		tya					; Transfer CMOS byte to A
		rts
;;
;; ADFS CMOS byte
;; --------------
;; b7    Floppy/Hard
;; b6    NoDir/Dir
;; b5    (Caps)
;; b4    (NoCaps)
;; b3    (ShCaps)
;; b2-b0 FDrive
;;
;;
.L9A88		lda	#&FD
		jsr	L84C4				; Read BREAK type
		txa
		rts

ENDIF

;;
;; Boot command offset bytes
;; -------------------------
.L9A8F		EQUB	<L9A92				; Option 1 at L9A92
		EQUB	<L9A94				; Option 2 at L9A94
		EQUB	<L9A9C				; Option 3 at L9A9C
;;
;; Boot commands - these must be within the same page
;; --------------------------------------------------
.L9A92		EQUS	"L."				; Start of *Load option
.L9A94		EQUS	"$.!BOOT"			; *Run option and end of *Load option
		EQUB	&0D
.L9A9C
IF TARGETOS > 1
		EQUS	"E.-ADFS-$.!BOOT"		; *Exec option
ELSE
		EQUS	"E.$.!BOOT"			; *Exec option
ENDIF
		EQUB	&0D
IF (L9A92 AND &FF00)<>(L9A9C AND &FF00)
		error	"Boot strings run over page boundary"
ENDIF
;;
;;
;; SERVICE CALL HANDLERS
;; =====================
;;
;; The following tables hold addresses pushed onto the stack to call
;; service routines. Consequently, they are one byte less than the
;; actual routine addresses as the RTS opcode increments the address
;; popped from the stack
;;
;; Low service call routines address-1 low bytes
;; ---------------------------------------------
.L9AAC		EQUB	<(Serv0-1)			; Serv0 - L9AD5 - Null
IF TARGETOS > 1
		EQUB	<(Serv0-1)			; Serv1 - L9AD5 - Null
ELSE
		EQUB	<(Serv1-1)			; Serv1 - L9AD5 - Null
ENDIF
		EQUB	<(Serv2-1)			; Serv2 - L9AFF - Low w/s
		EQUB	<(Serv3-1)			; Serv3 - L9B54 - Boot FS
		EQUB	<(Serv4-1)			; Serv4 - L9D23 - Commands
		EQUB	<(Svc5_IRQ-1)			; Serv5 - Svc5_IRQ - Interrupt
		EQUB	<(Serv0-1)			; Serv6 - L9AD5 - Null
		EQUB	<(Serv0-1)			; Serv7 - L9AD5 - Null
		EQUB	<(Serv8-1)			; Serv8 - L9D5E - Osword
		EQUB	<(Serv9-1)			; Serv9 - L9E0D - Help
;;
;; Low service call routines address-1 high bytes
;; ----------------------------------------------
.L9AB6		EQUB	>(Serv0-1)
IF TARGETOS > 1
		EQUB	>(Serv0-1)
ELSE
		EQUB	>(Serv1-1)
ENDIF
		EQUB	>(Serv2-1)
		EQUB	>(Serv3-1)
		EQUB	>(Serv4-1)
		EQUB	>(Svc5_IRQ-1)
		EQUB	>(Serv0-1)
		EQUB	>(Serv0-1)
		EQUB	>(Serv8-1)
		EQUB	>(Serv9-1)

IF TARGETOS > 1

;;
;; High service call routines address-1 low bytes
;; ----------------------------------------------
.L9AC0		EQUB	<(Serv21-1)			; Serv21 - Serv21 - High abs
		EQUB	<(Serv22-1)			; Serv22 - Serv22 - High w/s
		EQUB	<(Serv0-1)			; Serv23 - Serv0 - Null
		EQUB	<(Serv24-1)			; Serv24 - Serv24 - Hazel count
		EQUB	<(Serv25-1)			; Serv25 - Serv25 - FS Info
		EQUB	<(Serv26-1)			; Serv26 - Serv26 - *SHUT
		EQUB	<(Serv0-1)			; Serv27 - Serv0 - Null
;;
;; High service call routines address-1 high bytes
;; -----------------------------------------------
.L9AC7		EQUB	>(Serv21-1)
		EQUB	>(Serv22-1)
		EQUB	>(Serv0-1)
		EQUB	>(Serv24-1)
		EQUB	>(Serv25-1)
		EQUB	>(Serv26-1)
		EQUB	>(Serv0-1)

ELSE
.L9AC0
.L9AC7
							;TODO: not sure here


ENDIF

;;
;; SERVICE CALL HANDLER
;; ====================
;;
.ServiceCallHandlerL9ACE

IF TARGETOS > 1
		bit	&0DF0,X				; Check ROM w/s byte
		bpl	L9AD6				; &00-&7F -> Check bit6
		bvs	L9AD8				; &C0-&FF -> ROM enabled
;;
;; Service quit - jump here with calls not used
;; --------------------------------------------
.Serv0		rts					; &80-&BF -> ROM disabled
.L9AD6		bvs	Serv0				; &40-&7F -> ROM disabled
ELSE
		pha
		cmp	#$01
		bne	_lbbc9AB0
		lda	&0DF0,X
		and	#$BF
		sta	&0DF0,X
._lbbc9AB0
		lda	&0DF0,X
		cmp	#$40
		bcc	_lbbc9AB9
		pla
.Serv0
		rts

._lbbc9AB9
		pla
ENDIF

;;
;; Workspace is allowed to be at &00xx-&3Fxx or &C0xx-&FFxx. If the
;; ROM workspace byte is set to %01xxxxxx or %10xxxxxx, implying
;; workspace somewhere in &40xx-&BFxx, then the ROM is disabled.
;;
.L9AD8		cmp	#&12				; Select filing system?
IF TARGETOS = 0 AND HD_SCSI
		bne	_elkL9AC4
		jmp	L9B4C
._elkL9AC4
ELSE
		beq	L9B4C				; Jump to check FS
ENDIF
		cmp	#&0A				; Service call 10 or higher?
IF TARGETOS > 1
		bcs	L9AED				; Jump forward with higher calls
ELSE
		bcs	Serv0
ENDIF
		tax					; Pass service number into X
		lda	L9AB6,X				; Index into address table
		pha					; Push service routine address
		lda	L9AAC,X				; onto stack
.L9AE8		pha
		txa					; Pass service number back into A
		ldx	ZP_MOS_CURROM			; Get ROM number back into X
		rts					; Jump to service routine

IF TARGETOS > 1
;;
;; Service calls &21 to &27
;; ------------------------
.L9AED		cmp	#&21				; Check against the lowest value
		bcc	Serv0				; Quit with calls <&21
		cmp	#&28
		bcs	Serv0				; Quit with calls >&27
		tax					; Pass service call into X
		lda	L9AC7-&21,X			; Index into address table
		pha					; Push service routine address
		lda	L9AC0-&21,X			; onto stack
		bra	L9AE8				; Jump back to jump to service routine
ENDIF

IF TARGETOS <= 1
;;
;;
;; Serv1 - Low workspace claim
;; ===========================
;; If insufficient workspace was available in high memory, ADFS claims
;; a page of workspace from low memory. ADFS also does some initialisation
;; on this call.
;;
.Serv1
IF FLOPPY
		jsr	floppy_check_present_bbc
ENDIF
		inx
		bpl	Serv1
		bcc	_lbbc9AE6
		jsr	HD_InitDetectBoot
		beq	_lbbc9AE6
		lda	#&40
		ldx	ZP_MOS_CURROM
		sta	&0DF0,X
		lda	#$01
		rts
._lbbc9AE6
		lda	#$01
		ldx	$F4
		cpy	#$1C
		bcs	_lbbc9AF0
		ldy	#$1C
._lbbc9AF0
		rts
ENDIF

;;
;;
;; Serv2 - Low workspace claim
;; ===========================
;; If insufficient workspace was available in high memory, ADFS claims
;; a page of workspace from low memory. ADFS also does some initialisation
;; on this call.
;;
.Serv2
IF TARGETOS > 1
		lda	&0DF0,X				; Get workspace pointer
		cmp	#&DC				; Is it set to <&DC00?
		bcc	L9B0A				; Use existing value if it is
		tya
		sta	&0DF0,X				; Use low workspace
.L9B0A
IF USE65C12
		phy					; Save current pointer
ELSE
		tya
		pha
ENDIF
;;
;; Now do some initialisation. Look for a hard drive.
;;
IF PRESERVE_CONTEXT
		jsr	ReadBreak
ELSE
		jsr	L9A88				; Read BREAK type
ENDIF
ELSE ; TARGETOS <= 1
							;new BBC
		tya
		sta	$0DF0, X
		pha
IF PRESERVE_CONTEXT AND TARGETOS > 0
		jsr	ReadBreak
ELSE
		lda	$028D				; TODO Ask JGH : should this not be ReadBreak?
ENDIF ; TARGETOS
ENDIF ; TARGETOS


		beq	L9B3B				; Soft BREAK, jump ahead
		jsr	GetWkspAddr_BA			; Find workspace
		tay					; Y=0
.L9B14		lda	L9A4F,Y				; Initialise workspace
		cpy	#&1D				; First 29 bytes set to dir="$",
		bcc	L9B1D				; lib="$", csd=2, lib=2, back=2.
		lda	#&00				; Rest of workspace set to zero
.L9B1D		sta	(&BA),Y				; Store byte into workspace
		iny
		bne	L9B14				; Loop for all workspace
IF TARGETOS > 1
		jsr	HD_InitDetectBoot		; Check if hard drive present
		bne	L9B38				; Not present, jump ahead
		jsr	L9A7F				; Read Config HARD/FLOPPY setting
		and	#&80				; Keep bit 7
		ldy	#&17
		sta	(&BA),Y				; Set w/s byte &17
		ldy	#&1B
		sta	(&BA),Y				; Set w/s byte &1B
		ldy	#&1F
		sta	(&BA),Y				; Set w/s byte &1F
ENDIF
.L9B38		jsr	StoreWkspChecksumBA_Y		; Set workspace checksum
._lbbc9B10

.L9B3B
IF TARGETOS = 0 AND HD_SCSI
		jsr	CalcWkspChecksum
ELSE
		jsr	CheckWkspChecksum		; Check workspace checksum
ENDIF
;;

IF TARGETOS <= 1
IF TARGETOS = 0 AND HD_SCSI
		cmp     ($BA),y                         ; 9B19 D1 BA                    ..
        	beq     _elkL9B23                       ; 9B1B F0 06                    ..
        	tya                                     ; 9B1D 98                       .
        	sta     $0DF0,x                         ; 9B1E 9D F0 0D                 ...
        	bne     _elkL9B40                       ; 9B21 D0 1D                    ..
._elkL9B23:  	
ENDIF

		iny					; 9B13 C8                       .
		lda	($BA),y				; 9B14 B1 BA                    ..
		cmp	#$FF				; 9B16 C9 FF                    ..
		bne	_lbbc9B22			; 9B18 D0 08                    ..
		ror	ZP_ADFS_FLAGS			; clear ADFS_FLAGS_ENSURING
		clc
		rol	ZP_ADFS_FLAGS
		jsr	FSC6_NEWFS			; 9B1F 20 3C A9                  <.
._lbbc9B22
		ldx	#$00				; 9B22 A2 00                    ..
		lda	#$15				; 9B24 A9 15                    ..
		jsr	OSBYTE				; 9B26 20 F4 FF                  ..
		lda	#$8A				; 9B29 A9 8A                    ..
		ldy	#$CA				; 9B2B A0 CA                    ..
		jsr	OSBYTE
._elkL9B40


ENDIF	; TARGETOS = 0

IF USE65C12
		ply					; Get pointer back
ELSE
		pla
		tay
ENDIF
		ldx	ZP_MOS_CURROM				; Get ROM number back into X
IF TARGETOS > 1
		bit	&0DF0,X				; Check w/s pointer
		bmi	L9B47				; Exit if using high workspace
ENDIF
		iny					; Claim one page of low workspace
.L9B47		lda	#&02				; Restore A to &02
.L9B49		rts



IF TARGETOS > 1
;;
;;
;; Select ADFS
;; ===========
.L9B4A		ldy	#&08				; Y=8 to select ADFS
ENDIF
;;
;;
;; Serv12 - Select filing system
;; =============================
.L9B4C		cpy	#&08
		bne	L9B49				; No, quit
.L9B50
IF USE65C12
		phy
		phy
		bra	L9B94
ELSE
		tya
		pha
		pha
		bne	L9B94
ENDIF
;;
;;
;; Serv3 - Boot filing system
;; ==========================
.Serv3
IF USE65C12 AND OPTIMISE > 1
		phy
ELSE
		tya
		pha					; Save Boot flag
ENDIF
		lda	#&7A
		jsr	OSBYTE				; Scan keyboard
		inx					; No key pressed?



IF TARGETOS > 1
		beq	L9B74				; Yes, jump to select FS
		dex
;;
ELSE	; TARGETOS = 1
		bne	_lbbc9B57			; 9B49 D0 0C                    ..
		jsr	HD_InitDetectBoot		; 9B4B 20 63 9A                  c.
		beq	L9B74				; 9B4E F0 1E                    ..
IF (HD_IDE OR HD_MMC) AND TARGETOS > 0			; TODO should this not be readbreak for Elk too?
		jsr	ReadBreak
ELSE
		lda	$028D				; 9B50 AD 8D 02                 ...
ENDIF
		beq	L9B74
		ldx	#&44
._lbbc9B57
		dex					; 9B57 CA                       .
ENDIF							; TARGETOS


IF NOT(TRIM_REDUNDANT)
		cpx	#&79				; '->' pressed?
		beq	L9B74				; Yes
ENDIF
		cpx	#&41				; 'A' pressed?
		beq	L9B74				; Yes
		cpx	#&43				; 'F' pressed?
		beq	L9B72				; Yes, jump to select FS
IF USE65C12 AND OPTIMISE > 1
		ply
ELSE
		pla
		tay					; Restore Boot flag
ENDIF
		ldx	ZP_MOS_CURROM				; Restore ROM number
		lda	#&03				; Restore A=FSBoot
		rts					; Return unclaimed


.L9B72		pla					; Replace boot flag with 'F'-Break
IF USE65C12
		phx					; ...flag to prevent booting
ELSE
		txa
		pha					; ...flag to prevent booting
ENDIF
.L9B74		cli					; Enable IRQs
IF USE65C12
		phx					; Save keycode
ELSE
		txa
		pha					; Save keycode
ENDIF
;;
;; Stack now holds:
;;   top-1: Key pressed, &FF=none, &41='A', &43='F', &79='->'
;;   top-2: Boot flag, &00=boot, <>&00=no boot
;;
IF TARGETOS > 1
		jsr	L9A7F				; Read CMOS settings
		asl	A				; Move NoDir/Dir into bit7
		bpl	L9B85				; Jump forward with NoDir
IF PRESERVE_CONTEXT
		jsr	ReadBreak
ELSE
		jsr	L9A88				; Read BREAK type
ENDIF
		beq	L9B85				; Jump forward if soft BREAK
		pla					; With Hard BREAK and power on
		lda	#&43				; ...change key pressed to 'fadfs'
		pha
ELSE							; TARGETOS <=1
		ldy	#$00				; 9B71 A0 00                    ..
		lda	#$78				; 9B73 A9 78                    .x
		jsr	OSBYTE

ENDIF							; TARGETOS
.L9B85		jsr	L92A8				; Print FS banner
		EQUS	"Acorn ADFS", &0D, &8D
;;
;; Select ADFS
;; ===========
;; Stack now holds:
;;   top-1: Key pressed, &FF=none or *adfs, &41='A', &43='F' or *fadfs or
;;			  Serv08+Dir+Hard/PowerBreak, &79='->', &00/&08=Serv12
;;   top-2: Boot flag, &00=boot, <>&00=no boot
;;
.L9B94		lda	#&06
		jsr	L9A4C				; Tell current FS new FS taking over
IF TARGETOS <= 1
		lda	#&8F
		ldx	#&0A
		ldy	#&FF
		jsr	OSBYTE
ENDIF
		lda	#&10
		sta	WKSP_ADFS_200
IF TARGETOS > 1
		stz	WKSP_ADFS_2D7_SHADOW_SAVE
		jsr	L9A7F				; Get ADFS CMOS byte
		sta	WKSP_ADFS_2D8			; Store in workspace
ELSE
							;TODO: ???
ENDIF
		ldy	#&0D				; Initialise vectors
.L9BA9		lda	L9CB6,Y
		sta	&0212,Y
		dey
		bpl	L9BA9
		lda	#&A8
		jsr	L84C4				; Find extended vector table
		stx	&B4
		sty	&B5
		ldy	#&2F
		ldx	#&14
.L9BBF		lda	L9CC4,X				; Initialise extended vectors
		cmp	#&FF
		bne	L9BC8
		lda	ZP_MOS_CURROM
.L9BC8		sta	(&B4),Y
		dey
		dex
		bpl	L9BBF
		lda	#&8F
		ldx	#&0F
		ldy	#&FF
		jsr	OSBYTE				; Claim Vectors
		jsr	LBA57				; Set a flag
		jsr	CheckWkspChecksum		; Check workspace checksum

IF USE65C12
		stz	WKSP_ADFS_208
		stz	WKSP_ADFS_20C
		stz	WKSP_ADFS_210
		stz	WKSP_ADFS_214
		lda	#&01
		sta	WKSP_ADFS_204
ELSE
		ldx	#0
		stx	WKSP_ADFS_208
		stx	WKSP_ADFS_20C
		stx	WKSP_ADFS_210
		stx	WKSP_ADFS_214
		inx
		stx	WKSP_ADFS_204
ENDIF
		ldy	#&FB				; Copy workspace to &C300
.L9BF0		lda	(&BA),Y
		sta	WKSP_ADFS_300_CSDNAME,Y
		dey
		bne	L9BF0				; Loop for 252 bytes
		lda	(&BA),Y				; Do zeroth byte
		sta	WKSP_ADFS_300_CSDNAME,Y
		lda	WKSP_ADFS_320_FLAGS_SAVE	; Get *OPT1 setting
		and	#ADFS_FLAGS_OPT1
		sta	ZP_ADFS_FLAGS			; Put into &CD
		jsr	LA7D4				; Check some settings
		jsr	HD_InitDetect			; Check if hard drive hardware present
		bne	L9C10				; No hard drive, jump forward

IF USE65C12
		lda	#ADFS_FLAGS_HD_PRESENT
		tsb	ZP_ADFS_FLAGS			; Signal hard drive present
ELSE
		lda	ZP_ADFS_FLAGS
		ora	#ADFS_FLAGS_HD_PRESENT
		sta	ZP_ADFS_FLAGS
ENDIF
.L9C10
IF TARGETOS <= 1
		dey
		tya
		sta	(&BA),Y
ENDIF

		pla					; Get selection flag from stack
		cmp	#&43				; '*fadfs'/F-Break type of selection?
		bne	L9C18				; No, jump to keep context
		jsr	InvalidateFSMandDIR				; Set context to &FFFFFFFF when *fadfs
.L9C18		ldy	#&03				; Copy current context to backup context
.L9C1A		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	L9C1A
		jsr	L89D8				; Get FSM and root from :0 if context<>-1
		ldx	WKSP_ADFS_317_CURDRV			; Get current drive
		inx					; If &FF, no directory loaded
		beq	L9C7D				; No drive (eg *fadfs), jump ahead
		jsr	LB4CD
IF PRESERVE_CONTEXT
		lda	WKSP_ADFS_31B			; Lib not unset, jump ahead
IF TARGETOS = 0		
		clc					; TODO: Ask JGH - I can't see the purpose of this? Am I missing somthing subtle with carry flag?
		adc	#1
ELSE
		cmp	#&FF
ENDIF ; TARGETOS >= 1
		bne	L9C7A
		lda	ZP_ADFS_FLAGS			; If HD, look for $.Library
;;	AND #(ADFS_FLAGS_HD_PRESENT + ADFS_FLAGS_FSM_INCONSISTENT + ADFS_FLAGS_FSM_BAD) ;; TODO: ASK JGH why? not same as in original
		and	#ADFS_FLAGS_HD_PRESENT
		beq	L9C7A
		bne	L9C41
IF NOT(TRIM_REDUNDANT)
;       EQUB &41		; leftover bytes
;       EQUB &1B		; leftover bytes
;       EQUB ZP_ADFS_C3_SAVE_X
;       BNE L9C7A        ; leftover bytes
IF TARGETOS = 0
		rts
		rts
ELSE
		EQUB	0,0,0

ENDIF
ENDIF
ELSE
		lda	WKSP_ADFS_318			; Is LIB set to ":0.$"?
		cmp	#&02
		bne	L9C7A
		lda	WKSP_ADFS_319
		ora	WKSP_ADFS_31A
		ora	WKSP_ADFS_31B
		bne	L9C7A				; No, don't look for Library
ENDIF
.L9C41		lda	#<L9CAE
		sta	&B4
		lda	#>L9CAE
		sta	&B5				; Point to ":0.LIB*"
		jsr	L8FE8				; Search for it
		bne	L9C7A				; Not found, skip
.L9C4E		ldy	#&03
		lda	(&B6),Y				; Check 'D' bit
		bmi	L9C5B				; Directory, set LIB to it
		jsr	L8964				; Step to next entry
		bne	L9C7A				; No more 'LIB*' entries, skip
		beq	L9C4E				; Loop back to see if this is a directory
.L9C5B		ldx	#&02
		ldy	#&18
.L9C5F		lda	(&B6),Y				; Copy this entry's SECT to LIB
		sta	WKSP_ADFS_318,X
		dey
		dex
		bpl	L9C5F
		lda	WKSP_ADFS_317_CURDRV
		sta	WKSP_ADFS_31B
		ldy	#&09
.L9C70		lda	(&B6),Y				; Copy directory's name to LIBNAME
		and	#&7F
		sta	WKSP_ADFS_30A_LIBNAME,Y
		dey
		bpl	L9C70
.L9C7A		jsr	L89D8
.L9C7D		lda	#&EA
		jsr	L84C4

IF USE65C12
		lda	#ADFS_FLAGS_TUBE_PRESENT
		trb	ZP_ADFS_FLAGS
		inx
		bne	L9C8B
		tsb	ZP_ADFS_FLAGS
.L9C8B
ELSE
		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_TUBE_PRESENT EOR &FF
		inx
		bne	L9C8B
		ora	#ADFS_FLAGS_TUBE_PRESENT
.L9C8B		sta	ZP_ADFS_FLAGS
ENDIF
		pla					; Get boot flag
		pha
		bne	restoreROMandY_A0rts		; No boot, jump forward
		ldx	WKSP_ADFS_317_CURDRV			; Get current drive
		inx					; If &FF, no directory loaded
		bne	L9C9B
		stx	WKSP_ADFS_26F
		jsr	LA1A1
.L9C9B		ldy	WKSP_ADFS_100_FSM_S1 + &FD	; Get boot option
		beq	restoreROMandY_A0rts				; Zero, jump to finish
		ldx	L9A8F-1,Y			; Get low byte of boot command address
		ldy	#>L9A8F				; Get high byte of boot command address
		jsr	OSCLI				; Do *Load/*Run/*Exec
.restoreROMandY_A0rts					; L9CA8	
		ldx	ZP_MOS_CURROM			; Restore ROM number
IF USE65C12
		ply					; Rebalance stack
ELSE
		pla
		tay
ENDIF
		lda	#&00				; Claim the call
		rts
;;
.L9CAE		EQUS	":0.LIB*", &0D
;;
;;
;; Vector Table
;; ============
.L9CB6		EQUW	&FF1B
		EQUW	&FF1E
		EQUW	&FF21
		EQUW	&FF24
		EQUW	&FF27
		EQUW	&FF2A
		EQUW	&FF2D
;;
;; Extended Vector Table
;; =====================
.L9CC4		EQUW	my_OSFILE:EQUB &FF		; OSFILE
		EQUW	my_OSARGS:EQUB &FF		; OSARGS
		EQUW	my_OSBGET:EQUB &FF		; OSBGET
		EQUW	my_OSBPUT:EQUB &FF		; OSBPUT
		EQUW	my_OSGBPB:EQUB &FF		; OSGBPB
		EQUW	my_OSFIND:EQUB &FF		; OSFIND
		EQUW	my_FSCV:EQUB &FF		; FSCV

IF TARGETOS > 1

;;
;;
;; Serv21 - Claim High Absolute Workspace
;; ======================================
.Serv21		cpy	#&CE				; ADFS needs up to &CE00-1
		bcs	L9CDF				; Exit if Y>&CE
		ldy	#&CE				; ADFS needs up to &CE00-1
.L9CDF		rts
;;
;; Serv22 - Claim High Private Workspace
;; =====================================
.Serv22		tya					; Pass w/s pointer to A
		sta	&0DF0,X				; Store in w/s byte
		lda	#&22				; Restore A to &22
		iny					; ADFS needs one page
		rts
;;
;; Serv24 - State how much high workspace needed
;; =============================================
.Serv24		dey					; ADFS needs one page
		rts
;;
;; Serv25 - Return filing system information
;; =========================================
.Serv25		ldx	#&0A
.L9CEC		lda	L9CFA,X				; Copy information
		sta	(&F2),Y
		iny
		dex
		bpl	L9CEC
		lda	#&25				; Restore A to &25
.L9CF7		ldx	ZP_MOS_CURROM				; Get ROM number back to X
		rts

;;
;; Filing system information
;; -------------------------
.L9CFA		EQUB	ADFS_FS_NO			; Filing system number
		EQUB	CHANNEL_RANGE_HI		; Highest handle used
		EQUB	CHANNEL_RANGE_LO		; Lowest handle used
		EQUS	"    "

ENDIF

.str_SFDA		
		EQUS	"sfda"				; "adfs" filing system name
IF TARGETOS > 1
;;
;; Serv26 - *SHUT
;; ==============
.Serv26
IF USE65C12
		phy
ELSE
		tya
		pha
ENDIF
		jsr	GetWkspAddr_BA
		ldy	#&AC
		ldx	#&09
		lda	#&00
.L9D0F		ora	(&BA),Y
		iny
		dex
		bpl	L9D0F
		tax
		beq	L9D1E
		jsr	L9B4A
		jsr	starCLOSE
.L9D1E
IF USE65C12
		ply
ELSE
		pla
		tay
ENDIF
		lda	#&26
IF USE65C12
		bra	L9CF7
ELSE
		bne	L9CF7
ENDIF

ENDIF
;;
;; Serv04 - *Commands
;; ==================
.Serv4
IF USE65C12
		phy					; Save command pointer
ELSE
		tya
		pha					; Save command pointer
ENDIF
		lda	#&FF				; Flag not '*fadfs'
		pha
		lda	(&F2),Y				; Get first character
		ora	#&20				; Force to lower case
		cmp	#&66				; Is it 'f' of 'fadfs'?
		bne	L9D34				; No, jump past
		pla					; Lose previous flag
		lda	#&43				; Change flags to indicate '*fadfs'
		pha
		iny					; Point to next character
.L9D34		ldx	#&03				; 'adfs' is 3+1 characters
.L9D36		lda	(&F2),Y				; Get character
		iny					; Move to next
		cmp	#&2E				; Is it '.'?
		beq	L9D47				; Jump to match abbreviated command
		ora	#&20				; Force to lower case
		cmp	str_SFDA,X				; Compare with 'adfs' in FSInfo block
		bne	L9D57				; No match, abandon scanning
		dex					; Decrease length/pointer
		bpl	L9D36				; Loop for all four characters
.L9D47		lda	(&F2),Y				; Get next character
		iny					; Move to next character
		cmp	#&20				; Check if it was a space
		beq	L9D47				; Loop to skip spaces
		bcs	L9D57				; Non-space found, jump to abandon
IF USE65C12
		plx					; Get adfs/fadfs flag back
		pla					; Get command pointer back
		phx					; Add extra byte to stack
		phx					; Save adfs/fadfs flag
ELSE
		pla					; TODO: check !!!!
		tax
		pla
		txa
		pha
		pha
ENDIF
		jmp	L9B94				; Jump to select FS 8
;;
;; Not *fadfs/*adfs or command has extra characters after it
;; ---------------------------------------------------------
.L9D57		pla					; Drop fadfs/adfs flag

IF USE65C12
		ply					; Get command pointer back
ELSE
		pla					; Get command pointer back
		tay
ENDIF
		lda	#&04				; Restore A to '*Command'
		ldx	ZP_MOS_CURROM				; Restore ROM number
		rts					; Exit
;;
;;
;; Serv8 - OSWORD calls
;; ====================
.Serv8
IF USE65C12
		phy					; Save Y
ELSE
		tya
		pha					; Save Y
ENDIF
IF TARGETOS > 1						; ; TODO this removed to make adfs130 identical - put it back?
		lda	&EF				; Get OSWORD number
		cmp	#&70
		bcc	L9DBA				; If <&70, exit unclaimed
		cmp	#&74
		bcs	L9DBA				; If >&73, exit unclaimed
ENDIF
;;
;; The following code is VERY annoying, as it means that if you call the
;; sector access calls with another filing system selected, ADFS selects
;; itself as the current filing system, thereby trampling all over any
;; memory you may be using.
;;
		lda	#&00
		tay
		jsr	OSARGS				; Get current filing system
		cmp	#&08				; Is is ADFS?
IF TARGETOS > 1						
		beq	L9D76				; Yes, jump to continue
		jsr	L9B4A				; Select ADFS if ADFS not selected
ELSE
		bne	L9DBA				; exit
ENDIF
.L9D76		lda	&EF				; Get OSWORD number
		cmp	#&72				; Is it &72?
		bne	L9DC0				; No, jump ahead
;;
;;
;; OSWORD &72 - SCSI API for Device Access (Sector Read/Write/Etc)
;; ===============================================================
		lda	&F0				; Copy block pointer to &BA/B
		sta	&BA
		lda	&F1
		sta	&BB
		ldy	#&0F				; Copy control block to &C215
.L9D86		lda	(&BA),Y
		sta	WKSP_ADFS_215_DSKOPSAV_RET,Y
		dey
		bpl	L9D86
;;
;; The control block is copied to ADFS filing system workspace:
;;    Addr Ctrl
;;   &C215  0  Returned result
;;   &C216  1  Addr0
;;   &C217  2  Addr1
;;   &C218  3  Addr2
;;   &C219  4  Addr3
;;   &C21A  5  Command
;;   &C21B  6  Drive+Sector b16-19
;;   &C21C  7  Sector b8-b15
;;   &C21D  8  Sector b0-b7
;;   &C21E  9  Sector Count
;;   &C21F 10  -
;;   &C220 11  Length0
;;   &C221 12  Length1
;;   &C222 13  Length2
;;   &C223 14  Length3
;;   &C224 15
;;
		lda	WKSP_ADFS_21A_DSKOPSAV_CMD			; Get command
		and	#&FD				; Mask out bit 1
		cmp	#&08				; Is it &08 or &0A, Read or Write?
		beq	L9DA8				; Jump forward with Read and Write
;;
.L9D97		ldx	#<WKSP_ADFS_215_DSKOPSAV_RET
		ldy	#>WKSP_ADFS_215_DSKOPSAV_RET
		inc	WKSP_ADFS_317_CURDRV		; Increment current drive
		beq	L9DA3				; EQ, drive=&FF, nothing mounted
		dec	WKSP_ADFS_317_CURDRV		; Restore current drive
.L9DA3		jsr	CommandExecXY
		bpl	L9DB0				; Jump to exit
;;
.L9DA8		lda	WKSP_ADFS_21E_DSKOPSAV_SECCNT			; Get Sector Count
		bne	L9D97				; If not zero jump back to use it
		jsr	L8A4A				; Do the SCSI call
;;
;; Store result value and claim call
;; ---------------------------------
.L9DB0
IF USE65C12 AND OPTIMISE >= 1
		sta	(&BA)				; Store result in control block
ELSE
		ldy	#&00				; Point to result byte
		sta	(&BA),Y				; Store result in control block
ENDIF
IF OPTIMISE<2
; Claim OSWORD service call
; -------------------------
.L9DB4		ldx	ZP_MOS_CURROM				; Restore ROM number to X
IF USE65C12
		ply					; Restore Y
ELSE
		pla					; Restore Y
		tay
ENDIF
		lda	#&00				; A=0 to claim OSWORD
		rts

; Exit from OSWORD service call
; -----------------------------
.L9DBA		ldx	ZP_MOS_CURROM				; Restore ROM number to X
IF USE65C12
		ply					; Restore Y
ELSE
		pla					; Restore Y
		tay
ENDIF
		lda	#&08				; A=8 to exit with OSWORD unclaimed
		rts
ELSE
; Claim OSWORD service call
; -------------------------
.L9DB4		lda	#&00				; A=0 to claim OSWORD
		beq	L9DBC

; Exit from OSWORD service call
; -----------------------------
.L9DBA		lda	#&08				; A=8 to exit with OSWORD unclaimed
.L9DBC		ldx	ZP_MOS_CURROM				; Restore ROM number to X
IF USE65C12
		ply					; Restore Y
ELSE
		pla					; Restore Y
		tay
ENDIF
		rts
ENDIF

.L9DC0		cmp	#&73
		bne	L9DD0
		ldy	#&04
.L9DC6		lda	WKSP_ADFS_2D0_ERR_SECTOR,Y
		sta	(&F0),Y
		dey
		bpl	L9DC6
		bmi	L9DB4
.L9DD0		cmp	#&70
		bne	L9DE3
		lda	WKSP_ADFS_800_DIR_BUFFER + &FA
		ldy	#&00
		sta	(&F0),Y
		lda	ZP_ADFS_FLAGS
		iny
		sta	(&F0),Y
IF USE65C12 AND OPTIMISE >= 1
		bra	L9DB4
ELSE
		jmp	L9DB4
ENDIF
;;
.L9DE3		cmp	#&71
		bne	L9DBA
		jsr	LA1EA
		ldy	#&03
.L9DEC		lda	WKSP_ADFS_215_DSKOPSAV_RET,Y
		sta	(&F0),Y
		dey
		bpl	L9DEC
IF USE65C12
		bra	L9DB4
ELSE
		bmi	L9DB4
ENDIF
;;
.L9DF6		jsr	L92A8
IF OPTIMISE<6 AND NOT(HD_IDE AND TARGETOS = 1)
		EQUS	&0D, "Advanced DFS "		; Help string
ELSE
		EQUS	&0D, "Acorn ADFS "		; Help string
ENDIF
		EQUB	(VERSION DIV 256)+48		; Version string
		EQUB	"."
		EQUB	((VERSION AND &F0) DIV 16)+48
		EQUB	(VERSION AND &0F)+48
IF HD_IDE AND TARGETOS = 1
		EQUB	"r23"
ENDIF
		EQUB	&8D
		rts
.Serv9

IF USE65C12 AND OPTIMISE > 1
		phy
ELSE
		tya
		pha
ENDIF
IF HD_IDE AND TARGETOS = 1
		jsr	GetChar
ELSE
		lda	(&F2),Y
		cmp	#&20
ENDIF
		bcs	L9E3E
		jsr	L9DF6
		jsr	L92A8



		EQUS	"  ADFS", &8D
.L9E22
IF USE65C12 AND OPTIMISE > 1
		ply
ELSE
		pla
		tay
ENDIF
		ldx	ZP_MOS_CURROM
		lda	#&09
.L9E28		rts
;;
.L9E29		iny
		lda	(&F2),Y
		cmp	#&20
		bcs	L9E28
		pla
		pla
		bcc	L9E22
.L9E34		jsr	L9E29
		bne	L9E34
.L9E39		jsr	L9E29
		beq	L9E39
.L9E3E		ldx	#&03
.L9E40		lda	(&F2),Y
		cmp	#&2E
		beq	L9E57
		ora	#&20
		cmp	str_SFDA,X
		bne	L9E34
		iny
		dex
		bpl	L9E40
		lda	(&F2),Y
		cmp	#&21
		bcs	L9E34
.L9E57		jsr	L9DF6
		ldx	#&00
.L9E5C		lda	tbl_commands,X
		bmi	L9E22
		jsr	L92A8
		EQUB	&20, &A0			; Two spaces
		ldy	#&09
.L9E68		lda	tbl_commands,X			; Get character from command table
		bmi	L9E74
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSASCI
ENDIF
		inx
		dey
		bpl	L9E68
.L9E74		jsr	LA036
		dey
		bpl	L9E74

IF USE65C12
		phx
ELSE
		txa
		pha
ENDIF
		lda	tbl_commands+2,X
		pha
		lsr	A
		lsr	A
		lsr	A
		lsr	A
		jsr	L9283
		pla
		and	#&0F
		jsr	L9283
IF TARGETOS > 1
		jsr	LA03A
ELSE
		jsr	OSNEWL
ENDIF
IF USE65C12
		plx
ELSE
		pla
		tax
ENDIF
		inx
		inx
		inx
IF USE65C12
		bra	L9E5C
ELSE
		bne	L9E5C				; TODO: check
ENDIF
;;
;; Low byte of address of help strings
;; -----------------------------------
.L9E95		EQUB	<L9FFB
		EQUB	<L9FB1
		EQUB	<L9FBD
		EQUB	<L9FC7
		EQUB	<L9FD3
		EQUB	<L9FDD
		EQUB	<L9FE7
		EQUB	<L9FF4

;;
;;
;; FSC - Filing System Control
;; ===========================
.my_FSCV		stx	&B4				; Store X and Y in &B4/5
		sty	&B5
IF TARGETOS > 1
		sta	WKSP_ADFS_2D6			; Store function
ENDIF
		tax
		bmi	L9EBA				; Function<0 - exit
IF TARGETOS > 1
		cmp	#&0C
ELSE
		cmp	#&09
ENDIF
		bcs	L9EBA				; Function>11/9 - exit
IF USE65C12
		stz	WKSP_ADFS_2D5_CUR_CHANNEL			; Clear
ELSE
		lda	#0
		sta	WKSP_ADFS_2D5_CUR_CHANNEL			; Clear
ENDIF
		lda	L9EC7,X				; Push routine address onto stack
		pha
		lda	L9EBB,X
		pha
		ldx	&B4				; Retrieve X and Y
		ldy	&B5
.L9EBA		rts					; Jump to routine
;;
;; FSC Routine Low Bytes
;; ---------------------
.L9EBB		EQUB	<(LA001-1)			; *OPT
		EQUB	<(LAD49-1)			; =EOF
		EQUB	<(starRUN-1)			; */
		EQUB	<(L9ED3-1)			; *command
		EQUB	<(starRUN-1)			; *RUN
		EQUB	<(L93D5-1)			; *CAT
		EQUB	<(FSC6_NEWFS-1)			; NewFS taking over
		EQUB	<(L9FFC-1)			; File Handle Request
		EQUB	<(LA0DC-1)			; OSCLI being processed
IF TARGETOS > 1						; ; TODO BODGED FOR ADFS130
		EQUB	<(starEX-1)			; *EX
		EQUB	<(starINFO-1)			; *INFO
		EQUB	<(starRUN-1)			; *RUN from library
ENDIF
;;
;; FSC Routine High Bytes
;; ----------------------
.L9EC7		EQUB	>(LA001-1)
		EQUB	>(LAD49-1)
		EQUB	>(starRUN-1)
		EQUB	>(L9ED3-1)
		EQUB	>(starRUN-1)
		EQUB	>(L93D5-1)
		EQUB	>(FSC6_NEWFS-1)
		EQUB	>(L9FFC-1)
		EQUB	>(LA0DC-1)
IF TARGETOS > 1						; ; TODO BODGED FOR ADFS130
		EQUB	>(starEX-1)
		EQUB	>(starINFO-1)
		EQUB	>(starRUN-1)
ENDIF
;;
;; FSC 3 - *command
;; ================
.L9ED3		jsr	WaitEnsuring
		lda	#<WKSP_ADFS_2A2			; &B8/9=>&C2A2
		sta	&B8
		lda	#>WKSP_ADFS_2A2
		sta	&B9
		jsr	LA50D				; Skip spaces, etc
		ldx	#&FD				; Point to table start minus 3
.L9EE3		inx
		inx
		ldy	#&FF				; Point to text line minus 1
.L9EE7		inx
		iny
		lda	tbl_commands,X				; Get byte from command table
		bmi	L9F08				; End of entry
		cmp	(&B4),Y				; Compare with current character
		beq	L9EE7				; Jump with match
		ora	#&20				; Force to lower case
		cmp	(&B4),Y				; Compare again
		beq	L9EE7				; Jump with match
		dex
.L9EF9		inx					; Loop to end of entry
		lda	tbl_commands,X
		bpl	L9EF9
		lda	(&B4),Y				; Get current character
		cmp	#&2E				; Is it a '.'?
		bne	L9EE3				; No, jump to check next entry
		iny					; Move past '.'
		bne	L9F17				; Jump to update line pointer
.L9F08		tya					; Check line pointer
		beq	L9F24				; If zero, doesn't need updating
		lda	(&B4),Y				; Get terminating character
		and	#&5F				; Force to upper case
		cmp	#&41				; If more letters, jump to check again
		bcc	L9F17
		cmp	#&5B
		bcc	L9EE3
.L9F17		tya					; Update &B4/5 to point to params
		clc
		adc	&B4
		sta	&B4
		bcc	L9F21
		inc	&B5
.L9F21		jsr	LA50D				; Skip spaces, etc.
IF TARGETOS <= 1	;TODO: check is this necessary? not in newer os, +1 this seems to never get read?
		lda	&B4
		sta	WKSP_ADFS_2D6
		lda	&B5
		sta	WKSP_ADFS_2D7_SHADOW_SAVE
ENDIF
.L9F24		lda	tbl_commands+0,X		; Get command address
		pha					; Stack it
		lda	tbl_commands+1,X
		pha
		rts					; Jump indirectly to routine
;;
;;     Command	    Addr-1Hi    Addr-1Lo   Help
.tbl_commands
	EQUS	"ACCESS",   >(starACCESS-1)	, <(starACCESS-1)	, &16
	EQUS	"BACK",     >(starBACK-1)	, <(starBACK-1)		, &00
	EQUS	"BYE",      >(starBYE-1)	, <(starBYE-1)		, &00
	EQUS	"CDIR",     >(starCDIR-1)	, <(starCDIR-1)		, &20
IF TARGETOS <= 1		
	EQUS	"CLOSE",    >(starCLOSE-1)	, <(starCLOSE-1)	, &00
ENDIF
	EQUS	"COMPACT",  >(starCOMPACT-1)	, <(starCOMPACT-1)	, &50
	EQUS	"COPY",     >(starCOPY-1)	, <(starCOPY-1)		, &13
;; TODO: put back for SCSI2
IF TARGETOS <= 1 AND NOT(HD_SCSI2)
	EQUS	"DELETE",   >(starDELETE-1)	, <(starDELETE-1)	, &20
ENDIF
	EQUS	"DESTROY",  >(starDESTROY-1)	, <(starDESTROY-1)	, &10
	EQUS	"DIR",      >(starDIR-1)	, <(starDIR-1)		, &20
	EQUS	"DISMOUNT", >(starDISMOUNT-1)	, <(starDISMOUNT-1)	, &40
IF TARGETOS <= 1		
	EQUS	"EX",       >(starEX-1)		, <(starEX-1)		, &30
ENDIF
	EQUS	"FREE",     >(starFREE-1)	, <(starFREE-1)		, &00
IF TARGETOS <= 1		
	EQUS	"INFO",     >(starINFO-1)	, <(starINFO-1)		, &10
ENDIF
.cmdLC		
	EQUS	"LCAT",     >(starLCAT-1)	, <(starLCAT-1)		, &00
.cmdLE	
	EQUS	"LEX",      >(starLEX-1)	, <(starLEX-1)		, &00
	EQUS	"LIB",      >(starLIB-1)	, <(starLIB-1)		, &30
	EQUS	"MAP",      >(starMAP-1)	, <(starMAP-1)		, &00
IF PRESERVE_CONTEXT AND (HD_SCSI=0)
	EQUS	"MOUNT",    >(starMOUNTck-1)	, <(starMOUNTck-1)	, &40
ELSE
	EQUS	"MOUNT",    >(starMOUNT-1)	, <(starMOUNT-1)	, &40
ENDIF
;; TODO: put back for SCSI2
IF TARGETOS <= 1 AND NOT(HD_SCSI2)
	EQUS	"REMOVE",   >(starREMOVE-1)	, <(starREMOVE-1)	, &20
ENDIF
	EQUS	"RENAME",   >(starRENAME-1)	, <(starRENAME-1)	, &22
	EQUS	"TITLE",    >(starTITLE-1)	, <(starTITLE-1)	, &70
	EQUS	"",	    >(starRUN-1)	, <(starRUN-1)

; The next set of strings must not straddle a page boundary because
; code indexes into it with the MSB constant. See code at L9283
IF (P% AND &FF) > (256-&4B)
		print	"***WARNING: Help string table runs over page boundary"
;		ORG	(P% AND &FF00)+256
ENDIF
.L9FB1		EQUS	"<List Spec>"
		EQUB	&00
.L9FBD		EQUS	"<Ob Spec>"
		EQUB	&00
.L9FC7		EQUS	"<*Ob Spec*>"
		EQUB	&00
.L9FD3		EQUS	"(<Drive>)"
		EQUB	&00
.L9FDD		EQUS	"<SP> <LP>"
		EQUB	&00
.L9FE7		EQUS	"(L)(W)(R)(E)"
		EQUB	&00
.L9FF4		EQUS	"<Title>"
.L9FFB		EQUB	&00


; FSC 7 - Handle Request
; ======================
.L9FFC		ldx	#CHANNEL_RANGE_LO		; Lowest handle=&30
		ldy	#CHANNEL_RANGE_HI		; Highest handle=&39
		rts
;
; FSC 0 - *OPT
; ============
.LA001		ldx	&B4
		beq	LA00F
		dex
		bne	LA016
IF TARGETOS > 1
IF USE65C12
		lda	#ADFS_FLAGS_OPT1
		tsb	ZP_ADFS_FLAGS
ELSE
		lda	ZP_ADFS_FLAGS
		ora	#ADFS_FLAGS_OPT1
		sta	ZP_ADFS_FLAGS
ENDIF
		tya
		bne	LA013
.LA00F
IF USE65C12
		lda	#ADFS_FLAGS_OPT1
		trb	ZP_ADFS_FLAGS
ELSE
		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_OPT1 EOR &FF
		sta	ZP_ADFS_FLAGS
ENDIF
ELSE							; TARGETOS <= 1

		tya
		beq	LA00F
		lda	ZP_ADFS_FLAGS			; 9FE7 A5 CD                    ..
		ora	#ADFS_FLAGS_OPT1		; 9FE9 09 04                    ..
		bne	_lbbc9FF1
.LA00F		lda	ZP_ADFS_FLAGS			; 9FED A5 CD                    ..
		and	#ADFS_FLAGS_OPT1 EOR &FF
._lbbc9FF1		sta	ZP_ADFS_FLAGS		; 9FF1 85 CD                    ..
ENDIF
.LA013		jmp	L89D8

;;
.LA016		cpx	#&03
		bne	LA02A
		jsr	L8FF3
		jsr	LB546
		lda	&B5
		and	#&03
		sta	WKSP_ADFS_100_FSM_S1 + &FD
		jmp	L8F91
;;
.LA02A		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&CB				; ERR=203
		EQUS	"Bad opt"
		EQUB	&00

; Print a character with non-ADFS SPOOLing disabled
; -------------------------------------------------
; Prevents another filing system swapping in in the middle of doing ADFS text output
;
.LA036		lda	#&20				; Print a space
IF TARGETOS > 1
IF USE65C12
		bra	LA03C
ELSE
		bne	LA03C
ENDIF
ELSE
		jmp	OSWRCH
ENDIF

IF TARGETOS > 1
.LA03A		lda	#&0D				; Print a newline
.LA03C
IF USE65C12
		phx					; Print a character
		phy
		pha
ELSE
		pha
		txa
		pha
		tya
		pha
		tsx
		lda	&102,X
		pha
ENDIF

		lda	#&C7
		ldy	#&00				; Do OSBYTE &C7,0,0
		jsr	L84C6				; Set SPOOL handle to 0, returning X=SPOOL, Y=Escape/Break flags
		cpx	#CHANNEL_RANGE_LO
		bcc	LA053				; Not an ADFS handle
		cpx	#CHANNEL_RANGE_HI+1
		bcs	LA053				; Not an ADFS handle
							;This looks like we need a LDY #0 here as if *FX200,<>0, Y will be <>0
		jsr	OSBYTE				; Restore SPOOL handle, we can safely SPOOL to ourself
		ldx	#&00				; Don't need to restore again
.LA053		pla
		pha
		jsr	&FFE3				; Write the character without SPOOLing
		lda	#&C7
		ldy	#&FF				; Preserve handle if already restored
		jsr	OSBYTE				; Restore SPOOL handle with OSBYTE &C7,handle or &00,&FF
IF USE65C12
		pla
		ply
		plx
ELSE
		pla
		pla
		tay
		pla
		tax
		pla
ENDIF

		rts
ENDIF
;;
.starFREE		jsr	LA1EA
		jsr	LA206
		jsr	L92A8
		EQUS	"Free", &8D
		jsr	LA1EA
		ldy	#&01
		ldx	#&02
		sec
.LA079		lda	WKSP_ADFS_000_FSM_S0 + &FB,Y
		sbc	WKSP_ADFS_215_DSKOPSAV_RET,Y
		sta	WKSP_ADFS_215_DSKOPSAV_RET,Y
		iny
		dex
		bpl	LA079
		jsr	LA206
		jsr	L92A8
		EQUS	"Used", &8D
.LA091		rts

IF TARGETOS > 0 OR HD_SCSI = 0
	include "starmap.asm"
ENDIF ; NOT ELK SCSI

;;
;; FSC 8 - OSCLI being processed
;; =============================
.LA0DC		
IF TARGETOS > 1
		ldx	WKSP_ADFS_2D9
ELSE
		ldx	WKSP_ADFS_2D8
ENDIF
		bne	LA091				; Exit
		ldx	WKSP_ADFS_100_FSM_S1 + &FE	; Get FSM size
		cpx	#&E1
		bcc	LA091				; If FSM not filling up, exit
		jsr	L92A8				; Print message
		EQUB	"Compaction recommended", &8D
.LA102		rts

IF TARGETOS = 0 AND HD_SCSI
	include "starmap.asm"
ENDIF ; NOT ELK SCSI



;;TODO: put this back for SCSI2
IF TARGETOS <= 1 AND NOT(HD_SCSI2)
;;
;;
;; *DELETE
;; ====
.starDELETE
		jsr	starREMOVE
		bne	LA091
		jmp	L8BE2
ENDIF
;;
;;
;; *BYE
;; ====
.starBYE
IF HD_MMC
		ldx	WKSP_ADFS_317_CURDRV			; Get current drive
		inx
		beq	LA102				; No drive selected
		jmp	starCLOSE				; Do CLOSE#0
ELSE
IF TARGETOS = 0 AND HD_IDE <> 0
		rts                                     ; A0C3 60                       `

; ----------------------------------------------------------------------------
._lelkA0C4  	ldy     #$05                            ; A0C4 A0 05                    ..
        	lda     ($B0),y                         ; A0C6 B1 B0                    ..
        	cmp     #$09                            ; A0C8 C9 09                    ..
        	and     #$FD                            ; A0CA 29 FD                    ).
        	eor     #$08                            ; A0CC 49 08                    I.
.lelkA0CE  	beq     _lelkA0D5                           ; A0CE F0 05                    ..
        	lda     #$60                            ; A0D0 A9 60                    .`

        	jmp	CommandExit
._lelkA0D5  	jmp     CommandOk                     	; A0D5 4C 1B 81                 L..

LA113 = _lelkA0D5 - 2					; TODO ASK JGH - this can't be right?

; ----------------------------------------------------------------------------
._lelkLA0D8	php                                     ; A0D8 08                       .
        	jmp     SetCommand                     	; A0D9 4C 2F 82                 L/.

; ----------------------------------------------------------------------------
        	ora     ($38),y                         ; A0DC 11 38
ELSE

		lda	WKSP_ADFS_317_CURDRV			; Get current drive
		pha					; Save current drive
IF TARGETOS=0 AND HD_SCSI
		jsr	starCLOSE

ELSE
		tax
		inx
		beq	LA10E				; No drive selected
		jsr	starCLOSE				; Do CLOSE#0
ENDIF
.LA10E		lda	#&60
		sta	WKSP_ADFS_317_CURDRV			; Set drive to 3
.LA113		ldx	#<LA12A
		ldy	#>LA12A				; Point to control block
		jsr	CommandExecXY				; Do command &1B - park heads
		lda	WKSP_ADFS_317_CURDRV			; Get current drive
		sec
ENDIF ; TARGETOS = 0
		sbc	#&20				; Step back one
		sta	WKSP_ADFS_317_CURDRV
		bcs	LA113				; Loop for drives 3 to 0
		pla
		sta	WKSP_ADFS_317_CURDRV			; Restore current drive
		rts
ENDIF
;;
IF NOT(HD_MMC)
.LA12A		EQUB	&00				; Result=&00, Ok
		EQUW	WKSP_ADFS_900_RND_BUFFER	; Address=&FFFFC900, dummy address
		EQUW	&FFFF
		EQUB	&1B				; Action=Park
		EQUB	&00				; Sector=&000000
		EQUB	&00
		EQUB	&00
		EQUB	&00				; &00=Park
		EQUB	&00				; &00=use sector count
ENDIF
;;
.LA135		jsr	LA50D
		ldy	WKSP_ADFS_317_CURDRV
		iny
		beq	LA13F
		dey
.LA13F		sty	WKSP_ADFS_26F
		ldy	#&00				; Caller may need this
		lda	(&B4),Y				; Check first character of filename
		cmp	#&20
		bcc	LA150
		jsr	L8847
		sta	WKSP_ADFS_26F			; Set drive number
.LA150		rts
;;
.starDISMOUNT		jsr	LA135
		ldx	#&09
.LA156		lda	WKSP_ADFS_3AC_CH_FLAGS,X
		beq	LA16F
		lda	WKSP_ADFS_3B6,X
		and	#&E0
		cmp	WKSP_ADFS_26F
		bne	LA16F
		clc
		txa
		adc	#'0'
		tay
		lda	#&00
		jsr	my_OSFIND
.LA16F		dex
		bpl	LA156
		lda	WKSP_ADFS_317_CURDRV
		cmp	WKSP_ADFS_26F
		bne	LA1B9
		lda	#&FF
		sta	WKSP_ADFS_317_CURDRV
		sta	WKSP_ADFS_316
		ldx	#&00
		jsr	LA189
IF USE65C12
		bra	LA1B9
ELSE
		bmi	LA1B9
ENDIF
;;
.LA189		ldy	#&09
.LA18B		lda	LA196-2,Y
		sta	WKSP_ADFS_300_CSDNAME,X
		inx
		dey
		bpl	LA18B
.RTS1
		rts
;;
.LA196		EQUS	&0D, &22, "tesnU", &22
;;
;; *MOUNT
;; ======
.starMOUNT		
		jsr	LA135				; Scan drive number parameter
.LA1A1		lda	WKSP_ADFS_26F			; Get drive
		sta	WKSP_ADFS_317_CURDRV		; Set current drive
IF NOT(HD_MMC)
		ldx	#<SCSICMD_UNPARK		; Point to 'unpark' control block
		ldy	#>SCSICMD_UNPARK
		jsr	CommandExecXY			; Do SCSI command &1B - UnPark
ENDIF
		lda	#<(LA2EA)			; B4/5=>&00 - null string
		sta	&B4
		lda	#>(LA2EA)
		sta	&B5
		jsr	starDIR				; Do something
.LA1B9		lda	WKSP_ADFS_31F			; Get previous drive
		cmp	WKSP_ADFS_26F			; Compare with ???
		bne	LA1C9				; If different, jump past
		lda	#&FF
		sta	WKSP_ADFS_31E			; Set previous directory to &FFFFxxxx
		sta	WKSP_ADFS_31F
.LA1C9		lda	WKSP_ADFS_31B			; Get library drive
		cmp	WKSP_ADFS_26F			; Compare with ???
		bne	LA1DE				; If different, jump past
		lda	#&FF
		sta	WKSP_ADFS_31A			; Set library to &FFFFxxxx
		sta	WKSP_ADFS_31B
		ldx	#&0A
		jsr	LA189				; Set library name to "Unset"
.LA1DE		rts
;;
IF NOT(HD_MMC)
.SCSICMD_UNPARK		
		EQUB	&00				; Result=&00, Ok
		EQUW	WKSP_ADFS_900_RND_BUFFER	; Address=&FFFFC900, dummy address
		EQUW	&FFFF
		EQUB	&1B				; Action=Park
		EQUB	&00				; Sector=&000000
		EQUB	&00
		EQUB	&00
		EQUB	&01				; &01=unpark
		EQUB	&00				; &00=use sector count
ENDIF
;;
.LA1EA		lda	#&00
		ldx	#&03
.LA1EE		sta	WKSP_ADFS_215_DSKOPSAV_RET,X
		sta	WKSP_ADFS_227_TUBE_XFER,X
		dex
		bpl	LA1EE
		jsr	L8632
		ldx	#&02
.LA1FC		lda	WKSP_ADFS_25D,X
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR,X
		dex
		bpl	LA1FC
		rts
;;
.LA206		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR+2
		jsr	L9322
		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
		jsr	L9322
		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR
		jsr	L9322
		jsr	L92A8
		EQUS	" Sectors =", &A0
		ldx	#&1F
		stx	WKSP_ADFS_233
		lda	#&00
		ldx	#&09
.LA22F		sta	WKSP_ADFS_240,X
		dex
		bpl	LA22F
.LA235		asl	WKSP_ADFS_215_DSKOPSAV_RET
		rol	WKSP_ADFS_216_DSKOPSAV_MEMADDR
		rol	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
		rol	WKSP_ADFS_216_DSKOPSAV_MEMADDR+2
		ldx	#&00
		ldy	#&09
.LA245		lda	WKSP_ADFS_240,X
		rol	A
		cmp	#&0A
		bcc	LA24F
		sbc	#&0A
.LA24F		sta	WKSP_ADFS_240,X
		inx
		dey
		bpl	LA245
		dec	WKSP_ADFS_233
		bpl	LA235
		ldy	#&20
		ldx	#&08
.LA25F		bne	LA263
		ldy	#&2C
.LA263		lda	WKSP_ADFS_240,X
		bne	LA270
		cpy	#&2C
		beq	LA270
		lda	#&20
		bne	LA275
.LA270		ldy	#&2C
		clc
		adc	#'0'
.LA275
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSWRCH
ENDIF
		cpx	#&06
		beq	LA280
		cpx	#&03
		bne	LA284
.LA280		tya
IF TARGETOS > 1
		jsr	LA03C
ELSE
		jsr	OSWRCH
ENDIF
.LA284		dex
		bpl	LA25F
		jsr	L92A8
		EQUS	" Bytes",&A0
		rts
.starTITLE		jsr	LB546
		jsr	L8FF3
		jsr	LA50D
		ldy	#&00
.LA29D		lda	(&B4),Y
		and	#&7F
		cmp	#&22
		beq	LA2A9
		cmp	#&20
		bcs	LA2AB
.LA2A9		lda	#&0D
.LA2AB		sta	WKSP_ADFS_800_DIR_BUFFER + &D9,Y
		iny
		cpy	#&13
		bne	LA29D
		jmp	L8F91
;;
.starCOMPACT		jsr	LA50D
		ldy	#&00				; Y=0 needed for later
		lda	(&B4),Y				; Check first character of filename
		cmp	#&21
		bcs	LA2EB
		lda	#&84
		jsr	OSBYTE
		txa
		bne	LA2DB
		tya
		bmi	LA2DB
		sta	WKSP_ADFS_260
		lda	#&80
		sec
		sbc	WKSP_ADFS_260
		sta	WKSP_ADFS_261
		jmp	LA377
;;
.LA2DB		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&94				; ERR=148
		EQUS	"Bad compact"
.LA2EA		EQUB	&00				; Null string used in *MOUNT
;;
.LA2EB		sta	WKSP_ADFS_215_DSKOPSAV_RET
		iny
		lda	(&B4),Y
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR
		iny
		lda	(&B4),Y				; Get current character
		cmp	#&20				; space
		beq	LA2FF
		cmp	#&2C				; comma
		bne	LA2DB
.LA2FF		iny
		lda	(&B4),Y				; Get current character
		cmp	#&20				; space
		beq	LA2FF
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
		iny
		lda	(&B4),Y
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+2
		cmp	#&21
		bcs	LA31F
		lda	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+2
		lda	#&30
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR+1
		dey
.LA31F		iny
		lda	(&B4),Y				; Get current character
		cmp	#&20				; space
		beq	LA31F
		bcs	LA2DB
		ldx	#&03
.LA32A		lda	WKSP_ADFS_215_DSKOPSAV_RET,X
		cmp	#&30
		bcc	LA2DB
		cmp	#&3A
		bcs	LA33D
		sec
		sbc	#&30
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X
		bpl	LA34C
.LA33D		and	#&5F
		cmp	#&41
		bcc	LA2DB
		cmp	#&47
		bcs	LA2DB
		sbc	#&36
		sta	WKSP_ADFS_215_DSKOPSAV_RET,X
.LA34C		dex
		bpl	LA32A
		inx
		jsr	LA389
		bmi	LA2DB
		sta	WKSP_ADFS_260
		ldx	#&02
		jsr	LA389
		bpl	LA362
.LA35F		jmp	LA2DB
;;
.LA362		beq	LA35F
		sta	WKSP_ADFS_261
IF TARGETOS <= 1
		ldx	ZP_MOS_CURROM
		lda	&0DF0,X
		cmp	WKSP_ADFS_260
		bcc	_lbbcA334
		jmp	LA2DB
ENDIF
._lbbcA334
		clc
		lda	WKSP_ADFS_260
		adc	WKSP_ADFS_261
		bpl	LA377
		cmp	#&80
		beq	LA377
		jmp	LA2DB
;;
.LA377		jsr	starCLOSE
		jsr	WaitEnsuring
IF USE65C12
		lda	#ADFS_FLAGS_WTF
		tsb	ZP_ADFS_FLAGS
ELSE
		lda	ZP_ADFS_FLAGS
		ora	#ADFS_FLAGS_WTF
		sta	ZP_ADFS_FLAGS
ENDIF
		jsr	L98B3
IF USE65C12
		lda	#ADFS_FLAGS_WTF
		trb	ZP_ADFS_FLAGS
ELSE
		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_WTF EOR &FF
		sta	ZP_ADFS_FLAGS
ENDIF
		rts
;;
.LA389		lda	WKSP_ADFS_215_DSKOPSAV_RET,X
		asl	A
		asl	A
		asl	A
		asl	A
		ora	WKSP_ADFS_216_DSKOPSAV_MEMADDR,X
		rts
;;
.LA394		jsr	LA4F5
		lda	&B5
		pha
		lda	&B4
		pha
		jsr	LA4F5
		ldy	#&00				; Caller may need this
		lda	(&B4),Y				; Check first character of filename
		cmp	#&20
		bcs	LA3CB
		pla
		sta	&B4
		sta	WKSP_ADFS_240
		pla
		sta	&B5
		sta	WKSP_ADFS_241
		rts
;;
.LA3B5		jsr	LA4B1
IF TARGETOS > 1
		jsr	L89D8
		lda	WKSP_ADFS_2D6			; Get FSC function
		cmp	#&0B				; Was this Run from libfs?
		beq	LA3CB				; Yes, jump to error
		lda	#&0B				; Otherwise, pass on to libfs
		ldx	&C0
		ldy	&C1
		jmp	L9A4C				; Pass on to FSC to call libfs
ENDIF
;;
.LA3CB		jsr	ReloadFSMandDIR_ThenBRK				; Generate error
		EQUB	&FE				; ERR=254
		EQUS	"Bad command"
		EQUB	&00
;;
;; FSC 2,4,11 - */, *RUN, *RUN from library
;; ========================================
.starRUN		lda	&B4
		sta	&C0
		lda	&B5
		sta	&C1
		jsr	L8BBE
		beq	LA3FE
		jsr	L89D8
		lda	&C0
		sta	&B4
		lda	&C1
		sta	&B5
		jsr	LA49E
		jsr	L8BBE
		bne	LA3B5
		jsr	LA4B1
.LA3FE		lda	&B4
		sta	WKSP_ADFS_2A2
		lda	&B5
		sta	WKSP_ADFS_2A3
		ldy	#&0E
		lda	(&B6),Y
		ldx	#&02
.LA40E		iny
		and	(&B6),Y
		dex
		bpl	LA40E
IF USE65C12
		inc	A
ELSE
		cmp	#&FF
ENDIF
		bne	LA42A
		ldx	&B6
		ldy	&B7
		lda	#&40
		jsr	my_OSFIND
		sta	WKSP_ADFS_332
		ldx	#<L9A9C				; Point to E.-ADFS-$.!BOOT
		ldy	#>L9A9C
		jmp	OSCLI
;;
.LA42A		ldy	#&0B
		lda	(&B6),Y
		iny
		and	(&B6),Y
		iny
		and	(&B6),Y
IF USE65C12
		inc	A
ELSE
		cmp	#&FF
ENDIF
		bne	LA43F
		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&93				; ERR=147
IF TARGETOS > 1
		EQUS	"No!"
ELSE
		EQUS	"Won't"
ENDIF
		EQUB	&00
;;
.LA43F		lda	#&A5
		sta	WKSP_ADFS_2A8
		ldx	#<WKSP_ADFS_2A2
		ldy	#>WKSP_ADFS_2A2
		stx	&B8
		sty	&B9
		jsr	L8BBE
		ldy	#&04
		lda	(&B6),Y				; Get 'E' bit
		ldy	#&00
		ora	(&B6),Y				; Merge with 'R' bit
		bmi	LA45C				; 'E' or 'R' present, run it
		jmp	L8BFB				; No 'E' or 'R', can't run
;;
.LA45C		jsr	L8C1B
		lda	WKSP_ADFS_2AB
		cmp	#&FF
		bne	LA472
		lda	WKSP_ADFS_2AA
		cmp	#&FE
		bcc	LA472
.LA46D		lda	#&01
		jmp	(WKSP_ADFS_2A8)
;;
.LA472		bit	ZP_ADFS_FLAGS			; Get ADFS status byte
		bpl	LA46D				; No Tube, enter I/O address
		jsr	L8032
		ldx	#<WKSP_ADFS_2A8
		ldy	#>WKSP_ADFS_2A8
		lda	#&04
		jmp	&0406

;; *LIB <dir>
;; ==========
.starLIB		jsr	L9486				; Search for directory
		ldy	#&09
.LA487		lda	WKSP_ADFS_800_DIR_BUFFER + &CC,Y; Copy name to LIBNAME
		sta	WKSP_ADFS_30A_LIBNAME,Y
		dey
		bpl	LA487
		ldy	#&03
.LA492		lda	WKSP_ADFS_314,Y			; Copy CURRENT to LIB
		sta	WKSP_ADFS_318,Y
		dey
		bpl	LA492
.LA49B		jmp	L89D8				; Finish by loading $
;;
.LA49E		ldy	#&03
.LA4A0		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_230,Y
		lda	WKSP_ADFS_318,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	LA4A0
		bmi	LA49B
.LA4B1		ldy	#&03
.LA4B3		lda	WKSP_ADFS_230,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	LA4B3
		rts

IF OPTIMISE<6
; *LCAT
; =====
.starLCAT		jsr	LA49E
		jsr	LA4B1
		jsr	L93DB				; CAT the library
		jmp	L89D8

; *LEX
; ====
.starLEX		jsr	LA49E
		jsr	LA4B1
		jsr	L943D				; EX the library
		jmp	L89D8
ELSE
; *LCAT, *LEX
; ===========
.starLCAT
.starLEX
	IF USE65C12
		phx					; Save index into command table
	ELSE	
		txa
		pha
	ENDIF
		jsr	LA49E
		jsr	LA4B1
		pla
		eor	#cmdLC-tbl_commands+4
		jsr	CatOrEx				; CAT or EX the library
		jmp	L89D8				; Reload current directory
ENDIF

.starBACK		ldy	#&03
.LA4D7		lda	WKSP_ADFS_31C,Y
		sta	WKSP_ADFS_22C_CSD,Y
		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_31C,Y
		dey
		bpl	LA4D7
		jsr	L89D8
		ldy	#&09
.LA4EB		lda	WKSP_ADFS_800_DIR_BUFFER + &CC,Y
		sta	WKSP_ADFS_300_CSDNAME,Y
		dey
		bpl	LA4EB
		rts
;;
.LA4F5		ldy	#&00
.LA4F7		jsr	L8743
		beq	LA4FF
.LA4FC		iny
		bne	LA4F7
.LA4FF		cmp	#&2E
		beq	LA4FC
		tya
		clc					; &B4/5=&B4/5+Y
		adc	&B4
		sta	&B4
		bcc	LA50D
		inc	&B5
;;
.LA50D
		ldy	#&00
		clc
		php
.LA511		lda	(&B4),Y				; Get current character
		cmp	#&20				; Is it a space?
		bcc	LA528				; Control character,
		beq	LA525				; Space,
		cmp	#&22				; Is it a quote?
		bne	LA528
		plp
		bcc	LA523
		jmp	L8760
;;
.LA523		sec
		php
.LA525		iny
		bne	LA511
.LA528		tya
		plp
		clc
		adc	&B4
		sta	&B4
		bcc	LA533
		inc	&B5
.LA533		rts
;;
.LA534
		ldy	#&00				; Caller may need this
		lda	(&B4),Y				; Check first character of filename
		and	#&7F
		cmp	#&3A				; Can't rename to '*'
		bne	LA533				; Not '*', exit as ok
.LA53E		jmp	L8988				; Jump to 'Bad rename'
;;
.starRENAME		lda	&B4
		pha
		lda	&B5
		pha
		jsr	LA534
		jsr	L8DC8
		jsr	L8BF0
		beq	LA555
		jmp	L8BD3
;;
.LA555		ldy	#&03
		lda	(&B6),Y				; Check 'D' bit
		jsr	L89D8				; Load FSM
		bpl	LA580				; Not a directory
IF USE65C12
		plx
ELSE
		pla
		tax
ENDIF
		pla
		sta	&B4
IF USE65C12
		stx	&B5
		pha
		phx
ELSE
		pha
		txa
		sta	&B5
		pha
ENDIF
		ldy	#&00				; Caller may need this
		lda	(&B4),Y				; Get first character
IF TARGETOS = 0 AND HD_SCSI
		and	#&7F
		cmp	#'$'				; Is it '$' or '&'
		beq	LA53E				; If ROOT or URD, jump to 'Bad rename'
		cmp	#'&'				; Is it '$' or '&'
		beq	LA53E				; If ROOT or URD, jump to 'Bad rename'
		ldy	#0
ELSE
		and	#&7D
		cmp	#'$'				; Is it '$' or '&'
		beq	LA53E				; If ROOT or URD, jump to 'Bad rename'
ENDIF
.LA570		jsr	L8743
		beq	LA57C
		cmp	#'^'
		beq	LA53E				; Can't rename '^', jump to 'Bad rename'
.LA579		iny
		bne	LA570
.LA57C		cmp	#'.'
		beq	LA579
.LA580		jsr	LA394
		jsr	LA534
IF OPTIMISE<2
		lda	#<WKSP_ADFS_240			; &B8/9=>&C240, control block in workspace
		sta	&B8
		lda	#>WKSP_ADFS_240
		sta	&B9
ELSE
		jsr	PointToCtrl			; &B8/9=>&C240, control block in workspace
ENDIF
		jsr	L8CED
IF TARGETOS>0 OR NOT(HD_SCSI)
		php
ENDIF
		jsr	L8E01				; Check
IF TARGETOS>0 OR NOT(HD_SCSI)
		plp
		bne	LA5A5
		lda	&B6
		ldy	#&03
.LA59C		sta	WKSP_ADFS_234,Y
		lda	WKSP_ADFS_313,Y
		dey
		bpl	LA59C
.LA5A5
ENDIF
		lda	WKSP_ADFS_22E
		bpl	LA5B5
		ldy	#&02
.LA5AC		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	LA5AC
.LA5B5		jsr	L89D8
IF USE65C12
		plx
		pla
		sta	&B4
		stx	&B5
ELSE
		pla
		sta	&B5
		tax
		pla
		sta	&B4
ENDIF
		pha
IF USE65C12
		phx
ELSE
		txa
		pha
ENDIF
		jsr	L8FE8
		jsr	L8D1B
IF TARGETOS=0 AND HD_SCSI
        	ldy     #$18                            ; A58D A0 18                    ..
        	ldx     #$02                            ; A58F A2 02                    ..
.elkLA591  	lda     ($B6),y                         ; A591 B1 B6                    ..
        	cmp     $1034,x                         ; A593 DD 34 10                 .4.
        	bne     LA625                           ; A596 D0 56                    .V
        	dey                                     ; A598 88                       .
        	dex                                     ; A599 CA                       .
        	bpl     elkLA591                        ; A59A 10 F5                    ..
ELSE
		ldy	#&03
		lda	&B6
.LA5CA		cmp	WKSP_ADFS_234,Y
		bne	LA625				; Set bit 9
		lda	WKSP_ADFS_313,Y
		dey
		bpl	LA5CA
ENDIF
		pla
		sta	&B5
		pla
		sta	&B4
		jsr	LA394
.LA5DE		ldy	#&00
.LA5E0		lda	(&B4),Y
		cmp	#&2E
		beq	LA5EF
IF TARGETOS=0 AND HD_SCSI
		cmp	#&22
		beq	LA5FA
ELSE
		and	#&7D
ENDIF
		cmp	#&21
		bcc	LA5FA
		iny
IF USE65C12
		bra	LA5E0
ELSE
		bne	LA5E0
ENDIF
;;
.LA5EF		tya
		adc	&B4
		sta	&B4
		bcc	LA5DE
		inc	&B5
		bne	LA5DE
.LA5FA		
IF TARGETOS=0 AND HD_SCSI
		ldy	#0
		ldx	#09
ELSE
		ldy	#&09
ENDIF
.LA5FC		lda	(&B6),Y
		and	#&80
		sta	WKSP_ADFS_22B
		lda	(&B4),Y				; Get filename character
		and	#&7F
		cmp	#&22
		beq	LA60F
		cmp	#&21
		bcs	LA611
.LA60F		lda	#&0D
.LA611		ora	WKSP_ADFS_22B
		sta	(&B6),Y
IF TARGETOS=0 AND HD_SCSI
		iny
		dex
ELSE
		dey
ENDIF
		bpl	LA5FC
		jsr	L8F91
		jsr	LA6BB
		jmp	L89D8

IF TARGETOS>0 OR NOT(HD_SCSI)
;;
.LA622		jmp	L95AB				; Error 'Already exists'
;;
.LA625		lda	WKSP_ADFS_237
		bne	LA622				; <>&00, jump to 'Already exists'
ELSE
.LA625
ENDIF

		ldy	#&09				; What uses access bit 9?
IF OPTIMISE<2
		lda	(&B6),Y				; Set attribute bit
		ora	#&80
		sta	(&B6),Y
ELSE
		jsr	SetAttr				; Set attribute bit
ENDIF
		jsr	L8F91
		ldy	#&0A
		ldx	#&07
.LA639		lda	(&B6),Y
		sta	WKSP_ADFS_238,Y
		iny
		dex
		bpl	LA639
IF USE65C12
		stz	WKSP_ADFS_24A
		stz	WKSP_ADFS_24B
		stz	WKSP_ADFS_24C
		stz	WKSP_ADFS_24D
ELSE
		lda	#0
		sta	WKSP_ADFS_24A
		sta	WKSP_ADFS_24B
		sta	WKSP_ADFS_24C
		sta	WKSP_ADFS_24D
ENDIF
		ldx	#&03
.LA650		lda	(&B6),Y
		sta	WKSP_ADFS_23C,Y
		iny
		dex
		bpl	LA650
		ldy	#&00
.LA65B		lda	(&B6),Y
		rol	A
		rol	WKSP_ADFS_25D
		iny
		cpy	#&04
		bne	LA65B
		jsr	LA394
		ldy	#&18
		ldx	#&02
.LA66D		lda	(&B6),Y
		sta	WKSP_ADFS_23A,X
		dey
		dex
		bpl	LA66D
		jsr	L89D8
IF OPTIMISE<2
		lda	#<WKSP_ADFS_240		; &B8/9=>&C240
		sta	&B8
		lda	#>WKSP_ADFS_240
		sta	&B9
ELSE
		jsr	PointToCtrl			; &B8/9=>&C240
ENDIF
		jsr	L8DFE
		jsr	L8E7A
		ldy	#&03
.LA689		lda	(&B6),Y
		asl	A
		ror	WKSP_ADFS_25D
		ror	A
		sta	(&B6),Y
		dey
		bpl	LA689
		jsr	L8E96
		jsr	L8F63
		jsr	L8F91
		jsr	LA6BB
		jsr	L89D8
		pla
		sta	&B5
		pla
		sta	&B4
		jsr	L8FE8
		ldx	#&05
IF USE65C12
.LA6AF		stz	WKSP_ADFS_234,X
ELSE
		lda	#0
.LA6AF		sta	WKSP_ADFS_234,X
ENDIF
		dex
		bpl	LA6AF
		jsr	L921B
		jmp	L89D8
;;
.LA6BB
		ldy	#&03
		lda	(&B6),Y				; Check 'D' bit
		bmi	LA6C2				; Jump if directory
		rts					; Not directory, return
;;
.LA6C2		ldy	#&02
.LA6C4		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_270,Y
		dey
		bpl	LA6C4
		ldy	#&09
.LA6CF		lda	(&B6),Y				; Get character from directory entry
		and	#&7F
		sta	WKSP_ADFS_274,Y
		dey
		bpl	LA6CF
		lda	#<WKSP_ADFS_274
		sta	&B4
		lda	#>WKSP_ADFS_274
		sta	&B5
		jsr	L9486
		ldy	#&09
.LA6E6		lda	WKSP_ADFS_274,Y
		sta	WKSP_ADFS_800_DIR_BUFFER + &CC,Y
		dey
		bpl	LA6E6
		ldy	#&02
.LA6F1		lda	WKSP_ADFS_270,Y
		sta	WKSP_ADFS_800_DIR_BUFFER + &D6,Y
		dey
		bpl	LA6F1
		jmp	L8F91
;;
;; Check loaded directory
;; ----------------------
.CheckDirLoaded						; LA6FD
		ldx	WKSP_ADFS_317_CURDRV			; Get current drive
		inx					; If &FF, no directory loaded
		bne	LA72Erts			; Directory loaded, exit
		jsr	GenerateErrorNoSuff		; Generate error
		EQUB	&A9				; ERR=169
		EQUS	"No directory"
		EQUB	&00
;;
.LA714		jsr	CheckDirLoaded			; Check if directory loaded
		ldx	#&00				; Point to first character to check
IF TARGETOS=0 AND HD_SCSI
		ldy	#&04
ENDIF
		lda	WKSP_ADFS_800_DIR_BUFFER + &FA	; Get initial character
.LA71C		cmp	WKSP_ADFS_400_DIR_BUFFER,X	; Check "Hugo" string at start of dir
		bne	LA72F				; Jump to give broken dir error
		cmp	WKSP_ADFS_800_DIR_BUFFER + &FA,X; Check "Hugo" string at end of dir
		bne	LA72F				; Jump to give broken dir error
		inx					; Move to next char
		lda	L84DC,X				; Get byte from "Hugo" string
IF TARGETOS=0 AND HD_SCSI
		dey
		bpl	LA71C
ELSE
		cpx	#&05
		bne	LA71C				; Loop for 4 characters
ENDIF
.LA72Erts	rts
;;
.LA72F		jsr	L834E				; Generate error
		EQUB	&A8				; ERR=168
		EQUS	"Broken directory"
		EQUB	&00
;;
;; Get pointer to workspace into &BA/B, return A=&00
;; =================================================
.GetWkspAddr_BA						; LA744
		ldx	ZP_MOS_CURROM
		lda	&0DF0,X
		sta	&BB
		lda	#&00
		sta	&BA
		rts
;;
;;
;; Calculate workspace checksum
;; ----------------------------
.CalcWkspChecksum					; L7A50
		jsr	GetWkspAddr_BA			; Find workspace
		ldy	#&FD
		tya
		clc
.LA757		adc	(&BA),Y				; Add up contents of workspace
		dey
		bne	LA757				; Loop for 252 bytes
		adc	(&BA),Y				; Add zeroth byte
		ldy	#&FE				; Point to checksum
		rts
;;
;; Set workspace checksum
;; ----------------------
.StoreWkspChecksumBA_Y					; L7A61
		jsr	CalcWkspChecksum		; Calculate workspace checksum
		sta	(&BA),Y				; Store checksum
.LA766		rts
;;
;; Check workspace checksum
;; ------------------------
.CheckWkspChecksum
		jsr	CalcWkspChecksum		; Calculate workspace checksum
		cmp	(&BA),Y				; Does it match?
		beq	LA766				; Exit if it does
.LA76E		lda	#&0F
		sta	WKSP_ADFS_2CE
		jsr	GenerateErrorNoSuff				; Generate error
		EQUB	&AA				; ERR=170
		EQUS	"Bad sum"
		EQUB	&00
;;
.LA77F
		php					; Save all registers
IF USE65C12
		pha
		phy
		phx
ELSE
		pha
		tya
		pha
		txa
		pha
ENDIF
		lda	WKSP_ADFS_2CE			; Get workspace checksum
		bne	LA76E				; If nonzero, generate 'Bad sum' error
		jsr	L8FF3				; Check FSM checksum
		clc
		ldx	#&10
.LA78E		lda	WKSP_ADFS_204,X
		and	#&21
		beq	LA79B
		bcs	LA76E
		cmp	#&01
		bne	LA76E
.LA79B		dex
		dex
		dex
		dex
		bpl	LA78E
		bcc	LA76E
		jsr	LA7C9
		cmp	WKSP_ADFS_2C1
		bne	LA76E
		pha					; Create two spaces on stack
		pha
		ldy	#&05				; Move stack down two bytes
		tsx
.LA7B0		lda	&0103,X
		sta	&0101,X
		inx
		dey
		bpl	LA7B0
		lda	#<(LA7D4-1)
		sta	&0101,X
		lda	#>(LA7D4-1)
		sta	&0102,X				; Change return address to LA7D4
IF OPTIMISE<6
IF USE65C12
		plx
		ply
		pla
ELSE
		pla
		tax
		pla
		tay
		pla
ENDIF
		plp
		rts
ELSE
	IF USE65C12
		bra	LA7E7
	ELSE
		jmp	LA7E7
	ENDIF
ENDIF
;;
.LA7C9		ldx	#&78
		txa
		clc
.LA7CD		adc	WKSP_ADFS_383,X
		dex
		bne	LA7CD
		rts
;;
.LA7D4		php					; Save all registers
IF USE65C12
		pha
		phy
		phx
ELSE
		pha
		tya
		pha
		txa
		pha
ENDIF
		jsr	LA7C9
		sta	WKSP_ADFS_2C1
IF TARGETOS > 1
		stz	WKSP_ADFS_2CE
		stz	WKSP_ADFS_2D5_CUR_CHANNEL
		stz	WKSP_ADFS_2D9
ELSE
		lda	#0
		sta	WKSP_ADFS_2D8			; note 2D9 on master!
		sta	WKSP_ADFS_2CE
		sta	WKSP_ADFS_2D5_CUR_CHANNEL
ENDIF
.LA7E7
IF USE65C12
		plx
		ply
		pla
ELSE
		pla
		tax
		pla
		tay
		pla
ENDIF
		plp
		rts
;;
.LA7EC
IF OPTIMISE<6
		lda	WKSP_ADFS_291			; Copy &C291-4 to &B4-7
		sta	&B4
		lda	WKSP_ADFS_292
		sta	&B5
		lda	WKSP_ADFS_294
		sta	&B7
		lda	WKSP_ADFS_293
		sta	&B6
ELSE
		ldx	#3
.LA7EE		lda	WKSP_ADFS_291,X			; Copy &C291-4 to &B4-7
		sta	&B4,X
		dex
		bpl	LA7EE
ENDIF
IF OPTIMISE<6
IF TARGETOS=0 AND HD_SCSI
		ldy	#&0A
.LA802		lda	L883C,Y			; Copy 'load $' control block
		sta	WKSP_ADFS_214+1,Y
		dey
		bpl	LA802
		ldx	#&00
ELSE
		ldx	#&0B
.LA802		lda	L883C-1,X			; Copy 'load $' control block
		sta	WKSP_ADFS_214,X
		dex
		bne	LA802
ENDIF
		ldy	#&03

ELSE
		jsr	RootControl			; Copy 'load $' control block
ENDIF
.LA80D		lda	WKSP_ADFS_26C,Y
		sta	WKSP_ADFS_314,Y
		cpx	#&00
		beq	LA81A
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD,X
.LA81A		inx
		dey
		bpl	LA80D
		jmp	L82AA

IF OPTIMISE>=6
.RootControl
		ldx	#&0B
.RootCtrlLp
		lda	L883C-1,X			; Copy 'load $' control block
		sta	WKSP_ADFS_214,X
		dex
		bne	RootCtrlLp
		ldy	#&03
		rts
ENDIF

.LA821
IF OPTIMISE<6
IF TARGETOS=0 AND HD_SCSI
		ldy	#&0A
.LA823		lda	L883C,Y				; Copy 'load $' control block
		sta	WKSP_ADFS_214+1,Y
		dey
		bpl	LA823
		ldx	#&00
ELSE
		ldx	#&0B
.LA823		lda	L883C-1,X			; Copy 'load $' control block
		sta	WKSP_ADFS_214,X
		dex
		bne	LA823
ENDIF

		ldy	#&03
ELSE
		jsr	RootControl			; Copy 'load $' control block
ENDIF
.LA82E		lda	WKSP_ADFS_270,Y
		sta	WKSP_ADFS_314,Y
		cpx	#&00
		beq	LA83B
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD,X
.LA83B		inx
		dey
		bpl	LA82E
		jsr	L82AA
.LoadFSM
		ldx	#<L8831				; Point to 'load FSM' control block
		ldy	#>L8831
		jmp	L82AE				; Load FSM

.starCOPY	lda	#&7F				; &B8/9=>&C27F
		sta	&B8
		lda	#>WKSP_ADFS_274
		sta	&B9
		lda	#<WKSP_ADFS_274			; &C37F/0=>&C274
		sta	WKSP_ADFS_27F
		lda	#>WKSP_ADFS_200
		sta	WKSP_ADFS_280
		jsr	L8BBE
		beq	LA863
		jmp	L8BD3
;;
.LA863
IF OPTIMISE<6
		lda	&B6				; Copy &B6/7 to &C293/4
		sta	WKSP_ADFS_293
		lda	&B7
		sta	WKSP_ADFS_294
		lda	&B4				; Copy &B4/5 to &C291/2
		sta	WKSP_ADFS_291
		lda	&B5
		sta	WKSP_ADFS_292
		ldy	#&03
ELSE
		ldy	#&FF
.LA865		iny
		lda	&B4,Y				; Copy &B4-7 to &C291-4
		sta	WKSP_ADFS_291,Y
		cpy	#3
		bne	LA865
ENDIF
.LA879		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_26C,Y
		dey
		bpl	LA879
		jsr	L89D8
		ldy	#&03
.LA887		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	LA887
		jsr	LA394
		jsr	L8743
		bne	LA89B
		jmp	L8760
;;
.LA89B		jsr	L9486
		jsr	L8FF3
		ldy	#&03
.LA8A3		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_270,Y
		dey
		bpl	LA8A3
		jsr	LA7EC
.LA8AF		ldy	#&04
		lda	(&B6),Y				; Get 'E' bit
		dey
		ora	(&B6),Y				; Merge with 'D' bit
		bpl	LA8C7				; Not 'E' and not 'D'
IF TARGETOS > 1
.CheckESC						; LA8B8
		bit	ZP_MOS_ESCFLAG
		bpl	LA8BF
		jmp	ErrorEscapeACKReloadFSM				; Jump to give 'Escape' error
ENDIF
;;
.LA8BF		jsr	L8964
		beq	LA8AF
		jmp	L89D8
;;
.LA8C7		lda	&B6				; Copy &B6/7 to &C293/4
		sta	WKSP_ADFS_293
		lda	&B7
		sta	WKSP_ADFS_294
		jsr	L8C6D
		ldy	#&16
		lda	(&B6),Y
		sta	WKSP_ADFS_2A2
		iny
		lda	(&B6),Y
		sta	WKSP_ADFS_2A3
		iny
		lda	(&B6),Y
		ora	WKSP_ADFS_317_CURDRV
		sta	WKSP_ADFS_2A4
		ldx	#&00
		ldy	#&03
.LA8EE		lda	WKSP_ADFS_289,Y
		sta	WKSP_ADFS_28D,Y
		txa
		sta	WKSP_ADFS_289,Y
		dey
		bpl	LA8EE
		ldy	#&09
.LA8FD		lda	(&B6),Y				; Get character from directory entry
		and	#&7F
		sta	WKSP_ADFS_274,Y
		dey
		bpl	LA8FD
		lda	#&0D
		sta	WKSP_ADFS_27E
		jsr	LA821
		jsr	L8DFE
		jsr	L8E7A
		jsr	L8F5D
		ldy	#&02
.LA91A		lda	WKSP_ADFS_23A,Y
		sta	WKSP_ADFS_2A8,Y
		lda	WKSP_ADFS_23D,Y
		sta	WKSP_ADFS_2A5,Y
		dey
		bpl	LA91A
		lda	#&83
		jsr	OSBYTE				; Read bottom of memory
		sty	WKSP_ADFS_260
		lda	#&84
		jsr	OSBYTE				; Read top of memory
		tya
		sec
		sbc	WKSP_ADFS_260
		sta	WKSP_ADFS_261
IF USE65C12
		lda	#ADFS_FLAGS_WTF
		tsb	ZP_ADFS_FLAGS
ELSE
		lda	ZP_ADFS_FLAGS
		ora	#ADFS_FLAGS_WTF
		sta	ZP_ADFS_FLAGS
ENDIF
		lda	WKSP_ADFS_26F
		ora	WKSP_ADFS_2A4
		sta	WKSP_ADFS_2A4
		lda	WKSP_ADFS_273
		ora	WKSP_ADFS_2AA
		sta	WKSP_ADFS_2AA
		lda	WKSP_ADFS_317_CURDRV
		pha
		lda	#&00
		sta	WKSP_ADFS_317_CURDRV
		jsr	L96AC
		pla
		sta	WKSP_ADFS_317_CURDRV
		jsr	L8F91
		jsr	LA7EC
IF TARGETOS > 1
		jmp	CheckESC
ELSE
		jmp	LA8BF
ENDIF

IF TARGETOS > 1
;;
;; FSC 6 - New FS taking over
;; ==========================
.FSC6_NEWFS		
		ldx	WKSP_ADFS_317_CURDRV		; Get current drive
		inx					; If &FF, no directory loaded
		beq	LA983
		jsr	L89D8
		lda	#&FF				; Continue into OSARGS &FF,0
		ldy	#&00				; to ensure all files
;;
;; OSARGS
;; ======
.my_OSARGS						; LA97A
		cpy	#&00
		bne	LA9A8				; Jump with OSARGS Y<>0, info on channel
		tay
		bne	LA984				; Jump with OSARGS Y=0, A<>0, info on filing system
		lda	#&08				; OSARGS 0,0 - return filing system number
.LA983		rts
;;
;; OSARGS Y=0, A<>0 - Info on filing system
;; ----------------------------------------
.LA984		jsr	LA77F				; Check FSM
		stx	ZP_ADFS_C3_SAVE_X		; Store X, pointer to data word in zero page
		dey					; Y=&FF
		bne	LA992				; Jump forward
;;
;; Exit OSARGS Y=0
;; ---------------
.LA98C		ldx	ZP_ADFS_C3_SAVE_X		; Restore X
		lda	#&00				; A=0
		tay					; Y=0
		rts
ELSE

.FSC6_NEWFS
IF TARGETOS<>0 OR NOT(HD_SCSI)
		jsr	GetWkspAddr_BA			; A93C 20 0E A7                  ..
		ldy	#&FF				; A93F A0 FF                    ..
		sta	(&BA),y				; A941 91 BA                    ..
ENDIF
		ldx	WKSP_ADFS_317_CURDRV			; A943 AE 17 11                 ...
		inx					; A946 E8                       .
		beq	_lbbcA95E			; A947 F0 15                    ..
		lda	#OSBYTE_77_CLOSE		; A949 A9 77                    .w
		jsr	OSBYTE				; A94B 20 F4 FF                  ..
		jsr	L89D8				; A94E 20 D3 89                  ..
IF TARGETOS=0 AND HD_SCSI
		jsr	GetWkspAddr_BA
		ldy	#&FF				; A951 A0 FF                    ..
		lda	#0
		sta	(&BA),y	
ELSE
		ldy	#&FF				; A951 A0 FF                    ..

ENDIF
		tya					; A953 98                       .
		iny					; A954 C8                       .
.my_OSARGS
		cpy	#&00				; A955 C0 00                    ..
		bne	LA9A8				; A957 D0 3C                    .<
		tay					; A959 A8                       .
		bne	_lbbcA95F			; A95A D0 03                    ..
		lda	#&08				; A95C A9 08                    ..
._lbbcA95E
		rts					; A95E 60                       `

; ----------------------------------------------------------------------------
._lbbcA95F
		jsr	LA77F				; A95F 20 49 A7                  I.
		stx	ZP_ADFS_C3_SAVE_X				; A962 86 C3                    ..
		dey					; A964 88                       .
		bne	LA992				; A965 D0 15                    ..
		lda	$10D6				; A967 AD D6 10                 ...
		sta	$00,x				; A96A 95 00                    ..
		lda	$10D7				; A96C AD D7 10                 ...
		sta	$01,x				; A96F 95 01                    ..
		dey					; A971 88                       .
		sty	$02,x				; A972 94 02                    ..
		sty	$03,x				; A974 94 03                    ..
._lbbcA976
		ldx	ZP_ADFS_C3_SAVE_X				; A976 A6 C3                    ..
		lda	#$00				; A978 A9 00                    ..
		tay					; A97A A8                       .
		rts					; A97B 60
ENDIF
;;
;; OSARGS Y=0 - implement all calls as ENSURE (A=&FF)
;; --------------------------------------------------
.LA992		ldx	#&10
.LA994		jsr	LAB06				; Check things
IF USE65C12
		stz	WKSP_ADFS_204,X
ELSE
		lda	#0
		sta	WKSP_ADFS_204,X
ENDIF
		dex
		dex
		dex
		dex
		bpl	LA994
		inc	WKSP_ADFS_204
		jsr	WaitEnsuring				; Wait for ensuring to complete
IF TARGETOS <= 1
IF USE65C12
		bra	_lbbcA976
ELSE
		jmp	_lbbcA976
ENDIF	
ELSE
IF USE65C12
		bra	LA98C				; Exit
ELSE
		jmp	LA98C				; Exit
ENDIF
ENDIF
;;
;; OSARGS Y<>0 - Info on open channel
;; ----------------------------------
.LA9A8
		jsr	LA77F				; Check FSM
.LA9AB		stx	ZP_ADFS_C3_SAVE_X				; Store X, pointer to data word in zero page
		pha
		jsr	CheckSetChannelY				; Check channel and channel flags
		jsr	LB1E9
		pla					; Get action back
		ldy	ZP_ADFS_CF_CHANNEL_OFFS				; Y=offset to channel info
		tax
		bne	LA9DA				; Jump if not 0, not =PTR
;;
;; OSARGS 0,Y - Read PTR
;; ---------------------
		ldx	ZP_ADFS_C3_SAVE_X				; Get pointer to data word
		lda	WKSP_ADFS_37A,Y			; Copy PTR to data word
		sta	&00,X
		lda	WKSP_ADFS_370,Y
		sta	&01,X
		lda	WKSP_ADFS_366,Y
		sta	&02,X
		lda	WKSP_ADFS_35C,Y
		sta	&03,X
.LA9D0		jsr	LB19C
		lda	#&00				; A=0 - action done
		ldx	ZP_ADFS_C3_SAVE_X		; Restore X,Y
		ldy	ZP_ADFS_C2_SAVE_Y
		rts

;;
;; OSARGS 1,Y - Write PTR
;; ----------------------
.LA9DA		dex
		bne	LAA59				; Jump if not 1, not PTR=
		lda	WKSP_ADFS_3AC_CH_FLAGS,Y
		bpl	LAA16
.LA9E2		ldx	ZP_ADFS_C3_SAVE_X
IF OPTIMISE<4
		lda	&00,X
		sta	WKSP_ADFS_29A
		lda	&01,X
		sta	WKSP_ADFS_29B
		lda	&02,X
		sta	WKSP_ADFS_29C
		lda	&03,X
		sta	WKSP_ADFS_29D
		jsr	LAE68
		ldx	ZP_ADFS_C3_SAVE_X
		ldy	ZP_ADFS_CF_CHANNEL_OFFS
ELSE
		jsr	ArgsData			; Copy data to channel info
ENDIF
.LA9FF		lda	&00,X
		sta	WKSP_ADFS_37A,Y
		lda	&01,X
		sta	WKSP_ADFS_370,Y
		lda	&02,X
		sta	WKSP_ADFS_366,Y
		lda	&03,X
		sta	WKSP_ADFS_35C,Y
IF USE65C12 AND OPTIMISE >= 1
		bra	LA9D0
ELSE
		jmp	LA9D0
ENDIF
;;
.LAA16		ldx	ZP_ADFS_C3_SAVE_X
		ldy	ZP_ADFS_CF_CHANNEL_OFFS
		sec
		lda	WKSP_ADFS_352,Y
		sbc	&00,X
		lda	WKSP_ADFS_348,Y
		sbc	&01,X
		lda	WKSP_ADFS_33E,Y
		sbc	&02,X
		lda	WKSP_ADFS_334,Y
		sbc	&03,X
		bcc	LAA48
IF OPTIMISE<4
		lda	&00,X
		sta	WKSP_ADFS_37A,Y
		lda	&01,X
		sta	WKSP_ADFS_370,Y
		lda	&02,X
		sta	WKSP_ADFS_366,Y
		lda	&03,X
		sta	WKSP_ADFS_35C,Y
		jmp	LA9D0
ELSE
		bcs	LA9FF
ENDIF

;;
.LAA48		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&B7				; ERR=183
		EQUS	"Outside file"
		EQUB	&00

; OSARGS 2,Y - Read EXT
; ---------------------
.LAA59		dex
		bne	LAA75
		ldx	ZP_ADFS_C3_SAVE_X
		lda	WKSP_ADFS_352,Y
		sta	&00,X
		lda	WKSP_ADFS_348,Y
		sta	&01,X
		lda	WKSP_ADFS_33E,Y
		sta	&02,X
		lda	WKSP_ADFS_334,Y
		sta	&03,X
.LAA72		jmp	LA9D0

; OSARGS 3,Y - Write EXT
; ----------------------
.LAA75		dex
		bne	LAAB9
		ldx	ZP_ADFS_C3_SAVE_X
		lda	WKSP_ADFS_3AC_CH_FLAGS,Y
		bmi	LAA82
		jmp	LB0FA
;;
.LAA82
IF OPTIMISE<4
		lda	&00,X
		sta	WKSP_ADFS_29A
		lda	&01,X
		sta	WKSP_ADFS_29B
		lda	&02,X
		sta	WKSP_ADFS_29C
		lda	&03,X
		sta	WKSP_ADFS_29D
		jsr	LAE68
		ldx	ZP_ADFS_C3_SAVE_X
		ldy	ZP_ADFS_CF_CHANNEL_OFFS
ELSE
		jsr	ArgsData			; Copy data to channel info
ENDIF
		lda	&00,X
		sta	WKSP_ADFS_352,Y
		lda	&01,X
		sta	WKSP_ADFS_348,Y
		lda	&02,X
		sta	WKSP_ADFS_33E,Y
		lda	&03,X
		sta	WKSP_ADFS_334,Y
		jsr	Compare_WKSP_ADFS_334_X_to_WKSP_ADFS_35C
		bcs	LAA72
		jmp	LA9E2

IF OPTIMISE>=4
.ArgsData
		lda	&00,X
		sta	WKSP_ADFS_29A
		lda	&01,X
		sta	WKSP_ADFS_29B
		lda	&02,X
		sta	WKSP_ADFS_29C
		lda	&03,X
		sta	WKSP_ADFS_29D
		jsr	LAE68
		ldx	ZP_ADFS_C3_SAVE_X
		ldy	ZP_ADFS_CF_CHANNEL_OFFS
		rts
ENDIF

;; OSARGS 4+,Y - treat as OSARGS &FF,Y - Ensure File
;; -------------------------------------------------
.LAAB9		ldx	#&10
.LAABB		lda	WKSP_ADFS_204,X
		lsr	A
		and	#&0F
		cmp	ZP_ADFS_CF_CHANNEL_OFFS
		bne	LAAD0
		jsr	LAB06
		lda	WKSP_ADFS_204,X
		and	#&01
		sta	WKSP_ADFS_204,X
.LAAD0		dex
		dex
		dex
		dex
		bpl	LAABB
IF TARGETOS <= 1
		jmp	_lbbcA976
ELSE
		jmp	LA98C				; Exit
ENDIF

IF HD_MMC
		include	"MMC_DriverBGETBPUT.asm"
ELIF HD_IDE
		include "IDE_DriverBGETBPUT.asm"
ELIF HD_SCSI
		include "SCSI_DriverBGETBPUT.asm"
ELIF HD_SCSI2
		include "SCSI2_DriverBGETBPUT.asm"
ENDIF

.LAB03		jsr	LACE6				; Check checksum
.LAB06
IF NOT(HD_MMC) AND NOT(HD_SCSI2)
		jsr	LABB4				; Check for IRQ flagging data lost
ENDIF
		lda	WKSP_ADFS_204,X
		cmp	#&C0
		bcc	LAB88				; Exit
.LAB10		txa
		lsr	A
		lsr	A
		adc	#>WKSP_ADFS_900_RND_BUFFER	; &BC/D=>&C900
		sta	&BD
		lda	#&00
		sta	&BC
		lda	WKSP_ADFS_204,X
		and	#&BF
		sta	WKSP_ADFS_204,X
		and	#&1E
		ror	A
		ora	#CHANNEL_RANGE_LO
		sta	WKSP_ADFS_2D4			; Save channel number for error message
		lda	WKSP_ADFS_201,X
		sta	WKSP_ADFS_2D0_ERR_SECTOR
		lda	WKSP_ADFS_202,X
		sta	WKSP_ADFS_2D0_ERR_SECTOR+1
		lda	WKSP_ADFS_203,X
		sta	WKSP_ADFS_2D0_ERR_SECTOR+2
		jsr	LB56C				; ?
		jsr	CommandSetRetries		; Set default retries
		stx	&C1				; TODO: optimise this away?
IF FLOPPY
		lda	ZP_ADFS_FLAGS			; Get ADFS status byte
		and	#ADFS_FLAGS_HD_PRESENT		; Is hard drive present?
		beq	LAB50				; No hard drive, jump forward to do floppy
		lda	WKSP_ADFS_203,X			; Get drive
		bpl	HD_BPUT_WriteSector		; Hard drive, jump ahead
.LAB50		ldx	&C1
		jsr	ExecFloppyWriteBPUTSectorIND
		beq	RestoreChanInXrts
		dec	ZP_ADFS_RETRY_CTDN
		bpl	LAB50
ENDIF
.LAB5BJmpGenerateError		
		jmp	GenerateError				; Generate disk error

IF HD_IDE
		include "IDE_DriverBPUT.asm"
ELIF HD_MMC
		include "MMC_DriverBPUT.asm"
ELIF HD_SCSI
		include "SCSI_DriverBPUT.asm"
ELIF HD_SCSI2
		include "SCSI2_DriverBPUT.asm"
ENDIF

.RestoreChanInXrts		
		ldx	&C1				; Restore X, offset to channel info
IF HD_MMC
.Svc5_IRQ
ENDIF
.LAB88		rts

IF HD_IDE
		include "IDE_DriverSvc5.asm"
ELIF HD_MMC
		include "MMC_DriverSvc5.asm"
ELIF HD_SCSI
		include "SCSI_DriverSvc5.asm"
ELIF HD_SCSI2
		include "SCSI2_DriverSvc5.asm"
ENDIF




; Get pointer to channel buffer
; -----------------------------
.LABD8		txa
		stx	WKSP_ADFS_2A1
		lsr	A
		lsr	A
		adc	#>WKSP_ADFS_900_RND_BUFFER
		sta	&BF				; &BE/F=>buffer at &C900+256*handle
		lda	#<WKSP_ADFS_900_RND_BUFFER
		sta	&BE
.LABE6		rts
;;
;;
.LABE7		ldx	#&10
		stx	WKSP_ADFS_295
		tay
.LABED		lda	WKSP_ADFS_204,X
		and	#&01
		beq	LABF7
		stx	WKSP_ADFS_295
.LABF7		lda	WKSP_ADFS_204,X
		bpl	LAC71
		lda	WKSP_ADFS_201,X
		cmp	WKSP_ADFS_296
		bne	LAC71
		lda	WKSP_ADFS_202,X
		cmp	WKSP_ADFS_297
		bne	LAC71
		lda	WKSP_ADFS_203,X
		cmp	WKSP_ADFS_298
		bne	LAC71
		jsr	LABD8
.LAC17		tya
		lsr	A
		and	#&40
		ora	WKSP_ADFS_204,X
		ror	A
		and	#&E0
		ora	ZP_ADFS_CF_CHANNEL_OFFS
		php
		clc
		rol	A
		sta	WKSP_ADFS_204,X
		plp
		bcc	LAC4A
		ldy	#&10
.LAC2E		lda	WKSP_ADFS_204,Y
		bne	LAC3A
		lda	#&01
		sta	WKSP_ADFS_204,Y
		bne	LAC6E
.LAC3A		dey
		dey
		dey
		dey
		bpl	LAC2E
		jsr	Xminus4_16ifneg
		ror	WKSP_ADFS_204,X
		sec
		rol	WKSP_ADFS_204,X
.LAC4A		inx
		inx
		inx
		inx
		cpx	#&11
		bcc	LAC54
		ldx	#&00
.LAC54		lda	WKSP_ADFS_204,X
		lsr	A
		beq	LAC6E
		bcc	LAC6E
		clc
		rol	A
		sta	WKSP_ADFS_204,X
		jsr	Xminus4_16ifneg
		jsr	Xminus4_16ifneg
		ror	WKSP_ADFS_204,X
		sec
		rol	WKSP_ADFS_204,X
.LAC6E		jmp	LAB03
;;
.LAC71		dex
		dex
		dex
		dex
		bmi	LAC7A
		jmp	LABED
;;
.LAC7A		ldx	WKSP_ADFS_295
		lda	WKSP_ADFS_296
		sta	WKSP_ADFS_201,X
		sta	WKSP_ADFS_2D0_ERR_SECTOR
		lda	WKSP_ADFS_297
		sta	WKSP_ADFS_202,X
		sta	WKSP_ADFS_2D0_ERR_SECTOR+1
		lda	WKSP_ADFS_298
		sta	WKSP_ADFS_203,X
		sta	WKSP_ADFS_2D0_ERR_SECTOR+2
		jsr	LABD8
		lda	WKSP_ADFS_298
		jsr	LB56C
		sty	&B1
		stx	&B0
		jsr	CommandSetRetries
.LACA8		ldx	&B0
IF FLOPPY
		lda	ZP_ADFS_FLAGS			; Get ADFS status byte
		and	#ADFS_FLAGS_HD_PRESENT		; Is hard drive present?
		beq	LACB5
ENDIF
		lda	WKSP_ADFS_203,X
		bpl	HD_BGET_ReadSector
IF FLOPPY
.LACB5		jsr	ExecFloppyReadBPUTSectorIND
		beq	LACDA
ENDIF
.LACBA		dec	ZP_ADFS_RETRY_CTDN		; Decrement retries
		bpl	LACA8				; Loop to rey again
		jmp	GenerateError			; Generate a disk error

IF HD_IDE
		include "IDE_DriverBGET.asm"
ELIF HD_MMC
		include "MMC_DriverBGET.asm"
ELIF HD_SCSI
		include "SCSI_DriverBGET.asm"
ELIF HD_SCSI2
		include "SCSI2_DriverBGET.asm"
ENDIF


		bne	LACBA				; Retry if error occured
.LACDA		ldx	&B0				; Restore X & Y
		ldy	&B1
		lda	#&81
		sta	WKSP_ADFS_204,X
		jmp	LAC17
;;
.LACE6		ldx	#&10
.LACE8		lda	WKSP_ADFS_204,X
		and	#&01
		bne	LAD24
		dex
		dex
		dex
		dex
		bpl	LACE8
		jmp	LA76E
;;
.LACF8		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&DE				; ERR=222
		EQUS	"Channel"
		EQUB	&00
;;
.Xminus4_16ifneg		
		dex
		dex
		dex
		dex
		bpl	LAD0C
		ldx	#&10
.LAD0C		rts
;;
;; Check channel and get channel flags
;; -----------------------------------
.CheckSetChannelY		
		sty	ZP_ADFS_C2_SAVE_Y		; Save channel
		sty	WKSP_ADFS_2D5_CUR_CHANNEL
		cpy	#CHANNEL_RANGE_HI+1		; Check channel is in range
		bcs	LACF8				; Too high - error
		tya
		sec
		sbc	#CHANNEL_RANGE_LO
		bcc	LACF8				; Too low - error
		sta	ZP_ADFS_CF_CHANNEL_OFFS		; Store channel offset
		tax
		lda	WKSP_ADFS_3AC_CH_FLAGS,X	; Get channel flags
		beq	LACF8				; Channel not open - error
.LAD24		rts
;;
;; &C3AC,X channel flags
;; &C334,X
;; &C33E,X
;; &C348,X
;; &C352,X
;; &C35C,X
;; &C366,X
;; &C370,X
;; &C37A,X
;;
;; Compare something
;; -----------------
.Compare_WKSP_ADFS_334_X_to_WKSP_ADFS_35C		
		ldx	ZP_ADFS_CF_CHANNEL_OFFS		; Get channel offset
		lda	WKSP_ADFS_334,X
		cmp	WKSP_ADFS_35C,X			; Compare something
		bne	LAD48				; Different, so end with NE+CC/CS
		lda	WKSP_ADFS_33E,X
		cmp	WKSP_ADFS_366,X			; Compare something
		bne	LAD48				; Different, so end with NE+CC/CS
		lda	WKSP_ADFS_348,X
		cmp	WKSP_ADFS_370,X			; Compare something
		bne	LAD48				; Different, so end with NE+CC/CS
		lda	WKSP_ADFS_352,X
		cmp	WKSP_ADFS_37A,X			; Compare something
		bne	LAD48				; Different, so end with NE+CC/CS
		clc					; All same, set EQ+CC
.LAD48		rts
;;
;; FSC 1 - Read EOF
;; ================
.LAD49		ldy	&B4
		jsr	CheckSetChannelY
		ror	A
		bcs	LAD5A
		jsr	LA77F
		jsr	LB1E9
		jsr	Compare_WKSP_ADFS_334_X_to_WKSP_ADFS_35C
.LAD5A		ldx	#&00
		bcs	LAD5F
		dex
.LAD5F		
IF TARGETOS<>0 OR NOT(HD_SCSI)
		ldy	&B5
ENDIF
		rts
;;
.brkEOFandReloadFSM		
		lda	WKSP_ADFS_3AC_CH_FLAGS,X
		and	#&C8
		sta	WKSP_ADFS_3AC_CH_FLAGS,X	; 		WRONG? Clear 'pending EOF' flag
		jsr	ReloadFSMandDIR_ThenBRK		; Generate an error
		EQUB	&DF				; ERR=223
		EQUS	"EOF"
		EQUB	&00
;;
;; OSBGET
;; ======
.my_OSBGET	stx	ZP_ADFS_C3_SAVE_X		; Save X
		jsr	CheckSetChannelY		; Check channel and get flags
		ror	A
		bcs	LAD9C
		and	#CH_FLAGS_EOF>>1		; Gone past EOF?
		bne	brkEOFandReloadFSM		; Generate EOF error
		jsr	Compare_WKSP_ADFS_334_X_to_WKSP_ADFS_35C				; Compare something
		bcs	LAD9C				; CS+NE, ok to read byte
		bne	brkEOFandReloadFSM		; Not same, so generate 'EOF' error
		jsr	LA77F				; Check various checksums
		ldx	ZP_ADFS_CF_CHANNEL_OFFS		; Get offset to channel
		lda	WKSP_ADFS_3AC_CH_FLAGS,X	; Get channel flag
		and	#&C0
		ora	#CH_FLAGS_EOF			; Set 'pending EOF' flag, next call will error
		sta	WKSP_ADFS_3AC_CH_FLAGS,X
IF OPTIMISE<6
		ldy	ZP_ADFS_C2_SAVE_Y		; Restore Y
		ldx	ZP_ADFS_C3_SAVE_X		; Restore X
		sec					; Return 'EOF met'
		lda	#&FE				; EOF value
		rts					; Return
ELSE
		lda	#&FE				; EOF value
		sec					; Return 'EOF met'
		bcs	LADCE				; Restore X,Y and return
ENDIF

;;
;; Read byte from channel
;; ----------------------
.LAD9C		ldx	ZP_ADFS_CF_CHANNEL_OFFS				; Get channel offset
IF OPTIMISE<4
		clc
		lda	WKSP_ADFS_3CA,X
		adc	WKSP_ADFS_370,X
		sta	WKSP_ADFS_296
		lda	WKSP_ADFS_3C0,X
		adc	WKSP_ADFS_366,X
		sta	WKSP_ADFS_297
		lda	WKSP_ADFS_3B6,X
		adc	WKSP_ADFS_35C,X
		sta	WKSP_ADFS_298			; &C296/7/8=&C3CA/B/C,X+&C370/1/2,X
		lda	#&40
		jsr	LABE7				; Manipulate various things
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		ldy	WKSP_ADFS_37A,X			; Y=low byte of PTR, offset into buffer
ELSE
		lda	#&40
		jsr	ChannelUpdate
ENDIF
		lda	#&00
		sta	WKSP_ADFS_2CF
		jsr	LB180
		lda	(&BE),Y				; Get byte from buffer
IF OPTIMISE>=6
		clc					; Clear EOF flag
ENDIF
.LADCE		ldy	ZP_ADFS_C2_SAVE_Y				; Restore Y
		ldx	ZP_ADFS_C3_SAVE_X				; Restore X
IF OPTIMISE<6
		clc					; Return 'EOF not met'
ENDIF
		rts					; Return

.LADD4		ldy	#&02
.LADD6		lda	WKSP_ADFS_314,Y
		sta	WKSP_ADFS_230,Y
		dey
		bpl	LADD6
		lda	WKSP_ADFS_317_CURDRV
		sta	WKSP_ADFS_233
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		lda	WKSP_ADFS_3B6,X
		and	#&E0
		sta	WKSP_ADFS_22F
		lda	WKSP_ADFS_3E8,X
		sta	WKSP_ADFS_22C_CSD
		lda	WKSP_ADFS_3DE,X
		sta	WKSP_ADFS_22C_CSD + 1
		lda	WKSP_ADFS_3D4,X
		sta	WKSP_ADFS_22C_CSD + 2
		jsr	L89D8
		ldy	#&02
.LAE06		lda	WKSP_ADFS_230,Y
		sta	WKSP_ADFS_22C_CSD,Y
		dey
		bpl	LAE06
		lda	WKSP_ADFS_233
		sta	WKSP_ADFS_22F
		jsr	LB4DF
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		lda	WKSP_ADFS_3CA,X
		sta	WKSP_ADFS_234
		lda	WKSP_ADFS_3C0,X
		sta	WKSP_ADFS_235
		lda	WKSP_ADFS_3B6,X
		and	#&1F
		sta	WKSP_ADFS_236
		lda	#<WKSP_ADFS_405_DIR_START
		sta	&B8
		lda	#>WKSP_ADFS_405_DIR_START
		sta	&B9
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
.LAE38
IF USE65C12 AND OPTIMISE >= 1
		lda	(&B8)
ELSE
		ldy	#&00
		lda	(&B8),Y
ENDIF
		bne	LAE44				; Not &00, exit
		sta	WKSP_ADFS_3AC_CH_FLAGS,X
		jmp	LA76E				; Jump to 'Bad sum' error
;;
.LAE44		ldy	#&19
		lda	(&B8),Y
		cmp	WKSP_ADFS_3F2,X
		bne	LAE5B
		dey
.LAE4E		lda	(&B8),Y
		cmp	WKSP_ADFS_21E_DSKOPSAV_SECCNT,Y
		bne	LAE5B
		dey
		cpy	#&16
		bcs	LAE4E
		rts
;;
.LAE5B		lda	&B8
		clc
		adc	#&1A
		sta	&B8
		bcc	LAE38
		inc	&B9
		bcs	LAE38

.LAE68
IF USE65C12 AND OPTIMISE >= 1
		stz	WKSP_ADFS_2B5
ELSE
		lda	#&00
		sta	WKSP_ADFS_2B5
ENDIF
.LAE6D		lda	WKSP_ADFS_22F
		sta	WKSP_ADFS_2BF
		ldx	#&02
.LAE75		lda	WKSP_ADFS_22C_CSD,X
		sta	WKSP_ADFS_2BC,X
		dex
		bpl	LAE75
		lda	#&FF
		sta	WKSP_ADFS_22E
		sta	WKSP_ADFS_22F
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		lda	WKSP_ADFS_384,X
		cmp	WKSP_ADFS_29D
		bne	LAEA6
		lda	WKSP_ADFS_38E,X
		cmp	WKSP_ADFS_29C
		bne	LAEA6
		lda	WKSP_ADFS_398,X
		cmp	WKSP_ADFS_29B
		bne	LAEA6
		lda	WKSP_ADFS_3A2,X
		cmp	WKSP_ADFS_29A
.LAEA6		bcc	LAED0
		lda	WKSP_ADFS_334,X
		cmp	WKSP_ADFS_29D
		bne	LAECB
		lda	WKSP_ADFS_33E,X
		cmp	WKSP_ADFS_29C
		bne	LAECB
		lda	WKSP_ADFS_348,X
		cmp	WKSP_ADFS_29B
		bne	LAECB
		lda	WKSP_ADFS_352,X
		cmp	WKSP_ADFS_29A
		bne	LAECB
.LAEC8		jmp	LB0DA
;;
.LAECB		bcs	LAEC8
		jmp	LAFE4
;;

.LAED0	

IF TARGETOS <= 1
._lbbcAEC1
		sec					; AEC1 38                       8
		lda	#$00				; AEC2 A9 00                    ..
		adc	$109C				; AEC4 6D 9C 10                 m..
		sta	$109E				; AEC7 8D 9E 10                 ...
		lda	#$00				; AECA A9 00                    ..
		adc	$109D				; AECC 6D 9D 10                 m..
		sta	$109F				; AECF 8D 9F 10                 ...
		bcc	_lbbcAED7			; AED2 90 03                    ..
		jmp	L867F				; AED4 4C 56 86
._lbbcAED7

ENDIF


		jsr	LADD4
		lda	WKSP_ADFS_3A2,X
		cmp	#&01
		lda	WKSP_ADFS_398,X
		adc	#&00
		sta	WKSP_ADFS_237
		lda	WKSP_ADFS_38E,X
		adc	#&00
		sta	WKSP_ADFS_237 + 1
		lda	WKSP_ADFS_384,X
		adc	#&00
		sta	WKSP_ADFS_237 + 2


IF TARGETOS > 1
		jsr	L84E1
		stz	WKSP_ADFS_23D
		stz	WKSP_ADFS_23E
		stz	WKSP_ADFS_23F
		ldx	WKSP_ADFS_100_FSM_S1 + &FE
.LAEFF		lda	WKSP_ADFS_23F
		cmp	WKSP_ADFS_000_FSM_S0 + &FF,X
		bcc	LAF1B
		bne	LAF2A
		lda	WKSP_ADFS_23E
		cmp	WKSP_ADFS_000_FSM_S0 + &FE,X
		bcc	LAF1B
		bne	LAF2A
		lda	WKSP_ADFS_23D
		cmp	WKSP_ADFS_000_FSM_S0 + &FD,X
		bcs	LAF2A
.LAF1B		ldy	#&02
.LAF1D		lda	WKSP_ADFS_000_FSM_S0 + &FF,X
		sta	WKSP_ADFS_23D,Y
		dex
		dey
		bpl	LAF1D
		txa
IF USE65C12
		bra	LAF2D
ELSE
		jmp	LAF2D
ENDIF
;;
.LAF2A		dex
		dex
		dex
.LAF2D		bne	LAEFF
		ldx	#&03
.LAF31		lda	WKSP_ADFS_23C,X
		cmp	WKSP_ADFS_29A,X
		bne	LAF3F
		dex
		bne	LAF31
		cpx	WKSP_ADFS_29A
.LAF3F		lda	WKSP_ADFS_29C
		ldy	WKSP_ADFS_29D
IF USE65C12
		inc	A
ELSE
		cmp	#&FF
ENDIF
		bne	LAF4E
		iny
		bne	LAF4E
		jmp	L867F
;;
.LAF4E		bcc	LAF5E
		cpy	WKSP_ADFS_23F
		bcc	LAF5E
		bne	LAF67
		cmp	WKSP_ADFS_23E
		bcc	LAF5E
		bne	LAF67
.LAF5E		sty	WKSP_ADFS_23F
		sta	WKSP_ADFS_23E
IF USE65C12
		stz	WKSP_ADFS_23D
ELSE
		ldx	#0
		stx	WKSP_ADFS_23D
ENDIF
		

ELSE							; TARGETOS <= 1
		lda	#0
		sta	WKSP_ADFS_23D
		lda	WKSP_ADFS_29E
		sta	WKSP_ADFS_23E
		lda	WKSP_ADFS_29F
		sta	WKSP_ADFS_23F
		jsr	L84E1
		
ENDIF	; TARGETOS <= 1

.LAF67		jsr	L865B
		ldy	#&12
		lda	#&00
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		sta	(&B8),Y
		sta	WKSP_ADFS_3A2,X
		iny
IF TARGETOS > 1
		lda	WKSP_ADFS_23D
ENDIF
		sta	(&B8),Y
		sta	WKSP_ADFS_398,X
IF TARGETOS > 1
		lda	WKSP_ADFS_23E
ELSE
		lda	WKSP_ADFS_29E
ENDIF
		iny
		sta	(&B8),Y
		sta	WKSP_ADFS_38E,X
IF TARGETOS > 1
		lda	WKSP_ADFS_23F
ELSE
		lda	WKSP_ADFS_29F
ENDIF

		iny
		sta	(&B8),Y
		sta	WKSP_ADFS_384,X
		lda	WKSP_ADFS_23A
		iny
		sta	(&B8),Y
		sta	WKSP_ADFS_3CA,X
		lda	WKSP_ADFS_23B
		iny
		sta	(&B8),Y
		sta	WKSP_ADFS_3C0,X
		lda	WKSP_ADFS_23C
		iny
		sta	(&B8),Y
		ora	WKSP_ADFS_317_CURDRV
		sta	WKSP_ADFS_3B6,X
		jsr	L8F91
IF USE65C12
		lda	#ADFS_FLAGS_WTF
		trb	ZP_ADFS_FLAGS
ELSE
		lda	ZP_ADFS_FLAGS
		and	#ADFS_FLAGS_WTF EOR &FF
		sta	ZP_ADFS_FLAGS
ENDIF
		lda	#>WKSP_ADFS_409
		sta	WKSP_ADFS_260
		lda	#<WKSP_ADFS_409
		sta	WKSP_ADFS_261


		ldx	#&00
		ldy	#&02
.LAFC3		lda	WKSP_ADFS_234,Y
		sta	WKSP_ADFS_2A2,Y
		cmp	WKSP_ADFS_23A,Y
		beq	LAFD2
		inx
		lda	WKSP_ADFS_23A,Y
.LAFD2		sta	WKSP_ADFS_2A8,Y
		lda	WKSP_ADFS_237,Y
		sta	WKSP_ADFS_2A5,Y
		dey
		bpl	LAFC3
		txa
		beq	LAFE4
		jsr	L96AC

.LAFE4		lda	WKSP_ADFS_2B5
		beq	LAFEC
		jmp	LB0BD



;;
.LAFEC		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		clc
		lda	WKSP_ADFS_348,X
		adc	WKSP_ADFS_3CA,X
		sta	WKSP_ADFS_296
		lda	WKSP_ADFS_33E,X
		adc	WKSP_ADFS_3C0,X
		sta	WKSP_ADFS_297
		lda	WKSP_ADFS_334,X
		adc	WKSP_ADFS_3B6,X
		sta	WKSP_ADFS_298
		lda	#&C0
		jsr	LABE7
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		ldy	WKSP_ADFS_352,X
		lda	#&00
.LB016		sta	(&BE),Y
		iny
		bne	LB016
		lda	WKSP_ADFS_29B
		clc
		adc	WKSP_ADFS_3CA,X
		sta	WKSP_ADFS_234
		lda	WKSP_ADFS_29C
		adc	WKSP_ADFS_3C0,X
		sta	WKSP_ADFS_235
		lda	WKSP_ADFS_29D
		adc	WKSP_ADFS_3B6,X
		sta	WKSP_ADFS_236
		lda	WKSP_ADFS_29A
		bne	LB04F
		lda	WKSP_ADFS_234
		bne	LB04C
		lda	WKSP_ADFS_235
		bne	LB049
		dec	WKSP_ADFS_236
.LB049		dec	WKSP_ADFS_235
.LB04C		dec	WKSP_ADFS_234
.LB04F		lda	WKSP_ADFS_234
		cmp	WKSP_ADFS_296
		bne	LB06A
		lda	WKSP_ADFS_235
		cmp	WKSP_ADFS_297
		bne	LB06A
		lda	WKSP_ADFS_236
		cmp	WKSP_ADFS_298
		bne	LB06A
		jmp	LB0BD
;;
.LB06A		jsr	WaitEnsuring
		inc	WKSP_ADFS_296
		bne	LB07A
		inc	WKSP_ADFS_297
		bne	LB07A
		inc	WKSP_ADFS_298
.LB07A		lda	#&40
		jsr	LABE7
		ldy	#&00
		tya
.LB082		sta	(&BE),Y
		iny
		bne	LB082
.LB087		ldx	WKSP_ADFS_2A1
		lda	#&C0
		ora	WKSP_ADFS_204,X
		sta	WKSP_ADFS_204,X
		jsr	LAB06
		lda	WKSP_ADFS_234
		cmp	WKSP_ADFS_201,X
		bne	LB0AD
		lda	WKSP_ADFS_235
		cmp	WKSP_ADFS_202,X
		bne	LB0AD
		lda	WKSP_ADFS_236
		cmp	WKSP_ADFS_203,X
		beq	LB0BD
.LB0AD		inc	WKSP_ADFS_201,X
		bne	LB087
		inc	WKSP_ADFS_202,X
		bne	LB087
		inc	WKSP_ADFS_203,X
IF USE65C12 AND OPTIMISE >= 1
		bra	LB087
ELSE
		jmp	LB087
ENDIF
;;
.LB0BD		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		lda	WKSP_ADFS_29A
		sta	WKSP_ADFS_352,X
		lda	WKSP_ADFS_29B
		sta	WKSP_ADFS_348,X
		lda	WKSP_ADFS_29C
		sta	WKSP_ADFS_33E,X
		lda	WKSP_ADFS_29D
		sta	WKSP_ADFS_334,X
		jsr	L89D8
.LB0DA		lda	WKSP_ADFS_2BF
		sta	WKSP_ADFS_22F
		ldx	#&02
.LB0E2		lda	WKSP_ADFS_2BC,X
		sta	WKSP_ADFS_22C_CSD,X
		dex
		bpl	LB0E2
		rts
;;
;; OSBPUT
;; ======
.my_OSBPUT		
		stx	ZP_ADFS_C3_SAVE_X				; Save X
		pha					; Save output byte
		jsr	CheckSetChannelY				; Check channel and get flags
		ldy	#&00
		sty	WKSP_ADFS_2CF
		tay
		bmi	LB112				; Channel is writable
.LB0FA		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&C1				; ERR=193
		EQUS	"Not open for update"
		EQUB	&00
;;
.LB112		lda	WKSP_ADFS_3AC_CH_FLAGS,X
		and	#&07
		cmp	#&06
		bcs	LB14D
		cmp	#&03
		beq	LB14D
		lda	WKSP_ADFS_37A,X
		sec
		adc	#&00
		sta	WKSP_ADFS_29A
		lda	WKSP_ADFS_370,X
		adc	#&00
		sta	WKSP_ADFS_29B
		lda	WKSP_ADFS_366,X
		adc	#&00
		sta	WKSP_ADFS_29C
		lda	WKSP_ADFS_35C,X
		adc	#&00
		sta	WKSP_ADFS_29D
		pla
		jsr	LA77F
		pha
		dec	WKSP_ADFS_2CF
		jsr	LAE68
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
.LB14D
IF OPTIMISE<4
		clc
		lda	WKSP_ADFS_3CA,X
		adc	WKSP_ADFS_370,X
		sta	WKSP_ADFS_296
		lda	WKSP_ADFS_3C0,X
		adc	WKSP_ADFS_366,X
		sta	WKSP_ADFS_297
		lda	WKSP_ADFS_3B6,X
		adc	WKSP_ADFS_35C,X
		sta	WKSP_ADFS_298
		lda	#&C0
		jsr	LABE7
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		ldy	WKSP_ADFS_37A,X
ELSE
		lda	#&C0
		jsr	ChannelUpdate
ENDIF
		pla
		sta	(&BE),Y				; Store byte in buffer
		pha
		jsr	LB180
		pla
		ldy	ZP_ADFS_C2_SAVE_Y
		ldx	ZP_ADFS_C3_SAVE_X
.LB17F		rts

IF OPTIMISE>=4
.ChannelUpdate
		pha
		clc
		lda	WKSP_ADFS_3CA,X
		adc	WKSP_ADFS_370,X
		sta	WKSP_ADFS_296
		lda	WKSP_ADFS_3C0,X
		adc	WKSP_ADFS_366,X
		sta	WKSP_ADFS_297
		lda	WKSP_ADFS_3B6,X
		adc	WKSP_ADFS_35C,X
		sta	WKSP_ADFS_298			; &C296/7/8=&C3CA/B/C,X+&C370/1/2,X
		pla
		jsr	LABE7				; Manipulate various things
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		ldy	WKSP_ADFS_37A,X			; Y=low byte of PTR, offset into buffer
		rts
ENDIF

.LB180		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		inc	WKSP_ADFS_37A,X
		bne	LB17F
		bit	WKSP_ADFS_2CF
		bmi	LB18F
		jsr	LA77F
.LB18F		inc	WKSP_ADFS_370,X
		bne	LB19C
		inc	WKSP_ADFS_366,X
		bne	LB19C
		inc	WKSP_ADFS_35C,X
.LB19C		jsr	LB1E9
		pha
		sec
		lda	WKSP_ADFS_370,X
		sbc	WKSP_ADFS_348,X
		lda	WKSP_ADFS_366,X
		sbc	WKSP_ADFS_33E,X
		lda	WKSP_ADFS_35C,X
		sbc	WKSP_ADFS_334,X
		bcc	LB1DE
		lda	WKSP_ADFS_37A,X
		cmp	WKSP_ADFS_352,X
		bne	LB1C1
		pla
		ora	#&04
		pha
.LB1C1		sec
		lda	WKSP_ADFS_348,X
		sbc	WKSP_ADFS_398,X
		lda	WKSP_ADFS_33E,X
		sbc	WKSP_ADFS_38E,X
		lda	WKSP_ADFS_334,X
		sbc	WKSP_ADFS_384,X
		bcc	LB1D9
		pla
		bne	LB1E1
.LB1D9		pla
		ora	#&02
		bne	LB1E1
.LB1DE		pla
		ora	#&03
.LB1E1		bmi	LB1E5
		and	#&F9
.LB1E5		sta	WKSP_ADFS_3AC_CH_FLAGS,X
		rts
;;
.LB1E9		ldx	ZP_ADFS_CF_CHANNEL_OFFS				; Get channel offset
		lda	WKSP_ADFS_3AC_CH_FLAGS,X
		pha
		and	#&04
		beq	LB20B
		lda	WKSP_ADFS_37A,X
		sta	WKSP_ADFS_352,X
		lda	WKSP_ADFS_370,X
		sta	WKSP_ADFS_348,X
		lda	WKSP_ADFS_366,X
		sta	WKSP_ADFS_33E,X
		lda	WKSP_ADFS_35C,X
		sta	WKSP_ADFS_334,X
.LB20B		pla
		and	#&C0
		bne	LB1E5

.starCLOSE		
		lda	#&00				; A=0 for CLOSE
		tay					; CLOSE#0 - close all open channels
;;
;;
;; OSFIND - Open a file or close a channel
;; =======================================
.my_OSFIND		jsr	LA77F				; Check checksums
		stx	WKSP_ADFS_240
		stx	&B4
		stx	&C5				; Store X -> filename
		sty	&C4
		sty	WKSP_ADFS_241
		sty	&B5				; Store Y -> filename
		and	#&C0				; Open or close?
		ldy	#&00
		sty	WKSP_ADFS_2D5_CUR_CHANNEL
		tay					; Zero A and Y
		bne	LB231				; Jump ahead for open
		jmp	LB3E0				; Jump to close
;;
;; OPEN
;; ----
.LB231		lda	WKSP_ADFS_332			; Handle stored from *RUN?
		beq	LB23E				; No, do a real OPEN
		ldy	#&00
		sty	WKSP_ADFS_332			; Clear stored handle
		ldy	&B5				; Restore Y
		rts					; Return handle from *RUN
;;
;; Open a file
;; -----------
.LB23E		ldx	#&09				; Look for a spare channel
.LB240		lda	WKSP_ADFS_3AC_CH_FLAGS,X			; Check channel flags
		beq	LB260				; Found a spare channel
		dex					; Loop to next channel
		bpl	LB240				; Keep going until run out of channels
		jsr	ReloadFSMandDIR_ThenBRK				; Generate an error
		EQUB	&C0				; ERR=192
		EQUS	"Too many open files"
		EQUB	&00
;;
;; Found a spare channel
;; ---------------------
.LB260		stx	ZP_ADFS_CF_CHANNEL_OFFS				; Store channel offset
		sty	WKSP_ADFS_2A0
		tya
		bpl	LB26B
		jmp	LB33E
;;
.LB26B		jsr	L8FE8
		beq	LB275
		lda	#&00
		jmp	LB336
;
.LB275
IF OPTIMISE<4
		ldx	#&09
.LB277		lda	WKSP_ADFS_3AC_CH_FLAGS,X
		bpl	LB2AA
		lda	WKSP_ADFS_3B6,X
		and	#&E0
		cmp	WKSP_ADFS_317_CURDRV
		bne	LB2AA
		lda	WKSP_ADFS_3E8,X
		cmp	WKSP_ADFS_314
		bne	LB2AA
		lda	WKSP_ADFS_3DE,X
		cmp	WKSP_ADFS_315
		bne	LB2AA
		lda	WKSP_ADFS_3D4,X
		cmp	WKSP_ADFS_316
		bne	LB2AA
		ldy	#&19
		lda	(&B6),Y
		cmp	WKSP_ADFS_3F2,X
		bne	LB2AA
		jmp	L8D5E
.LB2AA		dex
		bpl	LB277
ELSE
		lda	#&80				; Only check b7 of channel flags
		jsr	CheckOpen			; Check if file not open
ENDIF
IF USE65C12 AND OPTIMISE >= 1
		lda	(&B6)				; Check 'R' bit
ELSE
		ldy	#&00
		lda	(&B6),Y				; Check 'R' bit
ENDIF
		bmi	LB2B6				; 'R' set, file can be opened
		jmp	L8BFB				; 'R' not set, jump to error
.LB2B6		ldy	#&12
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		lda	(&B6),Y
		sta	WKSP_ADFS_352,X
		iny
		lda	(&B6),Y
		sta	WKSP_ADFS_348,X
		iny
		lda	(&B6),Y
		sta	WKSP_ADFS_33E,X
		iny
		lda	(&B6),Y
		sta	WKSP_ADFS_334,X
.LB2D1		ldy	#&12
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		lda	(&B6),Y
		sta	WKSP_ADFS_3A2,X
		iny
		lda	(&B6),Y
		sta	WKSP_ADFS_398,X
		iny
		lda	(&B6),Y
		sta	WKSP_ADFS_38E,X
		iny
		lda	(&B6),Y
		sta	WKSP_ADFS_384,X
		iny
		lda	(&B6),Y
		sta	WKSP_ADFS_3CA,X
		iny
		lda	(&B6),Y
		sta	WKSP_ADFS_3C0,X
		iny
		lda	(&B6),Y
		ora	WKSP_ADFS_317_CURDRV
		sta	WKSP_ADFS_3B6,X
		iny
		lda	(&B6),Y
		sta	WKSP_ADFS_3F2,X
		lda	WKSP_ADFS_314
		sta	WKSP_ADFS_3E8,X
		lda	WKSP_ADFS_315
		sta	WKSP_ADFS_3DE,X
		lda	WKSP_ADFS_316
		sta	WKSP_ADFS_3D4,X
		lda	#&00
		sta	WKSP_ADFS_37A,X
		sta	WKSP_ADFS_370,X
		sta	WKSP_ADFS_366,X
		sta	WKSP_ADFS_35C,X
		lda	WKSP_ADFS_2A0
		sta	WKSP_ADFS_3AC_CH_FLAGS,X
		txa
		clc
		adc	#&30
		pha
		jsr	LB19C
		pla
.LB336		jsr	L89D8
		ldx	&C5
		ldy	&C4
		rts
;;
.LB33E		bit	WKSP_ADFS_2A0
		bvc	LB35B
		jsr	L8FE8
		php
		lda	#&00
		plp
		bne	LB336
		jsr	L8D2C				; Check if file is open
		ldy	#&01
		lda	(&B6),Y				; Check 'W' bit
		bmi	LB358				; 'W' present, can open file for writing
.LB355		jmp	L8BFB
.LB358		jmp	LB275

.LB35B		jsr	L8DC8
		jsr	L8FE8
		bne	LB36F
		jsr	L8D1B
		ldy	#&01
		lda	(&B6),Y
		bpl	LB355
		jmp	LB3CD
;;
.LB36F		lda	#&00
		ldx	#&0F
.LB373		sta	WKSP_ADFS_242,X
		dex
		bpl	LB373
		ldx	WKSP_ADFS_100_FSM_S1 + &FE
		lda	#&00
.LB37E		ora	WKSP_ADFS_000_FSM_S0 + &FE,X
		ora	WKSP_ADFS_000_FSM_S0 + &FF,X
		ldy	WKSP_ADFS_000_FSM_S0 + &FD,X
		cpy	WKSP_ADFS_24F
		bcc	LB38F
		sty	WKSP_ADFS_24F
.LB38F		dex
		dex
		dex
		bne	LB37E
		tay
		beq	LB39E
		stx	WKSP_ADFS_24F
		inx
		stx	WKSP_ADFS_250
.LB39E		lda	#&FF
		sta	WKSP_ADFS_246
		sta	WKSP_ADFS_247
		sta	WKSP_ADFS_248
		sta	WKSP_ADFS_249
		ldx	#<WKSP_ADFS_240
		stx	&B8
		ldy	#>WKSP_ADFS_240
		sty	&B9
		jsr	L89D8
		jsr	L8F57
		jsr	L8F91
		jsr	L89D5
		lda	WKSP_ADFS_240
		sta	&B4
		lda	WKSP_ADFS_241
		sta	&B5
		jsr	L8FE8
.LB3CD		lda	#&00
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		sta	WKSP_ADFS_352,X
		sta	WKSP_ADFS_348,X
		sta	WKSP_ADFS_33E,X
		sta	WKSP_ADFS_334,X
		jmp	LB2D1
;;
;; CLOSE a channel
;; ===============
.LB3E0		ldy	&C4				; Get handle
		bne	LB406				; Nonzero, close just this channel
IF TARGETOS <= 1
		txa
		pha
		lda	#OSBYTE_77_CLOSE
		jsr	OSBYTE
		pla
		sta	&C5
ENDIF
		ldx	#&09				; Loop for all channels
.LB3E6		lda	WKSP_ADFS_3AC_CH_FLAGS,X			; Get channel flag
		bne	LB3F7				; Jump to close this channel
.LB3EB		dex					; Loop for all channels
		bpl	LB3E6
		jsr	WaitEnsuring				; Wait until ensuring complete
		lda	#&00				; Clear A
		ldx	&C5				; Restore X
		tay					; Clear Y
		rts					; Returns with A and Y preserved
;;
;; Close a channel with X=offset
;; -----------------------------
.LB3F7		txa
		clc
		adc	#CHANNEL_RANGE_LO		; A=channel number for this offset
		sta	&B5
		stx	ZP_ADFS_CF_CHANNEL_OFFS				; Save X
		jsr	LB409				; Close this channel
		ldx	ZP_ADFS_CF_CHANNEL_OFFS				; Restore X
		bpl	LB3EB				; Jump back into close-all loop
;;
;; Close a channel with Y=handle
;; -----------------------------
.LB406		jsr	CheckSetChannelY				; Check channel and get flags
.LB409		jsr	LB1E9				; Check something and set flags
		ldy	WKSP_ADFS_3AC_CH_FLAGS,X			; Get flags
IF USE65C12
		stz	WKSP_ADFS_3AC_CH_FLAGS,X			; Clear flags
ELSE
		lda	#0
		sta	WKSP_ADFS_3AC_CH_FLAGS,X			; Clear flags
ENDIF
		tya					; Pass flags to A
		bpl	LB435				; Jump ahead if b7=0
		lda	WKSP_ADFS_352,X
		cmp	WKSP_ADFS_3A2,X
		bne	LB442
		lda	WKSP_ADFS_348,X
		cmp	WKSP_ADFS_398,X
		bne	LB442
		lda	WKSP_ADFS_33E,X
		cmp	WKSP_ADFS_38E,X
		bne	LB442
		lda	WKSP_ADFS_334,X
		cmp	WKSP_ADFS_384,X
		bne	LB442				; Jump ahead with difference
.LB435		jsr	LAAB9				; Write buffer?
		jsr	L89D8				; Do something with FSM
		lda	#&00
		ldy	&C4
		ldx	&C5
		rts
;;
;; Update directory entry?
;; -----------------------
.LB442		jsr	LADD4
		lda	WKSP_ADFS_352,X
		cmp	#&01
		lda	WKSP_ADFS_234
		adc	WKSP_ADFS_348,X
		sta	WKSP_ADFS_234
		lda	WKSP_ADFS_235
		adc	WKSP_ADFS_33E,X
		sta	WKSP_ADFS_235
		lda	WKSP_ADFS_236
		adc	WKSP_ADFS_334,X
		sta	WKSP_ADFS_236
		lda	WKSP_ADFS_3A2,X
		cmp	#&01
		lda	WKSP_ADFS_398,X
		sbc	WKSP_ADFS_348,X
		sta	WKSP_ADFS_237
		lda	WKSP_ADFS_38E,X
		sbc	WKSP_ADFS_33E,X
		sta	WKSP_ADFS_237 + 1
		lda	WKSP_ADFS_384,X
		sbc	WKSP_ADFS_334,X
		sta	WKSP_ADFS_237 + 2
		lda	WKSP_ADFS_352,X
		bne	LB497
		inc	WKSP_ADFS_237
		bne	LB497
		inc	WKSP_ADFS_237 + 1
		bne	LB497
		inc	WKSP_ADFS_237 + 2
.LB497		lda	WKSP_ADFS_352,X
		ldy	#&12
		sta	(&B8),Y
		lda	WKSP_ADFS_348,X
		iny
		sta	(&B8),Y
		lda	WKSP_ADFS_33E,X
		iny
		sta	(&B8),Y
		lda	WKSP_ADFS_334,X
		iny
		sta	(&B8),Y
		jsr	L84E1				; Calculate something in FSM
		jsr	L8F91
		jmp	LB435				; Jump back to write buffer
;;
.LB4B9		ldx	#&09
.LB4BB		lda	WKSP_ADFS_3AC_CH_FLAGS,X
		beq	LB4CA
		lda	WKSP_ADFS_3B6,X
		and	#&E0
		cmp	WKSP_ADFS_317_CURDRV
		beq	LB4DF
.LB4CA		dex
		bpl	LB4BB
;;
.LB4CD		lda	WKSP_ADFS_317_CURDRV
		jsr	LB5C5
		lda	WKSP_ADFS_100_FSM_S1 + &FB
		sta	WKSP_ADFS_321,X
		lda	WKSP_ADFS_100_FSM_S1 + &FC
		sta	WKSP_ADFS_322,X
.LB4DF		jsr	LB510				; Check elapsed time
.LB4E2		lda	WKSP_ADFS_317_CURDRV
		jsr	LB5C5
		lda	WKSP_ADFS_100_FSM_S1 + &FB
		cmp	WKSP_ADFS_321,X
		bne	LB4FF
		lda	WKSP_ADFS_100_FSM_S1 + &FC
		cmp	WKSP_ADFS_322,X
		bne	LB4FF
		jsr	LB560
		sta	WKSP_ADFS_2C2
		rts
;;
.LB4FF		jsr	ReloadFSMandDIR_ThenBRK
		EQUB	&C8				; ERR=200
		EQUS	"Disc changed"
		EQUB	&00
;;
.LB510		lda	#&01
		ldx	#<WKSP_ADFS_2C8			; XY=>&C2C8
		ldy	#>WKSP_ADFS_2C8
		jsr	&FFF1				; Read TIME to &C2C8 in workspace
		ldx	#&00
		ldy	#&04
		sec
.LB51E		lda	WKSP_ADFS_2C8,X			; Subtract from previous TIME
		pha
		sbc	WKSP_ADFS_2C3,X
		sta	WKSP_ADFS_2C8,X
		pla
		sta	WKSP_ADFS_2C3,X
		inx
		dey
		bpl	LB51E
		lda	WKSP_ADFS_2CC			; Check b24-b39 of difference
		ora	WKSP_ADFS_2CB
		ora	WKSP_ADFS_2CA
		bne	LB542				; <>&00, more than &10000cs
		lda	WKSP_ADFS_2C9			; Get difference b8-b15
		cmp	#&02				; &200cs? 5.12s?
		bcc	LB545				; <5.12s, return leaving &C2C2 unchanged
.LB542		sty	WKSP_ADFS_2C2			; >5.11s, set &C2C2 to &xx
.LB545		rts

.LB546		jsr	LB510				; Check elapsed time
		lda	WKSP_ADFS_317_CURDRV
		jsr	LB5C5
		jsr	LB560
		eor	WKSP_ADFS_2C2
		beq	LB545
IF OPTIMISE<5
		ldx	#<L8831				; Point to control block to load FSM
		ldy	#>L8831
		jsr	L82AE				; Load FSM
ELSE
		jsr	LoadFSM
ENDIF
IF USE65C12
		bra	LB4E2
ELSE
		jmp	LB4E2
ENDIF

.LB560		lda	#&FF
		clc
.LB563		rol	A
		dex
		dex
		bpl	LB563
		and	WKSP_ADFS_2C2
		rts
;;
.LB56C		and	#&E0
		sta	WKSP_ADFS_2CD
IF USE65C12
		phx
		phy
ELSE
		txa
		pha
		tya
		pha
ENDIF
		jsr	LB510				; Check elapsed time
		lda	WKSP_ADFS_2CD
		jsr	LB5C5
		jsr	LB560
		eor	WKSP_ADFS_2C2
		beq	LB5C2
		lda	WKSP_ADFS_2CD
IF USE65C12 AND OPTIMISE >= 1
		phx
ELSE
		tax
		pha
ENDIF
		lda	WKSP_ADFS_317_CURDRV
		sta	WKSP_ADFS_2CD
		ldy	WKSP_ADFS_22F
		cpy	#&FF
		bne	LB59C
		sta	WKSP_ADFS_22F
		sty	WKSP_ADFS_2CD
.LB59C		stx	WKSP_ADFS_317_CURDRV
		jsr	LB546
		ldy	WKSP_ADFS_2CD
		sty	WKSP_ADFS_317_CURDRV
		cpy	#&FF
		bne	LB5B5
		lda	WKSP_ADFS_22F
		sta	WKSP_ADFS_317_CURDRV
		sty	WKSP_ADFS_22F
.LB5B5		pla
		cmp	WKSP_ADFS_317_CURDRV
		beq	LB5C2
IF OPTIMISE<5
		ldx	#<L8831				; Point to control block to load FSM
		ldy	#>L8831
		jsr	L82AE
ELSE
		jsr	LoadFSM
ENDIF
.LB5C2
IF USE65C12
		ply
		plx
ELSE
		pla
		tay
		pla
		tax
ENDIF
		rts
;;
.LB5C5		lsr	A
		lsr	A
		lsr	A
		lsr	A
		tax
		rts
;;
.my_OSGBPB		jsr	LA77F
		sta	WKSP_ADFS_2B4
		sta	WKSP_ADFS_2B5
		sty	&C7
		stx	&C6
		ldy	#&01
		ldx	#&03
.LB5DC		lda	(&C6),Y
		sta	WKSP_ADFS_2B7,Y
		iny
		dex
		bpl	LB5DC
		lda	WKSP_ADFS_2B4
		cmp	#&05
		bcc	LB5F0				; OSGBPB <5 - read/write file data
		jmp	LB8DA				; OSGBPB 5+, read filing system information
;;
.LB5EF		rts
;;
.LB5F0		tay
		beq	LB5EF				; OSGBPB 0 - null
IF USE65C12 AND OPTIMISE >= 1
		lda	(&C6)
ELSE
		ldy	#&00
		lda	(&C6),Y				; Get handle
ENDIF
		tay
		jsr	CheckSetChannelY
		php
		jsr	LB1E9
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		lda	WKSP_ADFS_3B6,X
		jsr	LB56C
		plp
		bmi	LB614
		lda	WKSP_ADFS_2B4
		cmp	#&03
		bcs	LB614
		jmp	LB0FA
;;
.LB614		lda	WKSP_ADFS_2B4
		and	#&01
		beq	LB629
		ldy	#&0C
		ldx	#&03
.LB61F		lda	(&C6),Y
		sta	&C8,X
		dey
		dex
		bpl	LB61F
		lda	#&01
.LB629		ldy	ZP_ADFS_C2_SAVE_Y
		ldx	#&C8
		jsr	LA9AB
		clc
		ldx	#&03
		ldy	#&05
.LB635		lda	(&C6),Y
		adc	&00C3,Y
		sta	WKSP_ADFS_295,Y
		iny
		dex
		bpl	LB635
		lda	WKSP_ADFS_2B4
		sta	WKSP_ADFS_2B5
		cmp	#&03
		bcs	LB64E
		jsr	LAE6D
.LB64E		ldy	#&09
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		lda	WKSP_ADFS_29A
		sta	WKSP_ADFS_37A,X
		sta	(&C6),Y
		iny
		lda	WKSP_ADFS_29B
		sta	WKSP_ADFS_370,X
		sta	(&C6),Y
		iny
		lda	WKSP_ADFS_29C
		sta	WKSP_ADFS_366,X
		sta	(&C6),Y
		iny
		lda	WKSP_ADFS_29D
		sta	WKSP_ADFS_35C,X
		sta	(&C6),Y
		lda	WKSP_ADFS_2B4
		cmp	#&03
		bcs	LB690
.LB67C		ldx	#&03
		ldy	#&05
.LB680		lda	(&C6),Y
		sta	WKSP_ADFS_23B,Y
		lda	#&00
		sta	(&C6),Y
		iny
		dex
		bpl	LB680
		jmp	LB6FE
;;
.LB690		jsr	Compare_WKSP_ADFS_334_X_to_WKSP_ADFS_35C
		bcs	LB67C
		beq	LB67C
IF USE65C12
		stz	WKSP_ADFS_2B5
ELSE
		lda	#0
		sta	WKSP_ADFS_2B5
ENDIF
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		sec
		lda	WKSP_ADFS_352,X
		sbc	&C8
		sta	WKSP_ADFS_240
		lda	WKSP_ADFS_348,X
		sbc	&C9
		sta	WKSP_ADFS_241
		lda	WKSP_ADFS_33E,X
		sbc	&CA
		sta	WKSP_ADFS_242
		lda	WKSP_ADFS_334,X
		sbc	&CB
		sta	WKSP_ADFS_243
		ldx	#&03
		ldy	#&05
		sec
.LB6C2		lda	(&C6),Y
		sbc	WKSP_ADFS_23B,Y
		sta	(&C6),Y
		iny
		dex
		bpl	LB6C2
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		lda	WKSP_ADFS_352,X
		sta	WKSP_ADFS_29A
		sta	WKSP_ADFS_37A,X
		sta	(&C6),Y
		iny
		lda	WKSP_ADFS_348,X
		sta	WKSP_ADFS_29B
		sta	WKSP_ADFS_370,X
		sta	(&C6),Y
		iny
		lda	WKSP_ADFS_33E,X
		sta	WKSP_ADFS_29C
		sta	WKSP_ADFS_366,X
		sta	(&C6),Y
		iny
		lda	WKSP_ADFS_334,X
		sta	WKSP_ADFS_29D
		sta	WKSP_ADFS_35C,X
		sta	(&C6),Y
.LB6FE		ldy	#&01
		ldx	#&03
		clc
.LB703		lda	WKSP_ADFS_23F,Y
		adc	(&C6),Y
		sta	(&C6),Y
		iny
		dex
		bpl	LB703
		lda	&C8
		bne	LB715
		jmp	LB7A5
;;
.LB715		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		clc
		lda	WKSP_ADFS_3CA,X
		adc	&C9
		sta	WKSP_ADFS_296
		lda	WKSP_ADFS_3C0,X
		adc	&CA
		sta	WKSP_ADFS_297
		lda	WKSP_ADFS_3B6,X
		adc	&CB
		sta	WKSP_ADFS_298
		lda	#&02
		cmp	WKSP_ADFS_2B4
		lda	#&80
		ror	A
		jsr	LABE7
		lda	&C8
		sta	WKSP_ADFS_2B6
IF USE65C12
		stz	WKSP_ADFS_2B7
ELSE
		lda	#0
		sta	WKSP_ADFS_2B7
ENDIF
		ldx	#&02
.LB745		lda	WKSP_ADFS_29B,X
		cmp	&C9,X
		bne	LB768
		dex
		bpl	LB745
		lda	WKSP_ADFS_29A
		sta	WKSP_ADFS_2B7
		jsr	LB9CA
.LB758		jsr	L89D8
		jsr	LB19C
.LB75E		lda	#&00
		cmp	WKSP_ADFS_2B5
		ldx	&C6
		ldy	&C7
		rts
;;
.LB768		jsr	LB9CA
		lda	#&00
		sec
		sbc	WKSP_ADFS_2B6
		sta	WKSP_ADFS_2B6
		clc
		adc	WKSP_ADFS_2B8
		sta	WKSP_ADFS_2B8
		bcc	LB78A
		inc	WKSP_ADFS_2B9
		bne	LB78A
		inc	WKSP_ADFS_2BA
		bne	LB78A
		inc	WKSP_ADFS_2BB
.LB78A		sec
		lda	WKSP_ADFS_240
		sbc	WKSP_ADFS_2B6
		sta	WKSP_ADFS_240
		bcs	LB7A5
		ldy	#&01
.LB798		lda	WKSP_ADFS_240,Y
		sbc	#&00
		sta	WKSP_ADFS_240,Y
		bcs	LB7A5
		iny
		bne	LB798
.LB7A5		lda	WKSP_ADFS_241
		ora	WKSP_ADFS_242
		ora	WKSP_ADFS_243
		bne	LB7B3
		jmp	LB82B
;;
.LB7B3		lda	#&01
		sta	WKSP_ADFS_215_DSKOPSAV_RET
		ldy	#&03
.LB7BA		lda	WKSP_ADFS_2B8,Y
		sta	WKSP_ADFS_216_DSKOPSAV_MEMADDR,Y
		dey
		bpl	LB7BA
		lda	#&02
		cmp	WKSP_ADFS_2B4
		lda	#&02
		rol	A
		rol	A
		sta	WKSP_ADFS_21A_DSKOPSAV_CMD
		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		lda	&C8
		cmp	#&01
		lda	WKSP_ADFS_3CA,X
		adc	&C9
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+2
		lda	WKSP_ADFS_3C0,X
		adc	&CA
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC+1
		lda	WKSP_ADFS_3B6,X
		adc	&CB
		sta	WKSP_ADFS_21B_DSKOPSAV_SEC
		ldy	#&04
.LB7EF		lda	WKSP_ADFS_313,Y
		sta	WKSP_ADFS_22B,Y
		dey
		bne	LB7EF
		sty	WKSP_ADFS_317_CURDRV
		sty	WKSP_ADFS_21E_DSKOPSAV_SECCNT
		sty	WKSP_ADFS_21F_DSKOPSAV_CTL
		sty	WKSP_ADFS_220_DSKOPSAV_XLEN
		clc
		ldx	#&02
.LB807		lda	WKSP_ADFS_241,Y
		sta	WKSP_ADFS_220_DSKOPSAV_XLEN+1,Y
		adc	WKSP_ADFS_2B9,Y
		sta	WKSP_ADFS_2B9,Y
		iny
		dex
		bpl	LB807
		jsr	LAAB9
		jsr	L8A42
		lda	WKSP_ADFS_22F
		sta	WKSP_ADFS_317_CURDRV
		lda	#&FF
		sta	WKSP_ADFS_22F
		sta	WKSP_ADFS_22E
.LB82B		lda	WKSP_ADFS_29A
		bne	LB833
		jmp	LB758
;;
.LB833		ldx	ZP_ADFS_CF_CHANNEL_OFFS
		clc
		lda	WKSP_ADFS_3CA,X
		adc	WKSP_ADFS_29B
		sta	WKSP_ADFS_296
		lda	WKSP_ADFS_3C0,X
		adc	WKSP_ADFS_29C
		sta	WKSP_ADFS_297
		lda	WKSP_ADFS_3B6,X
		adc	WKSP_ADFS_29D
		sta	WKSP_ADFS_298
		lda	#&02
		cmp	WKSP_ADFS_2B4
		lda	#&80
		ror	A
		jsr	LABE7
IF USE65C12
		stz	WKSP_ADFS_2B6
ELSE
		lda	#0
		sta	WKSP_ADFS_2B6
ENDIF
		lda	WKSP_ADFS_29A
		sta	WKSP_ADFS_2B7
		jsr	LB9CA
		jmp	LB758

IF OPTIMISE>=6
.CheckAddr
		bit	ZP_ADFS_FLAGS			; Get ADFS status byte
		bpl	ChkNoTube			; Exit with PL if no Tube
IF TARGETOS > 1
		lda	WKSP_ADFS_2BA			; A=address &xxAAxxxx
		ldx	WKSP_ADFS_2BB			; X=address &AAxxxxxx
		jsr	CheckAndPageInShadowScreen				; Check for shadow screen
ENDIF
		lda	WKSP_ADFS_2BA			; A=address &xxAAxxxx
		cmp	#&FE				; If it &xxFExxxx - shadow screen or I/O?
		bcc	ChkTube				; <&xxFExxxx - Tube transfer
		lda	WKSP_ADFS_2BB			; A=address &AAxxxxxx
	IF USE65C12
		inc	A				; Is it &FFxxxxxx?
	ELSE
		adc	#0
	ENDIF

		beq	ChkNoTube			; Exit with PL if I/O transfer, no Tube
.ChkTube
		lda	#&FF				; Exit with MI if Tube transfer
.ChkNoTube
		rts
ENDIF

;;
.LB86B
IF OPTIMISE<6
		bit	ZP_ADFS_FLAGS			; Get ADFS status byte
		bpl	LB898				; Skip past if no Tube
IF TARGETOS > 1
		lda	WKSP_ADFS_2BA
		ldx	WKSP_ADFS_2BB
		jsr	CheckAndPageInShadowScreen				; Check for shadow screen
ENDIF
		lda	WKSP_ADFS_2BA
		cmp	#&FE
		bcc	LB885
		lda	WKSP_ADFS_2BB
IF USE65C12
		inc	A
ELSE
		cmp	#&FF
ENDIF
		beq	LB898
ELSE
		jsr	CheckAddr			; Check transfer address
		bpl	LB898				; Not a Tube transfer
ENDIF
.LB885		php
		sei
		jsr	L8032
IF USE65C12
		lda	#ADFS_FLAGS_TUBE_INUSE
		tsb	ZP_ADFS_FLAGS
ELSE
		lda	ZP_ADFS_FLAGS
		ora	#ADFS_FLAGS_TUBE_INUSE
		sta	ZP_ADFS_FLAGS
ENDIF
		lda	#&01
		ldx	#<WKSP_ADFS_2B8
		ldy	#>WKSP_ADFS_2B8
		jsr	&0406
		plp
.LB898
IF USE65C12
		stz	&BD
ELSE
		lda	#0
		sta	&BD
ENDIF
		lda	WKSP_ADFS_2B8
		sta	&B2
		lda	WKSP_ADFS_2B9
		sta	&B3
		rts
;;
.LB8A5		bit	ZP_ADFS_FLAGS
		bvc	LB8AD
IF HD_IDE
IF TARGETOS = 0 AND NOT(HD_SCSI)
		sbc	$EDED				; TODO: Reinstate?
ELSE
		jsr	TubeStore			; Longer delay
ENDIF
ELSE	; HD_IDE
		sta	TUBEIO
ENDIF
		rts
;;
.LB8AD		sty	&BC
		ldy	&BD
		sta	(&B2),Y
		inc	&BD
		bne	LB8B9
		inc	&B3
.LB8B9		ldy	&BC
		rts
;;
.LB8BC		lda	#&0A
		jsr	LB8A5
		sec
		ldx	#&09
		ldy	#&FF
.LB8C6		iny
		bcc	LB8D3
		lda	(&B4),Y
		and	#&7F
		cmp	#&21
		bcs	LB8D3
		lda	#&20
.LB8D3		jsr	LB8A5
		dex
		bpl	LB8C6
		rts
;;
;; OSGBPB 5+ - read filing system information
;; ------------------------------------------
.LB8DA		sbc	#&05
		tay
		beq	LB8EB				; A=5 - Read disk title and boot option
		dey
		beq	LB92B				; A=6 - Read directory name
		dey
		beq	LB94F				; A=7 - Read library name
		dey
		bne	LB925				; A>8 - unsupported
		jmp	LB96A				; A=8 - Scan directory
;;
;; OSGBPB 5 - Read disk title
;; --------------------------
.LB8EB		jsr	LB86B				; Check transfer address
		ldy	#&FF
.LB8F0		iny					; Count length of title
		lda	WKSP_ADFS_800_DIR_BUFFER + &D9,Y
		and	#&7F
		cmp	#&20
		bcc	LB8FE
		cpy	#&13
		bne	LB8F0
.LB8FE		tya
		jsr	LB8A5				; Store length byte
		ldy	#&FF
.LB904		iny
		lda	WKSP_ADFS_800_DIR_BUFFER + &D9,Y; Get character
		and	#&7F
		cmp	#&20
		bcc	LB915
		jsr	LB8A5				; Store character
		cpy	#&13
		bne	LB904				; Loop for up to 20 characters
.LB915		lda	WKSP_ADFS_100_FSM_S1 + &FD	; Get boot option
		jsr	LB8A5				; Store boot option
		lda	WKSP_ADFS_317_CURDRV			; Get current drive
		asl	A				; Rotate into b0-b3
		rol	A
		rol	A
		rol	A
		jsr	LB8A5				; Store drive numer
.LB925		jsr	TubeRelease				; Release Tube
		jmp	LB75E				; Restore X/Y, return A=0
;;
.LB92B		jsr	LB86B
		lda	#&01
		jsr	LB8A5
		lda	WKSP_ADFS_317_CURDRV
		jsr	LB946
		lda	#<WKSP_ADFS_300_CSDNAME		; &B4/5=>&C300, CSDNAME
		sta	&B4
		lda	#>WKSP_ADFS_300_CSDNAME
		sta	&B5
		jsr	LB8BC
		bmi	LB925
.LB946		asl	A
		rol	A
		rol	A
		rol	A
		adc	#&30
		jmp	LB8A5
;;
.LB94F		jsr	LB86B
		lda	#&01
		jsr	LB8A5
		lda	WKSP_ADFS_31B
		jsr	LB946
		lda	#<WKSP_ADFS_30A_LIBNAME		; &B4/5=>&C30A, LIBNAME
		sta	&B4
		lda	#>WKSP_ADFS_30A_LIBNAME
		sta	&B5
		jsr	LB8BC
		bmi	LB925
.LB96A		jsr	LB86B
		ldy	#&00
		sty	WKSP_ADFS_2B5
		lda	WKSP_ADFS_800_DIR_BUFFER + &FA
		sta	(&C6),Y
		ldy	#&05
		lda	(&C6),Y
		sta	&B0
		beq	LB925
		ldy	#&09
		lda	(&C6),Y
		sta	&B1
		cmp	#&2F
		bcs	LB925
		tax
		clc
		lda	#<WKSP_ADFS_405_DIR_START
		ldy	#>WKSP_ADFS_405_DIR_START
.LB98F		dex
		bmi	LB99A
		adc	#&1A
		bcc	LB98F
		iny
		clc
		bcc	LB98F
.LB99A		sty	&B5
		sta	&B4
.LB99E
IF USE65C12 AND OPTIMISE >= 1
		lda	(&B4)				; Check first character of directory entry
ELSE
		ldy	#&00
		lda	(&B4),Y				; Check first character of directory entry
ENDIF
		sta	WKSP_ADFS_2B5
		beq	LB9BB				; &00 - end of directory
		jsr	LB8BC
		lda	&B4
		clc
		adc	#&1A
		sta	&B4
		bcc	LB9B5
		inc	&B5
.LB9B5		inc	&B1
		dec	&B0
		bne	LB99E
.LB9BB		ldy	#&05
		lda	&B0
		sta	(&C6),Y
		ldy	#&09
		lda	&B1
		sta	(&C6),Y
		jmp	LB925
;;
.LB9CA		lda	WKSP_ADFS_2B6
		cmp	WKSP_ADFS_2B7
		bne	LB9D3
		rts
;;
.LB9D3
IF TARGETOS <= 1
		php
		sei
ENDIF

IF OPTIMISE<6
		bit	ZP_ADFS_FLAGS			; Check ADFS status byte
		bpl	LBA03				; Jump if no Tube present
IF TARGETOS > 1
		lda	WKSP_ADFS_2BA
		ldx	WKSP_ADFS_2BB
		jsr	CheckAndPageInShadowScreen				; Check for screen memory
ENDIF
		lda	WKSP_ADFS_2BA
		cmp	#&FE
		bcc	LB9ED
		lda	WKSP_ADFS_2BB
IF USE65C12
		inc	A
ELSE
		cmp	#&FF
ENDIF
		beq	LBA03
ELSE
		jsr	CheckAddr			; Check transfer address
		bpl	LBA03				; Not a Tube transfer
ENDIF
.LB9ED
IF USE65C12
		lda	#ADFS_FLAGS_TUBE_INUSE
		tsb	ZP_ADFS_FLAGS			; Set bit 6 of status byte
ELSE
		lda	ZP_ADFS_FLAGS			; Set bit 6 of status byte
		ora	#ADFS_FLAGS_TUBE_INUSE
		sta	ZP_ADFS_FLAGS
ENDIF

		jsr	L8032				; Check for Tube
		lda	WKSP_ADFS_2B4
		cmp	#&03
		lda	#&00
		rol	A
		ldx	#<WKSP_ADFS_2B8
		ldy	#>WKSP_ADFS_2B8
		jsr	&0406
.LBA03
IF TARGETOS <= 1
		plp
ENDIF

		lda	WKSP_ADFS_2B8
		sec
		sbc	WKSP_ADFS_2B6
		sta	&B2
		lda	WKSP_ADFS_2B9
		sbc	#&00
		sta	&B3
		lda	WKSP_ADFS_2B4
		cmp	#&03
		ldy	WKSP_ADFS_2B6
		php
.LBA1C		plp
		bit	ZP_ADFS_FLAGS
		bvs	LBA2F
		bcc	LBA29
		lda	(&BE),Y
		sta	(&B2),Y
		bcs	LBA40
.LBA29		lda	(&B2),Y
		sta	(&BE),Y
		bcc	LBA40
.LBA2F		jsr	TubeDelay2
		bcc	LBA3B
		lda	(&BE),Y
IF TARGETOS > 0 OR HD_SCSI				; TODO: reinstate
		sta	TUBEIO
ELSE
		sbc	&EDED
ENDIF
		bcs	LBA40
.LBA3B
IF TARGETOS > 0	OR HD_SCSI				; TODO: reinstate
		lda	TUBEIO
ELSE
		sbc	&EDED				
ENDIF

		sta	(&BE),Y
.LBA40		iny
		php
		cpy	WKSP_ADFS_2B7
		bne	LBA1C
		plp
		jmp	TubeRelease


IF FLOPPY
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
ENDIF
.LBA57		lda	#&FF
		sta	WKSP_ADFS_2E4
IF FLOPPY
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

.elkLBA26  sta     $FCC4                           ; BA26 8D C4 FC                 ...
        ldy     #$09                            ; BA29 A0 09                    ..
.elkLBA2B  dey                                     ; BA2B 88                       .
        bne     elkLBA2B                           ; BA2C D0 FD                    ..
        txa                                     ; BA2E 8A                       .
        beq     elkLBA7A                           ; BA2F F0 49                    .I
        bit     $A1                             ; BA31 24 A1                    $.
        bmi     elkLBA52                           ; BA33 30 1D                    0.
        jmp     (&0D10)                         ; BA35 6C 10 0D                 l..

; ----------------------------------------------------------------------------
.elkLBA38  lda     $FCC4                           ; BA38 AD C4 FC                 ...
        ror     a                               ; BA3B 6A                       j
        bcc     elkLBA4A                           ; BA3C 90 0C                    ..
        ror     a                               ; BA3E 6A                       j
        bcc     elkLBA38                           ; BA3F 90 F7                    ..
        stx     $FCC7                           ; BA41 8E C7 FC                 ...
        iny                                     ; BA44 C8                       .
        beq     elkLBA38                           ; BA45 F0 F1                    ..
        jmp     (&0D10)                         ; BA47 6C 10 0D                 l..

; ----------------------------------------------------------------------------
.elkLBA4A  asl     a                               ; BA4A 0A                       .
        and     $0D15                           ; BA4B 2D 15 0D                 -..
        beq     elkLBA95                           ; BA4E F0 45                    .E
        bne     elkLBA88                           ; BA50 D0 36                    .6
.elkLBA52  lda     $FCC4                           ; BA52 AD C4 FC                 ...
        ror     a                               ; BA55 6A                       j
        bcc     elkLBA4A                           ; BA56 90 F2                    ..
        ror     a                               ; BA58 6A                       j
        bcc     elkLBA52                           ; BA59 90 F7                    ..
        lda     $FCC7                           ; BA5B AD C7 FC                 ...
        jmp     (&0D10)                         ; BA5E 6C 10 0D                 l..

; ----------------------------------------------------------------------------
        lda     $FCE5                           ; BA61 AD E5 FC                 ...
        tax                                     ; BA64 AA                       .
        jmp     elkLBA38                           ; BA65 4C 38 BA                 L8.

; ----------------------------------------------------------------------------
        sta     $FCE5                           ; BA68 8D E5 FC                 ...
        jmp     elkLBA52                           ; BA6B 4C 52 BA                 LR.

; ----------------------------------------------------------------------------
        sta     ($CE),y                         ; BA6E 91 CE                    ..
        iny                                     ; BA70 C8                       .
        jmp     elkLBA52                           ; BA71 4C 52 BA                 LR.

; ----------------------------------------------------------------------------
        lda     ($CE),y                         ; BA74 B1 CE                    ..
        tax                                     ; BA76 AA                       .
        jmp     elkLBA38                           ; BA77 4C 38 BA                 L8.

; ----------------------------------------------------------------------------
.elkLBA7A  lda     $FCC4                           ; BA7A AD C4 FC                 ...
        ror     a                               ; BA7D 6A                       j
        bcs     elkLBA7A                           ; BA7E B0 FA                    ..
        rol     a                               ; BA80 2A                       *
        and     &0D15                           ; BA81 2D 15 0D                 -..
        and     #$FB                            ; BA84 29 FB                    ).
        beq     elkLBA97                           ; BA86 F0 0F                    ..
.elkLBA88  sta     $A0                             ; BA88 85 A0                    ..
        ror     $A1                             ; BA8A 66 A1                    f.
        sec                                     ; BA8C 38                       8
        rol     $A1                             ; BA8D 26 A1                    &.
.elkLBA8F  ror     $A2                             ; BA8F 66 A2                    f.
        sec                                     ; BA91 38                       8
        rol     $A2                             ; BA92 26 A2                    &.
        rts                                     ; BA94 60                       `

; ----------------------------------------------------------------------------
.elkLBA95  inc     $CF                             ; BA95 E6 CF                    ..
.elkLBA97  lda     $0D5D                           ; BA97 AD 5D 0D                 .].
        and     #$10                            ; BA9A 29 10                    ).
        beq     elkLBAAE                           ; BA9C F0 10                    ..
        bit     $FF                             ; BA9E 24 FF                    $.
        bpl     elkLBAAE                          ; BAA0 10 0C                    ..
        lda     #$00                            ; BAA2 A9 00                    ..
        sta     $FCC0                           ; BAA4 8D C0 FC                 ...
        lda     #$6F                            ; BAA7 A9 6F                    .o
        sta     $A0                             ; BAA9 85 A0                    ..
        jmp     FloppyErrorA0or2E3                           ; BAAB 4C AE BF                 L..

; ----------------------------------------------------------------------------
.elkLBAAE  
	bit     $A2                             ; BAAE 24 A2                    $.
        bvc     elkLBA8F                           ; BAB0 50 DD                    P.
        jsr     LBE77                          ; BAB2 20 7F BE                  ..
        rts                                     ; BAB5 60                       `

; ----------------------------------------------------------------------------
.FloppyWaitNMIFinish2elk
.elkLBAB6  ldx     #$00                            ; BAB6 A2 00                    ..
        beq     elkLBABC                           ; BAB8 F0 02                    ..
.FloppyWaitNMIFinish
.elkLBABA  ldx     #$FF                            ; BABA A2 FF                    ..
.elkLBABC  jsr     elkLBA26                           ; BABC 20 26 BA                  &.
        lda     $A2                             ; BABF A5 A2                    ..
        ror     a                               ; BAC1 6A                       j
        lda     $A6                             ; BAC2 A5 A6                    ..
        bcc     elkLBABA                           ; BAC4 90 F4                    ..
        rts                                     ; BAC6 60                       `

; ----------------------------------------------------------------------------
.CopyCodeToNMISpace2Elk
.elkLBAC7  bit     $CD                             ; BAC7 24 CD                    $.
        bvc     elkLBAF4                           ; BAC9 50 29                    P)
        lda     $A1                             ; BACB A5 A1                    ..
        and     #$FD                            ; BACD 29 FD                    ).
        sta     $A1                             ; BACF 85 A1                    ..
        rol     a                               ; BAD1 2A                       *
        lda     #$00                            ; BAD2 A9 00                    ..
        rol     a                               ; BAD4 2A                       *
        ldy     #$10                            ; BAD5 A0 10                    ..
        ldx     #$27                            ; BAD7 A2 27                    .'
        jsr     &0406                           ; BAD9 20 06 04                  ..
        lda     $A1                             ; BADC A5 A1                    ..
        and     #$10                            ; BADE 29 10                    ).
        beq     elkLBB1F                           ; BAE0 F0 3D                    .=
        bit     $A1                             ; BAE2 24 A1                    $.
        bmi     elkLBAED                           ; BAE4 30 07                    0.
        ldx     #$61                            ; BAE6 A2 61                    .a
        ldy     #$BA                            ; BAE8 A0 BA                    ..
        jmp     elkLBB03                           ; BAEA 4C 03 BB                 L..

; ----------------------------------------------------------------------------
.elkLBAED  ldx     #$68                            ; BAED A2 68                    .h
        ldy     #$BA                            ; BAEF A0 BA                    ..
        jmp     elkLBB03                           ; BAF1 4C 03 BB                 L..

; ----------------------------------------------------------------------------
.elkLBAF4  bit     $A1                             ; BAF4 24 A1                    $.
        bmi    elkLBAFF                           ; BAF6 30 07                    0.
        ldx     #$74                            ; BAF8 A2 74                    .t
        ldy     #$BA                            ; BAFA A0 BA                    ..
        jmp     elkLBB03                           ; BAFC 4C 03 BB                 L..

; ----------------------------------------------------------------------------
.elkLBAFF  ldx     #$6E                            ; BAFF A2 6E                    .n
        ldy     #$BA                            ; BB01 A0 BA                    ..
.elkLBB03  stx     &0D10                           ; BB03 8E 10 0D                 ...
        sty     $0D11                           ; BB06 8C 11 0D                 ...
        ldy     #$01                            ; BB09 A0 01                    ..
        lda     ($B0),y                         ; BB0B B1 B0                    ..
        sta     $CE                             ; BB0D 85 CE                    ..
        iny                                     ; BB0F C8                       .
        lda     ($B0),y                         ; BB10 B1 B0                    ..
        sta     $CF                             ; BB12 85 CF                    ..
        ldx     #$1C                            ; BB14 A2 1C                    ..
        bit     $A1                             ; BB16 24 A1                    $.
        bmi     elkLBB1C                           ; BB18 30 02                    0.
        ldx     #$5C                            ; BB1A A2 5C                    .\
.elkLBB1C  stx     $0D15                           ; BB1C 8E 15 0D                 ...
.elkLBB1F  rts                                     ; BB1F 60                       `

; ----------------------------------------------------------------------------
.elkLBB20  php                                     ; BB20 08                       .
        pla                                     ; BB21 68                       h
        sta     $0D16                           ; BB22 8D 16 0D                 ...
        sei                                     ; BB25 78                       x
        lda     $CE                             ; BB26 A5 CE                    ..
        sta     $0D13                           ; BB28 8D 13 0D                 ...
        lda     $CF                             ; BB2B A5 CF                    ..
        sta     $0D14                           ; BB2D 8D 14 0D                 ...
        ldx     #$01                            ; BB30 A2 01                    ..
        lda     #$73                            ; BB32 A9 73                    .s
        jsr     &FFF4                           ; BB34 20 F4 FF                  ..
        ldx     #$00                            ; BB37 A2 00                    ..
        ldy     #$FF                            ; BB39 A0 FF                    ..
        lda     #$F2                            ; BB3B A9 F2                    ..
        jsr     &FFF4                           ; BB3D 20 F4 FF                  ..
        txa                                     ; BB40 8A                       .
        sta     $0D12                           ; BB41 8D 12 0D                 ...
        and     #$F9                            ; BB44 29 F9                    ).
        tax                                     ; BB46 AA                       .
        and     #$20                            ; BB47 29 20                    ) 
        bne     elkLBB4F                           ; BB49 D0 04                    ..
        txa                                     ; BB4B 8A                       .
        ora     #$30                            ; BB4C 09 30                    .0
        tax                                     ; BB4E AA                       .
.elkLBB4F  stx     $FE07                           ; BB4F 8E 07 FE                 ...
        rts                                     ; BB52 60                       `

; ----------------------------------------------------------------------------
.elkLBB53  lda     $0D12                           ; BB53 AD 12 0D                 ...
        sta     &FE07                           ; BB56 8D 07 FE                 ...
        ldx     #$00                            ; BB59 A2 00                    ..
        lda     #$73                            ; BB5B A9 73                    .s
        jsr     &FFF4                           ; BB5D 20 F4 FF                  ..
        lda     $0D13                           ; BB60 AD 13 0D                 ...
        sta     $CE                             ; BB63 85 CE                    ..
        lda     $0D14                           ; BB65 AD 14 0D                 ...
        sta     $CF                             ; BB68 85 CF                    ..
        lda     $0D16                           ; BB6A AD 16 0D                 ...
        pha                                     ; BB6D 48                       H
        plp                                     ; BB6E 28                       (
        rts                                     ; BB6F 60                       `


.CopyCodeToNMISpace

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
IF OPTIMISE<5
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
ELSE
		jsr	FloppyCalcTrackSectorFromXA
ENDIF
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

IF OPTIMISE<6
		ora	NMIVARS_FDC_CMD_STEP
		sta	FDC_CMD				; FDC Status/Command
ELSE
		jsr	FloppyORA_STEP_SET_FDC_CMD
ENDIF	; OPT 6

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
IF OPTIMISE<2
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
ELSE  ; OPTIMISE>=2
		jsr	L9A7F				; Read ADFS CMOS byte
		pha
		and	#&02
		beq	LBBF6
		lda	#&03
.LBBF6		sta	WKSP_ADFS_2E8_FDC_CMD_STEP			; If FDrive=2,3,6,7 set &C2E8=3
		pla
		and	#CONFIG_BIT_FD_SPEED
		asl	A
		sta	NMIVARS_CMD_PRECOMP		; If FDrive=1,3,5,7 set NMIVARS_CMD_PRECOMP=2
ENDIF
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

ENDIF ; FLOPPY


IF TARGETOS > 1
	IF P%<&BFFF
		ORG	&BFFF
	ENDIF
	IF HD_MMC
		EQUB	&00				; MMC revision 0
	ENDIF
	IF HD_IDE
		EQUB	&23				; IDEPatch revision 1.23
	ENDIF
	IF HD_SCSI
		EQUB	&A9				; 'A'corn revision 9
	ENDIF
ELIF TARGETOS = 1 OR NOT(HD_SCSI)
		EQUS	"and Hugo."
	IF HD_IDE AND TARGETOS >= 1
		EQUB	&23
	ELSE		
		EQUB	&D
	ENDIF
ELSE	
		brk
		EQUS	"Roger"
		brk
ENDIF
.ENDOFROM

PRINT "Code ends at",~ENDOFROM,"(",(&C000-ENDOFROM),"bytes free)"

IF ENDOFROM > $C000
;	ERROR "OUT OF SPACE"
ENDIF

SAVE "", &8000, &C000

