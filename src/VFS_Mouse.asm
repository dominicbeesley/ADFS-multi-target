
		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"


		.export VFS_ServiceCallsExtra
		.export VFS_FSC3_STARCMD
		.export VFS_Serv9_extra


		.segment "vfs_mouse"


CFGBITS_01_EJECT = 1
ZP_EXTRA_LEN =   12
SCSICMD_1B_STARTSTOPUNIT = $1b
LV_FCMD_27_EJECT = $27      ;F command Eject
LV_FCMD_2A_halt = $2a       ;F command for halt/pause/still
LV_FCMD_E_VideoOnOff = $45  ;F Command Video On/Off
LV_FCMD_L_still_forward = $4c ;F command for still/forward
LV_FCMD_M_still_reverse = $4d ;F command for still reverse
LV_FCMD_O_PlayBackwards = $4f ;F command - O - play backwards
LV_FCMD_F_TERM_R_HALT = $52 ;Terminator for F command F search then halt
LV_FCMD_S_SetSlowSpeed = $53 ;F command S - set slow speed
LV_FCMD_U_SlowForward = $55 ;F command - U - slow forwards
LV_FCMD_V_SlowReverse = $56 ;F command - V - slow reverse
LV_FCMD_Z_FastReverse = $5a ;F command - Z - fast rewind
SCSICMD_C8_VENDOR_FCMDRESULT = $c8
SCSICMD_CA_VENDOR_FCMD = $ca ;Philips LV Vendor command to send F command
OSBYTE_DB_RW_TABCODE = $db
LV_FCMD_N_PlayForwards = $e4 ;F command - N - play forwards
VFS_PWSKP_373_SAVE_N933 = $0373 ;8 bytes saved from N933

LV_FCMD_2B_JUMP_FWD = $2b   ;F command - jump forward +YY tracks
LV_FCMD_2D_JUMP_BACK = $2d  ;F command - -YY jump back YY tracks
LV_FCMD_F_GOTOFRAME = $46   ;F command - goto frame XXXXX and play (term 'N') or continue (term'Q')
LV_FCMD_Q_CHAPTER = $51     ;F command - Q - Play chapter sequence
LV_FCMD_F_TERM_S_HALT = $53 ;Terminator for F command F - play, stop at this frame
LV_FCMD_W_FastForwards = $57 ;F command - fast forward
ZP_EXTRA_TMPPTR = $84
ZP_EXTRA_BASE =  $84
ZP_EXTR_PTR_Q =  $8e
zp_vfsv_a8_textptr = $a8    ;Used in VFS video and mouse commands when parsing command lines
zp_mos_txtptr =  $f2        ;MOS text pointer, along with Y register

zp_mos_escape =  $ff        ;MOS Escape flag

VFS_N900_MouseBounds = $0900 ;16:16 XY bounds
VFS_N900 =       $0900      ;Page 9 is used by VFS during mouse/video stuff, it gets backed up to private workspace
VFS_N904_MousePos = $0904   ;16:16 XY Mouse position
VFS_N908_MODESAVE = $0908
VFS_N924_PTR_Q = $0924
VFS_N926_ZPSAVE = $0926
VFS_N932_ACCON_SAVE = $0932
VFS_N937_PlayStart = $0937  ;16 bit starting frame number for play
VFS_N939_RETRY_CTR = $0939  ;Countdown retries of search/seeks
VFS_0D92_FLAG_POLL100 = $0d92
VFS_0D93_CTDN_SEARCH = $0d93
VFS_0D94_CTDN_QQQQQ = $0d94
VFS_0D95_20Hz_CTDN = $0d95  ;;count down 4..0

CommandExecXY =  $80a7
GenerateError =  $8270
ErrorEscapeACKReloadFSM = $827f ;AckEscapeAndBRK
ReloadFSMandDIR_ThenBRK = $8326
GenerateErrorNoSuff = $832d
myCmosRead =     $9076
WKSP_ADFS_215_CMDBUF = $c215

sheila_ACCON =   $fe34


;*******************************************************************************
;* VFS_ServiceCallsExtra - extra service calls                                 *
;*                                                                             *
;* This is called at the start of the main service call handler routine before *
;* all the ADFS stuff is tried                                                 *
;*******************************************************************************
         .org    $a6f1
VFS_ServiceCallsExtra:
         cmp     #SERVICE_15_100Hz_POLL
         bne     @trySvc4
         jmp     Serv15_Poll100Hz

@trySvc4:
         cmp     #SERVICE_04_UK_OSCLI
         bne     @rts
;*******************************************************************************
;* VFS Service call 4 handler - unknown OSCLI command                          *
;*******************************************************************************
         php
         pha
         phx
         phy
         tya
         clc
         adc     zp_mos_txtptr
         sta     zp_vfsv_a8_textptr
         lda     zp_mos_txtptr+1
         adc     #$00
         sta     zp_vfsv_a8_textptr+1 ;a8/9 point to command tail
         ldy     #$00
         lda     (zp_vfsv_a8_textptr),Y
         and     #$df       ;lowercase
         cmp     #'L'
         bne     @skNoPre
         iny                ;Skip L as prefix for commands
         lda     (zp_vfsv_a8_textptr),Y
         and     #$df       ;lowercase
         cmp     #'V'
         bne     @ex        ;If L[^V] then not a valid prefix
         iny
@skNoPre:
         ldx     #$00
         sty     $aa        ;remember Y
@cmdLp:  lda     (zp_vfsv_a8_textptr),Y
         and     #$df       ;lowercase
         cmp     VFSM_cmdTable,X ;compare with table
         beq     @incXY
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #'.'
         beq     @gotmatch  ;was a '.' ...matched
         lda     VFSM_cmdTable,X
         bmi     @LA753
         ldy     $aa        ;reload saved Y and try again
@skipEndCurCmd:
         inx
         lda     VFSM_cmdTable,X
         bpl     @skipEndCurCmd
         inx
         inx                ;skip over pointer after string
         lda     VFSM_cmdTable,X ;check for end of table (top bit set)
         bpl     @cmdLp
@ex:     ply
         plx
         pla
         plp
@rts:    rts

@incXY:  inx
         iny
         bne     @cmdLp
@gotmatch:
         iny
         bne     @gotmatch2
@LA753:  dex
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #' '
         beq     @gotmatch2
         cmp     #$0d
         bne     @ex
@gotmatch2:
         inx
         lda     VFSM_cmdTable,X
         bpl     @gotmatch2
         jsr     skipCommaOrSpace ;skip over spaces/comma
         tya
         clc
         adc     zp_vfsv_a8_textptr
         sta     zp_vfsv_a8_textptr
         bcc     @skinc
         inc     zp_vfsv_a8_textptr ;BUG? should be A9!
@skinc:  lda     VFSM_cmdTable,X
         sta     $ab
         lda     VFSM_cmdTable+1,X
         sta     $aa
         lda     #OSBYTE_87_SCRCHAR_MODE
         jsr     OSBYTE     ;get current mode
         tya
         and     #$07
         pha                ;push mode and #7
         sei
         jsr     PreserveZpAndPage9 ;grab some ZP and Page 9
         pla
         sta     VFS_N908_MODESAVE ;save mode #
         jsr     jmpIndAA   ;call command routine
         jsr     RestoreZpAndPage9
         ply
         plx
         pla
         lda     #$00
         plp
         rts

jmpIndAA:
         jmp     ($00aa)

VFSM_cmdTable:
         .byte   "MOUSE"
         .dbyt   VFSstarMOUSE
         .byte   "POINTER"
         .dbyt   VFSstarPOINTER
         .byte   "TMAX"
         .dbyt   VFSstarTMAX
         .byte   "TRACKERBALL"
         .dbyt   VFSstarMOUSE
         .byte   "TSET"
         .dbyt   VFSstarTSET
         .byte   $ff        ;table end marker
strVIDEO:
         .byte   "VIDEO"
strMOUSE:
         .byte   "MOUSE"
strTRACKERBALL:
         .byte   "TRACKERBALL"

;*******************************************************************************
;* VFS_Serv9_extra                                                             *
;*                                                                             *
;* Help for extra VFS sections MOUSE, TRACKERBALL, VIDEO                       *
;*******************************************************************************
VFS_Serv9_extra:
         tya
         pha
         ldx     #$00
@lpVIDEO:
         lda     (zp_mos_txtptr),Y
         cmp     #'.'
         beq     @prVIDEOhelpStr
         and     #$df       ;lowercase
         cmp     strVIDEO,X
         beq     @incLenCkVIDEO
@jmpTryMouse:
         jmp     @tryMOUSE

@incLenCkVIDEO:
         iny
         inx
         cpx     #$05       ;TODO: len "VIDEO"
         bne     @lpVIDEO
         lda     (zp_mos_txtptr),Y
         cmp     #'!'
         bcs     @jmpTryMouse
@prVIDEOhelpStr:
         jsr     VFS_PrintNopTermString
         .byte   $0a,"AUDIO <0-3> 0-off, 3-on",$0d,"CHAPTER <digits> Plays chapt"
         .byte   "er(s)",$0d,"EJECT",$0d,"FAST <dir.> Cue or Review",$0d,"FCODE "
         .byte   "<string>",$0d,"FRAME <no.>",$0d,"PLAY <start>,<end> Plays from"
         .byte   " start to end",$0d,"(NB *PLAY <RETURN> plays from current fram"
         .byte   "e)",$0d,"RESET",$0d,"SEARCH <no.> As FRAME, but no wait",$0d
         .byte   "SLOW <speed>,<dir.> Speed from 5 (slow) to 253 (fast)",$0d,"ST"
         .byte   "EP <1/0/255> Stop/step player",$0d,"STILL as FRAME",$0d,"VOCOM"
         .byte   "PUTER Computer to VDU",$0d,"VODISC LV to VDU",$0d,"VOHIGLIGHT "
         .byte   "Computer colour highlights LV",$0d,"VOSUPERIMPOSE Computer ove"
         .byte   "r LV",$0d,"VOTRANSPARENT LV & computer mixed",$0d,"VP <digit>"
         .byte   $0d
         nop
@tryMOUSE:
         ldx     #$00
         pla
         pha
         tay
@lpMOUSE:
         lda     (zp_mos_txtptr),Y
         cmp     #'.'
         beq     @helpTRACKERBALL
         and     #$df       ;lowercase
         cmp     strMOUSE,X
         beq     @incCkLenMOUSE
         pla
         pha
         tay
         ldx     #$00
@lpTRACKERBALL:
         lda     (zp_mos_txtptr),Y
         cmp     #'.'
         beq     @helpTRACKERBALL
         and     #$df       ;lowercase
         cmp     strTRACKERBALL,X
         beq     @incCkLenTRACKERBALL
@plyret: pla
         tay
         rts

@incCkLenTRACKERBALL:
         iny
         inx
         cpx     #$0b
         bne     @lpTRACKERBALL
         beq     @checkTokEndMOUSE

@incCkLenMOUSE:
         iny
         inx
         cpx     #$05
         bne     @lpMOUSE
@checkTokEndMOUSE:
         lda     (zp_mos_txtptr),Y
         cmp     #'!'
         bcs     @plyret
@helpTRACKERBALL:
         jsr     VFS_PrintNopTermString
         .byte   $0a,"MOUSE <1/0>",$0d,"TRACKERBALL as *MOUSE",$0d,"POINTER <0/1"
         .byte   "/2> to hide/show/hide & halt pointer",$0d,"NB MODEs 0,1 & 2 on"
         .byte   "ly",$0d,"TMAX <x>,<y> sets boundaries",$0d,"TSET <x>,<y> sets "
         .byte   "position",$0d," ADVAL(5) is X boundary, (6) is Y,",$0d," ADVAL"
         .byte   "(7) is X coordinate, (8) is Y,",$0d," ADVAL(9) is buttons",$0d
         nop
         jmp     @plyret

VFS_PrintNopTermString:
         pla
         sta     $b6
         pla
         sta     $b7
         ldy     #$00
         jsr     getB6CmdCharInc
@lp:     jsr     getB6CmdCharInc
         bmi     @retPTR
         jsr     $8c7a
         jmp     @lp

@retPTR: jmp     ($00b6)

getB6CmdCharInc:
         lda     ($b6),Y
         inc     $b6
         bne     @sk1
         inc     $b7
@sk1:    cmp     #$00
         rts

starEJECT:
         jsr     myCmosRead
         and     #CFGBITS_01_EJECT
         beq     @ok
         jsr     GenerateErrorNoSuff
         .byte   $94
         .asciiz "No eject"
@ok:     lda     #LV_FCMD_27_EJECT
;*******************************************************************************
;* Enter here with single character F command value in A                       *
;*                                                                             *
;* The character will be placed in the command data buffer followed by <CR>    *
;* and sent to the LV player as a $CA vendor command.                          *
;*******************************************************************************
FCMD_Single_CharA:
         sta     WKSP_VFS_E00_TXTBUF
         lda     #$0d
         sta     WKSP_VFS_E00_TXTBUF+1
;*******************************************************************************
;* Enter here to send the data constructed in the text buffer to the LV player *
;* as an F command as a $CA vendor command - the string should be terminated   *
;* with <CR>                                                                   *
;*******************************************************************************
FCMD_TextBuf:
         lda     #SCSICMD_CA_VENDOR_FCMD ;command $CA ; TODO: what is this command? the actial param seems to be in the command buffer
sendCmdATxtBuf:
         ldx     #<WKSP_VFS_E00_TXTBUF
         ldy     #>WKSP_VFS_E00_TXTBUF
SCSI_Command_AXY_res:
         jsr     SCSI_Command_AXY
         beq     LAB92rts
         pha
         jsr     swap7PWSP_373_N933
         pla
         jmp     GenerateError

LAB92rts:
         rts

         jsr     SCSI_Command_AXY
         beq     LAB92rts
         jmp     GenerateError

;*******************************************************************************
;* Construct a SCSI command in the ADFS workspace at offset 215 and send to    *
;* the LV player.                                                              *
;*                                                                             *
;* On entry A contains the SCSI command code and XY should point at a HOST     *
;* address with address of the data buffer (if any) containing/read to receive *
;* data to/from the command                                                    *
;*******************************************************************************
SCSI_Command_AXY:
         stx     WKSP_ADFS_215_CMDBUF+1
         sty     WKSP_ADFS_215_CMDBUF+2
         ldx     #$ff
         stx     WKSP_ADFS_215_CMDBUF+3
         stx     WKSP_ADFS_215_CMDBUF+4
         sta     WKSP_ADFS_215_CMDBUF+5
         lda     #$00
         sta     WKSP_ADFS_215_CMDBUF
         ldy     #$04
@clp:    sta     WKSP_ADFS_215_CMDBUF+6,Y
         dey
         bpl     @clp
         inc     WKSP_ADFS_215_CMDBUF+9
         ldx     #$15
         ldy     #$c2
         jmp     CommandExecXY

LABC3rts:
         rts

jmpSwapP373N933brkBadNumber:
         jmp     swapP373N933brkBadNumber

;*******************************************************************************
;* *VP <n>                                                                     *
;*                                                                             *
;* Sends a VP command to:                                                      *
;*                                                                             *
;* *VP 1   Video from LV            *VODISC                                    *
;* *VP 2   Video from Computer      *VOCOMPUTER                                *
;* *VP 3   Computer over LV         *VOSUPERIMPOSE                             *
;* *VP 4   Computer mixed with LV   *VOTRANSPARENT                             *
;* *VP 5   Laser vision "enhanced"  *VOHIGHLIGHT                               *
;*         by computer                                                         *
;*                                                                             *
;* This command actually looks to pass values 0..9 although only 1..5 are      *
;* documented in the VFS and LV415 manuals                                     *
;*******************************************************************************
starVP:  jsr     setYeq0
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #$30
         bcc     starVPint  ;if not a number skip forward and send
         cmp     #$3a
         bcs     starVPint  ;if not a number skip forward and send
         jsr     parse8bitDecA
         cmp     #$0a
         bcs     jmpSwapP373N933brkBadNumber
         ora     #'0'
starVPint:
         ldx     SYSVARS_291_ILACE
         bne     swapP373N933brkTurnIlaceOn
         sta     WKSP_VFS_E00_TXTBUF+2
         lda     #'V'
         sta     WKSP_VFS_E00_TXTBUF
         lda     #'P'
         sta     WKSP_VFS_E00_TXTBUF+1
         lda     #$0d
         sta     WKSP_VFS_E00_TXTBUF+3
         jmp     FCMD_TextBuf

swapP373N933brkTurnIlaceOn:
         jsr     swap7PWSP_373_N933
         jsr     ReloadFSMandDIR_ThenBRK
         .byte   $ad
         .asciiz "Turn interlace on"
;*******************************************************************************
;* *VODISC - show video from LV only                                           *
;*                                                                             *
;* Calls *VP 1 internally                                                      *
;*******************************************************************************
starVODISC:
         lda     #'1'
         bne     starVPint

;*******************************************************************************
;* *VOCOMPUTER - show video from computer only                                 *
;*                                                                             *
;* Calls *VP 2 internally                                                      *
;*******************************************************************************
starVOCOMPUTER:
         lda     #'2'
         bne     starVPint

;*******************************************************************************
;* *VOSUPERIMPOSE - computer overlaid on LV                                    *
;*                                                                             *
;* Calls *VP 3 internally                                                      *
;*******************************************************************************
starVOSUPERIMPOSE:
         lda     #'3'
         bne     starVPint

;*******************************************************************************
;* *VOTRANSPARENT - mix computer and LV                                        *
;*                                                                             *
;* Calls *VP 4 internally                                                      *
;*******************************************************************************
starVOTRANSPARENT:
         lda     #'4'
         bne     starVPint

;*******************************************************************************
;* *VOHIGHLIGHT - LV "enhanced" by computer                                    *
;*                                                                             *
;* Calls *VP 5 internally                                                      *
;*******************************************************************************
starVOHIGHLIGHT:
         lda     #'5'
         bne     starVPint

;*******************************************************************************
;* *FCODE <str>                                                                *
;*                                                                             *
;* Send an arbitrary GSTRANS string to the LV player, the string will be       *
;* terminated by <CR> by the command                                           *
;*******************************************************************************
starFCODE:
         ldx     zp_vfsv_a8_textptr
         stx     zp_mos_txtptr
         ldy     zp_vfsv_a8_textptr+1
         sty     zp_mos_txtptr+1
         ldy     #$00
         sec
         jsr     GSINIT
         beq     LABC3rts
         ldx     #$00
@lp:     jsr     GSREAD
         bcs     @skend
         sta     WKSP_VFS_E00_TXTBUF,X
         inx
         bne     @lp
@skend:  lda     #$0d
         sta     WKSP_VFS_E00_TXTBUF,X
         jmp     FCMD_TextBuf

;*******************************************************************************
;* *RESET - Send SCSI "Start Unit" command                                     *
;*                                                                             *
;* The SCSI command $1B is sent to the LV player to allow F commands to be     *
;* sent                                                                        *
;*******************************************************************************
starRESET:
         jsr     disableSearchPoll
         lda     #SCSICMD_1B_STARTSTOPUNIT
         jmp     SCSI_Command_AXY_res

;*******************************************************************************
;* *CHAPTER <N>[,<O>]                                                          *
;*                                                                             *
;* Play chapter sequence                                                       *
;*                                                                             *
;* If no <O> is specified:                                                     *
;*   -    chapter sequence is sent as an F-command Qxxyyzz..S with up to 7     *
;*        chapters specified and terminated with "S" for play sequence         *
;* otherwise                                                                   *
;* O = R  go to chapter, show a still and wait                                 *
;* O = N  go to chapter and play                                               *
;* O = S  as above                                                             *
;* others BRK Bad Parameter                                                    *
;*******************************************************************************
starCHAPTER:
         jsr     setYeq0
         lda     #LV_FCMD_Q_CHAPTER
         sta     WKSP_VFS_E00_TXTBUF
@diglp:  lda     (zp_vfsv_a8_textptr),Y
         sta     WKSP_VFS_E00_TXTBUF+1,Y
         cmp     #$0d
         beq     @term
         cmp     #' '
         beq     @term
         cmp     #','
         beq     @term
         iny
         bne     @diglp
@term:   tya
         tax
         jsr     skipCommaOrSpace
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #$0d
         bne     @parseOpt
         lda     #'S'
         bne     @setTermCharAndSend ;terminate with S and send

@parseOpt:
         iny
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #' '
         beq     @sk
         cmp     #$0d
         bne     @brkBadParm
@sk:     dey
         lda     (zp_vfsv_a8_textptr),Y
         and     #$df
         cmp     #'S'
         beq     @setTermCharAndSend
         cmp     #'R'
         beq     @setTermCharAndSend
         cmp     #'N'
         beq     @setTermCharAndSend
@brkBadParm:
         jsr     swap7PWSP_373_N933
         jsr     ReloadFSMandDIR_ThenBRK
         .byte   $ff
         .byte   "Bad parameter"
         .byte   $00

@setTermCharAndSend:
         sta     WKSP_VFS_E00_TXTBUF+1,X
         lda     #$0d
         sta     WKSP_VFS_E00_TXTBUF+2,X
         jsr     FCMD_TextBuf
         bra     FCMD_E1_VideoOn

setYeq0: ldy     #$00
         rts

; TODO: work out what this is then document
enableSearchPoll:
         lda     #$f0
         sta     VFS_0D93_CTDN_SEARCH
         lda     #$00
         sta     VFS_0D94_CTDN_QQQQQ
         rts

;*******************************************************************************
;* *SEARCH <N> - goto frame <N> return immediately                             *
;*******************************************************************************
starSEARCH:
         jsr     setYeq0
         lda     (zp_vfsv_a8_textptr),Y
         jsr     checkDecDigitBrkBadNumber ;check for digit - BRK bad number
         lda     #LV_FCMD_F_TERM_R_HALT
         jsr     parseDigitsBuildFCMD_F_TermA
         sta     $093a      ;store <CR>
         jsr     enableSearchPoll
         jmp     FCMD_TextBuf

;*******************************************************************************
;* *STILL <N> - Go to frame and still                                          *
;*                                                                             *
;* If no frame number calls *STEP with no parameter to stop                    *
;*                                                                             *
;* or calls *FRAME with parameter                                              *
;*******************************************************************************
starSTILL:
         jsr     setYeq0
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #$0d
         bne     starFRAME
         jmp     starSTEP

starFRAME:
         lda     #$05       ;5 retries?
         sta     VFS_N939_RETRY_CTR
@retry:  jsr     starSEARCH
         jsr     waitForSeek
         bcc     FCMD_E1_VideoOn
         dec     VFS_N939_RETRY_CTR
         bne     @retry
         jmp     swapP373N933brkBadNumber

; Turn the video on
FCMD_E1_VideoOn:
         lda     #LV_FCMD_E_VideoOnOff
         sta     WKSP_VFS_E00_TXTBUF
         lda     #$01
         jmp     sk

; wait for a "SEEK" *STILL/*FRAME
; 
; return Cy on fail or timeout
waitForSeek:
         lda     VFS_0D94_CTDN_QQQQQ
         bmi     disableSearchPoll
         bit     zp_mos_escape
         bpl     @noesc
         jmp     ErrorEscapeACKReloadFSM

@noesc:  jsr     FCMDRET_CheckForOpen ;check for "open" fail do BRK if open
         cli
         lda     WKSP_VFS_E00_TXTBUF ;check other return code
         cmp     #'A'       ;if not "A" try again
         bne     waitForSeek
         lda     WKSP_VFS_E00_TXTBUF+1
         cmp     #'0'       ;A0 - ok we're there? F*R or F*Q completed
         bne     checkNoFrame
disableSearchPoll:
         stz     VFS_0D93_CTDN_SEARCH ;OK disable timeout counters
         stz     VFS_0D94_CTDN_QQQQQ
         stz     $093a
         clc
         rts

checkNoFrame:
         cmp     #'N'       ;AN?
         bne     waitForSeek ;if not then keep waiting
         jsr     disableSearchPoll ;disable search poll
         lda     VFS_N939_RETRY_CTR
         bne     @secrts    ;if not on last retry then just return sec
         jmp     swapP373N933brkBadNumber ;do BRK bad number if AN returned again - it's a bad frame no

@secrts: sec                ;signal error
         rts

;*******************************************************************************
;* The LV player will be queried for the previously sent F command's result    *
;* which will be returned in the text buffer using vendore command $C8         *
;*******************************************************************************
FCMD_GetResult:
         lda     #SCSICMD_C8_VENDOR_FCMDRESULT
         jmp     sendCmdATxtBuf

;*******************************************************************************
;* Check the result of the previous F command for "door open" and cause a      *
;* door-open brk if true                                                       *
;*******************************************************************************
FCMDRET_CheckForOpen:
         jsr     FCMD_GetResult
         lda     WKSP_VFS_E00_TXTBUF
         cmp     #'O'
         beq     @bkrDoorOpen
         rts

@bkrDoorOpen:
         jsr     disableSearchPoll
         jsr     swap7PWSP_373_N933
         jsr     ReloadFSMandDIR_ThenBRK
         .byte   $93
         .byte   "Door open"
         .byte   $00

;*******************************************************************************
;* *STEP <mode>                                                                *
;*                                                                             *
;* where mode is a "signed" 8 bit number:                                      *
;*                                                                             *
;* -50..-2 (206..254)   Does "-" jump back <N> when N is -<mode>               *
;* -1      (255)        Does "M" still on prev picture                         *
;* 0                    Does "*" halt                                          *
;* 1                    Does "L" still on next picture                         *
;* 2..50                Does "+" jump forwards <N> when N is s<mode>           *
;*******************************************************************************
starSTEP:
         jsr     setYeq0
         jsr     parse8bitDecA
         cmp     #51
         bcc     @ok        ;<= 50 is ok
         cmp     #206
         bcc     swapP373N933brkBadNumber ;else must be >= -50
@ok:     tay
         iny                ;inc value
         cpy     #$03       ;if value was -1,0,1 look up special F-command for that step speed
         bcs     @mag       ;if outside range skip forward
         lda     tblFCMDStepSmall,Y ;look up specific command
         jmp     FCMD_Single_CharA ;send specific single-char command

@mag:    cmp     #$00
         bmi     @stepback
         ldy     #LV_FCMD_2B_JUMP_FWD ;send command F command +YY
@send:   sty     WKSP_VFS_E00_TXTBUF
         jsr     bit8DecimalToStringAtBuf1 ;followed by number in A
         jmp     FCMD_TextBuf ;send it

@stepback:
         eor     #$ff
         inc     A          ;negate
         ldy     #LV_FCMD_2D_JUMP_BACK ;send command F command -YY
         bne     @send

tblFCMDStepSmall:
         .byte   LV_FCMD_M_still_reverse ;step -1 send F command "M" - still reverse
         .byte   LV_FCMD_2A_halt ;step 0 send F command "*" - halt
         .byte   LV_FCMD_L_still_forward ;step 1 send F command "L" - still/forward

;*******************************************************************************
;* Parse string at ($A8),Y as an 8-bit decimal number                          *
;*                                                                             *
;* Number is terminated by <CR> or space                                       *
;*                                                                             *
;* Cy set on exit for not a number or overflow                                 *
;*******************************************************************************
parse8bitDecA:
         lda     #$0d
; If entered here the expected termination char is in A
Parse8bitDecATerminA:
         sta     $ae
         lda     #$00
         sta     $af
@digloop:
         lda     (zp_vfsv_a8_textptr),Y
         cmp     $ae
         beq     @skterm
         cmp     #' '
         beq     @skterm
         jsr     checkDecDigitBrkBadNumber
         and     #$0f
         pha
         lda     $af
         asl     A
         bcs     swapP373N933brkBadNumber
         asl     A
         bcs     swapP373N933brkBadNumber
         adc     $af
         bcs     swapP373N933brkBadNumber
         asl     A
         bcs     swapP373N933brkBadNumber
         sta     $af
         pla
         adc     $af
         bcs     swapP373N933brkBadNumber
         sta     $af
         iny
         jmp     @digloop

@skterm: jsr     skipCommaOrSpace
         lda     $af
         rts

checkDecDigitBrkBadNumber:
         cmp     #'0'
         bcc     swapP373N933brkBadNumber
         cmp     #':'
         bcs     swapP373N933brkBadNumber
         rts

swapP373N933brkBadNumber:
         jsr     swap7PWSP_373_N933
brkBadNumber:
         jsr     ReloadFSMandDIR_ThenBRK
         .byte   $dc
         .asciiz "Bad number"

;*******************************************************************************
;* *AUDIO <N>                                                                  *
;*                                                                             *
;* Sends an A or B F-command                                                   *
;*                                                                             *
;* <N>     Command Descr                                                       *
;* 0       A0      Both channels off                                           *
;* 1       A1      Ch.1 on,   Ch.2 off                                         *
;* 2       B0      Ch.1 off   Ch.2 on                                          *
;* 3       B1      Ch.1 on    Ch.2 on                                          *
;*******************************************************************************
starAUDIO:
         jsr     setYeq0
         jsr     parse8bitDecA
         cmp     #$04
         bcs     swapP373N933brkBadNumber
         pha
         ldx     #'A'
         stx     WKSP_VFS_E00_TXTBUF
         and     #$01
         jsr     sk
         inc     WKSP_VFS_E00_TXTBUF
         pla
         lsr     A
sk:      ora     #$30
         sta     WKSP_VFS_E00_TXTBUF+1
         lda     #$0d
         sta     WKSP_VFS_E00_TXTBUF+2
         jmp     FCMD_TextBuf

;*******************************************************************************
;* *FAST - <direction>                                                         *
;*                                                                             *
;* Move at 3*play speed, in direction 0..127 forwards, 128..255 backwards      *
;*******************************************************************************
starFAST:
         jsr     setYeq0
         jsr     parse8bitDecA
         bpl     @rewind
         lda     #LV_FCMD_Z_FastReverse
         bne     @send

@rewind: lda     #LV_FCMD_W_FastForwards
@send:   jmp     FCMD_Single_CharA

;*******************************************************************************
;* *SLOW <speed>,<direction>                                                   *
;*                                                                             *
;* 5>=speed>=254                                                               *
;* direction                                                                   *
;*******************************************************************************
starSLOW:
         jsr     setYeq0
         lda     #','       ;expect comma separator
         jsr     Parse8bitDecATerminA
         sty     WKSP_VFS_E00_TXTBUF+16 ;stash Y pointer at offset 16
         eor     #$ff       ;invert number
         cmp     #$02       ;check for bounds
         bcc     swapP373N933brkBadNumber
         cmp     #$fb
         bcs     swapP373N933brkBadNumber
         jsr     bit8DecimalToStringAtBuf1 ;place inverted(!) number in buffer
         lda     #LV_FCMD_S_SetSlowSpeed
         sta     WKSP_VFS_E00_TXTBUF
         jsr     FCMD_TextBuf ;set slow speed
         ldy     WKSP_VFS_E00_TXTBUF+16 ;get back stashed Y
         jsr     parse8bitDecA ;parse direction
         bpl     @forwards  ;forwards
         lda     #LV_FCMD_V_SlowReverse ;slow reverse
         jmp     FCMD_Single_CharA

@forwards:
         lda     #LV_FCMD_U_SlowForward
         jmp     FCMD_Single_CharA

; Skip over commas/spaces - looks like it will skip over multiple commas
skipCommaOrSpace:
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #','
         beq     @sk
         cmp     #' '
         bne     @ex
@sk:     iny
         bne     skipCommaOrSpace
@ex:     rts

;*******************************************************************************
;* place a 3 digit decimal representation of A in the buffer at offset 1 and   *
;* terminate with a <CR>                                                       *
;*******************************************************************************
bit8DecimalToStringAtBuf1:
         ldx     #100
         jsr     @digit
         pha
         tya
         ora     #'0'
         sta     WKSP_VFS_E00_TXTBUF+1
         pla
         ldx     #$0a
         jsr     @digit
         ora     #'0'
         sta     WKSP_VFS_E00_TXTBUF+3
         tya
         ora     #'0'
         sta     WKSP_VFS_E00_TXTBUF+2
         lda     #$0d
         sta     WKSP_VFS_E00_TXTBUF+4
         rts

@digit:  stx     WKSP_VFS_E00_TXTBUF+17
         sec
         ldy     #$ff
@lp:     sbc     WKSP_VFS_E00_TXTBUF+17
         iny
         bcs     @lp
         adc     WKSP_VFS_E00_TXTBUF+17
         rts

FCMD_N_then_E1:
         lda     #LV_FCMD_N_PlayForwards-150
         jsr     FCMD_Single_CharA
         jmp     FCMD_E1_VideoOn

;*******************************************************************************
;* *PLAY [<start>[,<end>]]                                                     *
;*******************************************************************************
starPLAY:
         jsr     setYeq0
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #$0d
         beq     FCMD_N_then_E1 ;no parameter just play
         jsr     parse16BitToYX
         stx     VFS_N937_PlayStart
         sty     VFS_N937_PlayStart+1
         jsr     setYeq0
         jsr     @skip2ndNumber
         jsr     parse16BitToYX
         lda     #LV_FCMD_O_PlayBackwards
         cpy     VFS_N937_PlayStart+1 ;compare start/end and decide on direction
         beq     @Yeq
         bcc     @Xlt
         bcs     @Yge

@Yeq:    cpx     VFS_N937_PlayStart
         bcc     @Xlt
@Yge:    lda     #LV_FCMD_N_PlayForwards-150
@Xlt:    pha                ;stash play command
         jsr     starFRAME  ;set starting frame
         jsr     setYeq0
         jsr     @skip2ndNumber
         lda     #LV_FCMD_F_TERM_S_HALT
         jsr     parseDigitsBuildFCMD_F_TermA
         jsr     FCMD_TextBuf ;set ending frame number
         pla                ;get back play direction command stashed above
         jmp     FCMD_Single_CharA ;start playing

@skip2ndNumber:
         lda     (zp_vfsv_a8_textptr),Y
         iny
         cmp     #' '
         beq     @skSpace
         cmp     #$0d
         beq     jmpSwBrkBadNumber
         cmp     #','
         bne     @skip2ndNumber
@skSpace:
         jmp     skipCommaOrSpace

;*******************************************************************************
;* The command tail is parsed for digits which are entered into the SCSI       *
;* command buffer preceded by F Command "F".                                   *
;*                                                                             *
;* If no digits, non-digits, or >5 digits a BRK Bad number is issued           *
;*                                                                             *
;* The command is terminated by the code passed in 'A' which should be:        *
;* 'N'     Search then play                                                    *
;* 'Q'     Search then continue                                                *
;* 'R'     Search then halt       *SEARCH                                      *
;* 'S'     Play until this frame  *PLAY                                        *
;*******************************************************************************
parseDigitsBuildFCMD_F_TermA:
         pha
         jsr     skipCommaOrSpace
@lpSkipZeroes:
         lda     (zp_vfsv_a8_textptr),Y
         iny
         cmp     #'0'
         beq     @lpSkipZeroes
         dey
         ldx     #$00       ;text buffer pointer = 0
@lp:     lda     (zp_vfsv_a8_textptr),Y
         cmp     #$0d
         beq     @term
         cmp     #' '
         beq     @term
         cmp     #','
         beq     @term
         jsr     checkDecDigitBrkBadNumber
         sta     WKSP_VFS_E00_TXTBUF+1,X
         inx
         cpx     #$06
         bcs     jmpSwBrkBadNumber
         iny
         bne     @lp
@term:   lda     #LV_FCMD_F_GOTOFRAME
         sta     WKSP_VFS_E00_TXTBUF
         pla
         sta     WKSP_VFS_E00_TXTBUF+1,X
         lda     #$0d
         sta     WKSP_VFS_E00_TXTBUF+2,X
         rts

jmpSwBrkBadNumber:
         jmp     swapP373N933brkBadNumber

parse16BitToYX:
         jsr     parse16bitDecXA
         bcs     jmpSwBrkBadNumber
         pha
         txa
         tay
         plx
         rts

LAF3D:   lda     VFS_0D92_FLAG_POLL100
         beq     LAF4D
         lda     #$18
         sta     sheila_USRVIA_ier
         jsr     LB022
         stz     VFS_0D92_FLAG_POLL100
LAF4D:   rts

LAF4E:   jsr     RestoreZpAndPage9
         jsr     ReloadFSMandDIR_ThenBRK
         .byte   $95
         .asciiz "IRQ already indirected"
VFSstarMOUSE:
         jsr     setYeq0
         jsr     skipCommaOrSpace
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #$0d
         beq     @LAF84
         jsr     parse16bitDecXA
         bcc     @LAF80
         jmp     restoreP9BrkBadNumber

@LAF80:  and     #$01
         beq     LAF3D
@LAF84:  ldx     VFS_0D92_FLAG_POLL100
         bne     LAF4D
         lda     VFS_N924_PTR_Q-1
         bne     LAF4E
         stx     $090d
         stx     $0909
         dex
         stx     VFS_0D92_FLAG_POLL100
         stx     $090a
         lda     sheila_USRVIA_pcr
         and     #$0f
         sta     sheila_USRVIA_pcr
         lda     sheila_USRVIA_acr
         and     #$fc
         sta     sheila_USRVIA_acr
         lda     #$98
         sta     sheila_USRVIA_ier
         lda     #$00
         sta     sheila_USRVIA_ddrb
         lda     #$80
         sta     VFS_N904_MousePos
         lda     #$02
         sta     VFS_N904_MousePos+1
         lda     #$00
         sta     VFS_N904_MousePos+2
         lda     #$02
         sta     VFS_N904_MousePos+3
         lda     #$7f
         sta     VFS_N900
         sta     VFS_N900_MouseBounds+1
         lda     #$00
         sta     VFS_N900_MouseBounds+2
         sta     VFS_N900_MouseBounds+3
         rts

VFSstarPOINTER:
         jsr     setYeq0
         jsr     skipCommaOrSpace
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #$0d
         bne     @LAFEA
         lda     #$01
         bne     @LAFF2

@LAFEA:  jsr     parse16bitDecXA
         bcc     @LAFF2
         jmp     restoreP9BrkBadNumber

@LAFF2:  ldy     #$18
         sty     sheila_USRVIA_ier
         pha
         and     #$02
         bne     @LB001
         lda     #$98
         sta     sheila_USRVIA_ier
@LB001:  pla
         and     #$01
         beq     LB022
         lda     VFS_0D92_FLAG_POLL100
         beq     LB021
         lda     $0909
         bne     LB021
         lda     #$ff
         sta     ZP_EXTR_PTR_Q+1
         jsr     LB2ED
         ldy     VFS_N904_MousePos
         dey
         sty     $090e
         dec     $0909
LB021:   rts

LB022:   lda     $0909
         beq     LB021
         stz     $0909
         lda     sheila_ACCON
         sta     VFS_N932_ACCON_SAVE
         and     #$fb
         bit     #$02
         beq     @LB038
         ora     #$04
@LB038:  sta     sheila_ACCON
         jsr     LB240
         lda     VFS_N932_ACCON_SAVE
         sta     sheila_ACCON
         rts

LB045:   lda     VFS_N904_MousePos
         cmp     $090e
         bne     @LB065
         lda     VFS_N904_MousePos+2
         cmp     $0910
         bne     @LB065
         lda     VFS_N904_MousePos+1
         cmp     $090f
         bne     @LB065
         lda     VFS_N904_MousePos+3
         cmp     $0911
         beq     LB021
@LB065:  lda     sheila_ACCON
         sta     VFS_N932_ACCON_SAVE
         and     #$fb
         bit     #$02
         beq     @LB073
         ora     #$04
@LB073:  sta     sheila_ACCON
         lda     VFS_N904_MousePos+2
         sta     $0910
         lda     VFS_N904_MousePos+3
         sta     $0911
         lda     VFS_N904_MousePos
         sta     $090e
         lda     VFS_N904_MousePos+1
         sta     $090f
         cmp     VFS_N900_MouseBounds+1
         bcc     @LB0A6
         beq     @LB097
         bcs     @LB09F

@LB097:  lda     VFS_N904_MousePos
         cmp     VFS_N900
         bcc     @LB0A6
@LB09F:  lda     $090b
         ora     #$01
         bne     @LB0AB

@LB0A6:  lda     $090b
         and     #$02
@LB0AB:  tay
         lda     VFS_N904_MousePos+3
         cmp     VFS_N900_MouseBounds+3
         bcc     @LB0C5
         beq     @LB0B8
         bcs     @LB0C0

@LB0B8:  lda     VFS_N904_MousePos+2
         cmp     VFS_N900_MouseBounds+2
         bcc     @LB0C5
@LB0C0:  tya
         ora     #$02
         bne     @LB0C8

@LB0C5:  tya
         and     #$01
@LB0C8:  cmp     $090b
         beq     @LB0D0
         jsr     LB2ED
@LB0D0:  ldy     VFS_N904_MousePos
         lda     VFS_N908_MODESAVE
         cmp     #$02
         bne     @LB0E9
         lda     VFS_N904_MousePos+1
         cmp     #$04
         bne     @LB0E9
         cpy     #$f8
         bcc     @LB0E9
         dey
         dey
         dey
         dey
@LB0E9:  ldx     $090b
         tya
         sec
         sbc     LB9A0,X
         sta     $0912
         lda     VFS_N904_MousePos+1
         sbc     #$00
         sta     $0913
         lda     LB9A4,X
         clc
         adc     VFS_N904_MousePos+2
         sta     $0916
         lda     VFS_N904_MousePos+3
         adc     #$00
         sta     $0917
         jsr     LB44C
         ldy     ZP_MOS_CURROM
         lda     SYSVARS_DF0_PWSKPTAB,Y
         inc     A
         sta     ZP_EXTRA_TMPPTR+1
         lda     LB990,X
         sta     ZP_EXTRA_BASE
         jsr     LB240
         lda     $0912
         sta     $0914
         lda     $0913
         sta     $0915
         lda     $8d
         pha
         lda     $8c
         pha
         lda     $8d
         pha
         lda     $8c
         pha
         ldx     #$00
         stx     $8a
@LB13D:  ldy     #$00
         sty     $89
         lda     $8d
         bmi     @LB1A5
         cmp     #$30
         bcc     @LB199
         lda     $0913
         bmi     @LB1A5
         cmp     #$05
         bcc     @LB155
         jmp     @LB1D4

@LB155:  ldy     $89
         lda     ($8c),Y
         ldy     $8a
         sta     ($86),Y
         inc     ZP_EXTRA_TMPPTR+1
         lda     (ZP_EXTRA_BASE),Y
         dec     ZP_EXTRA_TMPPTR+1
         ldy     $89
         and     ($8c),Y
         ldy     $8a
         ora     (ZP_EXTRA_BASE),Y
         ldy     $89
         sta     ($8c),Y
         inc     $8a
         lda     $8a
         and     #$0f
         beq     @LB1AE
         inc     $89
         lda     $89
         clc
         adc     $8c
         and     #$07
         bne     @LB155
@LB182:  ldy     VFS_N908_MODESAVE
         lda     $8c
         and     #$f8
         clc
         adc     LB98A,Y
         sta     $8c
         lda     $8d
         adc     LB98D,Y
         sta     $8d
         jmp     @LB13D

@LB199:  lda     $8c
         and     #$07
         clc
         adc     $8a
         sta     $8a
         jmp     @LB182

@LB1A5:  lda     $8a
         and     #$f0
         clc
         adc     #$10
         sta     $8a
@LB1AE:  lda     $0912
         clc
         adc     #$10
         sta     $0912
         bcc     @LB1BC
         inc     $0913
@LB1BC:  pla
         clc
         adc     #$08
         sta     $8c
         pla
         adc     #$00
         sta     $8d
         pha
         lda     $8c
         pha
         lda     $8a
         cmp     #$40
         beq     @LB1D4
         jmp     @LB13D

@LB1D4:  pla
         pla
         pla
         sta     ZP_EXTR_PTR_Q
         pla
         sta     ZP_EXTR_PTR_Q+1
         lda     VFS_N932_ACCON_SAVE
         sta     sheila_ACCON
         rts

RestoreZpAndPage9:
         lda     ZP_EXTR_PTR_Q
         sta     VFS_N924_PTR_Q
         lda     ZP_EXTR_PTR_Q+1
         sta     VFS_N924_PTR_Q+1
         ldx     #$0c
@lp:     lda     VFS_N926_ZPSAVE,X
         sta     ZP_EXTRA_BASE,X
         dex
         bpl     @lp
swapPage9AndPrivWkspP3:
         pha
         phx
         phy
         lda     ZP_EXTRA_BASE
         pha
         lda     ZP_EXTRA_TMPPTR+1
         pha
         ldx     ZP_MOS_CURROM
         lda     SYSVARS_DF0_PWSKPTAB,X
         clc
         adc     #$03       ;save page 900 to 3rd page of private workspace
         sta     ZP_EXTRA_TMPPTR+1
         lda     #$40
         sta     ZP_EXTRA_BASE
         ldy     #$32
@lp:     ldx     VFS_N900,Y
         lda     (ZP_EXTRA_BASE),Y
         sta     VFS_N900,Y
         txa
         sta     (ZP_EXTRA_BASE),Y
         dey
         bpl     @lp
         pla
         sta     ZP_EXTRA_TMPPTR+1
         pla
         sta     ZP_EXTRA_BASE
         ply
         plx
         pla
         rts

PreserveZpAndPage9:
         jsr     swapPage9AndPrivWkspP3
         ldx     #ZP_EXTRA_LEN
@lp:     lda     ZP_EXTRA_BASE,X
         sta     VFS_N926_ZPSAVE,X
         dex
         bpl     @lp
         lda     VFS_N924_PTR_Q
         sta     ZP_EXTR_PTR_Q
         lda     VFS_N924_PTR_Q+1
         sta     ZP_EXTR_PTR_Q+1
LB23Frts:
         rts

LB240:   ldy     ZP_MOS_CURROM
         lda     SYSVARS_DF0_PWSKPTAB,Y
         clc
         adc     #$03
         sta     $87
         stz     $86
         lda     ZP_EXTR_PTR_Q+1
         bmi     LB23Frts
         pha
         lda     ZP_EXTR_PTR_Q
         pha
         ldy     #$00
         sty     $8a
@LB258:  ldy     #$00
         sty     $89
         lda     ZP_EXTR_PTR_Q+1
         bmi     @LB2C5
         cmp     #$30
         bcc     @LB2D1
         lda     $0915
         bmi     @LB2C5
         cmp     #$05
         bcs     @LB2C2
@LB26D:  ldy     $8a
         lda     ($86),Y
         ldy     $89
         sta     (ZP_EXTR_PTR_Q),Y
         inc     $8a
         lda     $8a
         and     #$0f
         beq     @LB29F
         inc     $89
         lda     $89
         clc
         adc     ZP_EXTR_PTR_Q
         and     #$07
         bne     @LB26D
@LB288:  ldy     VFS_N908_MODESAVE
         lda     ZP_EXTR_PTR_Q
         and     #$f8
         clc
         adc     LB98A,Y
         sta     ZP_EXTR_PTR_Q
         lda     ZP_EXTR_PTR_Q+1
         adc     LB98D,Y
         sta     ZP_EXTR_PTR_Q+1
         jmp     @LB258

@LB29F:  lda     $0914
         clc
         adc     #$10
         sta     $0914
         bcc     @LB2AD
         inc     $0915
@LB2AD:  pla
         clc
         adc     #$08
         sta     ZP_EXTR_PTR_Q
         pla
         adc     #$00
         sta     ZP_EXTR_PTR_Q+1
         pha
         lda     ZP_EXTR_PTR_Q
         pha
         ldy     $8a
         cpy     #$40
         bne     @LB258
@LB2C2:  pla
         pla
         rts

@LB2C5:  lda     $8a
         and     #$f0
         clc
         adc     #$10
         sta     $8a
         jmp     @LB29F

@LB2D1:  lda     ZP_EXTR_PTR_Q
         and     #$07
         clc
         adc     $8a
         sta     $8a
         jmp     @LB288

LB2DD:   jsr     RestoreZpAndPage9
         jsr     ReloadFSMandDIR_ThenBRK
         lda     $6142
         stz     $20
         eor     $444f
         eor     $00
LB2ED:   sta     $090b
         asl     A
         asl     A
         asl     A
         asl     A
         asl     A
         asl     A
         tay
         lda     VFS_N908_MODESAVE
         cmp     #$03
         bcs     LB2DD
         pha
         clc
         adc     #$b9
         sta     ZP_EXTRA_TMPPTR+1
         lda     #$a8
         sta     ZP_EXTRA_BASE
         pla
         clc
         adc     #$bc
         sta     $87
         lda     #$a8
         sta     $86
         ldx     ZP_MOS_CURROM
         lda     SYSVARS_DF0_PWSKPTAB,X
         inc     A
         sta     $8d
         stz     $8c
         sty     $8a
         ldy     #$00
         sty     $89
@LB322:  ldy     $8a
         lda     (ZP_EXTRA_BASE),Y
         ldy     $89
         sta     ($8c),Y
         ldy     $8a
         lda     ($86),Y
         ldy     $89
         inc     $8d
         sta     ($8c),Y
         dec     $8d
         inc     $8a
         inc     $89
         ldy     $89
         cpy     #$40
         bne     @LB322
         stz     ZP_EXTRA_BASE
         lda     #$40
         sta     $86
         ldx     ZP_MOS_CURROM
         lda     SYSVARS_DF0_PWSKPTAB,X
         inc     A
         sta     ZP_EXTRA_TMPPTR+1
         sta     $87
         lda     #$00
         sta     $88
         jsr     @LB36B
         stz     ZP_EXTRA_BASE
         lda     #$40
         sta     $86
         ldx     ZP_MOS_CURROM
         lda     SYSVARS_DF0_PWSKPTAB,X
         clc
         adc     #$02
         sta     ZP_EXTRA_TMPPTR+1
         sta     $87
         dec     $88
@LB36B:  lda     VFS_N908_MODESAVE
         beq     @LB3C1
         cmp     #$01
         beq     @LB377
         jmp     @LB3FE

@LB377:  jsr     @LB37D
         jsr     @LB37D
@LB37D:  ldx     #$00
@LB37F:  lda     $88
         cmp     #$ff
         lda     #$00
         php
@LB386:  sta     $8a
         txa
         ora     $8a
         tay
         lda     (ZP_EXTRA_BASE),Y
         plp
         bcs     @LB395
         and     #$ef
         bcc     @LB397

@LB395:  ora     #$10
@LB397:  bit     $88
         bmi     @LB39C
         clc
@LB39C:  ror     A
         php
         sta     ($86),Y
         lda     $8a
         clc
         adc     #$10
         cmp     #$40
         bne     @LB386
         plp
         inx
         cpx     #$10
         bne     @LB37F
@LB3AF:  lda     ZP_EXTRA_TMPPTR+1
         sta     $87
         lda     $86
         sta     ZP_EXTRA_BASE
         clc
         adc     #$40
         sta     $86
         bcc     @LB3C0
         inc     $87
@LB3C0:  rts

@LB3C1:  jsr     @LB3C7
         jsr     @LB3C7
@LB3C7:  jsr     @LB3D8
         lda     ZP_EXTRA_TMPPTR+1
         sta     $87
         lda     $86
         sta     ZP_EXTRA_BASE
         jsr     @LB3D8
         jmp     @LB3AF

@LB3D8:  ldx     #$00
@LB3DA:  lda     $88
         cmp     #$ff
         lda     #$00
         php
@LB3E1:  sta     $8a
         txa
         ora     $8a
         tay
         lda     (ZP_EXTRA_BASE),Y
         plp
         ror     A
         php
         sta     ($86),Y
         lda     $8a
         clc
         adc     #$10
         cmp     #$40
         bne     @LB3E1
         plp
         inx
         cpx     #$10
         bne     @LB3DA
         rts

@LB3FE:  jsr     @LB440
         jsr     @LB407
         jmp     @LB440

@LB407:  ldx     #$00
@LB409:  lda     $88
         cmp     #$ff
         lda     #$00
         php
@LB410:  sta     $8a
         txa
         ora     $8a
         tay
         lda     (ZP_EXTRA_BASE),Y
         and     #$aa
         lsr     A
         plp
         bcc     @LB426
         bit     $88
         bpl     @LB424
         ora     #$aa
@LB424:  ora     #$02
@LB426:  sta     ($86),Y
         lda     (ZP_EXTRA_BASE),Y
         and     #$55
         lsr     A
         php
         lda     $8a
         clc
         adc     #$10
         cmp     #$40
         bne     @LB410
         plp
         inx
         cpx     #$10
         bne     @LB409
         jmp     @LB3AF

@LB440:  ldy     #$3f
@LB442:  lda     (ZP_EXTRA_BASE),Y
         sta     ($86),Y
         dey
         bpl     @LB442
         jmp     @LB3AF

LB44C:   lda     $0917
         sta     $8c
         lda     $0916
         lsr     $8c
         ror     A
         lsr     $8c
         ror     A
         sta     $0916
         lsr     A
         lsr     A
         lsr     A
         tax
         lda     $0913
         bpl     @LB467
         inx
@LB467:  lda     $8c
         beq     @LB47B
         txa
         clc
         adc     #$20
         tax
         lda     $0916
         eor     #$07
         sta     $0916
         dec     $0916
@LB47B:  lda     LB965,X
         sta     $8d
         lda     LB943,X
         sta     $8c
         lda     $0913
         bpl     @LB48D
         clc
         adc     #$05
@LB48D:  sta     $88
         lda     $0912
         lsr     $88
         ror     A
         and     #$f8
         clc
         adc     $8c
         sta     $8c
         lda     $88
         adc     $8d
         sta     $8d
         lda     $0916
         and     #$07
         eor     #$07
         ora     $8c
         sta     $8c
         lda     $0912
         lsr     A
         lsr     A
         and     #$03
         tax
         rts

         cmp     #$80
         beq     @LB50A
@LB4BA:  pha
         lda     $0d98
         cmp     #$ff
         beq     @LB4C6
         pla
         jmp     ($0d97)

@LB4C6:  php
         sei
         phx
         phy
         ldx     #$03
@LB4CC:  lda     zp_vfsv_a8_textptr,X
         pha
         dex
         bpl     @LB4CC
         ldy     ZP_MOS_CURROM
         lda     SYSVARS_DF0_PWSKPTAB,Y
         clc
         adc     #$03
         sta     $ab
         stz     $aa
         ldy     #$5b
         lda     ($aa),Y
         clc
         adc     #$4e
         sta     zp_vfsv_a8_textptr
         iny
         lda     ($aa),Y
         sta     zp_vfsv_a8_textptr+1
         lda     #$5d
         sta     $aa
         ldy     #$02
@LB4F2:  lda     ($aa),Y
         sta     (zp_vfsv_a8_textptr),Y
         dey
         bpl     @LB4F2
         ldx     #$00
@LB4FB:  pla
         sta     zp_vfsv_a8_textptr,X
         inx
         cpx     #$04
         bne     @LB4FB
         ply
         plx
         plp
         pla
         jmp     $ff4e

@LB50A:  cpx     #$09
         beq     @LB52F
         bcs     @LB4BA
         cpx     #$05
         bcc     @LB4BA
         php
         sei
         jsr     swapPage9AndPrivWkspP3
         txa
         asl     A
         adc     #$f6
         tay
         lda     VFS_N900,Y
         tax
         iny
         lda     VFS_N900,Y
         tay
         jsr     swapPage9AndPrivWkspP3
         plp
@LB52B:  lda     #$80
         clv
         rts

@LB52F:  php
         sei
         jsr     swapPage9AndPrivWkspP3
         jsr     LB65B
         lda     sheila_USRVIA_orb
         cpx     #$00
         beq     @LB542
         rol     A
         rol     A
         rol     A
         rol     A
@LB542:  and     #$07
         eor     #$07
         tax
         jsr     swapPage9AndPrivWkspP3
         plp
         ldy     #$00
         beq     @LB52B

         cld
         lda     sheila_USRVIA_ier
         and     sheila_USRVIA_ier-1
         and     #$18
         bne     @LB567
         lda     #$b5
         pha
         lda     #$66
         pha
         php
         lda     $fc
         jmp     ($0d9d)

         rts

@LB567:  phx
         ldx     sheila_USRVIA_orb
         phy
         tay
         lda     ZP_EXTRA_BASE
         pha
         lda     ZP_EXTRA_TMPPTR+1
         pha
         phx
         phy
         ldy     ZP_MOS_CURROM
         lda     SYSVARS_DF0_PWSKPTAB,Y
         clc
         adc     #$03
         sta     ZP_EXTRA_TMPPTR+1
         lda     #$44
         sta     ZP_EXTRA_BASE
         jsr     swapZPEXTRA6with904
         ply
         jsr     LB65B
         tya
         and     #$10
         beq     @LB5CC
         pla
         pha
         and     LB6CC,X
         beq     @LB5B3
         lda     VFS_N904_MousePos+1
         cmp     #$04
         bne     @LB5A4
         lda     VFS_N904_MousePos
         cmp     #$fc
         bcs     @LB5CC
@LB5A4:  lda     VFS_N904_MousePos
         adc     #$04
         sta     VFS_N904_MousePos
         bcc     @LB5B1
         inc     VFS_N904_MousePos+1
@LB5B1:  bra     @LB5CC

@LB5B3:  lda     VFS_N904_MousePos
         ora     VFS_N904_MousePos+1
         beq     @LB5CC
         lda     VFS_N904_MousePos
         sec
         sbc     #$04
         sta     VFS_N904_MousePos
         lda     VFS_N904_MousePos+1
         sbc     #$00
         sta     VFS_N904_MousePos+1
@LB5CC:  tya
         and     #$08
         beq     @LB609
         pla
         and     LB6CB,X
         beq     @LB5F1
         lda     VFS_N904_MousePos+3
         cmp     #$03
         lda     VFS_N904_MousePos+2
         bcc     @LB5E5
         cmp     #$fc
         bcs     @LB60A
@LB5E5:  adc     #$04
         sta     VFS_N904_MousePos+2
         bcc     @LB60A
         inc     VFS_N904_MousePos+3
         bra     @LB60A

@LB5F1:  lda     VFS_N904_MousePos+2
         ora     VFS_N904_MousePos+3
         beq     @LB60A
         lda     VFS_N904_MousePos+2
         sec
         sbc     #$04
         sta     VFS_N904_MousePos+2
         bcs     @LB60A
         dec     VFS_N904_MousePos+3
         bra     @LB60A

@LB609:  pla
@LB60A:  lda     sheila_USRVIA_orb
         jsr     swapZPEXTRA6with904
         pla
         sta     ZP_EXTRA_TMPPTR+1
         pla
         sta     ZP_EXTRA_BASE
         ply
         plx
         lda     $fc
         rts

Serv15_Poll100Hz:
         php
         dec     VFS_0D95_20Hz_CTDN
         bpl     @poh2
         pha
         lda     #$04
         sta     VFS_0D95_20Hz_CTDN
         lda     VFS_0D94_CTDN_QQQQQ
         bmi     @sk2
         lda     VFS_0D93_CTDN_SEARCH
         bne     @sk1
         dec     VFS_0D94_CTDN_QQQQQ
@sk1:    dec     VFS_0D93_CTDN_SEARCH
@sk2:    lda     VFS_0D92_FLAG_POLL100
         beq     @poh3
         phx
         phy
         jsr     PreserveZpAndPage9
         jsr     LB67E
         lda     $0909
         beq     @poh4
         jsr     LB045
@poh4:   jsr     RestoreZpAndPage9
         ply
         plx
@poh3:   pla
@poh2:   dey                ;decrement semaphore
         cpy     #$00
         bne     @poh
         lda     #$00       ;if we're the last then cancel the service call
@poh:    plp
         rts

LB65B:   ldx     $090a
         bpl     @LB67D
         ldx     #$00
         lda     sheila_USRVIA_orb
         and     #$e0
         cmp     #$e0
         bne     @LB678
         lda     sheila_USRVIA_orb
         and     #$18
         cmp     #$18
         bne     @LB67A
         ldx     #$07
         bne     @LB67D

@LB678:  ldx     #$07
@LB67A:  stx     $090a
@LB67D:  rts

LB67E:   jsr     LB65B
         lda     sheila_USRVIA_orb
         and     @LB6C7,X
         cmp     $090d
         beq     @LB698
         cmp     $090c
         sta     $090c
         beq     @LB697
         sta     $090d
@LB697:  rts

@LB698:  stz     $090d
         lda     $090c
         cmp     @LB6C7,X
         beq     @LB697
         ldy     #$0d
         and     @LB6C8,X
         beq     @LB6BF
         lda     $090c
         ldy     #$c0
         and     @LB6CA,X
         beq     @LB6BF
         lda     #OSBYTE_DB_RW_TABCODE
         ldx     #$00
         ldy     #$ff
         jsr     OSBYTE
         txa
         tay
@LB6BF:  lda     #OSBYTE_99_INS_BUF_CKESC
         ldx     #$00
         jmp     OSBYTE

         .byte   $18
@LB6C7:  .byte   $07
@LB6C8:  .byte   $01
         .byte   $02
@LB6CA:  .byte   $04
LB6CB:   .byte   $10
LB6CC:   .byte   $08
         .byte   $05
         .byte   $e0
         .byte   $20
         .byte   $40
         .byte   $80
         .byte   $04
         .byte   $01

swapZPEXTRA6with904:
         ldy     #$06
@lp:     ldx     VFS_N904_MousePos,Y
         lda     (ZP_EXTRA_BASE),Y
         sta     VFS_N904_MousePos,Y
         txa
         sta     (ZP_EXTRA_BASE),Y
         dey
         bpl     @lp
         rts

swap7PWSP_373_N933:
         ldx     ZP_MOS_CURROM
         lda     SYSVARS_DF0_PWSKPTAB,X
         clc
         adc     #>VFS_PWSKP_373_SAVE_N933
         sta     $ad
         lda     #<VFS_PWSKP_373_SAVE_N933
         sta     $ac
         ldy     #$07
@lp:     ldx     $0933,Y
         lda     ($ac),Y
         sta     $0933,Y
         txa
         sta     ($ac),Y
         dey
         bpl     @lp
         rts

;*******************************************************************************
;* Parse string at ($A8),Y as a decimal number                                 *
;*                                                                             *
;* Cy set on exit for not a number or overflow                                 *
;*******************************************************************************
parse16bitDecXA:
         ldx     #$03
@slp:    lda     $093b,X    ;save 93b-93d on stack for workspace (TODO: why not ZP?)
         pha
         dex
         bpl     @slp
         lda     #$00       ;zero accumulator
         sta     $093b
         sta     $093c
         sec
         php
         jsr     skipCommaOrSpace
@charlp: lda     (zp_vfsv_a8_textptr),Y
         cmp     #' '
         beq     @sksep
         cmp     #','
         beq     @sksep
         cmp     #$0d
         beq     @sksep
         cmp     #'0'
         bcc     @skError
         cmp     #':'
         bcs     @skError
; multiply current accumulator by 10, check for overflows
         lda     $093b
         sta     $093d
         lda     $093c
         sta     $093e
         lda     $093b
         asl     A
         rol     $093c
         bcs     @skError
         asl     A
         rol     $093c
         bcs     @skError
         adc     $093d
         sta     $093b
         lda     $093c
         adc     $093e
         bcs     @skError
         sta     $093c
         asl     $093b
         rol     $093c
         bcs     @skError
; get char back
         lda     (zp_vfsv_a8_textptr),Y
         and     #$0f
         clc
; add in and check for overflow
         adc     $093b
         sta     $093b
         bcc     @cysk
         inc     $093c
         beq     @skError
@cysk:   plp
         clc                ;clear carry error flag
         php
         iny
         bne     @charlp
@skError:
         plp
         sec                ;set carry for error flag
         php
@sksep:  plp                ;pop cy flag as set in routine
         lda     $093b      ;get low accumulator byte
         sta     $af        ;store in here briefly ; TODO: could have used this above!
         ldx     $093c      ;load high byte to return
         pla
         sta     $093b
         pla
         sta     $093c
         pla
         sta     $093d
         pla
         sta     $093e
         lda     $af        ;get back low byte
         rts

VFSstarTMAX:
         jsr     setYeq0
         jsr     parse16bitDecXA ;get first parameter
         bcs     restoreP9BrkBadNumber
         phx
         pha
         jsr     skipCommaOrSpace
         jsr     parse16bitDecXA ;get second param
         bcs     pl2RestoreP9BrkBadNumber
         ldy     #$02
         jsr     setMouseBoundsY ;save second param at offset Y=2
         pla                ;unstack first param
         plx
         dec     $090e      ;set some sort of flag?!
         ldy     #$00       ;save at offset 0
setMouseBoundsY:
         and     #$fc       ;clear bottom bits of X
         sta     VFS_N900_MouseBounds,Y
         txa
         iny
         sta     VFS_N900_MouseBounds,Y
         rts

pl2RestoreP9BrkBadNumber:
         pla
         pla
restoreP9BrkBadNumber:
         jsr     RestoreZpAndPage9
         jmp     brkBadNumber

VFSstarTSET:
         jsr     setYeq0
         jsr     parse16bitDecXA
         bcs     restoreP9BrkBadNumber
         phx
         pha
         jsr     skipCommaOrSpace
         jsr     parse16bitDecXA
         bcs     pl2RestoreP9BrkBadNumber
         cpx     #$04       ;check for Y>=1024
         bcc     @setY
         txa
         bpl     @setY1020
         lda     #$00
         tax
         beq     @setY
@setY1020:
         lda     #$fc
         ldx     #$03
@setY:   ldy     #$06
         jsr     setMouseBoundsY
         pla
         plx
         cpx     #$05       ;check for X>=1280
         bcc     @setX
         txa
         bpl     @setX1276
         lda     #$00       ;-ve X?! set to 0
         tax
         beq     @setX
@setX1276:
         lda     #$fc
         ldx     #$04
@setX:   ldy     #$04
         jmp     setMouseBoundsY

;*******************************************************************************
;* VFS_FSC3_STARCMD - parse a star command - passed from FSCV 3                *
;*                                                                             *
;*******************************************************************************
VFS_FSC3_STARCMD:
         stx     zp_vfsv_a8_textptr
         sty     zp_vfsv_a8_textptr+1
         ldy     #$00
         lda     (zp_vfsv_a8_textptr),Y
         and     #$df
         cmp     #'L'
         bne     @LB822
         iny
         lda     (zp_vfsv_a8_textptr),Y
         and     #$df
         cmp     #'V'
         bne     @LB849
         iny
@LB822:  ldx     #$00
         sty     $aa
@LB826:  lda     (zp_vfsv_a8_textptr),Y
         and     #$df
         cmp     @LB8A9,X
         beq     @LB84A
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #'.'
         beq     @LB84E
         lda     @LB8A9,X
         bmi     @LB851
         ldy     $aa
@LB83C:  inx
         lda     @LB8A9,X
         bpl     @LB83C
         inx
         inx
         lda     @LB8A9,X
         bpl     @LB826
@LB849:  rts

@LB84A:  inx
         iny
         bne     @LB826
@LB84E:  iny
         bne     @LB860
@LB851:  dex
         lda     (zp_vfsv_a8_textptr),Y
         cmp     #' '
         beq     @LB860
         cmp     #'"'
         beq     @LB860
         cmp     #$0d
         bne     @LB849
@LB860:  inx
         lda     @LB8A9,X
         bpl     @LB860
         cpx     #$22
         beq     @LB86D
         jsr     skipCommaOrSpace
@LB86D:  tya
         clc
         adc     zp_vfsv_a8_textptr
         sta     zp_vfsv_a8_textptr
         bcc     @LB877
         inc     zp_vfsv_a8_textptr
@LB877:  lda     @LB8A9,X
         sta     $ab
         lda     @LB8A9+1,X
         sta     $aa
         phx
         jsr     swap7PWSP_373_N933
         plx
         cpx     #$94
         beq     @LB89D
         lda     $093a
         beq     @LB892
         jsr     waitForSeek
@LB892:  jsr     FCMD_GetResult
         ldx     #$00
@LB897:  stz     WKSP_VFS_E00_TXTBUF,X
         dex
         bne     @LB897
@LB89D:  stz     VFS_N939_RETRY_CTR
         jsr     jmpIndAA
         jsr     swap7PWSP_373_N933
         pla
         pla
         rts

@LB8A9:  .byte   "AUDIO"
         .dbyt   starAUDIO
         .byte   "CHAPTER"
         .dbyt   starCHAPTER
         .byte   "EJECT"
         .dbyt   starEJECT
         .byte   "FAST"
         .dbyt   starFAST
         .byte   "FCODE"
         .dbyt   starFCODE
         .byte   "FRAME"
         .dbyt   starFRAME
         .byte   "PLAY"
         .dbyt   starPLAY
         .byte   "SEARCH"
         .dbyt   starSEARCH
         .byte   "SLOW"
         .dbyt   starSLOW
         .byte   "STEP"
         .dbyt   starSTEP
         .byte   "STILL"
         .dbyt   starSTILL
         .byte   "VOCOMPUTER"
         .dbyt   starVOCOMPUTER
         .byte   "VODISC"
         .dbyt   starVODISC
         .byte   "VOHIGHLIGHT"
         .dbyt   starVOHIGHLIGHT
         .byte   "VOSUPERIMPOSE"
         .dbyt   starVOSUPERIMPOSE
         .byte   "VOTRANSPARENT"
         .dbyt   starVOTRANSPARENT
         .byte   "VP"
         .dbyt   starVP
         .byte   "RESET"
         .dbyt   starRESET
         .byte   $ff
         .byte   %00010000
         .byte   %00010000
         .byte   %00010000
LB943:   .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
         .byte   %10000000
         .byte   %00000000
LB965:   .byte   %01111101
         .byte   %01111011
         .byte   %01111000
         .byte   %01110110
         .byte   %01110011
         .byte   %01110001
         .byte   %01101110
         .byte   %01101100
         .byte   %01101001
         .byte   %01100111
         .byte   %01100100
         .byte   %01100010
         .byte   %01011111
         .byte   %01011101
         .byte   %01011010
         .byte   %01011000
         .byte   %01010101
         .byte   %01010011
         .byte   %01010000
         .byte   %01001110
         .byte   %01001011
         .byte   %01001001
         .byte   %01000110
         .byte   %01000100
         .byte   %01000001
         .byte   %00111111
         .byte   %00111100
         .byte   %00111010
         .byte   %00110111
         .byte   %00110101
         .byte   %00110010
         .byte   %00110000
         .byte   %00101101
         .byte   %00101011
         .byte   %00000001
         .byte   %00000010
         .byte   %00000100
LB98A:   .byte   %10000000
         .byte   %10000000
         .byte   %10000000
LB98D:   .byte   %00000010
         .byte   %00000010
         .byte   %00000010
LB990:   .byte   %00000000
         .byte   %01000000
         .byte   %10000000
         .byte   %11000000
         .byte   %00000000
         .byte   %01000000
         .byte   %10000000
         .byte   %11000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
LB9A0:   .byte   %00010100
         .byte   %00011000
         .byte   %00000100
         .byte   %00101000
LB9A4:   .byte   %00011100
         .byte   %00010100
         .byte   %00000100
         .byte   %00000100
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00111111
         .byte   %00111111
         .byte   %00111111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11110000
         .byte   %11110000
         .byte   %11110000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000011
         .byte   %00000011
         .byte   %00001111
         .byte   %00001111
         .byte   %00001111
         .byte   %00000011
         .byte   %00000011
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00111111
         .byte   %11111111
         .byte   %11000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11000000
         .byte   %11111111
         .byte   %00111111
         .byte   %00000011
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11110000
         .byte   %11110000
         .byte   %00111100
         .byte   %00111100
         .byte   %00111100
         .byte   %11110000
         .byte   %11110000
         .byte   %11000000
         .byte   %11000000
         .byte   %11110000
         .byte   %11110000
         .byte   %00111100
         .byte   %00111100
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00110000
         .byte   %00111100
         .byte   %00111111
         .byte   %00111111
         .byte   %00111111
         .byte   %00111111
         .byte   %00111111
         .byte   %00110011
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11000000
         .byte   %11110000
         .byte   %11111100
         .byte   %11000000
         .byte   %11000000
         .byte   %11110000
         .byte   %11110000
         .byte   %00111100
         .byte   %00111100
         .byte   %00001111
         .byte   %00001111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000011
         .byte   %00001111
         .byte   %00111111
         .byte   %00000011
         .byte   %00000011
         .byte   %00001111
         .byte   %00001111
         .byte   %00111100
         .byte   %00111100
         .byte   %11110000
         .byte   %11110000
         .byte   %00000000
         .byte   %00000000
         .byte   %00001100
         .byte   %00111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11001100
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000111
         .byte   %00000111
         .byte   %00000111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00001110
         .byte   %00001110
         .byte   %00001110
         .byte   %00001110
         .byte   %00001110
         .byte   %00001111
         .byte   %00001111
         .byte   %00001111
         .byte   %00001110
         .byte   %00001110
         .byte   %00001110
         .byte   %00001110
         .byte   %00001110
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00001100
         .byte   %00001100
         .byte   %00001100
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000001
         .byte   %00000001
         .byte   %00000011
         .byte   %00000011
         .byte   %00000011
         .byte   %00000001
         .byte   %00000001
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000111
         .byte   %00001111
         .byte   %00001000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00001000
         .byte   %00001111
         .byte   %00000111
         .byte   %00000001
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00001100
         .byte   %00001100
         .byte   %00000110
         .byte   %00000110
         .byte   %00000110
         .byte   %00001100
         .byte   %00001100
         .byte   %00001000
         .byte   %00001000
         .byte   %00001100
         .byte   %00001100
         .byte   %00000110
         .byte   %00000110
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000100
         .byte   %00000110
         .byte   %00000111
         .byte   %00000111
         .byte   %00000111
         .byte   %00000111
         .byte   %00000111
         .byte   %00000101
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00001000
         .byte   %00001100
         .byte   %00001110
         .byte   %00001000
         .byte   %00001000
         .byte   %00001100
         .byte   %00001100
         .byte   %00000110
         .byte   %00000110
         .byte   %00000011
         .byte   %00000011
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000001
         .byte   %00000011
         .byte   %00000111
         .byte   %00000001
         .byte   %00000001
         .byte   %00000011
         .byte   %00000011
         .byte   %00000110
         .byte   %00000110
         .byte   %00001100
         .byte   %00001100
         .byte   %00000000
         .byte   %00000000
         .byte   %00000010
         .byte   %00000110
         .byte   %00001110
         .byte   %00001110
         .byte   %00001110
         .byte   %00001110
         .byte   %00001110
         .byte   %00001010
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000011
         .byte   %00000011
         .byte   %00000011
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000011
         .byte   %00000011
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000011
         .byte   %00000011
         .byte   %00000001
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000010
         .byte   %00000010
         .byte   %00000011
         .byte   %00000011
         .byte   %00000010
         .byte   %00000010
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000001
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000010
         .byte   %00000010
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000001
         .byte   %00000001
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000001
         .byte   %00000001
         .byte   %00000011
         .byte   %00000011
         .byte   %00000001
         .byte   %00000001
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000010
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111100
         .byte   %11111111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00000011
         .byte   %00000011
         .byte   %00000011
         .byte   %00000011
         .byte   %00000011
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111100
         .byte   %11110000
         .byte   %11110000
         .byte   %11000000
         .byte   %11000000
         .byte   %11000000
         .byte   %11110000
         .byte   %11110000
         .byte   %11111100
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00111111
         .byte   %00111111
         .byte   %00111111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11000000
         .byte   %11111100
         .byte   %11111100
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00001111
         .byte   %00000011
         .byte   %00000011
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000011
         .byte   %00000011
         .byte   %00001111
         .byte   %00001111
         .byte   %00000011
         .byte   %00000011
         .byte   %00000000
         .byte   %00000000
         .byte   %11000011
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00001111
         .byte   %00000011
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11111100
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00111111
         .byte   %00001111
         .byte   %00000011
         .byte   %00000000
         .byte   %00000011
         .byte   %00001111
         .byte   %00000011
         .byte   %00000011
         .byte   %00000000
         .byte   %00000000
         .byte   %11000000
         .byte   %11000000
         .byte   %11110000
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00111111
         .byte   %00111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111100
         .byte   %11111100
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111100
         .byte   %11110000
         .byte   %11000000
         .byte   %00000000
         .byte   %11000000
         .byte   %11110000
         .byte   %11000000
         .byte   %11000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000011
         .byte   %00000011
         .byte   %00001111
         .byte   %11110000
         .byte   %11000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11101110
         .byte   %11101110
         .byte   %11101110
         .byte   %11101110
         .byte   %11101110
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11101110
         .byte   %11101110
         .byte   %11101110
         .byte   %11101110
         .byte   %11101110
         .byte   %11111111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00010001
         .byte   %00010001
         .byte   %00010001
         .byte   %00010001
         .byte   %00010001
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11101110
         .byte   %11001100
         .byte   %11001100
         .byte   %10001000
         .byte   %10001000
         .byte   %10001000
         .byte   %11001100
         .byte   %11001100
         .byte   %11101110
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %10001000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %01110111
         .byte   %01110111
         .byte   %01110111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %10001000
         .byte   %11101110
         .byte   %11101110
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00110011
         .byte   %00010001
         .byte   %00010001
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00010001
         .byte   %00010001
         .byte   %00110011
         .byte   %00110011
         .byte   %00010001
         .byte   %00010001
         .byte   %00000000
         .byte   %00000000
         .byte   %10011001
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00110011
         .byte   %00010001
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11101110
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %01110111
         .byte   %00110011
         .byte   %00010001
         .byte   %00000000
         .byte   %00010001
         .byte   %00110011
         .byte   %00010001
         .byte   %00010001
         .byte   %00000000
         .byte   %00000000
         .byte   %10001000
         .byte   %10001000
         .byte   %11001100
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %01110111
         .byte   %01110111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11101110
         .byte   %11101110
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11101110
         .byte   %11001100
         .byte   %10001000
         .byte   %00000000
         .byte   %10001000
         .byte   %11001100
         .byte   %10001000
         .byte   %10001000
         .byte   %00000000
         .byte   %00000000
         .byte   %00010001
         .byte   %00010001
         .byte   %00110011
         .byte   %11001100
         .byte   %10001000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %01110111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %10101010
         .byte   %10101010
         .byte   %10101010
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11111111
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %10101010
         .byte   %10101010
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %10101010
         .byte   %10101010
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %10101010
         .byte   %10101010
         .byte   %10101010
         .byte   %10101010
         .byte   %11111111
         .byte   %11111111
         .byte   %01010101
         .byte   %01010101
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %01010101
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %01010101
         .byte   %01010101
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %10101010
         .byte   %10101010
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %01010101
         .byte   %01010101
         .byte   %11111111
         .byte   %11111111
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %01010101
         .byte   %00000000
         .byte   %00000000
         .byte   %01010101
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %10101010
         .byte   %10101010
         .byte   %11111111
         .byte   %11111111
         .byte   %10101010
         .byte   %10101010
         .byte   %10101010
         .byte   %10101010
         .byte   %00000000
         .byte   %00000000
         .byte   %10101010
         .byte   %11111111
         .byte   %10101010
         .byte   %10101010
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %01010101
         .byte   %01010101
         .byte   %11111111
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %00000000
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   %11111111
         .byte   "Many thanks to :-  Jonathan Griffiths, Tony Engeham, Chris Tur"
         .byte   "ner & Huge",$0d
