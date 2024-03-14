

; TODO: Tidy up and replace hard coded addresses

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
