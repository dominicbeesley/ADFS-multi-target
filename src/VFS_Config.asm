
		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"


		.export VFS_Serv29
		.export VFS_Serv28
		.export VFS_Serv1
		.export myCmosRead

		.segment "vfs_config"

;TODO: put in os.inc if same as ADFS?
CFGBITS_01_EJECT= $01
CFGBITS_40_DIR	= $40                            

VFS_Serv28:
		phx                                     ; 8FE3 DA                       .
        	sty     $A8                             ; 8FE4 84 A8                    ..
        	phy                                     ; 8FE6 5A                       Z
        	lda     ($F2),y                         ; 8FE7 B1 F2                    ..
        	cmp     #$0D                            ; 8FE9 C9 0D                    ..
        	bne     VFS_L8FFE                           ; 8FEB D0 11                    ..
        	ldy     #$00                            ; 8FED A0 00                    ..
VFS_L8FEF:  	lda     VFS_cfgStrings,y                         ; 8FEF B9 8F 90                 ...
        	jsr     masPrintChNoSpool                           ; 8FF2 20 28 97                  (.
        	iny                                     ; 8FF5 C8                       .
        	cpy     #$1E                            ; 8FF6 C0 1E                    ..
        	bne     VFS_L8FEF                           ; 8FF8 D0 F5                    ..
        	lda     #$28                            ; 8FFA A9 28                    .(
        	bne     VFS_L900D                           ; 8FFC D0 0F                    ..
VFS_L8FFE:  	jsr     VFS_L9038                           ; 8FFE 20 38 90                  8.
        	bne     VFS_L9010                           ; 9001 D0 0D                    ..
        	jsr     myCmosRead                           ; 9003 20 76 90                  v.
        	and     #$BF                            ; 9006 29 BF                    ).
VFS_L9008:  	jsr     myCmosWrite                           ; 9008 20 83 90                  ..
VFS_L900B:  	lda     #$00                            ; 900B A9 00                    ..
VFS_L900D:  	ply                                     ; 900D 7A                       z
        	plx                                     ; 900E FA                       .
        	rts                                     ; 900F 60                       `

; ----------------------------------------------------------------------------
VFS_L9010:  	jsr     VFS_L906A                           ; 9010 20 6A 90                  j.
        	bne     VFS_L901C                           ; 9013 D0 07                    ..
        	jsr     myCmosRead                           ; 9015 20 76 90                  v.
        	ora     #$40                            ; 9018 09 40                    .@
        	bra     VFS_L9008                           ; 901A 80 EC                    ..
VFS_L901C:  	jsr     VFS_L906E                           ; 901C 20 6E 90                  n.
        	bne     VFS_L9028                           ; 901F D0 07                    ..
        	jsr     myCmosRead                           ; 9021 20 76 90                  v.
        	and     #$FE                            ; 9024 29 FE                    ).
        	bra     VFS_L9008                           ; 9026 80 E0                    ..
VFS_L9028:  	jsr     VFS_L9072                           ; 9028 20 72 90                  r.
        	bne     VFS_L9034                           ; 902B D0 07                    ..
        	jsr     myCmosRead                           ; 902D 20 76 90                  v.
        	ora     #$01                            ; 9030 09 01                    ..
        	bra     VFS_L9008                           ; 9032 80 D4                    ..
VFS_L9034:  	lda     #$28                            ; 9034 A9 28                    .(
        	bra     VFS_L900D                           ; 9036 80 D5                    ..
VFS_L9038:  	ldx     #$00                            ; 9038 A2 00                    ..
VFS_L903A:  	ldy     $A8                             ; 903A A4 A8                    ..
VFS_L903C:  	lda     VFS_cfgStrings,x                         ; 903C BD 8F 90                 ...
        	cmp     #$0D                            ; 903F C9 0D                    ..
        	beq     VFS_L9049                           ; 9041 F0 06                    ..
        	lda     ($F2),y                         ; 9043 B1 F2                    ..
        	cmp     #$2E                            ; 9045 C9 2E                    ..
        	beq     VFS_L9069                           ; 9047 F0 20                    . 
VFS_L9049:  	lda     ($F2),y                         ; 9049 B1 F2                    ..
        	and     #$DF                            ; 904B 29 DF                    ).
        	sta     $AF                             ; 904D 85 AF                    ..
        	lda     VFS_cfgStrings,x                         ; 904F BD 8F 90                 ...
        	and     #$DF                            ; 9052 29 DF                    ).
        	cmp     $AF                             ; 9054 C5 AF                    ..
        	bne     VFS_L9069                           ; 9056 D0 11                    ..
        	iny                                     ; 9058 C8                       .
        	inx                                     ; 9059 E8                       .
        	lda     VFS_cfgStrings,x                         ; 905A BD 8F 90                 ...
        	cmp     #$0D                            ; 905D C9 0D                    ..
        	bne     VFS_L903C                           ; 905F D0 DB                    ..
        	lda     ($F2),y                         ; 9061 B1 F2                    ..
        	cmp     #$20                            ; 9063 C9 20                    . 
        	beq     VFS_L9069                           ; 9065 F0 02                    ..
        	cmp     #$0D                            ; 9067 C9 0D                    ..
VFS_L9069:  	rts                                     ; 9069 60                       `

; ----------------------------------------------------------------------------
VFS_L906A:  	ldx     #VFS_cfgStrOff_VFSNoDir
        	bra     VFS_L903A              
VFS_L906E:  	ldx     #VFS_cfgStrOff_VFSEject                   
        	bra     VFS_L903A              
VFS_L9072:  	ldx     #VFS_cfgStrOff_VFSNoEject                   
        	bra     VFS_L903A              
myCmosRead:  	lda     ZP_MOS_CURROM                             ; 9076 A5 F4                    ..
        	clc                                     ; 9078 18                       .
        	adc     #CMOS_PER_ROM_BASE                            ; 9079 69 14                    i.
        	tax                                     ; 907B AA                       .
        	lda     #OSBYTE_A1_READ_CMOS
        	jsr     OSBYTE                           ; 907E 20 F4 FF                  ..
        	tya                                     ; 9081 98                       .
        	rts                                     ; 9082 60                       `

; ----------------------------------------------------------------------------
myCmosWrite: 	tay                                     ; 9083 A8                       .
        	lda    	ZP_MOS_CURROM                             ; 9084 A5 F4                    ..
        	clc                                     ; 9086 18                       .
        	adc     #CMOS_PER_ROM_BASE              ; 9087 69 14                    i.
        	tax                                     ; 9089 AA                       .
        	lda     #OSBYTE_A2_WRITE_CMOS           ; 908A A9 A2                    ..
        	jmp     OSBYTE                          ; 908C 4C F4 FF                 L..

; ----------------------------------------------------------------------------
VFS_cfgStrings: 
VFS_cfgStrOff_VFSDir = *-VFS_cfgStrings
		.byte	"VFSDir", $D
VFS_cfgStrOff_VFSNoDir = *-VFS_cfgStrings		
		.byte   "VFSNoDir", $D
VFS_cfgStrOff_VFSNoEject = *-VFS_cfgStrings		
		.byte   "NoEject", $D
VFS_cfgStrOff_VFSEject = *-VFS_cfgStrings		
		.byte   "Eject", $D
VFS_Serv29:
        	lda     ($F2),y                         ; 90AD B1 F2                    ..
        	cmp     #$0D                            ; 90AF C9 0D                    ..
        	bne     VFS_L90B8                           ; 90B1 D0 05                    ..
        	jsr     cfgPrintDirNoDir                           ; 90B3 20 DB 90                  ..
        	bra     VFS_L90F8                           ; 90B6 80 40                    .@
VFS_L90B8:	phx                                     ; 90B8 DA                       .
        	sty     $A8                             ; 90B9 84 A8                    ..
        	phy                                     ; 90BB 5A                       Z
        	jsr     VFS_L9038                           ; 90BC 20 38 90                  8.
        	beq     VFS_L90D5                           ; 90BF F0 14                    ..
        	jsr     VFS_L906A                           ; 90C1 20 6A 90                  j.
        	beq     VFS_L90D5                           ; 90C4 F0 0F                    ..
        	jsr     VFS_L906E                           ; 90C6 20 6E 90                  n.
        	beq     VFS_L90D0                           ; 90C9 F0 05                    ..
        	jsr     VFS_L9072                           ; 90CB 20 72 90                  r.
        	bne     Serv29_exit                           ; 90CE D0 23                    .#
VFS_L90D0:	jsr     VFS_L90F8                           ; 90D0 20 F8 90                  ..
		bra     VFS_L90D8                           ; 90D3 80 03                    ..
VFS_L90D5:	jsr     cfgPrintDirNoDir                           ; 90D5 20 DB 90                  ..
VFS_L90D8:	jmp     VFS_L900B                           ; 90D8 4C 0B 90                 L..

; ----------------------------------------------------------------------------
cfgPrintDirNoDir:	
		phx                                     
		phy                                     
		jsr     myCmosRead                      
		ldx     #VFS_cfgStrOff_VFSDir           
		and     #CFGBITS_40_DIR
		beq     PrCfgStringX
		ldx     #VFS_cfgStrOff_VFSNoDir

		; print $D terminated string at VFS_cfgStrings,X
PrCfgStringX:	lda     VFS_cfgStrings,x                
		jsr     masPrintChNoSpool                           
		inx                                     
		cmp     #$0D                            
		bne     PrCfgStringX                    
Serv29_exit:	ply                                     
		plx                                     
		lda     #$29                            ; reload ervice call #
		rts                                     

; ----------------------------------------------------------------------------
VFS_L90F8:	phx
		phy
		jsr     myCmosRead
		ldx     #VFS_cfgStrOff_VFSEject
		and     #CFGBITS_01_EJECT
		beq     PrCfgStringX
		ldx     #VFS_cfgStrOff_VFSNoEject
		bra     PrCfgStringX
VFS_Serv1:
        	rts

; ----------------------------------------------------------------------------

	