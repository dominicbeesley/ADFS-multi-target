.ifndef __MMC_INC__
__MMC_INC__:

		.include "config.inc"
		.include "workspace.inc"

		;TODO: make the workspace references below take account of low/high workspace
		

;;; MMC settings
MAX_DRIVES             = 2         ; Don't make this bigger than 2 or the drive table below will overflow

MMC_ATTEMPTS           = $C2E9     ; 1 byte
MMC_SECTORCOUNT        = $C2EA     ; 1 byte
MMC_CARDSORT           = $C2EB     ; 1 byte
MMC_MMCSTATE           = $C2EC     ; 1 byte
MMC_NUMDRIVES          = $C2ED     ; 1 byte
MMC_CMDSEQ             = $C2F0     ; 8 bytes
MMC_DRIVETABLE         = $C2F8     ; 4 * MAX_DRIVES
MMC_MBRSECTOR          = $C000     ; 512 bytes tmp storage before fs is mounted
MMC_DATPTR             = $B2
;;;;


;; User VIA registers
MMC_IORB=MMC_VIA_BASE
MMC_DDRB=MMC_VIA_BASE + $02
MMC_SR  =MMC_VIA_BASE + $0A
MMC_ACR =MMC_VIA_BASE + $0B
MMC_IFR =MMC_VIA_BASE + $0D
MMC_IER =MMC_VIA_BASE + $0E

.ifdef _TURBOMMC
   temp    = $CF
   ddrmask = $1F ;; 0001 1111
   msbits  = $08 ;; 0000 1000
   msmask  = $E9 ;; 1110 1001
.else
   ddrmask = $03 ;; 0000 0011
   msbits  = $00 ;; 0000 0000
   msmask  = $FD ;; 1111 1101
.endif


.endif