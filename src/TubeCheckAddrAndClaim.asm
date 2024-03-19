                .include "config.inc"

                .segment "tube_claim"

; Check transfer address for Tube or I/O transfer
; -----------------------------------------------
              iny                                       ; Y=1
              lda    ($B0),Y                            ; Get Addr0
              sta    $B2
              iny
              lda    ($B0),Y                            ; Get Addr1
              sta    $B3                                ; &B2/3=address b0-b15
              iny
              lda    ($B0),Y                            ; Get Addr2
              cmp    #$FE
              bcc    sk1                                ; Addr<&FFFE0000, language space
              iny
              lda    ($B0),Y                            ; Get Addr3
.ifdef USE65C12
              inc    A
.else
              cmp    #$FF
.endif
              beq    sk2                                ; Address &FFxxxxxx, use I/O memory
sk1:          jsr    TUBE_CLAIM_IF_PRESENT              ; Claim Tube
sk2:

