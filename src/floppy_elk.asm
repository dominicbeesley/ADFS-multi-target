		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.export CopyCodeToNMISpace
		.export FloppyElkBeforeNMI
		.export FloppyElkAfterNMI
		.export FloppyWaitNMIFinish
		.export FloppyWaitNMIFinish2elk

		.segment "floppy_2"



; TODO: Tidy up and replace hard coded addresses

elkLBA26:	sta     FDC_CMD                           ; BA26 8D C4 FC                 ...
		ldy     #$09                            ; BA29 A0 09                    ..
elkLBA2B: 	dey                                     ; BA2B 88                       .
		bne     elkLBA2B                           ; BA2C D0 FD                    ..
		txa                                     ; BA2E 8A                       .
		beq     elkLBA7A                           ; BA2F F0 49                    .I
		bit     $A1                             ; BA31 24 A1                    $.
		bmi     elkLBA52                           ; BA33 30 1D                    0.
		jmp     (NMI_ELK_RTN_PTR)                        ; BA35 6C 10 0D                 l..

; ----------------------------------------------------------------------------
sendXtoFDCandLOOP:
		lda     FDC_CMD                           ; BA38 AD C4 FC                 ...
		ror	A                               ; BA3B 6A                       j
		bcc     elkLBA4A                        ; BA3C 90 0C                    ..
		ror	A                               ; BA3E 6A                       j
		bcc     sendXtoFDCandLOOP                        ; BA3F 90 F7                    ..
		stx     FDC_DATA                           ; BA41 8E C7 FC                 ...
		iny                                     ; BA44 C8                       .
		beq     sendXtoFDCandLOOP                        ; BA45 F0 F1                    ..
		jmp     (NMI_ELK_RTN_PTR)                         ; BA47 6C 10 0D                 l..

; ----------------------------------------------------------------------------
elkLBA4A:	asl     a                               ; BA4A 0A                       .
		and     $0D15                           ; BA4B 2D 15 0D                 -..
		beq     elkLBA95                           ; BA4E F0 45                    .E
		bne     elkLBA88                           ; BA50 D0 36                    .6
elkLBA52:	lda     FDC_CMD                           ; BA52 AD C4 FC                 ...
		ror	A                               ; BA55 6A                       j
		bcc	elkLBA4A                           ; BA56 90 F2                    ..
		ror	A                               ; BA58 6A                       j
		bcc	elkLBA52                           ; BA59 90 F7                    ..
		lda	FDC_DATA                           ; BA5B AD C7 FC                 ...
		jmp	(NMI_ELK_RTN_PTR)                         ; BA5E 6C 10 0D                 l..

;=============================== NMI access routines =========================
	; routine to read a byte from the tube
nmi_rd_tube:	lda	TUBEIO       
		tax
		jmp	sendXtoFDCandLOOP

	; routine to write a byte to the tube
nmi_wr_tube:	sta	TUBEIO
		jmp	elkLBA52

	; routine to write a byte to memory
nmi_wr_ptr:	sta	(ZP_ELK_CE_NMIPTR),y
		iny
		jmp     elkLBA52
	; routine to read a byte from
nmi_rd_ptr:	lda     (ZP_ELK_CE_NMIPTR),y
		tax
		jmp     sendXtoFDCandLOOP

; ----------------------------------------------------------------------------
elkLBA7A:	lda     FDC_CMD                           ; BA7A AD C4 FC                 ...
		ror	A                               ; BA7D 6A                       j
		bcs     elkLBA7A                           ; BA7E B0 FA                    ..
		rol     a                               ; BA80 2A                       *
		and     $0D15                           ; BA81 2D 15 0D                 -..
		and     #$FB                            ; BA84 29 FB                    ).
		beq     elkLBA97                           ; BA86 F0 0F                    ..
elkLBA88: 	sta     $A0                             ; BA88 85 A0                    ..
		ror     $A1                             ; BA8A 66 A1                    f.
		sec                                     ; BA8C 38                       8
		rol     $A1                             ; BA8D 26 A1                    &.
elkLBA8F:	ror     $A2                             ; BA8F 66 A2                    f.
		sec                                     ; BA91 38                       8
		rol     $A2                             ; BA92 26 A2                    &.
		rts                                     ; BA94 60                       `

; ----------------------------------------------------------------------------
elkLBA95:	inc     $CF                             ; BA95 E6 CF                    ..
elkLBA97:	lda     $0D5D                           ; BA97 AD 5D 0D                 .].
		and     #$10                            ; BA9A 29 10                    ).
		beq     elkLBAAE                           ; BA9C F0 10                    ..
		bit     $FF                             ; BA9E 24 FF                    $.
		bpl     elkLBAAE                          ; BAA0 10 0C                    ..
		lda     #$00                            ; BAA2 A9 00                    ..
		sta     DRVSEL                           ; BAA4 8D C0 FC                 ...
		lda     #$6F                            ; BAA7 A9 6F                    .o
		sta     $A0                             ; BAA9 85 A0                    ..
		jmp     FloppyErrorA0or2E3                           ; BAAB 4C AE BF                 L..

; ----------------------------------------------------------------------------
elkLBAAE:	bit     $A2                             ; BAAE 24 A2                    $.
		bvc     elkLBA8F                           ; BAB0 50 DD                    P.
		jsr     LBE77                          ; BAB2 20 7F BE                  ..
		rts                                     ; BAB5 60                       `

; ----------------------------------------------------------------------------
FloppyWaitNMIFinish2elk:
		ldx     #$00                            ; BAB6 A2 00                    ..
		beq     elkLBABC                           ; BAB8 F0 02                    ..
FloppyWaitNMIFinish:
elkLBABA:  	ldx     #$FF                            ; BABA A2 FF                    ..
elkLBABC:  	jsr     elkLBA26                           ; BABC 20 26 BA                  &.
		lda     $A2                             ; BABF A5 A2                    ..
		ror	A                               ; BAC1 6A                       j
		lda     $A6                             ; BAC2 A5 A6                    ..
		bcc     elkLBABA                           ; BAC4 90 F4                    ..
		rts                                     ; BAC6 60                       `

; ----------------------------------------------------------------------------
.proc CopyCodeToNMISpace
		bit     $CD                             ; BAC7 24 CD                    $.
		bvc     @nottube                        ; BAC9 50 29                    P)
		lda     $A1                             ; BACB A5 A1                    ..
		and     #$FD                            ; BACD 29 FD                    ).
		sta     $A1                             ; BACF 85 A1                    ..
		rol     a                               ; BAD1 2A                       *
		lda     #$00                            ; BAD2 A9 00                    ..
		rol     a                               ; BAD4 2A                       *
		ldy	#>WKSP_ADFS_227_TUBE_XFER
		ldx	#<WKSP_ADFS_227_TUBE_XFER
		jsr     $0406                           ; BAD9 20 06 04                  ..
		lda     $A1                             ; BADC A5 A1                    ..
		and     #$10                            ; BADE 29 10                    ).
		beq     elkLBB1F                           ; BAE0 F0 3D                    .=
		bit     $A1                             ; BAE2 24 A1                    $.
		bmi     @tube_wr                           ; BAE4 30 07                    0.
		ldx     #<nmi_rd_tube                         ; BAE6 A2 61                    .a
		ldy     #>nmi_rd_tube                         ; BAE8 A0 BA                    ..
		jmp     elkLBB03                           ; BAEA 4C 03 BB                 L..

; ----------------------------------------------------------------------------
@tube_wr:	ldx     #<nmi_wr_tube                         ; BAED A2 68                    .h
		ldy     #>nmi_wr_tube                         ; BAEF A0 BA                    ..
		jmp     elkLBB03                           ; BAF1 4C 03 BB                 L..

; ----------------------------------------------------------------------------
@nottube:  	bit     $A1                             ; BAF4 24 A1                    $.
		bmi   	@memwr                           ; BAF6 30 07                    0.
		ldx     #<nmi_rd_ptr                            ; BAF8 A2 74                    .t
		ldy     #>nmi_rd_ptr                            ; BAFA A0 BA                    ..
		jmp     elkLBB03                           ; BAFC 4C 03 BB                 L..

; ----------------------------------------------------------------------------
@memwr:		ldx     #<nmi_wr_ptr                         ; BAFF A2 6E                    .n
		ldy     #>nmi_wr_ptr                         ; BB01 A0 BA                    ..
elkLBB03:	stx     NMI_ELK_RTN_PTR
		sty     NMI_ELK_RTN_PTR+1
		ldy     #$01                            ; BB09 A0 01                    ..
		lda     ($B0),y                         ; BB0B B1 B0                    ..
		sta     ZP_ELK_CE_NMIPTR
		iny     
		lda     ($B0),y
		sta     ZP_ELK_CE_NMIPTR+1
		ldx     #$1C                            ; BB14 A2 1C                    ..
		bit     $A1                             ; BB16 24 A1                    $.
		bmi     elkLBB1C                           ; BB18 30 02                    0.
		ldx     #$5C                            ; BB1A A2 5C                    .\
elkLBB1C:	stx     $0D15                           ; BB1C 8E 15 0D                 ...
elkLBB1F:	rts                                     ; BB1F 60                       `

.endproc

; ----------------------------------------------------------------------------
FloppyElkBeforeNMI:	
		php                                     
		pla                                     
		sta     NMI_ELK_SAVE_CPUFLAGS           ; save interrupt status
		sei                                     ; disable interrupts
		lda     ZP_ELK_CE_NMIPTR                              
		sta     NMI_ELK_SAVE_CE			; save $CE
		lda     ZP_ELK_CE_NMIPTR+1                              
		sta     NMI_ELK_SAVE_CF			; save $CF
		ldx     #$01                            
		lda     #OSBYTE_73_BLANK_PAL
		jsr     OSBYTE				; Blank the screen
		ldx     #$00                            
		ldy     #$FF                            
		lda     #OSBYTE_F2_ELK_ULA_CTL_COPY
		jsr     OSBYTE				; Read saved copy of ULA control FE07 into X
		txa                                     
		sta     NMI_ELK_MODE_SAVE		; save the old control value
		and     #$F9				; shut off SOUND/Cassette
		tax                                     
		and     #$20				; test for 2MHz screen modes
		bne     elkLBB4F			; mode >= 4 skip
		txa					; TODO: remove all the txa/tax and use BIT above?
		ora     #$30				; force mode 6/7
		tax                                     
elkLBB4F: 	stx     ULA_CTL				; set mode / SOUND
		rts                                     

; ----------------------------------------------------------------------------
FloppyElkAfterNMI:  	
		lda     NMI_ELK_MODE_SAVE
		sta     ULA_CTL				; restore ULA screen mode
		ldx     #$00
		lda     #$73
		jsr     OSBYTE				; un-blank palette
		lda     NMI_ELK_SAVE_CE
		sta     ZP_ELK_CE_NMIPTR	
		lda     NMI_ELK_SAVE_CF
		sta     ZP_ELK_CE_NMIPTR+1			; restore CE/F (used for pointer)
		lda     NMI_ELK_SAVE_CPUFLAGS
		pha
		plp					; restore interrupts
		rts

