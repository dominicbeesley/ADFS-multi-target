    cpu 1

; Constants
osbyte_acknowledge_escape             = 126
osbyte_increment_polling_semaphore    = 22
osbyte_insert_input_buffer            = 153
osbyte_issue_service_request          = 143
osbyte_read_char_at_cursor            = 135
osbyte_read_cmos_ram                  = 161
osbyte_read_rom_ptr_table_low         = 168
osbyte_read_text_cursor_pos           = 134
osbyte_read_write_spool_file_handle   = 199
osbyte_read_write_tab_char            = 219
osbyte_scan_keyboard_from_16          = 122
osbyte_write_cmos_ram                 = 162

; Memory locations
l0000                   = &0000
l0001                   = &0001
l0002                   = &0002
l0003                   = &0003
l0084                   = &0084
l0085                   = &0085
l0086                   = &0086
l0087                   = &0087
l0088                   = &0088
l0089                   = &0089
l008a                   = &008a
l008c                   = &008c
l008d                   = &008d
l008e                   = &008e
l008f                   = &008f
l00a8                   = &00a8
l00a9                   = &00a9
l00aa                   = &00aa
l00ab                   = &00ab
l00ac                   = &00ac
l00ad                   = &00ad
l00ae                   = &00ae
l00af                   = &00af
l00b0                   = &00b0
l00b1                   = &00b1
l00b2                   = &00b2
l00b3                   = &00b3
l00b4                   = &00b4
l00b5                   = &00b5
l00b6                   = &00b6
l00b7                   = &00b7
l00b8                   = &00b8
l00b9                   = &00b9
l00ba                   = &00ba
l00bb                   = &00bb
l00bc                   = &00bc
l00bd                   = &00bd
l00be                   = &00be
l00bf                   = &00bf
l00c0                   = &00c0
l00c1                   = &00c1
l00c2                   = &00c2
l00c3                   = &00c3
l00c4                   = &00c4
l00c5                   = &00c5
l00c6                   = &00c6
l00c7                   = &00c7
l00c8                   = &00c8
l00c9                   = &00c9
l00ca                   = &00ca
l00cb                   = &00cb
scsi_status_zp          = &00cc
tube_used_zp            = &00cd
l00cf                   = &00cf
l00ef                   = &00ef
l00f0                   = &00f0
l00f1                   = &00f1
os_text_ptr             = &00f2
os_text_ptr1            = &00f3
romsel_copy             = &00f4
l00fc                   = &00fc
l00ff                   = &00ff
l0100                   = &0100
l0101                   = &0101
l0102                   = &0102
l0103                   = &0103
l0104                   = &0104
userv                   = &0200
irq1v                   = &0204
bytev                   = &020a
filev                   = &0212
fscv                    = &021e
os_interlace_flag       = &0291
l0406                   = &0406
l0900                   = &0900
l0901                   = &0901
l0902                   = &0902
l0903                   = &0903
l0904                   = &0904
l0905                   = &0905
l0906                   = &0906
l0907                   = &0907
l0908                   = &0908
l0909                   = &0909
l090a                   = &090a
l090b                   = &090b
l090c                   = &090c
l090d                   = &090d
l090e                   = &090e
l090f                   = &090f
l0910                   = &0910
l0911                   = &0911
l0912                   = &0912
l0913                   = &0913
l0914                   = &0914
l0915                   = &0915
l0916                   = &0916
l0917                   = &0917
l091b                   = &091b
l091c                   = &091c
l091d                   = &091d
l091e                   = &091e
l091f                   = &091f
l0923                   = &0923
l0924                   = &0924
l0925                   = &0925
l0926                   = &0926
l0932                   = &0932
l0933                   = &0933
l0937                   = &0937
l0938                   = &0938
l0939                   = &0939
l093a                   = &093a
l093b                   = &093b
l093c                   = &093c
l093d                   = &093d
l093e                   = &093e
vfs_flags1              = &0d92
vfs_25Hz_timer_lo       = &0d93
vfs_25Hz_timer_hi       = &0d94
vfs_100Hz_timer         = &0d95
vfs_flags2              = &0d96
vfs_old_bytev1          = &0d97
vfs_old_bytev2          = &0d98
vfs_irq1                = &0d99
vfs_irq2                = &0d9a
vfs_old_irq1v1          = &0d9b
vfs_old_irq1v2          = &0d9c
vfs_old_irq1v1a         = &0d9d
vfs_old_irq1v2a         = &0d9e
rom_private_byte        = &0df0
lc0fb                   = &c0fb
lc0fd                   = &c0fd
lc0ff                   = &c0ff
lc100                   = &c100
tube_data_transfer      = &c144
lc1fb                   = &c1fb
lc1fc                   = &c1fc
lc1fd                   = &c1fd
lc1fe                   = &c1fe
lc1ff                   = &c1ff
lc201                   = &c201
lc202                   = &c202
lc203                   = &c203
lc204                   = &c204
lc208                   = &c208
lc20c                   = &c20c
lc210                   = &c210
lc214                   = &c214
lc215                   = &c215
lc216                   = &c216
lc217                   = &c217
lc218                   = &c218
lc219                   = &c219
lc21a                   = &c21a
lc21b                   = &c21b
lc21c                   = &c21c
lc21d                   = &c21d
lc21e                   = &c21e
lc21f                   = &c21f
lc220                   = &c220
lc221                   = &c221
lc222                   = &c222
lc223                   = &c223
lc226                   = &c226
lc227                   = &c227
lc228                   = &c228
lc229                   = &c229
lc22a                   = &c22a
lc22b                   = &c22b
lc22c                   = &c22c
lc22d                   = &c22d
lc22e                   = &c22e
lc22f                   = &c22f
lc230                   = &c230
lc233                   = &c233
lc23b                   = &c23b
lc23f                   = &c23f
lc240                   = &c240
lc241                   = &c241
lc242                   = &c242
lc243                   = &c243
lc25d                   = &c25d
lc25e                   = &c25e
lc25f                   = &c25f
lc262                   = &c262
lc263                   = &c263
lc26f                   = &c26f
lc295                   = &c295
lc296                   = &c296
lc297                   = &c297
lc298                   = &c298
lc29a                   = &c29a
lc29b                   = &c29b
lc29c                   = &c29c
lc29d                   = &c29d
lc2a0                   = &c2a0
lc2a1                   = &c2a1
lc2a2                   = &c2a2
lc2a3                   = &c2a3
lc2a8                   = &c2a8
lc2aa                   = &c2aa
lc2ab                   = &c2ab
lc2b4                   = &c2b4
lc2b5                   = &c2b5
lc2b6                   = &c2b6
lc2b7                   = &c2b7
lc2b8                   = &c2b8
lc2b9                   = &c2b9
lc2ba                   = &c2ba
lc2bb                   = &c2bb
lc2c0                   = &c2c0
lc2c1                   = &c2c1
lc2c2                   = &c2c2
lc2cd                   = &c2cd
lc2ce                   = &c2ce
lc2cf                   = &c2cf
lc2d0                   = &c2d0
lc2d1                   = &c2d1
lc2d2                   = &c2d2
lc2d3                   = &c2d3
lc2d5                   = &c2d5
lc2d6                   = &c2d6
screen_memory_flag      = &c2d7
CMOS_byte_copy          = &c2d8
lc2d9                   = &c2d9
lc2fe                   = &c2fe
lc300                   = &c300
lc30a                   = &c30a
lc313                   = &c313
lc314                   = &c314
lc315                   = &c315
lc316                   = &c316
lc317                   = &c317
lc318                   = &c318
lc319                   = &c319
lc31a                   = &c31a
lc31b                   = &c31b
lc31c                   = &c31c
lc31e                   = &c31e
lc31f                   = &c31f
lc320                   = &c320
lc321                   = &c321
lc322                   = &c322
lc331                   = &c331
lc332                   = &c332
lc333                   = &c333
lc334                   = &c334
lc33e                   = &c33e
lc348                   = &c348
lc352                   = &c352
lc35c                   = &c35c
lc366                   = &c366
lc370                   = &c370
lc37a                   = &c37a
lc383                   = &c383
lc384                   = &c384
lc38e                   = &c38e
lc398                   = &c398
lc3a2                   = &c3a2
lc3ac                   = &c3ac
lc3b6                   = &c3b6
lc3c0                   = &c3c0
lc3ca                   = &c3ca
lc3d4                   = &c3d4
lc3de                   = &c3de
lc3e8                   = &c3e8
lc3f2                   = &c3f2
lc400                   = &c400
lc8cc                   = &c8cc
lc8d9                   = &c8d9
lc8fa                   = &c8fa
lce00                   = &ce00
lce01                   = &ce01
lce02                   = &ce02
lce03                   = &ce03
lce04                   = &ce04
lce10                   = &ce10
lce11                   = &ce11
acccon                  = &fe34
user_via_orb_irb        = &fe60
user_via_ddrb           = &fe62
user_via_acr            = &fe6b
user_via_pcr            = &fe6c
user_via_ifr            = &fe6d
user_via_ier            = &fe6e
scsi_data               = &fe80
scsi_status_byte        = &fe81
scsi_nSEL               = &fe82
scsi_enable_disable_IRQ = &fe83
tube_host_r3_data       = &fee5
lff4e                   = &ff4e
lffb7                   = &ffb7
lffb8                   = &ffb8
gsinit                  = &ffc2
gsread                  = &ffc5
osargs                  = &ffda
osasci                  = &ffe3
osbyte                  = &fff4
oscli                   = &fff7

    org &8000

; Sideways ROM header
.rom_header
.language_entry
.pydis_start
    equb 0, 0, 0                                                      ; 8000: 00 00 00    ...

.service_entry
    jmp service_handler                                               ; 8003: 4c ac 8f    L..

.rom_type
    equb &82                                                          ; 8006: 82          .
.copyright_offset
    equb copyright - rom_header                                       ; 8007: 16          .
.binary_version
    equb 1                                                            ; 8008: 01          .
.title
    equs "Acorn VFS"                                                  ; 8009: 41 63 6f... Aco
.version
    equb 0                                                            ; 8012: 00          .
    equs "170"                                                        ; 8013: 31 37 30    170
.copyright
    equb 0                                                            ; 8016: 00          .
    equs "(C)1986 Acorn", 0                                           ; 8017: 28 43 29... (C)

; &8025 referenced 2 times by &80d3, &8976
.claim_tube
    ldy #4                                                            ; 8025: a0 04       ..
    bit tube_used_zp                                                  ; 8027: 24 cd       $.
    bpl c803e                                                         ; 8029: 10 13       ..
; &802b referenced 1 time by &8031
.loop_c802b
    lda (l00b0),y                                                     ; 802b: b1 b0       ..
    sta lc226,y                                                       ; 802d: 99 26 c2    .&.
    dey                                                               ; 8030: 88          .
    bne loop_c802b                                                    ; 8031: d0 f8       ..
    lda #&40 ; '@'                                                    ; 8033: a9 40       .@
    tsb tube_used_zp                                                  ; 8035: 04 cd       ..
; &8037 referenced 4 times by &803c, &9a58, &a52b, &a697
.c8037
    lda #&c7                                                          ; 8037: a9 c7       ..
    jsr l0406                                                         ; 8039: 20 06 04     ..
    bcc c8037                                                         ; 803c: 90 f9       ..
; &803e referenced 1 time by &8029
.c803e
    rts                                                               ; 803e: 60          `

; &803f referenced 4 times by &8158, &83de, &a5c9, &a6ee
.release_tube
    bit tube_used_zp                                                  ; 803f: 24 cd       $.
    bvc c804c                                                         ; 8041: 50 09       P.
    lda #&87                                                          ; 8043: a9 87       ..
    jsr l0406                                                         ; 8045: 20 06 04     ..
    lda #&40 ; '@'                                                    ; 8048: a9 40       .@
    trb tube_used_zp                                                  ; 804a: 14 cd       ..
; &804c referenced 1 time by &8041
.c804c
    lda screen_memory_flag                                            ; 804c: ad d7 c2    ...
    beq c8054                                                         ; 804f: f0 03       ..
    sta acccon                                                        ; 8051: 8d 34 fe    .4.
; &8054 referenced 1 time by &804f
.c8054
    stz screen_memory_flag                                            ; 8054: 9c d7 c2    ...
    rts                                                               ; 8057: 60          `

; &8058 referenced 4 times by &80b6, &8946, &a519, &a683
.shadow_to_main
    phy                                                               ; 8058: 5a          Z
    ldy acccon                                                        ; 8059: ac 34 fe    .4.
    sty screen_memory_flag                                            ; 805c: 8c d7 c2    ...
    inx                                                               ; 805f: e8          .
    bne c8072                                                         ; 8060: d0 10       ..
    cmp #&fe                                                          ; 8062: c9 fe       ..
    bne c8072                                                         ; 8064: d0 0c       ..
    tya                                                               ; 8066: 98          .
    ror a                                                             ; 8067: 6a          j
    lda #4                                                            ; 8068: a9 04       ..
    trb acccon                                                        ; 806a: 1c 34 fe    .4.
    bcc c8072                                                         ; 806d: 90 03       ..
    tsb acccon                                                        ; 806f: 0c 34 fe    .4.
; &8072 referenced 3 times by &8060, &8064, &806d
.c8072
    ply                                                               ; 8072: 7a          z
    rts                                                               ; 8073: 60          `

; &8074 referenced 5 times by &808c, &809c, &8165, &82ec, &9d05
.read_drive_status
    php                                                               ; 8074: 08          .
; &8075 referenced 1 time by &807f
.loop_c8075
    lda scsi_status_byte                                              ; 8075: ad 81 fe    ...
    sta scsi_status_zp                                                ; 8078: 85 cc       ..
    lda scsi_status_byte                                              ; 807a: ad 81 fe    ...
    cmp scsi_status_zp                                                ; 807d: c5 cc       ..
    bne loop_c8075                                                    ; 807f: d0 f4       ..
    eor #&10                                                          ; 8081: 49 10       I.
    and #&fb                                                          ; 8083: 29 fb       ).
    plp                                                               ; 8085: 28          (
    rts                                                               ; 8086: 60          `

; &8087 referenced 3 times by &80b9, &820c, &895c
.set_scsi_to_command_mode
    ldy #0                                                            ; 8087: a0 00       ..
; &8089 referenced 1 time by &9cd7
.sub_c8089
    lda #1                                                            ; 8089: a9 01       ..
    pha                                                               ; 808b: 48          H
; &808c referenced 1 time by &8091
.loop_c808c
    jsr read_drive_status                                             ; 808c: 20 74 80     t.
    and #2                                                            ; 808f: 29 02       ).
    bne loop_c808c                                                    ; 8091: d0 f9       ..
    pla                                                               ; 8093: 68          h
    eor #&ff                                                          ; 8094: 49 ff       I.
    sta scsi_data                                                     ; 8096: 8d 80 fe    ...
    sta scsi_nSEL                                                     ; 8099: 8d 82 fe    ...
; &809c referenced 1 time by &80a1
.loop_c809c
    jsr read_drive_status                                             ; 809c: 20 74 80     t.
    and #2                                                            ; 809f: 29 02       ).
    beq loop_c809c                                                    ; 80a1: f0 f9       ..
    rts                                                               ; 80a3: 60          `

; unused jmp 827c
    equb &4c, &7c, &82                                                ; 80a4: 4c 7c 82    L|.

;  Access a drive using SCSI protocol
; ==================================
;  Transfer up to &FF00 bytes at a time
;  XY=>control block:
;    XY+ 0  Flag on entry, Returned result on exit
;    XY+ 1  Addr0
;    XY+ 2  Addr1
;    XY+ 3  Addr2
;    XY+ 4  Addr3
;    XY+ 5  Command
;    XY+ 6  Drive+Sector b16-19
;    XY+ 7  Sector b8-b15
;    XY+ 8  Sector b0-b7
;    XY+ 9  Sector Count
;    XY+10  -
;    XY+11  Length0
;    XY+12  Length1
;    XY+13  Length2
;    XY+14  Length3
;    XY+15
; 
;  On exit: A=result. 0=OK, <>0=error, with VFS error block filled in
; 
; &80a7 referenced 7 times by &8261, &88af, &88fa, &94bf, &97cd, &9874, &abc0
.access_scsi_drive
    jsr ensure_drive                                                  ; 80a7: 20 e0 82     ..
    stx l00b0                                                         ; 80aa: 86 b0       ..
    sty l00b1                                                         ; 80ac: 84 b1       ..
    ldy #4                                                            ; 80ae: a0 04       ..
    lda (l00b0),y                                                     ; 80b0: b1 b0       ..
    tax                                                               ; 80b2: aa          .
    dey                                                               ; 80b3: 88          .
    lda (l00b0),y                                                     ; 80b4: b1 b0       ..
    jsr shadow_to_main                                                ; 80b6: 20 58 80     X.
    jsr set_scsi_to_command_mode                                      ; 80b9: 20 87 80     ..
    iny                                                               ; 80bc: c8          .
    lda (l00b0),y                                                     ; 80bd: b1 b0       ..
    sta l00b2                                                         ; 80bf: 85 b2       ..
    iny                                                               ; 80c1: c8          .
    lda (l00b0),y                                                     ; 80c2: b1 b0       ..
    sta l00b3                                                         ; 80c4: 85 b3       ..
    iny                                                               ; 80c6: c8          .
    lda (l00b0),y                                                     ; 80c7: b1 b0       ..
    cmp #&fe                                                          ; 80c9: c9 fe       ..
    bcc c80d3                                                         ; 80cb: 90 06       ..
    iny                                                               ; 80cd: c8          .
    lda (l00b0),y                                                     ; 80ce: b1 b0       ..
    inc a                                                             ; 80d0: 1a          .
    beq c80d6                                                         ; 80d1: f0 03       ..
; &80d3 referenced 1 time by &80cb
.c80d3
    jsr claim_tube                                                    ; 80d3: 20 25 80     %.
; &80d6 referenced 1 time by &80d1
.c80d6
    ldy #5                                                            ; 80d6: a0 05       ..
    lda (l00b0),y                                                     ; 80d8: b1 b0       ..
    jsr sub_c82f7                                                     ; 80da: 20 f7 82     ..
    iny                                                               ; 80dd: c8          .
    lda (l00b0),y                                                     ; 80de: b1 b0       ..
    ora lc317                                                         ; 80e0: 0d 17 c3    ...
    cmp #&ff                                                          ; 80e3: c9 ff       ..
    bne c80e8                                                         ; 80e5: d0 01       ..
    inc a                                                             ; 80e7: 1a          .
; &80e8 referenced 1 time by &80e5
.c80e8
    sta lc333                                                         ; 80e8: 8d 33 c3    .3.
    jmp c80f0                                                         ; 80eb: 4c f0 80    L..

; &80ee referenced 1 time by &80fb
.loop_c80ee
    lda (l00b0),y                                                     ; 80ee: b1 b0       ..
; &80f0 referenced 1 time by &80eb
.c80f0
    jsr sub_c82f7                                                     ; 80f0: 20 f7 82     ..
    jsr wait_for_scsi_REQ                                             ; 80f3: 20 ea 82     ..
    bpl c80fd                                                         ; 80f6: 10 05       ..
    bvs c80fd                                                         ; 80f8: 70 03       p.
    iny                                                               ; 80fa: c8          .
    bne loop_c80ee                                                    ; 80fb: d0 f1       ..
; &80fd referenced 2 times by &80f6, &80f8
.c80fd
    ldy #5                                                            ; 80fd: a0 05       ..
    lda (l00b0),y                                                     ; 80ff: b1 b0       ..
    and #&fd                                                          ; 8101: 29 fd       ).
    eor #8                                                            ; 8103: 49 08       I.
    bne c810a                                                         ; 8105: d0 03       ..
    jmp c8186                                                         ; 8107: 4c 86 81    L..

; &810a referenced 1 time by &8105
.c810a
    jsr wait_for_scsi_REQ                                             ; 810a: 20 ea 82     ..
    clc                                                               ; 810d: 18          .
    bvc c8111                                                         ; 810e: 50 01       P.
    sec                                                               ; 8110: 38          8
; &8111 referenced 1 time by &810e
.c8111
    ldy #0                                                            ; 8111: a0 00       ..
    bit tube_used_zp                                                  ; 8113: 24 cd       $.
    bvc c8123                                                         ; 8115: 50 0c       P.
    ldx #&27 ; '''                                                    ; 8117: a2 27       .'
    ldy #&c2                                                          ; 8119: a0 c2       ..
    lda #0                                                            ; 811b: a9 00       ..
    php                                                               ; 811d: 08          .
    rol a                                                             ; 811e: 2a          *
    jsr sub_c81c3                                                     ; 811f: 20 c3 81     ..
    plp                                                               ; 8122: 28          (
; &8123 referenced 5 times by &8115, &813d, &8141, &814e, &8156
.c8123
    jsr wait_for_scsi_REQ                                             ; 8123: 20 ea 82     ..
    bmi c8158                                                         ; 8126: 30 30       00
    bit tube_used_zp                                                  ; 8128: 24 cd       $.
    bvs c8144                                                         ; 812a: 70 18       p.
    bcs c8137                                                         ; 812c: b0 09       ..
    lda (l00b2),y                                                     ; 812e: b1 b2       ..
    eor #&ff                                                          ; 8130: 49 ff       I.
    sta scsi_data                                                     ; 8132: 8d 80 fe    ...
    bcc c813c                                                         ; 8135: 90 05       ..
; &8137 referenced 1 time by &812c
.c8137
    lda scsi_data                                                     ; 8137: ad 80 fe    ...
    sta (l00b2),y                                                     ; 813a: 91 b2       ..
; &813c referenced 1 time by &8135
.c813c
    iny                                                               ; 813c: c8          .
    bne c8123                                                         ; 813d: d0 e4       ..
    inc l00b3                                                         ; 813f: e6 b3       ..
    jmp c8123                                                         ; 8141: 4c 23 81    L#.

; &8144 referenced 1 time by &812a
.c8144
    bcs c8150                                                         ; 8144: b0 0a       ..
    lda tube_host_r3_data                                             ; 8146: ad e5 fe    ...
    eor #&ff                                                          ; 8149: 49 ff       I.
    sta scsi_data                                                     ; 814b: 8d 80 fe    ...
    bcc c8123                                                         ; 814e: 90 d3       ..
; &8150 referenced 1 time by &8144
.c8150
    lda scsi_data                                                     ; 8150: ad 80 fe    ...
    sta tube_host_r3_data                                             ; 8153: 8d e5 fe    ...
    bcs c8123                                                         ; 8156: b0 cb       ..
; &8158 referenced 6 times by &8126, &818f, &81d8, &8306, &89c1, &9e12
.c8158
    jsr release_tube                                                  ; 8158: 20 3f 80     ?.
; &815b referenced 1 time by &816a
.loop_c815b
    jsr wait_for_scsi_REQ                                             ; 815b: 20 ea 82     ..
    lda scsi_data                                                     ; 815e: ad 80 fe    ...
    jsr wait_for_scsi_REQ                                             ; 8161: 20 ea 82     ..
    tay                                                               ; 8164: a8          .
    jsr read_drive_status                                             ; 8165: 20 74 80     t.
    and #1                                                            ; 8168: 29 01       ).
    beq loop_c815b                                                    ; 816a: f0 ef       ..
    tya                                                               ; 816c: 98          .
    ldx scsi_data                                                     ; 816d: ae 80 fe    ...
    beq c8175                                                         ; 8170: f0 03       ..
    jmp c8258                                                         ; 8172: 4c 58 82    LX.

; &8175 referenced 1 time by &8170
.c8175
    tax                                                               ; 8175: aa          .
    and #2                                                            ; 8176: 29 02       ).
    beq c817d                                                         ; 8178: f0 03       ..
    jmp c820c                                                         ; 817a: 4c 0c 82    L..

; &817d referenced 1 time by &8178
.c817d
    lda #0                                                            ; 817d: a9 00       ..
; &817f referenced 2 times by &8255, &825a
.c817f
    ldx l00b0                                                         ; 817f: a6 b0       ..
    ldy l00b1                                                         ; 8181: a4 b1       ..
    and #&ff                                                          ; 8183: 29 ff       ).
    rts                                                               ; 8185: 60          `

; &8186 referenced 1 time by &8107
.c8186
    ldy #0                                                            ; 8186: a0 00       ..
    bit tube_used_zp                                                  ; 8188: 24 cd       $.
    bvs c81cf                                                         ; 818a: 70 43       pC
; &818c referenced 2 times by &819f, &81ae
.c818c
    jsr wait_for_scsi_REQ                                             ; 818c: 20 ea 82     ..
    bmi c8158                                                         ; 818f: 30 c7       0.
    bvs c81a1                                                         ; 8191: 70 0e       p.
; &8193 referenced 1 time by &819b
.loop_c8193
    lda (l00b2),y                                                     ; 8193: b1 b2       ..
    eor #&ff                                                          ; 8195: 49 ff       I.
    sta scsi_data                                                     ; 8197: 8d 80 fe    ...
    iny                                                               ; 819a: c8          .
    bne loop_c8193                                                    ; 819b: d0 f6       ..
    inc l00b3                                                         ; 819d: e6 b3       ..
    bra c818c                                                         ; 819f: 80 eb       ..
; &81a1 referenced 2 times by &8191, &81aa
.c81a1
    jsr wait_for_scsi_REQ                                             ; 81a1: 20 ea 82     ..
    lda scsi_data                                                     ; 81a4: ad 80 fe    ...
    sta (l00b2),y                                                     ; 81a7: 91 b2       ..
    iny                                                               ; 81a9: c8          .
    bne c81a1                                                         ; 81aa: d0 f5       ..
    inc l00b3                                                         ; 81ac: e6 b3       ..
    bra c818c                                                         ; 81ae: 80 dc       ..
; &81b0 referenced 2 times by &81ee, &8206
.sub_c81b0
    inc lc228                                                         ; 81b0: ee 28 c2    .(.
    bne c81bd                                                         ; 81b3: d0 08       ..
    inc lc229                                                         ; 81b5: ee 29 c2    .).
    bne c81bd                                                         ; 81b8: d0 03       ..
    inc lc22a                                                         ; 81ba: ee 2a c2    .*.
; &81bd referenced 2 times by &81b3, &81b8
.c81bd
    ldx #&27 ; '''                                                    ; 81bd: a2 27       .'
    ldy #&c2                                                          ; 81bf: a0 c2       ..
    rts                                                               ; 81c1: 60          `

; &81c2 referenced 2 times by &81e0, &81f7
.sub_c81c2
    sei                                                               ; 81c2: 78          x
; &81c3 referenced 1 time by &811f
.sub_c81c3
    jsr l0406                                                         ; 81c3: 20 06 04     ..
    ldy #0                                                            ; 81c6: a0 00       ..
    jsr sub_c81cb                                                     ; 81c8: 20 cb 81     ..
; &81cb referenced 3 times by &81c8, &89b3, &a6d5
.sub_c81cb
    jsr sub_c81ce                                                     ; 81cb: 20 ce 81     ..
; &81ce referenced 1 time by &81cb
.sub_c81ce
    rts                                                               ; 81ce: 60          `

; &81cf referenced 1 time by &818a
.c81cf
    ldx #&27 ; '''                                                    ; 81cf: a2 27       .'
    ldy #&c2                                                          ; 81d1: a0 c2       ..
; &81d3 referenced 2 times by &81f2, &820a
.c81d3
    jsr wait_for_scsi_REQ                                             ; 81d3: 20 ea 82     ..
    bpl c81db                                                         ; 81d6: 10 03       ..
    jmp c8158                                                         ; 81d8: 4c 58 81    LX.

; &81db referenced 1 time by &81d6
.c81db
    bvs c81f4                                                         ; 81db: 70 17       p.
    php                                                               ; 81dd: 08          .
    lda #6                                                            ; 81de: a9 06       ..
    jsr sub_c81c2                                                     ; 81e0: 20 c2 81     ..
; &81e3 referenced 1 time by &81ec
.loop_c81e3
    lda tube_host_r3_data                                             ; 81e3: ad e5 fe    ...
    eor #&ff                                                          ; 81e6: 49 ff       I.
    sta scsi_data                                                     ; 81e8: 8d 80 fe    ...
    iny                                                               ; 81eb: c8          .
    bne loop_c81e3                                                    ; 81ec: d0 f5       ..
    jsr sub_c81b0                                                     ; 81ee: 20 b0 81     ..
    plp                                                               ; 81f1: 28          (
    bra c81d3                                                         ; 81f2: 80 df       ..
; &81f4 referenced 1 time by &81db
.c81f4
    php                                                               ; 81f4: 08          .
    lda #7                                                            ; 81f5: a9 07       ..
    jsr sub_c81c2                                                     ; 81f7: 20 c2 81     ..
; &81fa referenced 1 time by &8204
.loop_c81fa
    jsr wait_for_scsi_REQ                                             ; 81fa: 20 ea 82     ..
    lda scsi_data                                                     ; 81fd: ad 80 fe    ...
    sta tube_host_r3_data                                             ; 8200: 8d e5 fe    ...
    iny                                                               ; 8203: c8          .
    bne loop_c81fa                                                    ; 8204: d0 f4       ..
    jsr sub_c81b0                                                     ; 8206: 20 b0 81     ..
    plp                                                               ; 8209: 28          (
    bra c81d3                                                         ; 820a: 80 c7       ..
; &820c referenced 1 time by &817a
.c820c
    jsr set_scsi_to_command_mode                                      ; 820c: 20 87 80     ..
    lda #3                                                            ; 820f: a9 03       ..
    tax                                                               ; 8211: aa          .
    tay                                                               ; 8212: a8          .
    jsr sub_c82f7                                                     ; 8213: 20 f7 82     ..
    lda lc333                                                         ; 8216: ad 33 c3    .3.
    and #&e0                                                          ; 8219: 29 e0       ).
    jsr sub_c82f7                                                     ; 821b: 20 f7 82     ..
; &821e referenced 1 time by &8222
.loop_c821e
    jsr sub_c82f7                                                     ; 821e: 20 f7 82     ..
    dey                                                               ; 8221: 88          .
    bpl loop_c821e                                                    ; 8222: 10 fa       ..
; &8224 referenced 1 time by &822e
.loop_c8224
    jsr wait_for_scsi_REQ                                             ; 8224: 20 ea 82     ..
    lda scsi_data                                                     ; 8227: ad 80 fe    ...
    sta lc2d0,x                                                       ; 822a: 9d d0 c2    ...
    dex                                                               ; 822d: ca          .
    bpl loop_c8224                                                    ; 822e: 10 f4       ..
    lda lc333                                                         ; 8230: ad 33 c3    .3.
    cmp #&ff                                                          ; 8233: c9 ff       ..
    beq c823f                                                         ; 8235: f0 08       ..
    and #&e0                                                          ; 8237: 29 e0       ).
    ora lc2d2                                                         ; 8239: 0d d2 c2    ...
    sta lc2d2                                                         ; 823c: 8d d2 c2    ...
; &823f referenced 1 time by &8235
.c823f
    jsr wait_for_scsi_REQ                                             ; 823f: 20 ea 82     ..
    ldx lc2d3                                                         ; 8242: ae d3 c2    ...
    lda scsi_data                                                     ; 8245: ad 80 fe    ...
    jsr wait_for_scsi_REQ                                             ; 8248: 20 ea 82     ..
    ldy scsi_data                                                     ; 824b: ac 80 fe    ...
    bne c8258                                                         ; 824e: d0 08       ..
    and #2                                                            ; 8250: 29 02       ).
    bne c8258                                                         ; 8252: d0 04       ..
    txa                                                               ; 8254: 8a          .
    jmp c817f                                                         ; 8255: 4c 7f 81    L..

; &8258 referenced 3 times by &8172, &824e, &8252
.c8258
    lda #&ff                                                          ; 8258: a9 ff       ..
    jmp c817f                                                         ; 825a: 4c 7f 81    L..

; &825d referenced 3 times by &8804, &8853, &8e7f
.c825d
    ldx #&15                                                          ; 825d: a2 15       ..
    ldy #&c2                                                          ; 825f: a0 c2       ..
; &8261 referenced 5 times by &8700, &871b, &8821, &a21c, &a280
.sub_c8261
    jsr access_scsi_drive                                             ; 8261: 20 a7 80     ..
    bne c8270                                                         ; 8264: d0 0a       ..
    rts                                                               ; 8266: 60          `

; &8267 referenced 2 times by &8272, &8276
.c8267
    lda lc22f                                                         ; 8267: ad 2f c2    ./.
    sta lc317                                                         ; 826a: 8d 17 c3    ...
    jmp c89e8                                                         ; 826d: 4c e8 89    L..

; &8270 referenced 7 times by &8264, &82d9, &887b, &9883, &9df8, &ab8f, &ab98
.c8270
    cmp #&25 ; '%'                                                    ; 8270: c9 25       .%
    beq c8267                                                         ; 8272: f0 f3       ..
    cmp #&65 ; 'e'                                                    ; 8274: c9 65       .e
    beq c8267                                                         ; 8276: f0 ef       ..
    cmp #&6f ; 'o'                                                    ; 8278: c9 6f       .o
    bne c828f                                                         ; 827a: d0 13       ..
    jsr sub_c8459                                                     ; 827c: 20 59 84     Y.
; &827f referenced 1 time by &ad12
.c827f
    lda #osbyte_acknowledge_escape                                    ; 827f: a9 7e       .~
    jsr osbyte                                                        ; 8281: 20 f4 ff     ..            ; Clear escape condition and perform escape effects
    jsr generate_error_inline                                         ; 8284: 20 26 83     &.
    equs &11, "Escape", 0                                             ; 8287: 11 45 73... .Es

; &828f referenced 1 time by &827a
.c828f
    cmp #2                                                            ; 828f: c9 02       ..
    bne c82aa                                                         ; 8291: d0 17       ..
    jsr sub_c8459                                                     ; 8293: 20 59 84     Y.
    jsr generate_error_inline                                         ; 8296: 20 26 83     &.
    equs &cd, "Drive not ready", 0                                    ; 8299: cd 44 72... .Dr

; &82aa referenced 1 time by &8291
.c82aa
    cmp #&40 ; '@'                                                    ; 82aa: c9 40       .@
    beq c82c3                                                         ; 82ac: f0 15       ..
    pha                                                               ; 82ae: 48          H
    jsr sub_c8459                                                     ; 82af: 20 59 84     Y.
    pla                                                               ; 82b2: 68          h
    tax                                                               ; 82b3: aa          .
    jsr sub_c832f                                                     ; 82b4: 20 2f 83     /.
    equb &c7                                                          ; 82b7: c7          .
    equs "Disc error"                                                 ; 82b8: 44 69 73... Dis
    equb 0                                                            ; 82c2: 00          .

; &82c3 referenced 5 times by &82ac, &8c0a, &9fa5, &a06a, &a2d2
.c82c3
    jsr generate_error_inline2                                        ; 82c3: 20 09 83     ..
    equs &c9, "Disc read only", 0                                     ; 82c6: c9 44 69... .Di

; &82d6 referenced 6 times by &9cdb, &9ce4, &9cea, &9cf0, &9cf5, &9cfa
.c82d6
    jsr sub_c82dc                                                     ; 82d6: 20 dc 82     ..
    bne c8270                                                         ; 82d9: d0 95       ..
    rts                                                               ; 82db: 60          `

; &82dc referenced 1 time by &82d6
.sub_c82dc
    jsr sub_c82f7                                                     ; 82dc: 20 f7 82     ..
    rts                                                               ; 82df: 60          `

; &82e0 referenced 6 times by &80a7, &82e7, &8930, &960f, &9cd4, &a17e
.ensure_drive
    lda #1                                                            ; 82e0: a9 01       ..
    php                                                               ; 82e2: 08          .
    cli                                                               ; 82e3: 58          X
    plp                                                               ; 82e4: 28          (
    bit tube_used_zp                                                  ; 82e5: 24 cd       $.
    bne ensure_drive                                                  ; 82e7: d0 f7       ..
    rts                                                               ; 82e9: 60          `

; &82ea referenced 17 times by &80f3, &810a, &8123, &815b, &8161, &818c, &81a1, &81d3, &81fa, &8224, &823f, &8248, &82f7, &89a0, &89a5, &9e00, &9e07
.wait_for_scsi_REQ
    cli                                                               ; 82ea: 58          X
; &82eb referenced 1 time by &9d1c
.sub_c82eb
    pha                                                               ; 82eb: 48          H
; &82ec referenced 1 time by &82f1
.loop_c82ec
    jsr read_drive_status                                             ; 82ec: 20 74 80     t.
    and #&20 ; ' '                                                    ; 82ef: 29 20       )
    beq loop_c82ec                                                    ; 82f1: f0 f9       ..
    pla                                                               ; 82f3: 68          h
    bit scsi_status_zp                                                ; 82f4: 24 cc       $.
    rts                                                               ; 82f6: 60          `

; &82f7 referenced 7 times by &80da, &80f0, &8213, &821b, &821e, &82dc, &8987
.sub_c82f7
    jsr wait_for_scsi_REQ                                             ; 82f7: 20 ea 82     ..
    bvs c8304                                                         ; 82fa: 70 08       p.
    eor #&ff                                                          ; 82fc: 49 ff       I.
    sta scsi_data                                                     ; 82fe: 8d 80 fe    ...
    lda #0                                                            ; 8301: a9 00       ..
    rts                                                               ; 8303: 60          `

; &8304 referenced 1 time by &82fa
.c8304
    pla                                                               ; 8304: 68          h
    pla                                                               ; 8305: 68          h
    jmp c8158                                                         ; 8306: 4c 58 81    LX.

; &8309 referenced 3 times by &82c3, &8b7a, &9b53
.generate_error_inline2
    ldx lc22f                                                         ; 8309: ae 2f c2    ./.
    inx                                                               ; 830c: e8          .
    bne generate_error_inline                                         ; 830d: d0 17       ..
    ldx lc22e                                                         ; 830f: ae 2e c2    ...
    inx                                                               ; 8312: e8          .
    bne c8320                                                         ; 8313: d0 0b       ..
    ldy #2                                                            ; 8315: a0 02       ..
; &8317 referenced 1 time by &831e
.loop_c8317
    lda lc314,y                                                       ; 8317: b9 14 c3    ...
    sta lc22c,y                                                       ; 831a: 99 2c c2    .,.
    dey                                                               ; 831d: 88          .
    bpl loop_c8317                                                    ; 831e: 10 f7       ..
; &8320 referenced 1 time by &8313
.c8320
    lda lc317                                                         ; 8320: ad 17 c3    ...
    sta lc22f                                                         ; 8323: 8d 2f c2    ./.
; &8326 referenced 21 times by &8284, &8296, &830d, &85ab, &89e8, &8a01, &8b4a, &9716, &99ad, &9a19, &9ca3, &9e35, &9ea7, &a07a, &a1f5, &abfa, &ac9b, &ad59, &ade0, &af51, &b2e0
.generate_error_inline
    jsr c880d                                                         ; 8326: 20 0d 88     ..
    lda #&10                                                          ; 8329: a9 10       ..
    trb tube_used_zp                                                  ; 832b: 14 cd       ..
; &832d referenced 3 times by &9b27, &9b97, &ab68
.generate_error_inline3
    ldx #0                                                            ; 832d: a2 00       ..
; &832f referenced 1 time by &82b4
.sub_c832f
    pla                                                               ; 832f: 68          h
    sta l00b2                                                         ; 8330: 85 b2       ..
    pla                                                               ; 8332: 68          h
    sta l00b3                                                         ; 8333: 85 b3       ..
    lda #&10                                                          ; 8335: a9 10       ..
    trb tube_used_zp                                                  ; 8337: 14 cd       ..
    ldy #0                                                            ; 8339: a0 00       ..
; &833b referenced 1 time by &8341
.loop_c833b
    iny                                                               ; 833b: c8          .
    lda (l00b2),y                                                     ; 833c: b1 b2       ..
    sta l0100,y                                                       ; 833e: 99 00 01    ...
    bne loop_c833b                                                    ; 8341: d0 f8       ..
    txa                                                               ; 8343: 8a          .
    beq c8399                                                         ; 8344: f0 53       .S
    lda #&20 ; ' '                                                    ; 8346: a9 20       .
    sta l0100,y                                                       ; 8348: 99 00 01    ...
    txa                                                               ; 834b: 8a          .
    and #&7f                                                          ; 834c: 29 7f       ).
    cmp #&50 ; 'P'                                                    ; 834e: c9 50       .P
    bcc c8356                                                         ; 8350: 90 04       ..
    cmp #&5a ; 'Z'                                                    ; 8352: c9 5a       .Z
    bcs c835e                                                         ; 8354: b0 08       ..
; &8356 referenced 1 time by &8350
.c8356
    jsr hex_byte_on_stack                                             ; 8356: 20 10 84     ..
    txa                                                               ; 8359: 8a          .
    bpl c8393                                                         ; 835a: 10 37       .7
    bmi c8361                                                         ; 835c: 30 03       0.
; &835e referenced 1 time by &8354
.c835e
    jsr sub_c842c                                                     ; 835e: 20 2c 84     ,.
; &8361 referenced 1 time by &835c
.c8361
    ldx #4                                                            ; 8361: a2 04       ..
; &8363 referenced 1 time by &836b
.loop_c8363
    iny                                                               ; 8363: c8          .
    lda at_string,x                                                   ; 8364: bd ff 83    ...
    sta l0100,y                                                       ; 8367: 99 00 01    ...
    dex                                                               ; 836a: ca          .
    bpl loop_c8363                                                    ; 836b: 10 f6       ..
    lda lc2d2                                                         ; 836d: ad d2 c2    ...
    asl a                                                             ; 8370: 0a          .
    rol a                                                             ; 8371: 2a          *
    rol a                                                             ; 8372: 2a          *
    rol a                                                             ; 8373: 2a          *
    jsr nibble_to_asciihexdigit                                       ; 8374: 20 21 84     !.
    iny                                                               ; 8377: c8          .
    sta l0100,y                                                       ; 8378: 99 00 01    ...
    lda #&2f ; '/'                                                    ; 837b: a9 2f       ./
    iny                                                               ; 837d: c8          .
    sta l0100,y                                                       ; 837e: 99 00 01    ...
    lda lc2d2                                                         ; 8381: ad d2 c2    ...
    and #&1f                                                          ; 8384: 29 1f       ).
    ldx #2                                                            ; 8386: a2 02       ..
    bne c838d                                                         ; 8388: d0 03       ..
; &838a referenced 1 time by &8391
.loop_c838a
    lda lc2d0,x                                                       ; 838a: bd d0 c2    ...
; &838d referenced 1 time by &8388
.c838d
    jsr hex_byte_on_stack                                             ; 838d: 20 10 84     ..
    dex                                                               ; 8390: ca          .
    bpl loop_c838a                                                    ; 8391: 10 f7       ..
; &8393 referenced 1 time by &835a
.c8393
    iny                                                               ; 8393: c8          .
    lda #0                                                            ; 8394: a9 00       ..
    sta l0100,y                                                       ; 8396: 99 00 01    ...
; &8399 referenced 1 time by &8344
.c8399
    lda lc2d5                                                         ; 8399: ad d5 c2    ...
    beq c83ce                                                         ; 839c: f0 30       .0
    ldx #&0b                                                          ; 839e: a2 0b       ..
    dey                                                               ; 83a0: 88          .
; &83a1 referenced 1 time by &83a9
.loop_c83a1
    lda nochannel_string,x                                            ; 83a1: bd 04 84    ...
    iny                                                               ; 83a4: c8          .
    sta l0100,y                                                       ; 83a5: 99 00 01    ...
    dex                                                               ; 83a8: ca          .
    bpl loop_c83a1                                                    ; 83a9: 10 f6       ..
    lda lc2d5                                                         ; 83ab: ad d5 c2    ...
    jsr sub_c842c                                                     ; 83ae: 20 2c 84     ,.
    phy                                                               ; 83b1: 5a          Z
; osbyte *exec file handle
    lda #&c6                                                          ; 83b2: a9 c6       ..
    sta lc2d9                                                         ; 83b4: 8d d9 c2    ...
    jsr OSBYTE_YFFX0                                                  ; 83b7: 20 83 84     ..
    cpx lc2d5                                                         ; 83ba: ec d5 c2    ...
    php                                                               ; 83bd: 08          .
    ldx #<starEdot                                                    ; 83be: a2 7c       .|
    plp                                                               ; 83c0: 28          (
    beq c83ca                                                         ; 83c1: f0 07       ..
    cpy lc2d5                                                         ; 83c3: cc d5 c2    ...
    bne c83cd                                                         ; 83c6: d0 05       ..
    ldx #<starSPdot                                                   ; 83c8: a2 7f       ..
; &83ca referenced 1 time by &83c1
.c83ca
    jsr sub_c8492                                                     ; 83ca: 20 92 84     ..
; &83cd referenced 1 time by &83c6
.c83cd
    ply                                                               ; 83cd: 7a          z
; &83ce referenced 1 time by &839c
.c83ce
    lda lc2ce                                                         ; 83ce: ad ce c2    ...
    bne c83d6                                                         ; 83d1: d0 03       ..
    jsr Function_entered_via_rts_onstack                              ; 83d3: 20 f8 9b     ..
; &83d6 referenced 1 time by &83d1
.c83d6
    lda #0                                                            ; 83d6: a9 00       ..
    sta l0100                                                         ; 83d8: 8d 00 01    ...
    sta l0101,y                                                       ; 83db: 99 01 01    ...
    jsr release_tube                                                  ; 83de: 20 3f 80     ?.
    lda l0101                                                         ; 83e1: ad 01 01    ...
    cmp #&c7                                                          ; 83e4: c9 c7       ..
    bne c83fc                                                         ; 83e6: d0 14       ..
    dec a                                                             ; 83e8: 3a          :
; osbyte *exec file handle
    jsr OSBYTE_YFFX0                                                  ; 83e9: 20 83 84     ..
    phy                                                               ; 83ec: 5a          Z
    txa                                                               ; 83ed: 8a          .
    ldx #<starEdot                                                    ; 83ee: a2 7c       .|
    jsr sub_c848a                                                     ; 83f0: 20 8a 84     ..
    pla                                                               ; 83f3: 68          h
    ldx #<starSPdot                                                   ; 83f4: a2 7f       ..
    jsr sub_c848a                                                     ; 83f6: 20 8a 84     ..
    jsr sub_c8459                                                     ; 83f9: 20 59 84     Y.
; &83fc referenced 1 time by &83e6
.c83fc
    jmp l0100                                                         ; 83fc: 4c 00 01    L..

; &83ff referenced 1 time by &8364
.at_string
    equs ": ta "                                                      ; 83ff: 3a 20 74... : t
; &8404 referenced 1 time by &83a1
.nochannel_string
    equs " lennahc no "                                               ; 8404: 20 6c 65...  le

; &8410 referenced 2 times by &8356, &838d
.hex_byte_on_stack
    pha                                                               ; 8410: 48          H
    lsr a                                                             ; 8411: 4a          J
    lsr a                                                             ; 8412: 4a          J
    lsr a                                                             ; 8413: 4a          J
    lsr a                                                             ; 8414: 4a          J
    jsr sub_c8419                                                     ; 8415: 20 19 84     ..
    pla                                                               ; 8418: 68          h
; &8419 referenced 1 time by &8415
.sub_c8419
    jsr nibble_to_asciihexdigit                                       ; 8419: 20 21 84     !.
    iny                                                               ; 841c: c8          .
    sta l0100,y                                                       ; 841d: 99 00 01    ...
    rts                                                               ; 8420: 60          `

; &8421 referenced 3 times by &8374, &8419, &8cda
.nibble_to_asciihexdigit
    and #&0f                                                          ; 8421: 29 0f       ).
    ora #&30 ; '0'                                                    ; 8423: 09 30       .0
    cmp #&3a ; ':'                                                    ; 8425: c9 3a       .:
    bcc c842b                                                         ; 8427: 90 02       ..
    adc #6                                                            ; 8429: 69 06       i.
; &842b referenced 1 time by &8427
.c842b
    rts                                                               ; 842b: 60          `

; &842c referenced 2 times by &835e, &83ae
.sub_c842c
    bit c8442                                                         ; 842c: 2c 42 84    ,B.
    ldx #&64 ; 'd'                                                    ; 842f: a2 64       .d
    jsr sub_c843c                                                     ; 8431: 20 3c 84     <.
    ldx #&0a                                                          ; 8434: a2 0a       ..
    jsr sub_c843c                                                     ; 8436: 20 3c 84     <.
    clv                                                               ; 8439: b8          .
    ldx #1                                                            ; 843a: a2 01       ..
; &843c referenced 2 times by &8431, &8436
.sub_c843c
    php                                                               ; 843c: 08          .
    stx l00b3                                                         ; 843d: 86 b3       ..
    ldx #&2f ; '/'                                                    ; 843f: a2 2f       ./
    sec                                                               ; 8441: 38          8
; &8442 referenced 2 times by &842c, &8445
.c8442
    inx                                                               ; 8442: e8          .
    sbc l00b3                                                         ; 8443: e5 b3       ..
    bcs c8442                                                         ; 8445: b0 fb       ..
    adc l00b3                                                         ; 8447: 65 b3       e.
    plp                                                               ; 8449: 28          (
    pha                                                               ; 844a: 48          H
    txa                                                               ; 844b: 8a          .
    bvc c8453                                                         ; 844c: 50 05       P.
    cmp #&30 ; '0'                                                    ; 844e: c9 30       .0
    beq c8457                                                         ; 8450: f0 05       ..
    clv                                                               ; 8452: b8          .
; &8453 referenced 1 time by &844c
.c8453
    iny                                                               ; 8453: c8          .
    sta l0100,y                                                       ; 8454: 99 00 01    ...
; &8457 referenced 1 time by &8450
.c8457
    pla                                                               ; 8457: 68          h
    rts                                                               ; 8458: 60          `

; &8459 referenced 5 times by &827c, &8293, &82af, &83f9, &924d
.sub_c8459
    ldx #&0c                                                          ; 8459: a2 0c       ..
    lda #&ff                                                          ; 845b: a9 ff       ..
; &845d referenced 1 time by &8464
.loop_c845d
    sta lc22b,x                                                       ; 845d: 9d 2b c2    .+.
    sta lc313,x                                                       ; 8460: 9d 13 c3    ...
    dex                                                               ; 8463: ca          .
    bne loop_c845d                                                    ; 8464: d0 f7       ..
    jsr sub_c983c                                                     ; 8466: 20 3c 98     <.
    jsr sub_c983c                                                     ; 8469: 20 3c 98     <.
    ldy #0                                                            ; 846c: a0 00       ..
    tya                                                               ; 846e: 98          .
; &846f referenced 1 time by &8479
.loop_c846f
    sta lc100,y                                                       ; 846f: 99 00 c1    ...
    sta pydis_end,y                                                   ; 8472: 99 00 c0    ...
    sta lc400,y                                                       ; 8475: 99 00 c4    ...
    iny                                                               ; 8478: c8          .
    bne loop_c846f                                                    ; 8479: d0 f4       ..
; &847b referenced 2 times by &848c, &8490
.c847b
    rts                                                               ; 847b: 60          `

; *** string table must not cross a page boundary
.starEdot
    equs "E.", &0d                                                    ; 847c: 45 2e 0d    E..
.starSPdot
    equs "SP."                                                        ; 847f: 53 50 2e    SP.
    equb &0d                                                          ; 8482: 0d          .

; &8483 referenced 5 times by &83b7, &83e9, &8f65, &91d2, &92d2
.OSBYTE_YFFX0
    ldy #&ff                                                          ; 8483: a0 ff       ..
; &8485 referenced 1 time by &972f
.OSBYTE_X0
    ldx #0                                                            ; 8485: a2 00       ..
    jmp osbyte                                                        ; 8487: 4c f4 ff    L..

; &848a referenced 2 times by &83f0, &83f6
.sub_c848a
    cmp #&50 ; 'P'                                                    ; 848a: c9 50       .P
    bcc c847b                                                         ; 848c: 90 ed       ..
    cmp #&5a ; 'Z'                                                    ; 848e: c9 5a       .Z
    bcs c847b                                                         ; 8490: b0 e9       ..
; &8492 referenced 1 time by &83ca
.sub_c8492
    ldy #>starEdot                                                    ; 8492: a0 84       ..
    jmp oscli                                                         ; 8494: 4c f7 ff    L..

    equb &0d                                                          ; 8497: 0d          .
    equs "SEY"                                                        ; 8498: 53 45 59    SEY
; &849b referenced 1 time by &9b4b
.Hugo_string
    equb 0                                                            ; 849b: 00          .
    equs "Hugo"                                                       ; 849c: 48 75 67... Hug

; &84a0 referenced 1 time by &84af
.loop_c84a0
    rts                                                               ; 84a0: 60          `

; &84a1 referenced 1 time by &98cf
.sub_c84a1
    ldx #0                                                            ; 84a1: a2 00       ..
    stx lc25d                                                         ; 84a3: 8e 5d c2    .].
    stx lc25e                                                         ; 84a6: 8e 5e c2    .^.
    stx lc25f                                                         ; 84a9: 8e 5f c2    ._.
; &84ac referenced 1 time by &84c7
.loop_c84ac
    cpx lc1fe                                                         ; 84ac: ec fe c1    ...
    beq loop_c84a0                                                    ; 84af: f0 ef       ..
    ldy #0                                                            ; 84b1: a0 00       ..
    clc                                                               ; 84b3: 18          .
    php                                                               ; 84b4: 08          .
; &84b5 referenced 1 time by &84c4
.loop_c84b5
    plp                                                               ; 84b5: 28          (
    lda lc100,x                                                       ; 84b6: bd 00 c1    ...
    adc lc25d,y                                                       ; 84b9: 79 5d c2    y].
    sta lc25d,y                                                       ; 84bc: 99 5d c2    .].
    php                                                               ; 84bf: 08          .
    iny                                                               ; 84c0: c8          .
    inx                                                               ; 84c1: e8          .
    cpy #3                                                            ; 84c2: c0 03       ..
    bne loop_c84b5                                                    ; 84c4: d0 ef       ..
    plp                                                               ; 84c6: 28          (
    jmp loop_c84ac                                                    ; 84c7: 4c ac 84    L..

    equb &a2, &ff, &86, &b3, &e8, &ec, &fe, &c1, &90, &58, &a6, &b3   ; 84ca: a2 ff 86... ...
    equb &e0, &ff, &d0, &16, &20, &a1, &84, &a0,   0, &a2,   2, &38   ; 84d6: e0 ff d0... ...
    equb &b9, &5d, &c2, &f9, &3d, &c2, &c8, &ca, &10, &f6, &b0,   1   ; 84e2: b9 5d c2... .].
    equb &60, &60, &a0,   2, &ca, &bd,   0, &c0, &99, &3a, &c2, &88   ; 84ee: 60 60 a0... ``.
    equb &10, &f6, &c8, &a6, &b3, &18,   8, &28, &bd, &fd, &bf, &79   ; 84fa: 10 f6 c8... ...
    equb &3d, &c2, &9d, &fd, &bf,   8, &e8, &c8, &c0,   3, &d0, &ef   ; 8506: 3d c2 9d... =..
    equb &28, &a0,   0, &a6, &b3, &38,   8, &28, &bd, &fd, &c0, &f9   ; 8512: 28 a0 00... (..
    equb &3d, &c2, &9d, &fd, &c0,   8, &e8, &c8, &c0,   3, &d0, &ef   ; 851e: 3d c2 9d... =..
    equb &28, &60, &a0,   2, &e8, &e8, &e8, &86, &b2, &ca, &bd,   0   ; 852a: 28 60 a0... (`.
    equb &c1, &d9, &3d, &c2, &90, &3b, &d0, &30, &88, &10, &f2, &a6   ; 8536: c1 d9 3d... ..=
    equb &b2, &a0,   2, &ca, &bd,   0, &c0, &99, &3a, &c2, &88, &10   ; 8542: b2 a0 02... ...
    equb &f6, &a6, &b2, &ec, &fe, &c1, &b0, &0f, &bd,   0, &c0, &9d   ; 854e: f6 a6 b2... ...
    equb &fd, &bf, &bd,   0, &c1, &9d, &fd, &c0, &e8, &d0, &ec, &ad   ; 855a: fd bf bd... ...
    equb &fe, &c1, &e9,   3, &8d, &fe, &c1, &60, &a6, &b3, &e8, &d0   ; 8566: fe c1 e9... ...
    equb   4, &a5, &b2, &85, &b3, &a6, &b2, &4c, &cf, &84             ; 8572: 04 a5 b2... ...

; &857c referenced 3 times by &86c9, &86e1, &8737
.sub_c857c
    inc l00b4                                                         ; 857c: e6 b4       ..
    bne c8582                                                         ; 857e: d0 02       ..
    inc l00b5                                                         ; 8580: e6 b5       ..
; &8582 referenced 1 time by &857e
.c8582
    rts                                                               ; 8582: 60          `

; &8583 referenced 2 times by &86bb, &86c0
.sub_c8583
    jsr sub_c9aef                                                     ; 8583: 20 ef 9a     ..
    jsr sub_c8ada                                                     ; 8586: 20 da 8a     ..
    ldy #0                                                            ; 8589: a0 00       ..
    sty lc2c0                                                         ; 858b: 8c c0 c2    ...
; &858e referenced 15 times by &85a3, &85db, &85f6, &85fb, &8610, &86d8, &8730, &873c, &8751, &878c, &8adc, &8aec, &8b0b, &8b17, &8b42
.sub_c858e
    lda (l00b4),y                                                     ; 858e: b1 b4       ..
    and #&7f                                                          ; 8590: 29 7f       ).
    cmp #&2e ; '.'                                                    ; 8592: c9 2e       ..
    beq c859e                                                         ; 8594: f0 08       ..
    cmp #&22 ; '"'                                                    ; 8596: c9 22       ."
    beq c859e                                                         ; 8598: f0 04       ..
    cmp #&20 ; ' '                                                    ; 859a: c9 20       .
    bcs c85a0                                                         ; 859c: b0 02       ..
; &859e referenced 2 times by &8594, &8598
.c859e
    ldx #0                                                            ; 859e: a2 00       ..
; &85a0 referenced 1 time by &859c
.c85a0
    rts                                                               ; 85a0: 60          `

; &85a1 referenced 2 times by &8666, &87c0
.sub_c85a1
    ldy #&0a                                                          ; 85a1: a0 0a       ..
; &85a3 referenced 1 time by &85a9
.loop_c85a3
    jsr sub_c858e                                                     ; 85a3: 20 8e 85     ..
    beq c85b8                                                         ; 85a6: f0 10       ..
    dey                                                               ; 85a8: 88          .
    bpl loop_c85a3                                                    ; 85a9: 10 f8       ..
; &85ab referenced 6 times by &85f9, &86b8, &89e1, &8b47, &9801, &9b02
.c85ab
    jsr generate_error_inline                                         ; 85ab: 20 26 83     &.
    equs &cc, "Bad name", 0                                           ; 85ae: cc 42 61... .Ba

; &85b8 referenced 1 time by &85a6
.c85b8
    ldy #9                                                            ; 85b8: a0 09       ..
; &85ba referenced 1 time by &85c2
.loop_c85ba
    lda (l00b6),y                                                     ; 85ba: b1 b6       ..
    and #&7f                                                          ; 85bc: 29 7f       ).
    sta lc262,y                                                       ; 85be: 99 62 c2    .b.
    dey                                                               ; 85c1: 88          .
    bpl loop_c85ba                                                    ; 85c2: 10 f6       ..
    iny                                                               ; 85c4: c8          .
    ldx #0                                                            ; 85c5: a2 00       ..
; &85c7 referenced 2 times by &85f3, &862c
.c85c7
    cpx #&0a                                                          ; 85c7: e0 0a       ..
    bcs c860c                                                         ; 85c9: b0 41       .A
    lda lc262,x                                                       ; 85cb: bd 62 c2    .b.
    cmp #&21 ; '!'                                                    ; 85ce: c9 21       .!
    bcc c860c                                                         ; 85d0: 90 3a       .:
    ora #&20 ; ' '                                                    ; 85d2: 09 20       .
    sta lc22b                                                         ; 85d4: 8d 2b c2    .+.
    cpy #&0a                                                          ; 85d7: c0 0a       ..
    bcs c85f6                                                         ; 85d9: b0 1b       ..
    jsr sub_c858e                                                     ; 85db: 20 8e 85     ..
    beq c85fb                                                         ; 85de: f0 1b       ..
    cmp #&2a ; '*'                                                    ; 85e0: c9 2a       .*
    beq c861c                                                         ; 85e2: f0 38       .8
    cmp #&23 ; '#'                                                    ; 85e4: c9 23       .#
    beq c85f1                                                         ; 85e6: f0 09       ..
    ora #&20 ; ' '                                                    ; 85e8: 09 20       .
    cmp lc22b                                                         ; 85ea: cd 2b c2    .+.
    bcc c85fb                                                         ; 85ed: 90 0c       ..
    bne c85f5                                                         ; 85ef: d0 04       ..
; &85f1 referenced 1 time by &85e6
.c85f1
    inx                                                               ; 85f1: e8          .
    iny                                                               ; 85f2: c8          .
    bne c85c7                                                         ; 85f3: d0 d2       ..
; &85f5 referenced 3 times by &85ef, &860e, &8613
.c85f5
    rts                                                               ; 85f5: 60          `

; &85f6 referenced 1 time by &85d9
.c85f6
    jsr sub_c858e                                                     ; 85f6: 20 8e 85     ..
    bne c85ab                                                         ; 85f9: d0 b0       ..
; &85fb referenced 3 times by &85de, &85ed, &8607
.c85fb
    jsr sub_c858e                                                     ; 85fb: 20 8e 85     ..
    cmp #&23 ; '#'                                                    ; 85fe: c9 23       .#
    beq c8619                                                         ; 8600: f0 17       ..
    cmp #&2a ; '*'                                                    ; 8602: c9 2a       .*
    beq c8619                                                         ; 8604: f0 13       ..
    dey                                                               ; 8606: 88          .
    bpl c85fb                                                         ; 8607: 10 f2       ..
    cmp #&ff                                                          ; 8609: c9 ff       ..
    rts                                                               ; 860b: 60          `

; &860c referenced 2 times by &85c9, &85d0
.c860c
    cpy #&0a                                                          ; 860c: c0 0a       ..
    beq c85f5                                                         ; 860e: f0 e5       ..
    jsr sub_c858e                                                     ; 8610: 20 8e 85     ..
    beq c85f5                                                         ; 8613: f0 e0       ..
    cmp #&2a ; '*'                                                    ; 8615: c9 2a       .*
    beq c861c                                                         ; 8617: f0 03       ..
; &8619 referenced 2 times by &8600, &8604
.c8619
    cmp #0                                                            ; 8619: c9 00       ..
    rts                                                               ; 861b: 60          `

; &861c referenced 3 times by &85e2, &8617, &8653
.c861c
    iny                                                               ; 861c: c8          .
; &861d referenced 1 time by &8634
.loop_c861d
    lda lc262,x                                                       ; 861d: bd 62 c2    .b.
    and #&7f                                                          ; 8620: 29 7f       ).
    cmp #&21 ; '!'                                                    ; 8622: c9 21       .!
    bcc c863f                                                         ; 8624: 90 19       ..
    cpx #&0a                                                          ; 8626: e0 0a       ..
    bcs c863f                                                         ; 8628: b0 15       ..
    phx                                                               ; 862a: da          .
    phy                                                               ; 862b: 5a          Z
    jsr c85c7                                                         ; 862c: 20 c7 85     ..
    beq c8639                                                         ; 862f: f0 08       ..
    ply                                                               ; 8631: 7a          z
    plx                                                               ; 8632: fa          .
    inx                                                               ; 8633: e8          .
    bne loop_c861d                                                    ; 8634: d0 e7       ..
; &8636 referenced 1 time by &8655
.loop_c8636
    cpx #0                                                            ; 8636: e0 00       ..
    rts                                                               ; 8638: 60          `

; &8639 referenced 1 time by &862f
.c8639
    pla                                                               ; 8639: 68          h
    pla                                                               ; 863a: 68          h
; &863b referenced 4 times by &8641, &8647, &864b, &864f
.c863b
    lda #0                                                            ; 863b: a9 00       ..
    sec                                                               ; 863d: 38          8
    rts                                                               ; 863e: 60          `

; &863f referenced 2 times by &8624, &8628
.c863f
    cpy #&0a                                                          ; 863f: c0 0a       ..
    bcs c863b                                                         ; 8641: b0 f8       ..
    lda (l00b4),y                                                     ; 8643: b1 b4       ..
    cmp #&21 ; '!'                                                    ; 8645: c9 21       .!
    bcc c863b                                                         ; 8647: 90 f2       ..
    cmp #&2e ; '.'                                                    ; 8649: c9 2e       ..
    beq c863b                                                         ; 864b: f0 ee       ..
    cmp #&22 ; '"'                                                    ; 864d: c9 22       ."
    beq c863b                                                         ; 864f: f0 ea       ..
    cmp #&2a ; '*'                                                    ; 8651: c9 2a       .*
    beq c861c                                                         ; 8653: f0 c7       ..
    bne loop_c8636                                                    ; 8655: d0 df       ..
; &8657 referenced 1 time by &8775
.sub_c8657
    jsr sub_c9aef                                                     ; 8657: 20 ef 9a     ..
    jsr sub_c8d7b                                                     ; 865a: 20 7b 8d     {.
    jsr check_directory_for_Hugo                                      ; 865d: 20 38 9b     8.
; &8660 referenced 2 times by &8673, &8677
.c8660
    ldy #0                                                            ; 8660: a0 00       ..
    lda (l00b6),y                                                     ; 8662: b1 b6       ..
    beq c8679                                                         ; 8664: f0 13       ..
    jsr sub_c85a1                                                     ; 8666: 20 a1 85     ..
    beq c867b                                                         ; 8669: f0 10       ..
    bcc c867b                                                         ; 866b: 90 0e       ..
    lda l00b6                                                         ; 866d: a5 b6       ..
    adc #&19                                                          ; 866f: 69 19       i.
    sta l00b6                                                         ; 8671: 85 b6       ..
    bcc c8660                                                         ; 8673: 90 eb       ..
    inc l00b7                                                         ; 8675: e6 b7       ..
    bne c8660                                                         ; 8677: d0 e7       ..
; &8679 referenced 1 time by &8664
.c8679
    cmp #&0f                                                          ; 8679: c9 0f       ..
; &867b referenced 2 times by &8669, &866b
.c867b
    rts                                                               ; 867b: 60          `

.table2
    equb   1,   0, &c0, &ff, &ff,   8,   0,   0,   0,   2,   0        ; 867c: 01 00 c0... ...
; &8687 referenced 3 times by &87eb, &882d, &8e60
.table3
    equb   1,   0, &c4, &ff, &ff,   8,   0,   0,   2,   5,   0        ; 8687: 01 00 c4... ...

; &8692 referenced 2 times by &86db, &97fa
.sub_c8692
    cmp #&30 ; '0'                                                    ; 8692: c9 30       .0
    bcc c86b8                                                         ; 8694: 90 22       ."
    cmp #&38 ; '8'                                                    ; 8696: c9 38       .8
    bcc c86a5                                                         ; 8698: 90 0b       ..
    ora #&20 ; ' '                                                    ; 869a: 09 20       .
    cmp #&61 ; 'a'                                                    ; 869c: c9 61       .a
    bcc c86b8                                                         ; 869e: 90 18       ..
    cmp #&69 ; 'i'                                                    ; 86a0: c9 69       .i
    bcs c86b8                                                         ; 86a2: b0 14       ..
    dec a                                                             ; 86a4: 3a          :
; &86a5 referenced 1 time by &8698
.c86a5
    pha                                                               ; 86a5: 48          H
    lda tube_used_zp                                                  ; 86a6: a5 cd       ..
    and #&20 ; ' '                                                    ; 86a8: 29 20       )
    bne c86b0                                                         ; 86aa: d0 04       ..
    pla                                                               ; 86ac: 68          h
    and #3                                                            ; 86ad: 29 03       ).
    pha                                                               ; 86af: 48          H
; &86b0 referenced 1 time by &86aa
.c86b0
    pla                                                               ; 86b0: 68          h
    and #7                                                            ; 86b1: 29 07       ).
    lsr a                                                             ; 86b3: 4a          J
    ror a                                                             ; 86b4: 6a          j
    ror a                                                             ; 86b5: 6a          j
    ror a                                                             ; 86b6: 6a          j
    rts                                                               ; 86b7: 60          `

; &86b8 referenced 4 times by &8694, &869e, &86a2, &86be
.c86b8
    jmp c85ab                                                         ; 86b8: 4c ab 85    L..

; &86bb referenced 2 times by &89c4, &8b5f
.sub_c86bb
    jsr sub_c8583                                                     ; 86bb: 20 83 85     ..
    beq c86b8                                                         ; 86be: f0 f8       ..
; &86c0 referenced 1 time by &8e35
.sub_c86c0
    jsr sub_c8583                                                     ; 86c0: 20 83 85     ..
    beq c86e4                                                         ; 86c3: f0 1f       ..
    cmp #&3a ; ':'                                                    ; 86c5: c9 3a       .:
    bne c873a                                                         ; 86c7: d0 71       .q
    jsr sub_c857c                                                     ; 86c9: 20 7c 85     |.
    ldx lc22f                                                         ; 86cc: ae 2f c2    ./.
    inx                                                               ; 86cf: e8          .
    bne c86d8                                                         ; 86d0: d0 06       ..
    lda lc317                                                         ; 86d2: ad 17 c3    ...
    sta lc22f                                                         ; 86d5: 8d 2f c2    ./.
; &86d8 referenced 1 time by &86d0
.c86d8
    jsr sub_c858e                                                     ; 86d8: 20 8e 85     ..
    jsr sub_c8692                                                     ; 86db: 20 92 86     ..
    sta lc317                                                         ; 86de: 8d 17 c3    ...
; &86e1 referenced 1 time by &8743
.c86e1
    jsr sub_c857c                                                     ; 86e1: 20 7c 85     |.
; &86e4 referenced 1 time by &86c3
.c86e4
    ldx lc317                                                         ; 86e4: ae 17 c3    ...
    inx                                                               ; 86e7: e8          .
    bne c86f8                                                         ; 86e8: d0 0e       ..
    lda tube_used_zp                                                  ; 86ea: a5 cd       ..
    and #&20 ; ' '                                                    ; 86ec: 29 20       )
    beq c86f5                                                         ; 86ee: f0 05       ..
    lda CMOS_byte_copy                                                ; 86f0: ad d8 c2    ...
    and #&80                                                          ; 86f3: 29 80       ).
; &86f5 referenced 1 time by &86ee
.c86f5
    sta lc317                                                         ; 86f5: 8d 17 c3    ...
; &86f8 referenced 1 time by &86e8
.c86f8
    lda #&10                                                          ; 86f8: a9 10       ..
    tsb tube_used_zp                                                  ; 86fa: 04 cd       ..
    ldx #<table2                                                      ; 86fc: a2 7c       .|
    ldy #>table2                                                      ; 86fe: a0 86       ..
    jsr sub_c8261                                                     ; 8700: 20 61 82     a.
    lda #&10                                                          ; 8703: a9 10       ..
    trb tube_used_zp                                                  ; 8705: 14 cd       ..
    lda lc22e                                                         ; 8707: ad 2e c2    ...
    bpl c8717                                                         ; 870a: 10 0b       ..
    ldy #2                                                            ; 870c: a0 02       ..
; &870e referenced 1 time by &8715
.loop_c870e
    lda lc314,y                                                       ; 870e: b9 14 c3    ...
    sta lc22c,y                                                       ; 8711: 99 2c c2    .,.
    dey                                                               ; 8714: 88          .
    bpl loop_c870e                                                    ; 8715: 10 f7       ..
; &8717 referenced 1 time by &870a
.c8717
    ldy #>table3                                                      ; 8717: a0 86       ..
    ldx #<table3                                                      ; 8719: a2 87       ..
    jsr sub_c8261                                                     ; 871b: 20 61 82     a.
    lda #2                                                            ; 871e: a9 02       ..
    sta lc314                                                         ; 8720: 8d 14 c3    ...
    lda #0                                                            ; 8723: a9 00       ..
    sta lc315                                                         ; 8725: 8d 15 c3    ...
    sta lc316                                                         ; 8728: 8d 16 c3    ...
    jsr sub_ca1af                                                     ; 872b: 20 af a1     ..
    ldy #0                                                            ; 872e: a0 00       ..
    jsr sub_c858e                                                     ; 8730: 20 8e 85     ..
    cmp #&2e ; '.'                                                    ; 8733: c9 2e       ..
    bne c875b                                                         ; 8735: d0 24       .$
    jsr sub_c857c                                                     ; 8737: 20 7c 85     |.
; &873a referenced 1 time by &86c7
.c873a
    ldy #0                                                            ; 873a: a0 00       ..
    jsr sub_c858e                                                     ; 873c: 20 8e 85     ..
    and #&fd                                                          ; 873f: 29 fd       ).
    cmp #&24 ; '$'                                                    ; 8741: c9 24       .$
    beq c86e1                                                         ; 8743: f0 9c       ..
    jsr sub_ca207                                                     ; 8745: 20 07 a2     ..
; &8748 referenced 1 time by &8807
.c8748
    jsr sub_c8e05                                                     ; 8748: 20 05 8e     ..
    bne c8775                                                         ; 874b: d0 28       .(
    iny                                                               ; 874d: c8          .
    sty lc2a2                                                         ; 874e: 8c a2 c2    ...
    jsr sub_c858e                                                     ; 8751: 20 8e 85     ..
    cmp #&2e ; '.'                                                    ; 8754: c9 2e       ..
    bne c877a                                                         ; 8756: d0 22       ."
    jmp c87cc                                                         ; 8758: 4c cc 87    L..

; &875b referenced 1 time by &8735
.c875b
    lda #&24 ; '$'                                                    ; 875b: a9 24       .$
    sta lc262                                                         ; 875d: 8d 62 c2    .b.
    lda #&0d                                                          ; 8760: a9 0d       ..
    sta lc263                                                         ; 8762: 8d 63 c2    .c.
    lda #<table1                                                      ; 8765: a9 82       ..
    sta l00b6                                                         ; 8767: 85 b6       ..
    lda #>table1                                                      ; 8769: a9 8e       ..
    sta l00b7                                                         ; 876b: 85 b7       ..
    lda #2                                                            ; 876d: a9 02       ..
    sta lc2c0                                                         ; 876f: 8d c0 c2    ...
    lda #0                                                            ; 8772: a9 00       ..
    rts                                                               ; 8774: 60          `

; &8775 referenced 1 time by &874b
.c8775
    jsr sub_c8657                                                     ; 8775: 20 57 86     W.
    beq c878a                                                         ; 8778: f0 10       ..
; &877a referenced 1 time by &8756
.c877a
    rts                                                               ; 877a: 60          `

; &877b referenced 2 times by &8791, &8795
.c877b
    ldx #1                                                            ; 877b: a2 01       ..
    ldy #3                                                            ; 877d: a0 03       ..
    lda (l00b6),y                                                     ; 877f: b1 b6       ..
    bpl c8784                                                         ; 8781: 10 01       ..
    inx                                                               ; 8783: e8          .
; &8784 referenced 1 time by &8781
.c8784
    stx lc2c0                                                         ; 8784: 8e c0 c2    ...
    lda #0                                                            ; 8787: a9 00       ..
    rts                                                               ; 8789: 60          `

; &878a referenced 1 time by &8778
.c878a
    ldy #0                                                            ; 878a: a0 00       ..
; &878c referenced 1 time by &879c
.loop_c878c
    jsr sub_c858e                                                     ; 878c: 20 8e 85     ..
    cmp #&21 ; '!'                                                    ; 878f: c9 21       .!
    bcc c877b                                                         ; 8791: 90 e8       ..
    cmp #&22 ; '"'                                                    ; 8793: c9 22       ."
    beq c877b                                                         ; 8795: f0 e4       ..
    cmp #&2e ; '.'                                                    ; 8797: c9 2e       ..
    beq c879e                                                         ; 8799: f0 03       ..
    iny                                                               ; 879b: c8          .
    bne loop_c878c                                                    ; 879c: d0 ee       ..
; &879e referenced 1 time by &8799
.c879e
    sty lc2a2                                                         ; 879e: 8c a2 c2    ...
; &87a1 referenced 1 time by &87aa
.loop_c87a1
    ldy #3                                                            ; 87a1: a0 03       ..
    lda (l00b6),y                                                     ; 87a3: b1 b6       ..
    bmi c87c6                                                         ; 87a5: 30 1f       0.
    jsr c87af                                                         ; 87a7: 20 af 87     ..
    beq loop_c87a1                                                    ; 87aa: f0 f5       ..
; &87ac referenced 1 time by &87be
.loop_c87ac
    lda #&ff                                                          ; 87ac: a9 ff       ..
    rts                                                               ; 87ae: 60          `

; &87af referenced 6 times by &87a7, &87c3, &89cb, &8e40, &8ea8, &9281
.c87af
    clc                                                               ; 87af: 18          .
    lda l00b6                                                         ; 87b0: a5 b6       ..
    adc #&1a                                                          ; 87b2: 69 1a       i.
    sta l00b6                                                         ; 87b4: 85 b6       ..
    bcc c87ba                                                         ; 87b6: 90 02       ..
    inc l00b7                                                         ; 87b8: e6 b7       ..
; &87ba referenced 1 time by &87b6
.c87ba
    ldy #0                                                            ; 87ba: a0 00       ..
    lda (l00b6),y                                                     ; 87bc: b1 b6       ..
    beq loop_c87ac                                                    ; 87be: f0 ec       ..
    jsr sub_c85a1                                                     ; 87c0: 20 a1 85     ..
    bne c87af                                                         ; 87c3: d0 ea       ..
    rts                                                               ; 87c5: 60          `

; &87c6 referenced 1 time by &87a5
.c87c6
    ldy #9                                                            ; 87c6: a0 09       ..
    lda (l00b6),y                                                     ; 87c8: b1 b6       ..
    bpl c87cc                                                         ; 87ca: 10 00       ..
; &87cc referenced 2 times by &8758, &87ca
.c87cc
    lda lc2a2                                                         ; 87cc: ad a2 c2    ...
    sec                                                               ; 87cf: 38          8
    adc l00b4                                                         ; 87d0: 65 b4       e.
    sta l00b4                                                         ; 87d2: 85 b4       ..
    bcc c87d8                                                         ; 87d4: 90 02       ..
    inc l00b5                                                         ; 87d6: e6 b5       ..
; &87d8 referenced 1 time by &87d4
.c87d8
    lda lc22e                                                         ; 87d8: ad 2e c2    ...
    inc a                                                             ; 87db: 1a          .
    bne c87e9                                                         ; 87dc: d0 0b       ..
    ldy #2                                                            ; 87de: a0 02       ..
; &87e0 referenced 1 time by &87e7
.loop_c87e0
    lda lc314,y                                                       ; 87e0: b9 14 c3    ...
    sta lc22c,y                                                       ; 87e3: 99 2c c2    .,.
    dey                                                               ; 87e6: 88          .
    bpl loop_c87e0                                                    ; 87e7: 10 f7       ..
; &87e9 referenced 1 time by &87dc
.c87e9
    ldx #&0a                                                          ; 87e9: a2 0a       ..
; &87eb referenced 1 time by &87f2
.loop_c87eb
    lda table3,x                                                      ; 87eb: bd 87 86    ...
    sta lc215,x                                                       ; 87ee: 9d 15 c2    ...
    dex                                                               ; 87f1: ca          .
    bpl loop_c87eb                                                    ; 87f2: 10 f7       ..
    ldx #2                                                            ; 87f4: a2 02       ..
    ldy #&16                                                          ; 87f6: a0 16       ..
; &87f8 referenced 1 time by &8802
.loop_c87f8
    lda (l00b6),y                                                     ; 87f8: b1 b6       ..
    sta lc21b,x                                                       ; 87fa: 9d 1b c2    ...
    sta lc2fe,y                                                       ; 87fd: 99 fe c2    ...
    iny                                                               ; 8800: c8          .
    dex                                                               ; 8801: ca          .
    bpl loop_c87f8                                                    ; 8802: 10 f4       ..
    jsr c825d                                                         ; 8804: 20 5d 82     ].
    jmp c8748                                                         ; 8807: 4c 48 87    LH.

; &880a referenced 2 times by &8a70, &8ad7
.c880a
    lda lc2c0                                                         ; 880a: ad c0 c2    ...
; &880d referenced 17 times by &8326, &8ad1, &8dd2, &8ead, &8f23, &9250, &92a7, &9713, &999a, &99ca, &9a7d, &9aa8, &9ab4, &9ac8, &a165, &a1a5, &a40c
.c880d
    pha                                                               ; 880d: 48          H
    lda lc22f                                                         ; 880e: ad 2f c2    ./.
    cmp #&ff                                                          ; 8811: c9 ff       ..
    beq c8824                                                         ; 8813: f0 0f       ..
    sta lc317                                                         ; 8815: 8d 17 c3    ...
    ldx #&ff                                                          ; 8818: a2 ff       ..
    stx lc22f                                                         ; 881a: 8e 2f c2    ./.
    ldx #<table2                                                      ; 881d: a2 7c       .|
    ldy #>table2                                                      ; 881f: a0 86       ..
    jsr sub_c8261                                                     ; 8821: 20 61 82     a.
; &8824 referenced 1 time by &8813
.c8824
    ldx lc22e                                                         ; 8824: ae 2e c2    ...
    cpx #&ff                                                          ; 8827: e0 ff       ..
    beq c8856                                                         ; 8829: f0 2b       .+
    ldy #&0a                                                          ; 882b: a0 0a       ..
; &882d referenced 1 time by &8834
.loop_c882d
    lda table3,y                                                      ; 882d: b9 87 86    ...
    sta lc215,y                                                       ; 8830: 99 15 c2    ...
    dey                                                               ; 8833: 88          .
    bpl loop_c882d                                                    ; 8834: 10 f7       ..
    stx lc316                                                         ; 8836: 8e 16 c3    ...
    stx lc21b                                                         ; 8839: 8e 1b c2    ...
    lda lc22d                                                         ; 883c: ad 2d c2    .-.
    sta lc315                                                         ; 883f: 8d 15 c3    ...
    sta lc21c                                                         ; 8842: 8d 1c c2    ...
    lda lc22c                                                         ; 8845: ad 2c c2    .,.
    sta lc314                                                         ; 8848: 8d 14 c3    ...
    sta lc21d                                                         ; 884b: 8d 1d c2    ...
    lda #&ff                                                          ; 884e: a9 ff       ..
    sta lc22e                                                         ; 8850: 8d 2e c2    ...
    jsr c825d                                                         ; 8853: 20 5d 82     ].
; &8856 referenced 2 times by &8829, &9c11
.c8856
    lda tube_used_zp                                                  ; 8856: a5 cd       ..
    sta lc320                                                         ; 8858: 8d 20 c3    . .
    jsr sub_c9b68                                                     ; 885b: 20 68 9b     h.
    ldy #&fb                                                          ; 885e: a0 fb       ..
; &8860 referenced 1 time by &8866
.loop_c8860
    lda lc300,y                                                       ; 8860: b9 00 c3    ...
    sta (l00ba),y                                                     ; 8863: 91 ba       ..
    dey                                                               ; 8865: 88          .
    bne loop_c8860                                                    ; 8866: d0 f8       ..
    lda lc300                                                         ; 8868: ad 00 c3    ...
    sta (l00ba),y                                                     ; 886b: 91 ba       ..
    jsr sub_c9b85                                                     ; 886d: 20 85 9b     ..
    ldx l00b8                                                         ; 8870: a6 b8       ..
    ldy l00b9                                                         ; 8872: a4 b9       ..
    pla                                                               ; 8874: 68          h
; &8875 referenced 1 time by &8879
.loop_c8875
    rts                                                               ; 8875: 60          `

; &8876 referenced 2 times by &8a6a, &a4c4
.sub_c8876
    jsr sub_c887e                                                     ; 8876: 20 7e 88     ~.
    beq loop_c8875                                                    ; 8879: f0 fa       ..
    jmp c8270                                                         ; 887b: 4c 70 82    Lp.

; &887e referenced 2 times by &8876, &94c9
.sub_c887e
    lda lc21a                                                         ; 887e: ad 1a c2    ...
    and #&1f                                                          ; 8881: 29 1f       ).
    cmp #8                                                            ; 8883: c9 08       ..
    beq c889e                                                         ; 8885: f0 17       ..
    lda lc220                                                         ; 8887: ad 20 c2    . .
    beq c889e                                                         ; 888a: f0 12       ..
    lda #0                                                            ; 888c: a9 00       ..
    sta lc220                                                         ; 888e: 8d 20 c2    . .
    inc lc221                                                         ; 8891: ee 21 c2    .!.
    bne c889e                                                         ; 8894: d0 08       ..
    inc lc222                                                         ; 8896: ee 22 c2    .".
    bne c889e                                                         ; 8899: d0 03       ..
    inc lc223                                                         ; 889b: ee 23 c2    .#.
; &889e referenced 4 times by &8885, &888a, &8894, &8899
.c889e
    ldx #&15                                                          ; 889e: a2 15       ..
    ldy #&c2                                                          ; 88a0: a0 c2       ..
    lda #&ff                                                          ; 88a2: a9 ff       ..
    sta lc21e                                                         ; 88a4: 8d 1e c2    ...
; &88a7 referenced 2 times by &88e3, &88f0
.c88a7
    lda lc223                                                         ; 88a7: ad 23 c2    .#.
    ora lc222                                                         ; 88aa: 0d 22 c2    .".
    beq c88f2                                                         ; 88ad: f0 43       .C
    jsr access_scsi_drive                                             ; 88af: 20 a7 80     ..
    bne c8904                                                         ; 88b2: d0 50       .P
    lda #&ff                                                          ; 88b4: a9 ff       ..
    clc                                                               ; 88b6: 18          .
    adc lc217                                                         ; 88b7: 6d 17 c2    m..
    sta lc217                                                         ; 88ba: 8d 17 c2    ...
    bcc c88c7                                                         ; 88bd: 90 08       ..
    inc lc218                                                         ; 88bf: ee 18 c2    ...
    bne c88c7                                                         ; 88c2: d0 03       ..
    inc lc219                                                         ; 88c4: ee 19 c2    ...
; &88c7 referenced 2 times by &88bd, &88c2
.c88c7
    lda #&ff                                                          ; 88c7: a9 ff       ..
    clc                                                               ; 88c9: 18          .
    adc lc21d                                                         ; 88ca: 6d 1d c2    m..
    sta lc21d                                                         ; 88cd: 8d 1d c2    ...
    bcc c88da                                                         ; 88d0: 90 08       ..
    inc lc21c                                                         ; 88d2: ee 1c c2    ...
    bne c88da                                                         ; 88d5: d0 03       ..
    inc lc21b                                                         ; 88d7: ee 1b c2    ...
; &88da referenced 2 times by &88d0, &88d5
.c88da
    lda lc221                                                         ; 88da: ad 21 c2    .!.
    sec                                                               ; 88dd: 38          8
    sbc #&ff                                                          ; 88de: e9 ff       ..
    sta lc221                                                         ; 88e0: 8d 21 c2    .!.
    bcs c88a7                                                         ; 88e3: b0 c2       ..
    lda lc222                                                         ; 88e5: ad 22 c2    .".
    bne c88ed                                                         ; 88e8: d0 03       ..
    dec lc223                                                         ; 88ea: ce 23 c2    .#.
; &88ed referenced 1 time by &88e8
.c88ed
    dec lc222                                                         ; 88ed: ce 22 c2    .".
    bra c88a7                                                         ; 88f0: 80 b5       ..
; &88f2 referenced 1 time by &88ad
.c88f2
    lda lc221                                                         ; 88f2: ad 21 c2    .!.
    beq c88ff                                                         ; 88f5: f0 08       ..
    sta lc21e                                                         ; 88f7: 8d 1e c2    ...
    jsr access_scsi_drive                                             ; 88fa: 20 a7 80     ..
    bne c8904                                                         ; 88fd: d0 05       ..
; &88ff referenced 1 time by &88f5
.c88ff
    lda lc220                                                         ; 88ff: ad 20 c2    . .
    bne c8905                                                         ; 8902: d0 01       ..
; &8904 referenced 3 times by &88b2, &88fd, &8936
.c8904
    rts                                                               ; 8904: 60          `

; &8905 referenced 1 time by &8902
.c8905
    sta lc21e                                                         ; 8905: 8d 1e c2    ...
    lda lc221                                                         ; 8908: ad 21 c2    .!.
    clc                                                               ; 890b: 18          .
    adc lc21d                                                         ; 890c: 6d 1d c2    m..
    sta lc21d                                                         ; 890f: 8d 1d c2    ...
    bcc c891c                                                         ; 8912: 90 08       ..
    inc lc21c                                                         ; 8914: ee 1c c2    ...
    bne c891c                                                         ; 8917: d0 03       ..
    inc lc21b                                                         ; 8919: ee 1b c2    ...
; &891c referenced 2 times by &8912, &8917
.c891c
    lda lc221                                                         ; 891c: ad 21 c2    .!.
    clc                                                               ; 891f: 18          .
    adc lc217                                                         ; 8920: 6d 17 c2    m..
    sta lc217                                                         ; 8923: 8d 17 c2    ...
    bcc c8930                                                         ; 8926: 90 08       ..
    inc lc218                                                         ; 8928: ee 18 c2    ...
    bne c8930                                                         ; 892b: d0 03       ..
    inc lc219                                                         ; 892d: ee 19 c2    ...
; &8930 referenced 2 times by &8926, &892b
.c8930
    jsr ensure_drive                                                  ; 8930: 20 e0 82     ..
    jsr sub_c8938                                                     ; 8933: 20 38 89     8.
    beq c8904                                                         ; 8936: f0 cc       ..
; &8938 referenced 1 time by &8933
.sub_c8938
    ldx #&15                                                          ; 8938: a2 15       ..
    ldy #&c2                                                          ; 893a: a0 c2       ..
    stx l00b0                                                         ; 893c: 86 b0       ..
    sty l00b1                                                         ; 893e: 84 b1       ..
    ldx lc219                                                         ; 8940: ae 19 c2    ...
    lda lc218                                                         ; 8943: ad 18 c2    ...
    jsr shadow_to_main                                                ; 8946: 20 58 80     X.
    lda lc317                                                         ; 8949: ad 17 c3    ...
    inc a                                                             ; 894c: 1a          .
    beq c8950                                                         ; 894d: f0 01       ..
    dec a                                                             ; 894f: 3a          :
; &8950 referenced 1 time by &894d
.c8950
    ora lc21b                                                         ; 8950: 0d 1b c2    ...
    sta lc21b                                                         ; 8953: 8d 1b c2    ...
    sta lc333                                                         ; 8956: 8d 33 c3    .3.
    lda lc333                                                         ; 8959: ad 33 c3    .3.
    jsr set_scsi_to_command_mode                                      ; 895c: 20 87 80     ..
    lda lc216                                                         ; 895f: ad 16 c2    ...
    sta l00b2                                                         ; 8962: 85 b2       ..
    lda lc217                                                         ; 8964: ad 17 c2    ...
    sta l00b3                                                         ; 8967: 85 b3       ..
    lda lc218                                                         ; 8969: ad 18 c2    ...
    cmp #&fe                                                          ; 896c: c9 fe       ..
    bcc c8976                                                         ; 896e: 90 06       ..
    lda lc219                                                         ; 8970: ad 19 c2    ...
    inc a                                                             ; 8973: 1a          .
    beq c8979                                                         ; 8974: f0 03       ..
; &8976 referenced 1 time by &896e
.c8976
    jsr claim_tube                                                    ; 8976: 20 25 80     %.
; &8979 referenced 1 time by &8974
.c8979
    lda lc21e                                                         ; 8979: ad 1e c2    ...
    tax                                                               ; 897c: aa          .
    lda #1                                                            ; 897d: a9 01       ..
    sta lc21e                                                         ; 897f: 8d 1e c2    ...
    ldy #0                                                            ; 8982: a0 00       ..
; &8984 referenced 1 time by &898d
.loop_c8984
    lda lc21a,y                                                       ; 8984: b9 1a c2    ...
    jsr sub_c82f7                                                     ; 8987: 20 f7 82     ..
    iny                                                               ; 898a: c8          .
    cpy #6                                                            ; 898b: c0 06       ..
    bne loop_c8984                                                    ; 898d: d0 f5       ..
    bit tube_used_zp                                                  ; 898f: 24 cd       $.
    bvc c899e                                                         ; 8991: 50 0b       P.
    phx                                                               ; 8993: da          .
    ldx #&27 ; '''                                                    ; 8994: a2 27       .'
    ldy #&c2                                                          ; 8996: a0 c2       ..
    lda #1                                                            ; 8998: a9 01       ..
    jsr l0406                                                         ; 899a: 20 06 04     ..
    plx                                                               ; 899d: fa          .
; &899e referenced 1 time by &8991
.c899e
    ldy #0                                                            ; 899e: a0 00       ..
    jsr wait_for_scsi_REQ                                             ; 89a0: 20 ea 82     ..
    bmi c89c1                                                         ; 89a3: 30 1c       0.
; &89a5 referenced 1 time by &89bf
.loop_c89a5
    jsr wait_for_scsi_REQ                                             ; 89a5: 20 ea 82     ..
    lda scsi_data                                                     ; 89a8: ad 80 fe    ...
    cpx #0                                                            ; 89ab: e0 00       ..
    beq c89be                                                         ; 89ad: f0 0f       ..
    bit tube_used_zp                                                  ; 89af: 24 cd       $.
    bvc c89bb                                                         ; 89b1: 50 08       P.
    jsr sub_c81cb                                                     ; 89b3: 20 cb 81     ..
    sta tube_host_r3_data                                             ; 89b6: 8d e5 fe    ...
    bvs c89bd                                                         ; 89b9: 70 02       p.
; &89bb referenced 1 time by &89b1
.c89bb
    sta (l00b2),y                                                     ; 89bb: 91 b2       ..
; &89bd referenced 1 time by &89b9
.c89bd
    dex                                                               ; 89bd: ca          .
; &89be referenced 1 time by &89ad
.c89be
    iny                                                               ; 89be: c8          .
    bne loop_c89a5                                                    ; 89bf: d0 e4       ..
; &89c1 referenced 1 time by &89a3
.c89c1
    jmp c8158                                                         ; 89c1: 4c 58 81    LX.

; &89c4 referenced 4 times by &8a16, &99c5, &99d8, &9a2e
.sub_c89c4
    jsr sub_c86bb                                                     ; 89c4: 20 bb 86     ..
    beq c89d0                                                         ; 89c7: f0 07       ..
    bne c89d8                                                         ; 89c9: d0 0d       ..
; &89cb referenced 1 time by &89d4
.loop_c89cb
    jsr c87af                                                         ; 89cb: 20 af 87     ..
    bne c89d8                                                         ; 89ce: d0 08       ..
; &89d0 referenced 1 time by &89c7
.c89d0
    ldy #3                                                            ; 89d0: a0 03       ..
    lda (l00b6),y                                                     ; 89d2: b1 b6       ..
    bmi loop_c89cb                                                    ; 89d4: 30 f5       0.
; &89d6 referenced 1 time by &89ff
.c89d6
    lda #0                                                            ; 89d6: a9 00       ..
; &89d8 referenced 3 times by &89c9, &89ce, &89f9
.c89d8
    rts                                                               ; 89d8: 60          `

; &89d9 referenced 2 times by &8a19, &8ea2
.c89d9
    ldy #0                                                            ; 89d9: a0 00       ..
    lda (l00b4),y                                                     ; 89db: b1 b4       ..
    cmp #&5e ; '^'                                                    ; 89dd: c9 5e       .^
    bne c89e4                                                         ; 89df: d0 03       ..
; &89e1 referenced 1 time by &89e6
.loop_c89e1
    jmp c85ab                                                         ; 89e1: 4c ab 85    L..

; &89e4 referenced 1 time by &89df
.c89e4
    cmp #&40 ; '@'                                                    ; 89e4: c9 40       .@
    beq loop_c89e1                                                    ; 89e6: f0 f9       ..
; &89e8 referenced 2 times by &826d, &8e45
.c89e8
    jsr generate_error_inline                                         ; 89e8: 20 26 83     &.
    equs &d6, "Not found", 0                                          ; 89eb: d6 4e 6f... .No

    jsr sub_c8b5f                                                     ; 89f6: 20 5f 8b     _.
    bne c89d8                                                         ; 89f9: d0 dd       ..
    ldy #4                                                            ; 89fb: a0 04       ..
    lda (l00b6),y                                                     ; 89fd: b1 b6       ..
    bpl c89d6                                                         ; 89ff: 10 d5       ..
; &8a01 referenced 3 times by &8a1f, &9a3b, &a0e2
.c8a01
    jsr generate_error_inline                                         ; 8a01: 20 26 83     &.
    equs &bd, "Access violation", 0                                   ; 8a04: bd 41 63... .Ac

.sub_c8a16
    jsr sub_c89c4                                                     ; 8a16: 20 c4 89     ..
    bne c89d9                                                         ; 8a19: d0 be       ..
    ldy #0                                                            ; 8a1b: a0 00       ..
    lda (l00b6),y                                                     ; 8a1d: b1 b6       ..
    bpl c8a01                                                         ; 8a1f: 10 e0       ..
; &8a21 referenced 1 time by &9a3e
.sub_c8a21
    ldy #6                                                            ; 8a21: a0 06       ..
    lda (l00b8),y                                                     ; 8a23: b1 b8       ..
    bne c8a34                                                         ; 8a25: d0 0d       ..
    dey                                                               ; 8a27: 88          .
; &8a28 referenced 1 time by &8a30
.loop_c8a28
    lda (l00b8),y                                                     ; 8a28: b1 b8       ..
    sta lc214,y                                                       ; 8a2a: 99 14 c2    ...
    dey                                                               ; 8a2d: 88          .
    cpy #1                                                            ; 8a2e: c0 01       ..
    bne loop_c8a28                                                    ; 8a30: d0 f6       ..
    beq c8a41                                                         ; 8a32: f0 0d       ..
; &8a34 referenced 1 time by &8a25
.c8a34
    ldx #4                                                            ; 8a34: a2 04       ..
    ldy #&0d                                                          ; 8a36: a0 0d       ..
; &8a38 referenced 1 time by &8a3f
.loop_c8a38
    lda (l00b6),y                                                     ; 8a38: b1 b6       ..
    sta lc215,x                                                       ; 8a3a: 9d 15 c2    ...
    dey                                                               ; 8a3d: 88          .
    dex                                                               ; 8a3e: ca          .
    bne loop_c8a38                                                    ; 8a3f: d0 f7       ..
; &8a41 referenced 1 time by &8a32
.c8a41
    lda #1                                                            ; 8a41: a9 01       ..
    sta lc215                                                         ; 8a43: 8d 15 c2    ...
    lda #8                                                            ; 8a46: a9 08       ..
    sta lc21a                                                         ; 8a48: 8d 1a c2    ...
    lda #0                                                            ; 8a4b: a9 00       ..
    sta lc21f                                                         ; 8a4d: 8d 1f c2    ...
    ldy #&16                                                          ; 8a50: a0 16       ..
    ldx #3                                                            ; 8a52: a2 03       ..
; &8a54 referenced 1 time by &8a5b
.loop_c8a54
    lda (l00b6),y                                                     ; 8a54: b1 b6       ..
    sta lc21a,x                                                       ; 8a56: 9d 1a c2    ...
    iny                                                               ; 8a59: c8          .
    dex                                                               ; 8a5a: ca          .
    bne loop_c8a54                                                    ; 8a5b: d0 f7       ..
    ldy #&15                                                          ; 8a5d: a0 15       ..
    ldx #4                                                            ; 8a5f: a2 04       ..
; &8a61 referenced 1 time by &8a68
.loop_c8a61
    lda (l00b6),y                                                     ; 8a61: b1 b6       ..
    sta lc21f,x                                                       ; 8a63: 9d 1f c2    ...
    dey                                                               ; 8a66: 88          .
    dex                                                               ; 8a67: ca          .
    bne loop_c8a61                                                    ; 8a68: d0 f7       ..
    jsr sub_c8876                                                     ; 8a6a: 20 76 88     v.
    jsr sub_c8a73                                                     ; 8a6d: 20 73 8a     s.
    jmp c880a                                                         ; 8a70: 4c 0a 88    L..

; &8a73 referenced 1 time by &8a6d
.sub_c8a73
    jsr sub_c8eb0                                                     ; 8a73: 20 b0 8e     ..
; &8a76 referenced 1 time by &8ad4
.sub_c8a76
    ldy #&15                                                          ; 8a76: a0 15       ..
    ldx #&0b                                                          ; 8a78: a2 0b       ..
; &8a7a referenced 1 time by &8a81
.loop_c8a7a
    lda (l00b6),y                                                     ; 8a7a: b1 b6       ..
    sta lc215,x                                                       ; 8a7c: 9d 15 c2    ...
    dey                                                               ; 8a7f: 88          .
    dex                                                               ; 8a80: ca          .
    bpl loop_c8a7a                                                    ; 8a81: 10 f7       ..
    ldy #&0d                                                          ; 8a83: a0 0d       ..
    ldx #&0b                                                          ; 8a85: a2 0b       ..
; &8a87 referenced 1 time by &8a8e
.loop_c8a87
    lda lc215,x                                                       ; 8a87: bd 15 c2    ...
    sta (l00b8),y                                                     ; 8a8a: 91 b8       ..
    dey                                                               ; 8a8c: 88          .
    dex                                                               ; 8a8d: ca          .
    bpl loop_c8a87                                                    ; 8a8e: 10 f7       ..
    lda #0                                                            ; 8a90: a9 00       ..
    sta lc22b                                                         ; 8a92: 8d 2b c2    .+.
    ldy #2                                                            ; 8a95: a0 02       ..
; &8a97 referenced 1 time by &8a9e
.loop_c8a97
    lda (l00b6),y                                                     ; 8a97: b1 b6       ..
    asl a                                                             ; 8a99: 0a          .
    rol lc22b                                                         ; 8a9a: 2e 2b c2    .+.
    dey                                                               ; 8a9d: 88          .
    bpl loop_c8a97                                                    ; 8a9e: 10 f7       ..
    lda lc22b                                                         ; 8aa0: ad 2b c2    .+.
    ror a                                                             ; 8aa3: 6a          j
    ror a                                                             ; 8aa4: 6a          j
    ror a                                                             ; 8aa5: 6a          j
    php                                                               ; 8aa6: 08          .
    lsr a                                                             ; 8aa7: 4a          J
    plp                                                               ; 8aa8: 28          (
    ror a                                                             ; 8aa9: 6a          j
    sta lc22b                                                         ; 8aaa: 8d 2b c2    .+.
    lsr a                                                             ; 8aad: 4a          J
    lsr a                                                             ; 8aae: 4a          J
    lsr a                                                             ; 8aaf: 4a          J
    lsr a                                                             ; 8ab0: 4a          J
    ora lc22b                                                         ; 8ab1: 0d 2b c2    .+.
    ldy #&0e                                                          ; 8ab4: a0 0e       ..
    sta (l00b8),y                                                     ; 8ab6: 91 b8       ..
    rts                                                               ; 8ab8: 60          `

.sub_c8ab9
    ldy #0                                                            ; 8ab9: a0 00       ..
    lda (l00b8),y                                                     ; 8abb: b1 b8       ..
    sta l00b4                                                         ; 8abd: 85 b4       ..
    iny                                                               ; 8abf: c8          .
    lda (l00b8),y                                                     ; 8ac0: b1 b8       ..
    sta l00b5                                                         ; 8ac2: 85 b5       ..
    jsr sub_c8b5f                                                     ; 8ac4: 20 5f 8b     _.
    bne c8ad7                                                         ; 8ac7: d0 0e       ..
    ldy #4                                                            ; 8ac9: a0 04       ..
    lda (l00b6),y                                                     ; 8acb: b1 b6       ..
    bpl c8ad4                                                         ; 8acd: 10 05       ..
    lda #&ff                                                          ; 8acf: a9 ff       ..
    jmp c880d                                                         ; 8ad1: 4c 0d 88    L..

; &8ad4 referenced 1 time by &8acd
.c8ad4
    jsr sub_c8a76                                                     ; 8ad4: 20 76 8a     v.
; &8ad7 referenced 1 time by &8ac7
.c8ad7
    jmp c880a                                                         ; 8ad7: 4c 0a 88    L..

; &8ada referenced 2 times by &8586, &8b29
.sub_c8ada
    ldy #0                                                            ; 8ada: a0 00       ..
    jsr sub_c858e                                                     ; 8adc: 20 8e 85     ..
    bne c8ae6                                                         ; 8adf: d0 05       ..
    cmp #&2e ; '.'                                                    ; 8ae1: c9 2e       ..
    beq c8b47                                                         ; 8ae3: f0 62       .b
    rts                                                               ; 8ae5: 60          `

; &8ae6 referenced 1 time by &8adf
.c8ae6
    cmp #&3a ; ':'                                                    ; 8ae6: c9 3a       .:
    bne c8af9                                                         ; 8ae8: d0 0f       ..
    iny                                                               ; 8aea: c8          .
; &8aeb referenced 1 time by &8afd
.loop_c8aeb
    iny                                                               ; 8aeb: c8          .
    jsr sub_c858e                                                     ; 8aec: 20 8e 85     ..
    bne c8b47                                                         ; 8aef: d0 56       .V
    cmp #&2e ; '.'                                                    ; 8af1: c9 2e       ..
    bne c8b41                                                         ; 8af3: d0 4c       .L
    iny                                                               ; 8af5: c8          .
    jsr sub_c8b42                                                     ; 8af6: 20 42 8b     B.
; &8af9 referenced 1 time by &8ae8
.c8af9
    and #&fd                                                          ; 8af9: 29 fd       ).
    cmp #&24 ; '$'                                                    ; 8afb: c9 24       .$
    beq loop_c8aeb                                                    ; 8afd: f0 ec       ..
; &8aff referenced 1 time by &8b15
.loop_c8aff
    jsr sub_c8b42                                                     ; 8aff: 20 42 8b     B.
    cmp #&5e ; '^'                                                    ; 8b02: c9 5e       .^
    beq c8b0a                                                         ; 8b04: f0 04       ..
    cmp #&40 ; '@'                                                    ; 8b06: c9 40       .@
    bne c8b17                                                         ; 8b08: d0 0d       ..
; &8b0a referenced 1 time by &8b04
.c8b0a
    iny                                                               ; 8b0a: c8          .
    jsr sub_c858e                                                     ; 8b0b: 20 8e 85     ..
    bne c8b47                                                         ; 8b0e: d0 37       .7
; &8b10 referenced 1 time by &8b1a
.loop_c8b10
    cmp #&2e ; '.'                                                    ; 8b10: c9 2e       ..
    bne c8b41                                                         ; 8b12: d0 2d       .-
    iny                                                               ; 8b14: c8          .
    bra loop_c8aff                                                    ; 8b15: 80 e8       ..
; &8b17 referenced 2 times by &8b08, &8b27
.c8b17
    jsr sub_c858e                                                     ; 8b17: 20 8e 85     ..
    beq loop_c8b10                                                    ; 8b1a: f0 f4       ..
    ldx #5                                                            ; 8b1c: a2 05       ..
; &8b1e referenced 1 time by &8b24
.loop_c8b1e
    cmp l8b59,x                                                       ; 8b1e: dd 59 8b    .Y.
    beq c8b47                                                         ; 8b21: f0 24       .$
    dex                                                               ; 8b23: ca          .
    bpl loop_c8b1e                                                    ; 8b24: 10 f8       ..
    iny                                                               ; 8b26: c8          .
    bne c8b17                                                         ; 8b27: d0 ee       ..
    jsr sub_c8ada                                                     ; 8b29: 20 da 8a     ..
; &8b2c referenced 1 time by &8b3f
.loop_c8b2c
    lda (l00b4),y                                                     ; 8b2c: b1 b4       ..
    and #&7f                                                          ; 8b2e: 29 7f       ).
    cmp #&2a ; '*'                                                    ; 8b30: c9 2a       .*
    beq c8b4a                                                         ; 8b32: f0 16       ..
    cmp #&23 ; '#'                                                    ; 8b34: c9 23       .#
    beq c8b4a                                                         ; 8b36: f0 12       ..
    cmp #&2e ; '.'                                                    ; 8b38: c9 2e       ..
    beq c8b41                                                         ; 8b3a: f0 05       ..
    dey                                                               ; 8b3c: 88          .
    cpy #&ff                                                          ; 8b3d: c0 ff       ..
    bne loop_c8b2c                                                    ; 8b3f: d0 eb       ..
; &8b41 referenced 4 times by &8af3, &8b12, &8b3a, &8b45
.c8b41
    rts                                                               ; 8b41: 60          `

; &8b42 referenced 2 times by &8af6, &8aff
.sub_c8b42
    jsr sub_c858e                                                     ; 8b42: 20 8e 85     ..
    bne c8b41                                                         ; 8b45: d0 fa       ..
; &8b47 referenced 4 times by &8ae3, &8aef, &8b0e, &8b21
.c8b47
    jmp c85ab                                                         ; 8b47: 4c ab 85    L..

; &8b4a referenced 2 times by &8b32, &8b36
.c8b4a
    jsr generate_error_inline                                         ; 8b4a: 20 26 83     &.
    equs &fd, "Wild cards", 0                                         ; 8b4d: fd 57 69... .Wi
; &8b59 referenced 1 time by &8b1e
.l8b59
    equb &7f                                                          ; 8b59: 7f          .
    equs "^@:$&"                                                      ; 8b5a: 5e 40 3a... ^@:

; &8b5f referenced 5 times by &89f6, &8ac4, &8e9d, &9276, &a09d
.sub_c8b5f
    jsr sub_c86bb                                                     ; 8b5f: 20 bb 86     ..
    php                                                               ; 8b62: 08          .
    pha                                                               ; 8b63: 48          H
    jsr sub_c8b6a                                                     ; 8b64: 20 6a 8b     j.
    pla                                                               ; 8b67: 68          h
    plp                                                               ; 8b68: 28          (
; &8b69 referenced 3 times by &8b78, &8b8c, &8ba8
.c8b69
    rts                                                               ; 8b69: 60          `

; &8b6a referenced 2 times by &8b64, &9bac
.sub_c8b6a
    jsr sub_c8b89                                                     ; 8b6a: 20 89 8b     ..
    jsr sub_c8bdc                                                     ; 8b6d: 20 dc 8b     ..
    cmp lc1ff                                                         ; 8b70: cd ff c1    ...
    bne c8b7a                                                         ; 8b73: d0 05       ..
    cpx lc0ff                                                         ; 8b75: ec ff c0    ...
    beq c8b69                                                         ; 8b78: f0 ef       ..
; &8b7a referenced 7 times by &8b73, &8b97, &8b9a, &8ba1, &8bba, &8bc5, &8bca
.c8b7a
    jsr generate_error_inline2                                        ; 8b7a: 20 09 83     ..
    equs &a9, "Bad FS map", 0                                         ; 8b7d: a9 42 61... .Ba

; &8b89 referenced 1 time by &8b6a
.sub_c8b89
    ldx lc1fe                                                         ; 8b89: ae fe c1    ...
    beq c8b69                                                         ; 8b8c: f0 db       ..
    lda #0                                                            ; 8b8e: a9 00       ..
; &8b90 referenced 1 time by &8b9d
.loop_c8b90
    ora lbfff,x                                                       ; 8b90: 1d ff bf    ...
    ora lc0ff,x                                                       ; 8b93: 1d ff c0    ...
    dex                                                               ; 8b96: ca          .
    beq c8b7a                                                         ; 8b97: f0 e1       ..
    dex                                                               ; 8b99: ca          .
    beq c8b7a                                                         ; 8b9a: f0 de       ..
    dex                                                               ; 8b9c: ca          .
    bne loop_c8b90                                                    ; 8b9d: d0 f1       ..
    and #&e0                                                          ; 8b9f: 29 e0       ).
    bne c8b7a                                                         ; 8ba1: d0 d7       ..
    ldx lc1fe                                                         ; 8ba3: ae fe c1    ...
    cpx #6                                                            ; 8ba6: e0 06       ..
    bcc c8b69                                                         ; 8ba8: 90 bf       ..
    ldx #3                                                            ; 8baa: a2 03       ..
; &8bac referenced 1 time by &8bd9
.c8bac
    ldy #2                                                            ; 8bac: a0 02       ..
    clc                                                               ; 8bae: 18          .
; &8baf referenced 1 time by &8bb8
.loop_c8baf
    lda lbffd,x                                                       ; 8baf: bd fd bf    ...
    adc lc0fd,x                                                       ; 8bb2: 7d fd c0    }..
    pha                                                               ; 8bb5: 48          H
    inx                                                               ; 8bb6: e8          .
    dey                                                               ; 8bb7: 88          .
    bpl loop_c8baf                                                    ; 8bb8: 10 f5       ..
    bcs c8b7a                                                         ; 8bba: b0 be       ..
    ldy #2                                                            ; 8bbc: a0 02       ..
; &8bbe referenced 1 time by &8bc8
.loop_c8bbe
    pla                                                               ; 8bbe: 68          h
    dex                                                               ; 8bbf: ca          .
    cmp pydis_end,x                                                   ; 8bc0: dd 00 c0    ...
    bcc c8bcc                                                         ; 8bc3: 90 07       ..
    bne c8b7a                                                         ; 8bc5: d0 b3       ..
    dey                                                               ; 8bc7: 88          .
    bpl loop_c8bbe                                                    ; 8bc8: 10 f4       ..
    bmi c8b7a                                                         ; 8bca: 30 ae       0.
; &8bcc referenced 2 times by &8bc3, &8bcf
.c8bcc
    pla                                                               ; 8bcc: 68          h
    dex                                                               ; 8bcd: ca          .
    dey                                                               ; 8bce: 88          .
    bpl c8bcc                                                         ; 8bcf: 10 fb       ..
    pha                                                               ; 8bd1: 48          H
    inx                                                               ; 8bd2: e8          .
    inx                                                               ; 8bd3: e8          .
    inx                                                               ; 8bd4: e8          .
    inx                                                               ; 8bd5: e8          .
    cpx lc1fe                                                         ; 8bd6: ec fe c1    ...
    bcc c8bac                                                         ; 8bd9: 90 d1       ..
    rts                                                               ; 8bdb: 60          `

; &8bdc referenced 1 time by &8b6d
.sub_c8bdc
    clc                                                               ; 8bdc: 18          .
    ldy #&ff                                                          ; 8bdd: a0 ff       ..
    tya                                                               ; 8bdf: 98          .
; &8be0 referenced 1 time by &8be4
.loop_c8be0
    adc lbfff,y                                                       ; 8be0: 79 ff bf    y..
    dey                                                               ; 8be3: 88          .
    bne loop_c8be0                                                    ; 8be4: d0 fa       ..
    tax                                                               ; 8be6: aa          .
    dey                                                               ; 8be7: 88          .
    tya                                                               ; 8be8: 98          .
    clc                                                               ; 8be9: 18          .
; &8bea referenced 1 time by &8bee
.loop_c8bea
    adc lc0ff,y                                                       ; 8bea: 79 ff c0    y..
    dey                                                               ; 8bed: 88          .
    bne loop_c8bea                                                    ; 8bee: d0 fa       ..
    rts                                                               ; 8bf0: 60          `

.vector1
    stx l00b8                                                         ; 8bf1: 86 b8       ..
    sty l00b9                                                         ; 8bf3: 84 b9       ..
    tay                                                               ; 8bf5: a8          .
    ldx #0                                                            ; 8bf6: a2 00       ..
    stx lc2d5                                                         ; 8bf8: 8e d5 c2    ...
    asl a                                                             ; 8bfb: 0a          .
    tax                                                               ; 8bfc: aa          .
    inx                                                               ; 8bfd: e8          .
    inx                                                               ; 8bfe: e8          .
    bmi c8c1f                                                         ; 8bff: 30 1e       0.
    cpx #&12                                                          ; 8c01: e0 12       ..
    bcs c8c1f                                                         ; 8c03: b0 1a       ..
    lda l8c20+1,x                                                     ; 8c05: bd 21 8c    .!.
    bne c8c0d                                                         ; 8c08: d0 03       ..
    jmp c82c3                                                         ; 8c0a: 4c c3 82    L..

; &8c0d referenced 1 time by &8c08
.c8c0d
    pha                                                               ; 8c0d: 48          H
    lda l8c20,x                                                       ; 8c0e: bd 20 8c    . .
    pha                                                               ; 8c11: 48          H
    phy                                                               ; 8c12: 5a          Z
    ldy #0                                                            ; 8c13: a0 00       ..
    lda (l00b8),y                                                     ; 8c15: b1 b8       ..
    sta l00b4                                                         ; 8c17: 85 b4       ..
    iny                                                               ; 8c19: c8          .
    lda (l00b8),y                                                     ; 8c1a: b1 b8       ..
    sta l00b5                                                         ; 8c1c: 85 b5       ..
    pla                                                               ; 8c1e: 68          h
; &8c1f referenced 2 times by &8bff, &8c03
.c8c1f
    rts                                                               ; 8c1f: 60          `

; &8c20 referenced 1 time by &8c0e
.l8c20
    equw sub_c8a16-1                                                  ; 8c20: 15 8a       ..
; &8c21 referenced 1 time by &8c05
    equw l0001-1                                                      ; 8c22: 00 00       ..
    equw l0001-1                                                      ; 8c24: 00 00       ..
    equw l0001-1                                                      ; 8c26: 00 00       ..
    equw l0001-1                                                      ; 8c28: 00 00       ..
    equw l0001-1                                                      ; 8c2a: 00 00       ..
    equw sub_c8ab9-1                                                  ; 8c2c: b8 8a       ..
    equw l0001-1                                                      ; 8c2e: 00 00       ..
    equw l0001-1                                                      ; 8c30: 00 00       ..

; &8c32 referenced 2 times by &95bc, &95c2
.sub_c8c32
    tax                                                               ; 8c32: aa          .
    lda #>string_list_spec                                            ; 8c33: a9 96       ..
    sta l00b7                                                         ; 8c35: 85 b7       ..
    lda string_spec_list_pointers,x                                   ; 8c37: bd ce 95    ...
    sta l00b6                                                         ; 8c3a: 85 b6       ..
    ldx #&0c                                                          ; 8c3c: a2 0c       ..
; &8c3e referenced 6 times by &8c96, &8ced, &8d1c, &8d42, &8d59, &8d73
.sub_c8c3e
    ldy #0                                                            ; 8c3e: a0 00       ..
; &8c40 referenced 1 time by &8c4d
.loop_c8c40
    lda (l00b6),y                                                     ; 8c40: b1 b6       ..
    and #&7f                                                          ; 8c42: 29 7f       ).
    cmp #&20 ; ' '                                                    ; 8c44: c9 20       .
    bcc print_X_spaces                                                ; 8c46: 90 08       ..
    jsr sub_c8c7a                                                     ; 8c48: 20 7a 8c     z.
    iny                                                               ; 8c4b: c8          .
    dex                                                               ; 8c4c: ca          .
    bne loop_c8c40                                                    ; 8c4d: d0 f1       ..
    rts                                                               ; 8c4f: 60          `

; &8c50 referenced 2 times by &8c46, &8c54
.print_X_spaces
    jsr print_space                                                   ; 8c50: 20 22 97     ".
    dex                                                               ; 8c53: ca          .
    bne print_X_spaces                                                ; 8c54: d0 fa       ..
    rts                                                               ; 8c56: 60          `

; &8c57 referenced 17 times by &8cf0, &8cfb, &8d1f, &8d2f, &8d45, &8d5c, &8d76, &9190, &9512, &9534, &959a, &9755, &9775, &977e, &97ab, &98f0, &995f
.print_string
    pla                                                               ; 8c57: 68          h
    sta l00b6                                                         ; 8c58: 85 b6       ..
    pla                                                               ; 8c5a: 68          h
    sta l00b7                                                         ; 8c5b: 85 b7       ..
    ldy #1                                                            ; 8c5d: a0 01       ..
; &8c5f referenced 1 time by &8c67
.loop_c8c5f
    lda (l00b6),y                                                     ; 8c5f: b1 b6       ..
    bmi c8c69                                                         ; 8c61: 30 06       0.
    jsr sub_c8c7a                                                     ; 8c63: 20 7a 8c     z.
    iny                                                               ; 8c66: c8          .
    bne loop_c8c5f                                                    ; 8c67: d0 f6       ..
; &8c69 referenced 1 time by &8c61
.c8c69
    and #&7f                                                          ; 8c69: 29 7f       ).
    jsr sub_c8c7a                                                     ; 8c6b: 20 7a 8c     z.
    tya                                                               ; 8c6e: 98          .
    clc                                                               ; 8c6f: 18          .
    adc l00b6                                                         ; 8c70: 65 b6       e.
    tay                                                               ; 8c72: a8          .
    lda #0                                                            ; 8c73: a9 00       ..
    adc l00b7                                                         ; 8c75: 65 b7       e.
    pha                                                               ; 8c77: 48          H
    phy                                                               ; 8c78: 5a          Z
    rts                                                               ; 8c79: 60          `

; &8c7a referenced 4 times by &8c48, &8c63, &8c6b, &ab4d
.sub_c8c7a
    pha                                                               ; 8c7a: 48          H
    txa                                                               ; 8c7b: 8a          .
    pha                                                               ; 8c7c: 48          H
    lda l00b6                                                         ; 8c7d: a5 b6       ..
    pha                                                               ; 8c7f: 48          H
    lda l00b7                                                         ; 8c80: a5 b7       ..
    pha                                                               ; 8c82: 48          H
    tsx                                                               ; 8c83: ba          .
    lda l0104,x                                                       ; 8c84: bd 04 01    ...
    jsr print_char                                                    ; 8c87: 20 28 97     (.
    pla                                                               ; 8c8a: 68          h
    sta l00b7                                                         ; 8c8b: 85 b7       ..
    pla                                                               ; 8c8d: 68          h
    sta l00b6                                                         ; 8c8e: 85 b6       ..
    pla                                                               ; 8c90: 68          h
    tax                                                               ; 8c91: aa          .
    pla                                                               ; 8c92: 68          h
    rts                                                               ; 8c93: 60          `

; &8c94 referenced 2 times by &8d98, &8eb7
.sub_c8c94
    ldx #&0a                                                          ; 8c94: a2 0a       ..
    jsr sub_c8c3e                                                     ; 8c96: 20 3e 8c     >.
    jsr print_space                                                   ; 8c99: 20 22 97     ".
    ldy #4                                                            ; 8c9c: a0 04       ..
    ldx #3                                                            ; 8c9e: a2 03       ..
; &8ca0 referenced 1 time by &8cad
.loop_c8ca0
    lda (l00b6),y                                                     ; 8ca0: b1 b6       ..
    rol a                                                             ; 8ca2: 2a          *
    bcc c8cac                                                         ; 8ca3: 90 07       ..
    lda l8ccc,y                                                       ; 8ca5: b9 cc 8c    ...
    jsr print_char                                                    ; 8ca8: 20 28 97     (.
    dex                                                               ; 8cab: ca          .
; &8cac referenced 1 time by &8ca3
.c8cac
    dey                                                               ; 8cac: 88          .
    bpl loop_c8ca0                                                    ; 8cad: 10 f1       ..
; &8caf referenced 1 time by &8cb5
.loop_c8caf
    dex                                                               ; 8caf: ca          .
    bmi c8cb8                                                         ; 8cb0: 30 06       0.
    jsr print_space                                                   ; 8cb2: 20 22 97     ".
    jmp loop_c8caf                                                    ; 8cb5: 4c af 8c    L..

; &8cb8 referenced 1 time by &8cb0
.c8cb8
    lda #&28 ; '('                                                    ; 8cb8: a9 28       .(
    jsr print_char                                                    ; 8cba: 20 28 97     (.
    ldy #&19                                                          ; 8cbd: a0 19       ..
    lda (l00b6),y                                                     ; 8cbf: b1 b6       ..
    jsr hex_byte_print                                                ; 8cc1: 20 d1 8c     ..
    lda #&29 ; ')'                                                    ; 8cc4: a9 29       .)
    jsr print_char                                                    ; 8cc6: 20 28 97     (.
    jmp print_space                                                   ; 8cc9: 4c 22 97    L".

; &8ccc referenced 1 time by &8ca5
.l8ccc
    equs "RWLDE"                                                      ; 8ccc: 52 57 4c... RWL

; &8cd1 referenced 9 times by &8cc1, &8cf8, &8d2c, &8ed7, &97a5, &97bb, &98e1, &98e7, &98ed
.hex_byte_print
    pha                                                               ; 8cd1: 48          H
    lsr a                                                             ; 8cd2: 4a          J
    lsr a                                                             ; 8cd3: 4a          J
    lsr a                                                             ; 8cd4: 4a          J
    lsr a                                                             ; 8cd5: 4a          J
    jsr sub_c8cda                                                     ; 8cd6: 20 da 8c     ..
    pla                                                               ; 8cd9: 68          h
; &8cda referenced 1 time by &8cd6
.sub_c8cda
    jsr nibble_to_asciihexdigit                                       ; 8cda: 20 21 84     !.
    jmp print_char                                                    ; 8cdd: 4c 28 97    L(.

; &8ce0 referenced 2 times by &8d8a, &8dec
.sub_c8ce0
    jsr check_directory_for_Hugo                                      ; 8ce0: 20 38 9b     8.
    lda #&d9                                                          ; 8ce3: a9 d9       ..
    sta l00b6                                                         ; 8ce5: 85 b6       ..
    lda #&c8                                                          ; 8ce7: a9 c8       ..
    sta l00b7                                                         ; 8ce9: 85 b7       ..
    ldx #&13                                                          ; 8ceb: a2 13       ..
    jsr sub_c8c3e                                                     ; 8ced: 20 3e 8c     >.
    jsr print_string                                                  ; 8cf0: 20 57 8c     W.
    equs " ", &80+'('                                                 ; 8cf3: 20 a8        .

    lda lc8fa                                                         ; 8cf5: ad fa c8    ...
    jsr hex_byte_print                                                ; 8cf8: 20 d1 8c     ..
    jsr print_string                                                  ; 8cfb: 20 57 8c     W.
    equs ")", &0d, "Drive", &80+':'                                   ; 8cfe: 29 0d 44... ).D

    lda lc317                                                         ; 8d06: ad 17 c3    ...
    asl a                                                             ; 8d09: 0a          .
    rol a                                                             ; 8d0a: 2a          *
    rol a                                                             ; 8d0b: 2a          *
    rol a                                                             ; 8d0c: 2a          *
    adc #&30 ; '0'                                                    ; 8d0d: 69 30       i0
    jsr print_char                                                    ; 8d0f: 20 28 97     (.
    lda #<unknown_table1                                              ; 8d12: a9 42       .B
    sta l00b6                                                         ; 8d14: 85 b6       ..
    lda #>unknown_table1                                              ; 8d16: a9 8f       ..
    sta l00b7                                                         ; 8d18: 85 b7       ..
    ldx #&0d                                                          ; 8d1a: a2 0d       ..
    jsr sub_c8c3e                                                     ; 8d1c: 20 3e 8c     >.
    jsr print_string                                                  ; 8d1f: 20 57 8c     W.
    equs "Option", &80+' '                                            ; 8d22: 4f 70 74... Opt

    lda lc1fd                                                         ; 8d29: ad fd c1    ...
    jsr hex_byte_print                                                ; 8d2c: 20 d1 8c     ..
    jsr print_string                                                  ; 8d2f: 20 57 8c     W.
    equs " ", &80+'('                                                 ; 8d32: 20 a8        .

    ldx lc1fd                                                         ; 8d34: ae fd c1    ...
    lda opt4_string_table_pointer,x                                   ; 8d37: bd d5 8d    ...
    sta l00b6                                                         ; 8d3a: 85 b6       ..
    lda #>string_Off                                                  ; 8d3c: a9 8d       ..
    sta l00b7                                                         ; 8d3e: 85 b7       ..
    ldx #4                                                            ; 8d40: a2 04       ..
    jsr sub_c8c3e                                                     ; 8d42: 20 3e 8c     >.
    jsr print_string                                                  ; 8d45: 20 57 8c     W.
    equs ")", &0d, "Dir.", &80+' '                                    ; 8d48: 29 0d 44... ).D

    lda #0                                                            ; 8d4f: a9 00       ..
    sta l00b6                                                         ; 8d51: 85 b6       ..
    lda #&c3                                                          ; 8d53: a9 c3       ..
    sta l00b7                                                         ; 8d55: 85 b7       ..
    ldx #&0a                                                          ; 8d57: a2 0a       ..
    jsr sub_c8c3e                                                     ; 8d59: 20 3e 8c     >.
    jsr print_string                                                  ; 8d5c: 20 57 8c     W.
    equs "     Lib.", &80+' '                                         ; 8d5f: 20 20 20...

    lda #&0a                                                          ; 8d69: a9 0a       ..
    sta l00b6                                                         ; 8d6b: 85 b6       ..
    lda #&c3                                                          ; 8d6d: a9 c3       ..
    sta l00b7                                                         ; 8d6f: 85 b7       ..
    ldx #&0a                                                          ; 8d71: a2 0a       ..
    jsr sub_c8c3e                                                     ; 8d73: 20 3e 8c     >.
    jsr print_string                                                  ; 8d76: 20 57 8c     W.
    equs &0d, &80+&0d                                                 ; 8d79: 0d 8d       ..

; &8d7b referenced 1 time by &865a
.sub_c8d7b
    lda #5                                                            ; 8d7b: a9 05       ..
    sta l00b6                                                         ; 8d7d: 85 b6       ..
    lda #&c4                                                          ; 8d7f: a9 c4       ..
    sta l00b7                                                         ; 8d81: 85 b7       ..
    rts                                                               ; 8d83: 60          `

.sub_c8d84
    jsr sub_c9aef                                                     ; 8d84: 20 ef 9a     ..
    jsr sub_c8e27                                                     ; 8d87: 20 27 8e     '.
; &8d8a referenced 1 time by &9aa5
.sub_c8d8a
    jsr sub_c8ce0                                                     ; 8d8a: 20 e0 8c     ..
    lda #4                                                            ; 8d8d: a9 04       ..
    sta lc22b                                                         ; 8d8f: 8d 2b c2    .+.
; &8d92 referenced 2 times by &8db5, &8db9
.c8d92
    ldy #0                                                            ; 8d92: a0 00       ..
    lda (l00b6),y                                                     ; 8d94: b1 b6       ..
    beq c8dbb                                                         ; 8d96: f0 23       .#
    jsr sub_c8c94                                                     ; 8d98: 20 94 8c     ..
    dec lc22b                                                         ; 8d9b: ce 2b c2    .+.
    bne c8dab                                                         ; 8d9e: d0 0b       ..
    lda #4                                                            ; 8da0: a9 04       ..
    sta lc22b                                                         ; 8da2: 8d 2b c2    .+.
    jsr c9726                                                         ; 8da5: 20 26 97     &.
    jmp c8dae                                                         ; 8da8: 4c ae 8d    L..

; &8dab referenced 1 time by &8d9e
.c8dab
    jsr print_space                                                   ; 8dab: 20 22 97     ".
; &8dae referenced 1 time by &8da8
.c8dae
    clc                                                               ; 8dae: 18          .
    lda l00b6                                                         ; 8daf: a5 b6       ..
    adc #&1a                                                          ; 8db1: 69 1a       i.
    sta l00b6                                                         ; 8db3: 85 b6       ..
    bcc c8d92                                                         ; 8db5: 90 db       ..
    inc l00b7                                                         ; 8db7: e6 b7       ..
    bcs c8d92                                                         ; 8db9: b0 d7       ..
; &8dbb referenced 1 time by &8d96
.c8dbb
    lda lc22b                                                         ; 8dbb: ad 2b c2    .+.
    cmp #4                                                            ; 8dbe: c9 04       ..
    beq c8dd2                                                         ; 8dc0: f0 10       ..
    lda #osbyte_read_text_cursor_pos                                  ; 8dc2: a9 86       ..
    jsr osbyte                                                        ; 8dc4: 20 f4 ff     ..            ; Read input cursor position (Sets X=POS and Y=VPOS)
    txa                                                               ; 8dc7: 8a          .              ; X is the horizontal text position ('POS')
    bne c8dcf                                                         ; 8dc8: d0 05       ..
    lda #&0b                                                          ; 8dca: a9 0b       ..
    jsr print_char                                                    ; 8dcc: 20 28 97     (.
; &8dcf referenced 1 time by &8dc8
.c8dcf
    jsr c9726                                                         ; 8dcf: 20 26 97     &.
; &8dd2 referenced 2 times by &8dc0, &8df3
.c8dd2
    jmp c880d                                                         ; 8dd2: 4c 0d 88    L..

; &8dd5 referenced 1 time by &8d37
.opt4_string_table_pointer
    equb  <string_Off, <string_Load,  <string_Run, <string_Exec       ; 8dd5: d9 dd e1... ...
.string_Off
    equs "Off "                                                       ; 8dd9: 4f 66 66... Off
.string_Load
    equs "Load"                                                       ; 8ddd: 4c 6f 61... Loa
.string_Run
    equs "Run "                                                       ; 8de1: 52 75 6e... Run
.string_Exec
    equs "Exec"                                                       ; 8de5: 45 78 65... Exe

.sub_c8de9
    jsr sub_c8e27                                                     ; 8de9: 20 27 8e     '.
; &8dec referenced 1 time by &9ab1
.sub_c8dec
    jsr sub_c8ce0                                                     ; 8dec: 20 e0 8c     ..
; &8def referenced 2 times by &8dff, &8e03
.c8def
    ldy #0                                                            ; 8def: a0 00       ..
    lda (l00b6),y                                                     ; 8df1: b1 b6       ..
    beq c8dd2                                                         ; 8df3: f0 dd       ..
    jsr c8eb7                                                         ; 8df5: 20 b7 8e     ..
    clc                                                               ; 8df8: 18          .
    lda l00b6                                                         ; 8df9: a5 b6       ..
    adc #&1a                                                          ; 8dfb: 69 1a       i.
    sta l00b6                                                         ; 8dfd: 85 b6       ..
    bcc c8def                                                         ; 8dff: 90 ee       ..
    inc l00b7                                                         ; 8e01: e6 b7       ..
    bra c8def                                                         ; 8e03: 80 ea       ..
; &8e05 referenced 2 times by &8748, &8e48
.sub_c8e05
    ldy #0                                                            ; 8e05: a0 00       ..
    lda (l00b4),y                                                     ; 8e07: b1 b4       ..
    and #&7f                                                          ; 8e09: 29 7f       ).
    cmp #&5e ; '^'                                                    ; 8e0b: c9 5e       .^
    bne c8e19                                                         ; 8e0d: d0 0a       ..
    lda #&c0                                                          ; 8e0f: a9 c0       ..
    sta l00b6                                                         ; 8e11: 85 b6       ..
    lda #&c8                                                          ; 8e13: a9 c8       ..
    sta l00b7                                                         ; 8e15: 85 b7       ..
    bne c8e25                                                         ; 8e17: d0 0c       ..
; &8e19 referenced 1 time by &8e0d
.c8e19
    cmp #&40 ; '@'                                                    ; 8e19: c9 40       .@
    bne c8e26                                                         ; 8e1b: d0 09       ..
    lda #&fe                                                          ; 8e1d: a9 fe       ..
    sta l00b6                                                         ; 8e1f: 85 b6       ..
    lda #&c2                                                          ; 8e21: a9 c2       ..
    sta l00b7                                                         ; 8e23: 85 b7       ..
; &8e25 referenced 1 time by &8e17
.c8e25
    tya                                                               ; 8e25: 98          .
; &8e26 referenced 2 times by &8e1b, &8e33
.c8e26
    rts                                                               ; 8e26: 60          `

; &8e27 referenced 2 times by &8d87, &8de9
.sub_c8e27
    ldy #0                                                            ; 8e27: a0 00       ..
    lda (l00b4),y                                                     ; 8e29: b1 b4       ..
    cmp #&21 ; '!'                                                    ; 8e2b: c9 21       .!
    bcs c8e35                                                         ; 8e2d: b0 06       ..
    ldx lc317                                                         ; 8e2f: ae 17 c3    ...
    inx                                                               ; 8e32: e8          .
    bne c8e26                                                         ; 8e33: d0 f1       ..
; &8e35 referenced 3 times by &8e2d, &8ef5, &9a64
.c8e35
    jsr sub_c86c0                                                     ; 8e35: 20 c0 86     ..
    bne c8e48                                                         ; 8e38: d0 0e       ..
; &8e3a referenced 1 time by &8e43
.loop_c8e3a
    ldy #3                                                            ; 8e3a: a0 03       ..
    lda (l00b6),y                                                     ; 8e3c: b1 b6       ..
    bmi c8e4d                                                         ; 8e3e: 30 0d       0.
    jsr c87af                                                         ; 8e40: 20 af 87     ..
    beq loop_c8e3a                                                    ; 8e43: f0 f5       ..
; &8e45 referenced 1 time by &8e4b
.loop_c8e45
    jmp c89e8                                                         ; 8e45: 4c e8 89    L..

; &8e48 referenced 1 time by &8e38
.c8e48
    jsr sub_c8e05                                                     ; 8e48: 20 05 8e     ..
    bne loop_c8e45                                                    ; 8e4b: d0 f8       ..
; &8e4d referenced 1 time by &8e3e
.c8e4d
    ldy lc22e                                                         ; 8e4d: ac 2e c2    ...
    iny                                                               ; 8e50: c8          .
    bne c8e5e                                                         ; 8e51: d0 0b       ..
    ldy #2                                                            ; 8e53: a0 02       ..
; &8e55 referenced 1 time by &8e5c
.loop_c8e55
    lda lc314,y                                                       ; 8e55: b9 14 c3    ...
    sta lc22c,y                                                       ; 8e58: 99 2c c2    .,.
    dey                                                               ; 8e5b: 88          .
    bpl loop_c8e55                                                    ; 8e5c: 10 f7       ..
; &8e5e referenced 1 time by &8e51
.c8e5e
    ldx #&0a                                                          ; 8e5e: a2 0a       ..
; &8e60 referenced 1 time by &8e67
.loop_c8e60
    lda table3,x                                                      ; 8e60: bd 87 86    ...
    sta lc215,x                                                       ; 8e63: 9d 15 c2    ...
    dex                                                               ; 8e66: ca          .
    bpl loop_c8e60                                                    ; 8e67: 10 f7       ..
    ldx #2                                                            ; 8e69: a2 02       ..
    ldy #&16                                                          ; 8e6b: a0 16       ..
; &8e6d referenced 1 time by &8e77
.loop_c8e6d
    lda (l00b6),y                                                     ; 8e6d: b1 b6       ..
    sta lc21b,x                                                       ; 8e6f: 9d 1b c2    ...
    sta lc2fe,y                                                       ; 8e72: 99 fe c2    ...
    iny                                                               ; 8e75: c8          .
    dex                                                               ; 8e76: ca          .
    bpl loop_c8e6d                                                    ; 8e77: 10 f4       ..
    lda l00b7                                                         ; 8e79: a5 b7       ..
    cmp #>table1                                                      ; 8e7b: c9 8e       ..
    beq c8eb6                                                         ; 8e7d: f0 37       .7
    jmp c825d                                                         ; 8e7f: 4c 5d 82    L].

.table1
    equb &a4, &0d, &8d, &8d, &0d, &0d, &0d, &0d, &0d, &0d,   0,   0   ; 8e82: a4 0d 8d... ...
    equb   0,   0,   0,   0,   0,   0,   0,   5,   0,   0,   2,   0   ; 8e8e: 00 00 00... ...
    equb   0,   0,   0                                                ; 8e9a: 00 00 00    ...

.sub_c8e9d
    jsr sub_c8b5f                                                     ; 8e9d: 20 5f 8b     _.
    beq c8ea5                                                         ; 8ea0: f0 03       ..
    jmp c89d9                                                         ; 8ea2: 4c d9 89    L..

; &8ea5 referenced 2 times by &8ea0, &8eab
.c8ea5
    jsr c8eb7                                                         ; 8ea5: 20 b7 8e     ..
    jsr c87af                                                         ; 8ea8: 20 af 87     ..
    beq c8ea5                                                         ; 8eab: f0 f8       ..
    jmp c880d                                                         ; 8ead: 4c 0d 88    L..

; &8eb0 referenced 1 time by &8a73
.sub_c8eb0
    lda tube_used_zp                                                  ; 8eb0: a5 cd       ..
    and #4                                                            ; 8eb2: 29 04       ).
    bne c8eb7                                                         ; 8eb4: d0 01       ..
; &8eb6 referenced 1 time by &8e7d
.c8eb6
    rts                                                               ; 8eb6: 60          `

; &8eb7 referenced 3 times by &8df5, &8ea5, &8eb4
.c8eb7
    jsr sub_c8c94                                                     ; 8eb7: 20 94 8c     ..
    jsr print_char                                                    ; 8eba: 20 28 97     (.
    ldy #4                                                            ; 8ebd: a0 04       ..
    lda (l00b6),y                                                     ; 8ebf: b1 b6       ..
    bmi c8ef2                                                         ; 8ec1: 30 2f       0/
    dey                                                               ; 8ec3: 88          .
    lda (l00b6),y                                                     ; 8ec4: b1 b6       ..
    rol a                                                             ; 8ec6: 2a          *
    ldx #&0a                                                          ; 8ec7: a2 0a       ..
    ldy #&0d                                                          ; 8ec9: a0 0d       ..
    bcc c8ed1                                                         ; 8ecb: 90 04       ..
    ldx #&17                                                          ; 8ecd: a2 17       ..
    ldy #&18                                                          ; 8ecf: a0 18       ..
; &8ed1 referenced 2 times by &8ecb, &8ef0
.c8ed1
    cpx #&16                                                          ; 8ed1: e0 16       ..
    beq c8eda                                                         ; 8ed3: f0 05       ..
    lda (l00b6),y                                                     ; 8ed5: b1 b6       ..
    jsr hex_byte_print                                                ; 8ed7: 20 d1 8c     ..
; &8eda referenced 1 time by &8ed3
.c8eda
    txa                                                               ; 8eda: 8a          .
    and #3                                                            ; 8edb: 29 03       ).
    cmp #1                                                            ; 8edd: c9 01       ..
    bne c8eec                                                         ; 8edf: d0 0b       ..
    jsr print_space                                                   ; 8ee1: 20 22 97     ".
    jsr print_space                                                   ; 8ee4: 20 22 97     ".
    txa                                                               ; 8ee7: 8a          .
    clc                                                               ; 8ee8: 18          .
    adc #5                                                            ; 8ee9: 69 05       i.
    tay                                                               ; 8eeb: a8          .
; &8eec referenced 1 time by &8edf
.c8eec
    dey                                                               ; 8eec: 88          .
    inx                                                               ; 8eed: e8          .
    cpx #&1a                                                          ; 8eee: e0 1a       ..
    bne c8ed1                                                         ; 8ef0: d0 df       ..
; &8ef2 referenced 1 time by &8ec1
.c8ef2
    jmp c9726                                                         ; 8ef2: 4c 26 97    L&.

; &8ef5 referenced 1 time by &988e
.DIR_command
    jsr c8e35                                                         ; 8ef5: 20 35 8e     5.
    ldy #9                                                            ; 8ef8: a0 09       ..
; &8efa referenced 1 time by &8f01
.loop_c8efa
    lda lc8cc,y                                                       ; 8efa: b9 cc c8    ...
    sta lc300,y                                                       ; 8efd: 99 00 c3    ...
    dey                                                               ; 8f00: 88          .
    bpl loop_c8efa                                                    ; 8f01: 10 f7       ..
    lda lc22f                                                         ; 8f03: ad 2f c2    ./.
    cmp #&ff                                                          ; 8f06: c9 ff       ..
    bne c8f0d                                                         ; 8f08: d0 03       ..
    lda lc317                                                         ; 8f0a: ad 17 c3    ...
; &8f0d referenced 1 time by &8f08
.c8f0d
    sta lc31f                                                         ; 8f0d: 8d 1f c3    ...
    ldy #2                                                            ; 8f10: a0 02       ..
; &8f12 referenced 1 time by &8f19
.loop_c8f12
    lda lc22c,y                                                       ; 8f12: b9 2c c2    .,.
    sta lc31c,y                                                       ; 8f15: 99 1c c3    ...
    dey                                                               ; 8f18: 88          .
    bpl loop_c8f12                                                    ; 8f19: 10 f7       ..
    lda #&ff                                                          ; 8f1b: a9 ff       ..
    sta lc22e                                                         ; 8f1d: 8d 2e c2    ...
    sta lc22f                                                         ; 8f20: 8d 2f c2    ./.
    jmp c880d                                                         ; 8f23: 4c 0d 88    L..

; &8f26 referenced 2 times by &91a2, &99aa
.c8f26
    jmp (fscv)                                                        ; 8f26: 6c 1e 02    l..

; &8f29 referenced 1 time by &911b
.l8f29
    equs "$         $         "                                       ; 8f29: 24 20 20... $
    equb 2, 0, 0, 0, 2                                                ; 8f3d: 02 00 00... ...
.unknown_table1
    equb 0, 0, 0, 2                                                   ; 8f42: 00 00 00... ...

; &8f46 referenced 2 times by &9129, &9214
.sub_c8f46
    lda #&5a ; 'Z'                                                    ; 8f46: a9 5a       .Z
    jsr sub_c8f4f                                                     ; 8f48: 20 4f 8f     O.
    bne c8f5c                                                         ; 8f4b: d0 0f       ..
    lda #&a5                                                          ; 8f4d: a9 a5       ..
; &8f4f referenced 1 time by &8f48
.sub_c8f4f
    eor #&ff                                                          ; 8f4f: 49 ff       I.
    sta scsi_data                                                     ; 8f51: 8d 80 fe    ...
    eor #&ff                                                          ; 8f54: 49 ff       I.
    stz scsi_enable_disable_IRQ                                       ; 8f56: 9c 83 fe    ...
    cmp scsi_data                                                     ; 8f59: cd 80 fe    ...
; &8f5c referenced 1 time by &8f4b
.c8f5c
    rts                                                               ; 8f5c: 60          `

; &8f5d referenced 3 times by &912e, &917e, &91bf
.Get_CMOS_bit6
    jsr Get_CMOS_byte                                                 ; 8f5d: 20 76 90     v.
    and #&40 ; '@'                                                    ; 8f60: 29 40       )@
    rts                                                               ; 8f62: 60          `

; &8f63 referenced 2 times by &9112, &9187
.OSBYTE_last_break_type
    lda #&fd                                                          ; 8f63: a9 fd       ..
    jsr OSBYTE_YFFX0                                                  ; 8f65: 20 83 84     ..
    txa                                                               ; 8f68: 8a          .
; &8f69 referenced 1 time by &92c2
    rts                                                               ; 8f69: 60          `

; *** string table must not cross a page boundary
.bootcommand_pointer_table
    equb        <starLOAD_boot,    <String_dollarBOOT                 ; 8f6a: 6d 6f       mo
    equb <starEdot_VFS_dotBOOT                                        ; 8f6c: 77          w
.starLOAD_boot
String_cr = starLOAD_boot+2
    equs "L.$.!BOOT", &0d                                             ; 8f6d: 4c 2e 24... L.$
.starEdot_VFS_dotBOOT
l8f79 = starEdot_VFS_dotBOOT+2
l8f82 = starEdot_VFS_dotBOOT+11
    equs "E.-VFS-$.!BOOT", &0d                                        ; 8f77: 45 2e 2d... E.-
; &8f79 referenced 1 time by &8fde
; &8f82 referenced 1 time by &8fda
; &8f86 referenced 1 time by &8fc9
.l8f86
    equb <(Service_handler_NOP-1)                                     ; 8f86: b5          .
    equb <(Service_handler_AbsoluteWorkSpaceClaim-1)                  ; 8f87: 06          .
    equb <(Service_handler_PrivateWorkSpaceClaim-1)                   ; 8f88: 07          .
    equb <(Service_handler_Autoboot-1)                                ; 8f89: 60          `
    equb <(Service_handler_UnrecognisedCommand-1)                     ; 8f8a: 24          $
    equb <(Service_handler_UnrecognisedInterrupt-1)                   ; 8f8b: fc          .
    equb <(Service_handler_NOP-1)                                     ; 8f8c: b5          .
    equb <(Service_handler_NOP-1)                                     ; 8f8d: b5          .
    equb <(Service_handler_UnrecognisedOSWord-1)                      ; 8f8e: 60          `
    equb <(Service_handler_StarHELP-1)                                ; 8f8f: 28          (
; &8f90 referenced 1 time by &8fc5
.l8f90
    equb >(Service_handler_NOP-1)                                     ; 8f90: 8f          .
    equb >(Service_handler_AbsoluteWorkSpaceClaim-1)                  ; 8f91: 91          .
    equb >(Service_handler_PrivateWorkSpaceClaim-1)                   ; 8f92: 91          .
    equb >(Service_handler_Autoboot-1)                                ; 8f93: 91          .
    equb >(Service_handler_UnrecognisedCommand-1)                     ; 8f94: 94          .
    equb >(Service_handler_UnrecognisedInterrupt-1)                   ; 8f95: 9c          .
    equb >(Service_handler_NOP-1)                                     ; 8f96: 8f          .
    equb >(Service_handler_NOP-1)                                     ; 8f97: 8f          .
    equb >(Service_handler_UnrecognisedOSWord-1)                      ; 8f98: 94          .
    equb >(Service_handler_StarHELP-1)                                ; 8f99: 95          .
    equb <(Service_handler_OfferHiddenStaticWorkspace-1)              ; 8f9a: 09          .
    equb <(Service_handler_OfferHiddenDynamicWorkspace-1)             ; 8f9b: 10          .
    equb <(Service_handler_NOP-1)                                     ; 8f9c: b5          .
    equb <(Service_handler_DynamicWorkspaceRequirements-1)            ; 8f9d: 24          $
    equb <(Service_handler_InformMosofNameRequirements-1)             ; 8f9e: 29          )
    equb <(Service_handler_CloseAllFiles-1)                           ; 8f9f: 44          D
    equb <(Service_handler_ResetOccured-1)                            ; 8fa0: 62          b
    equb <(Service_handler_UnkownConfigureOption-1)                   ; 8fa1: e2          .
    equb <(Service_handler_UnkownStatusOption-1)                      ; 8fa2: ac          .
    equb >(Service_handler_OfferHiddenStaticWorkspace-1)              ; 8fa3: 93          .
    equb >(Service_handler_OfferHiddenDynamicWorkspace-1)             ; 8fa4: 93          .
    equb >(Service_handler_NOP-1)                                     ; 8fa5: 8f          .
    equb >(Service_handler_DynamicWorkspaceRequirements-1)            ; 8fa6: 93          .
    equb >(Service_handler_InformMosofNameRequirements-1)             ; 8fa7: 93          .
    equb >(Service_handler_CloseAllFiles-1)                           ; 8fa8: 93          .
    equb >(Service_handler_ResetOccured-1)                            ; 8fa9: 93          .
    equb >(Service_handler_UnkownConfigureOption-1)                   ; 8faa: 8f          .
    equb >(Service_handler_UnkownStatusOption-1)                      ; 8fab: 90          .

; &8fac referenced 1 time by &8003
.service_handler
    jsr Mouse_service_handler                                         ; 8fac: 20 f1 a6     ..
    bit rom_private_byte,x                                            ; 8faf: 3c f0 0d    <..
    bpl c8fb7                                                         ; 8fb2: 10 03       ..
    bvs c8fb9                                                         ; 8fb4: 70 03       p.
; &8fb6 referenced 3 times by &8fb7, &8fd3, &8fd7
.Service_handler_NOP
.Service_handler_BRK
.Service_handler_UnrecognisedOSByte
    rts                                                               ; 8fb6: 60          `

; &8fb7 referenced 1 time by &8fb2
.c8fb7
    bvs Service_handler_NOP                                           ; 8fb7: 70 fd       p.
; &8fb9 referenced 1 time by &8fb4
.c8fb9
    cmp #&12                                                          ; 8fb9: c9 12       ..
    bne c8fc0                                                         ; 8fbb: d0 03       ..
    jmp Initalise_filesystem                                          ; 8fbd: 4c 56 91    LV.

; &8fc0 referenced 1 time by &8fbb
.c8fc0
    cmp #&0a                                                          ; 8fc0: c9 0a       ..
    bcs c8fd1                                                         ; 8fc2: b0 0d       ..
    tax                                                               ; 8fc4: aa          .
    lda l8f90,x                                                       ; 8fc5: bd 90 8f    ...
    pha                                                               ; 8fc8: 48          H
    lda l8f86,x                                                       ; 8fc9: bd 86 8f    ...
; &8fcc referenced 1 time by &8fe1
.loop_c8fcc
    pha                                                               ; 8fcc: 48          H
    txa                                                               ; 8fcd: 8a          .
    ldx romsel_copy                                                   ; 8fce: a6 f4       ..
    rts                                                               ; 8fd0: 60          `

; &8fd1 referenced 1 time by &8fc2
.c8fd1
    cmp #&21 ; '!'                                                    ; 8fd1: c9 21       .!
    bcc Service_handler_NOP                                           ; 8fd3: 90 e1       ..
    cmp #&2a ; '*'                                                    ; 8fd5: c9 2a       .*
    bcs Service_handler_NOP                                           ; 8fd7: b0 dd       ..
    tax                                                               ; 8fd9: aa          .
    lda l8f82,x                                                       ; 8fda: bd 82 8f    ...
    pha                                                               ; 8fdd: 48          H
    lda l8f79,x                                                       ; 8fde: bd 79 8f    .y.
    bra loop_c8fcc                                                    ; 8fe1: 80 e9       ..
.Service_handler_UnkownConfigureOption
    phx                                                               ; 8fe3: da          .
    sty l00a8                                                         ; 8fe4: 84 a8       ..
    phy                                                               ; 8fe6: 5a          Z
    lda (os_text_ptr),y                                               ; 8fe7: b1 f2       ..
    cmp #&0d                                                          ; 8fe9: c9 0d       ..
    bne c8ffe                                                         ; 8feb: d0 11       ..
    ldy #0                                                            ; 8fed: a0 00       ..
; &8fef referenced 1 time by &8ff8
.loop_c8fef
    lda l908f,y                                                       ; 8fef: b9 8f 90    ...
    jsr print_char                                                    ; 8ff2: 20 28 97     (.
    iny                                                               ; 8ff5: c8          .
    cpy #&1e                                                          ; 8ff6: c0 1e       ..
    bne loop_c8fef                                                    ; 8ff8: d0 f5       ..
    lda #&28 ; '('                                                    ; 8ffa: a9 28       .(
    bne c900d                                                         ; 8ffc: d0 0f       ..
; &8ffe referenced 1 time by &8feb
.c8ffe
    jsr sub_c9038                                                     ; 8ffe: 20 38 90     8.
    bne c9010                                                         ; 9001: d0 0d       ..
    jsr Get_CMOS_byte                                                 ; 9003: 20 76 90     v.
    and #&bf                                                          ; 9006: 29 bf       ).
; &9008 referenced 3 times by &901a, &9026, &9032
.c9008
    jsr sub_c9083                                                     ; 9008: 20 83 90     ..
; &900b referenced 1 time by &90d8
.c900b
    lda #0                                                            ; 900b: a9 00       ..
; &900d referenced 2 times by &8ffc, &9036
.c900d
    ply                                                               ; 900d: 7a          z
    plx                                                               ; 900e: fa          .
    rts                                                               ; 900f: 60          `

; &9010 referenced 1 time by &9001
.c9010
    jsr sub_c906a                                                     ; 9010: 20 6a 90     j.
    bne c901c                                                         ; 9013: d0 07       ..
    jsr Get_CMOS_byte                                                 ; 9015: 20 76 90     v.
    ora #&40 ; '@'                                                    ; 9018: 09 40       .@
    bra c9008                                                         ; 901a: 80 ec       ..
; &901c referenced 1 time by &9013
.c901c
    jsr sub_c906e                                                     ; 901c: 20 6e 90     n.
    bne c9028                                                         ; 901f: d0 07       ..
    jsr Get_CMOS_byte                                                 ; 9021: 20 76 90     v.
    and #&fe                                                          ; 9024: 29 fe       ).
    bra c9008                                                         ; 9026: 80 e0       ..
; &9028 referenced 1 time by &901f
.c9028
    jsr sub_c9072                                                     ; 9028: 20 72 90     r.
    bne c9034                                                         ; 902b: d0 07       ..
    jsr Get_CMOS_byte                                                 ; 902d: 20 76 90     v.
    ora #1                                                            ; 9030: 09 01       ..
    bra c9008                                                         ; 9032: 80 d4       ..
; &9034 referenced 1 time by &902b
.c9034
    lda #&28 ; '('                                                    ; 9034: a9 28       .(
    bra c900d                                                         ; 9036: 80 d5       ..
; &9038 referenced 2 times by &8ffe, &90bc
.sub_c9038
    ldx #0                                                            ; 9038: a2 00       ..
; &903a referenced 3 times by &906c, &9070, &9074
.c903a
    ldy l00a8                                                         ; 903a: a4 a8       ..
; &903c referenced 1 time by &905f
.c903c
    lda l908f,x                                                       ; 903c: bd 8f 90    ...
    cmp #&0d                                                          ; 903f: c9 0d       ..
    beq c9049                                                         ; 9041: f0 06       ..
    lda (os_text_ptr),y                                               ; 9043: b1 f2       ..
    cmp #&2e ; '.'                                                    ; 9045: c9 2e       ..
    beq c9069                                                         ; 9047: f0 20       .
; &9049 referenced 1 time by &9041
.c9049
    lda (os_text_ptr),y                                               ; 9049: b1 f2       ..
    and #&df                                                          ; 904b: 29 df       ).
    sta l00af                                                         ; 904d: 85 af       ..
    lda l908f,x                                                       ; 904f: bd 8f 90    ...
    and #&df                                                          ; 9052: 29 df       ).
    cmp l00af                                                         ; 9054: c5 af       ..
    bne c9069                                                         ; 9056: d0 11       ..
    iny                                                               ; 9058: c8          .
    inx                                                               ; 9059: e8          .
    lda l908f,x                                                       ; 905a: bd 8f 90    ...
    cmp #&0d                                                          ; 905d: c9 0d       ..
    bne c903c                                                         ; 905f: d0 db       ..
    lda (os_text_ptr),y                                               ; 9061: b1 f2       ..
    cmp #&20 ; ' '                                                    ; 9063: c9 20       .
    beq c9069                                                         ; 9065: f0 02       ..
    cmp #&0d                                                          ; 9067: c9 0d       ..
; &9069 referenced 3 times by &9047, &9056, &9065
.c9069
    rts                                                               ; 9069: 60          `

; &906a referenced 2 times by &9010, &90c1
.sub_c906a
    ldx #7                                                            ; 906a: a2 07       ..
    bra c903a                                                         ; 906c: 80 cc       ..
; &906e referenced 2 times by &901c, &90c6
.sub_c906e
    ldx #&18                                                          ; 906e: a2 18       ..
    bra c903a                                                         ; 9070: 80 c8       ..
; &9072 referenced 2 times by &9028, &90cb
.sub_c9072
    ldx #&10                                                          ; 9072: a2 10       ..
    bra c903a                                                         ; 9074: 80 c4       ..
; &9076 referenced 8 times by &8f5d, &9003, &9015, &9021, &902d, &90dd, &90fa, &ab61
.Get_CMOS_byte
    lda romsel_copy                                                   ; 9076: a5 f4       ..
    clc                                                               ; 9078: 18          .
    adc #&14                                                          ; 9079: 69 14       i.
    tax                                                               ; 907b: aa          .
    lda #osbyte_read_cmos_ram                                         ; 907c: a9 a1       ..
    jsr osbyte                                                        ; 907e: 20 f4 ff     ..            ; Master and Compact: Read CMOS RAM/EEPROM byte X
    tya                                                               ; 9081: 98          .              ; Y is the byte value read from the CMOS RAM/EEPROM
    rts                                                               ; 9082: 60          `

; &9083 referenced 1 time by &9008
.sub_c9083
    tay                                                               ; 9083: a8          .
    lda romsel_copy                                                   ; 9084: a5 f4       ..
    clc                                                               ; 9086: 18          .
    adc #&14                                                          ; 9087: 69 14       i.
    tax                                                               ; 9089: aa          .
    lda #osbyte_write_cmos_ram                                        ; 908a: a9 a2       ..
    jmp osbyte                                                        ; 908c: 4c f4 ff    L..            ; Master and Compact: Write to CMOS RAM/EEPROM byte X with value Y

; &908f referenced 5 times by &8fef, &903c, &904f, &905a, &90e8
.l908f
    equs "VFSDir"                                                     ; 908f: 56 46 53... VFS
    equb &0d                                                          ; 9095: 0d          .
    equs "VFSNoDir"                                                   ; 9096: 56 46 53... VFS
    equb &0d                                                          ; 909e: 0d          .
    equs "NoEject"                                                    ; 909f: 4e 6f 45... NoE
    equb &0d                                                          ; 90a6: 0d          .
    equs "Eject"                                                      ; 90a7: 45 6a 65... Eje
    equb &0d                                                          ; 90ac: 0d          .

.Service_handler_UnkownStatusOption
    lda (os_text_ptr),y                                               ; 90ad: b1 f2       ..
    cmp #&0d                                                          ; 90af: c9 0d       ..
    bne c90b8                                                         ; 90b1: d0 05       ..
    jsr sub_c90db                                                     ; 90b3: 20 db 90     ..
    bra c90f8                                                         ; 90b6: 80 40       .@
; &90b8 referenced 1 time by &90b1
.c90b8
    phx                                                               ; 90b8: da          .
    sty l00a8                                                         ; 90b9: 84 a8       ..
    phy                                                               ; 90bb: 5a          Z
    jsr sub_c9038                                                     ; 90bc: 20 38 90     8.
    beq c90d5                                                         ; 90bf: f0 14       ..
    jsr sub_c906a                                                     ; 90c1: 20 6a 90     j.
    beq c90d5                                                         ; 90c4: f0 0f       ..
    jsr sub_c906e                                                     ; 90c6: 20 6e 90     n.
    beq c90d0                                                         ; 90c9: f0 05       ..
    jsr sub_c9072                                                     ; 90cb: 20 72 90     r.
    bne c90f3                                                         ; 90ce: d0 23       .#
; &90d0 referenced 1 time by &90c9
.c90d0
    jsr c90f8                                                         ; 90d0: 20 f8 90     ..
    bra c90d8                                                         ; 90d3: 80 03       ..
; &90d5 referenced 2 times by &90bf, &90c4
.c90d5
    jsr sub_c90db                                                     ; 90d5: 20 db 90     ..
; &90d8 referenced 1 time by &90d3
.c90d8
    jmp c900b                                                         ; 90d8: 4c 0b 90    L..

; &90db referenced 2 times by &90b3, &90d5
.sub_c90db
    phx                                                               ; 90db: da          .
    phy                                                               ; 90dc: 5a          Z
    jsr Get_CMOS_byte                                                 ; 90dd: 20 76 90     v.
    ldx #0                                                            ; 90e0: a2 00       ..
    and #&40 ; '@'                                                    ; 90e2: 29 40       )@
    beq c90e8                                                         ; 90e4: f0 02       ..
    ldx #7                                                            ; 90e6: a2 07       ..
; &90e8 referenced 4 times by &90e4, &90f1, &9101, &9105
.c90e8
    lda l908f,x                                                       ; 90e8: bd 8f 90    ...
    jsr print_char                                                    ; 90eb: 20 28 97     (.
    inx                                                               ; 90ee: e8          .
    cmp #&0d                                                          ; 90ef: c9 0d       ..
    bne c90e8                                                         ; 90f1: d0 f5       ..
; &90f3 referenced 1 time by &90ce
.c90f3
    ply                                                               ; 90f3: 7a          z
    plx                                                               ; 90f4: fa          .
    lda #&29 ; ')'                                                    ; 90f5: a9 29       .)
    rts                                                               ; 90f7: 60          `

; &90f8 referenced 2 times by &90b6, &90d0
.c90f8
    phx                                                               ; 90f8: da          .
    phy                                                               ; 90f9: 5a          Z
    jsr Get_CMOS_byte                                                 ; 90fa: 20 76 90     v.
    ldx #&18                                                          ; 90fd: a2 18       ..
    and #1                                                            ; 90ff: 29 01       ).
    beq c90e8                                                         ; 9101: f0 e5       ..
    ldx #&10                                                          ; 9103: a2 10       ..
    bra c90e8                                                         ; 9105: 80 e1       ..
.Service_handler_AbsoluteWorkSpaceClaim
    rts                                                               ; 9107: 60          `

.Service_handler_PrivateWorkSpaceClaim
    lda rom_private_byte,x                                            ; 9108: bd f0 0d    ...
    bne c9111                                                         ; 910b: d0 04       ..
    tya                                                               ; 910d: 98          .
    sta rom_private_byte,x                                            ; 910e: 9d f0 0d    ...
; &9111 referenced 1 time by &910b
.c9111
    phy                                                               ; 9111: 5a          Z
    jsr OSBYTE_last_break_type                                        ; 9112: 20 63 8f     c.
    beq c9142                                                         ; 9115: f0 2b       .+
    jsr sub_c9b68                                                     ; 9117: 20 68 9b     h.
    tay                                                               ; 911a: a8          .
; &911b referenced 1 time by &9127
.loop_c911b
    lda l8f29,y                                                       ; 911b: b9 29 8f    .).
    cpy #&1d                                                          ; 911e: c0 1d       ..
    bcc c9124                                                         ; 9120: 90 02       ..
    lda #0                                                            ; 9122: a9 00       ..
; &9124 referenced 1 time by &9120
.c9124
    sta (l00ba),y                                                     ; 9124: 91 ba       ..
    iny                                                               ; 9126: c8          .
    bne loop_c911b                                                    ; 9127: d0 f2       ..
    jsr sub_c8f46                                                     ; 9129: 20 46 8f     F.
    bne c913f                                                         ; 912c: d0 11       ..
    jsr Get_CMOS_bit6                                                 ; 912e: 20 5d 8f     ].
    and #&80                                                          ; 9131: 29 80       ).
    ldy #&17                                                          ; 9133: a0 17       ..
    sta (l00ba),y                                                     ; 9135: 91 ba       ..
    ldy #&1b                                                          ; 9137: a0 1b       ..
    sta (l00ba),y                                                     ; 9139: 91 ba       ..
    ldy #&1f                                                          ; 913b: a0 1f       ..
    sta (l00ba),y                                                     ; 913d: 91 ba       ..
; &913f referenced 1 time by &912c
.c913f
    jsr sub_c9b85                                                     ; 913f: 20 85 9b     ..
; &9142 referenced 1 time by &9115
.c9142
    jsr sub_c9b8b                                                     ; 9142: 20 8b 9b     ..
    pla                                                               ; 9145: 68          h
    ldx romsel_copy                                                   ; 9146: a6 f4       ..
    bit rom_private_byte,x                                            ; 9148: 3c f0 0d    <..
    bmi c9150                                                         ; 914b: 30 03       0.
    clc                                                               ; 914d: 18          .
    adc #4                                                            ; 914e: 69 04       i.
; &9150 referenced 1 time by &914b
.c9150
    tay                                                               ; 9150: a8          .
    lda #2                                                            ; 9151: a9 02       ..
; &9153 referenced 1 time by &9158
.loop_c9153
    rts                                                               ; 9153: 60          `

; &9154 referenced 2 times by &9358, &9476
.sub_c9154
    ldy #&0a                                                          ; 9154: a0 0a       ..
; &9156 referenced 1 time by &8fbd
.Initalise_filesystem
    cpy #&0a                                                          ; 9156: c0 0a       ..
    bne loop_c9153                                                    ; 9158: d0 f9       ..
    lda #&ff                                                          ; 915a: a9 ff       ..
    pha                                                               ; 915c: 48          H
    pha                                                               ; 915d: 48          H
    sec                                                               ; 915e: 38          8
    bcs c919f                                                         ; 915f: b0 3e       .>
.Service_handler_Autoboot
    phy                                                               ; 9161: 5a          Z
    lda #osbyte_scan_keyboard_from_16                                 ; 9162: a9 7a       .z
    jsr osbyte                                                        ; 9164: 20 f4 ff     ..            ; Keyboard scan starting from key 16
    inx                                                               ; 9167: e8          .
    beq c917c                                                         ; 9168: f0 12       ..
    dex                                                               ; 916a: ca          .
    cpx #&10                                                          ; 916b: e0 10       ..
    beq c917c                                                         ; 916d: f0 0d       ..
    cpx #&56 ; 'V'                                                    ; 916f: e0 56       .V
    beq c917a                                                         ; 9171: f0 07       ..
    pla                                                               ; 9173: 68          h
    tay                                                               ; 9174: a8          .
    ldx romsel_copy                                                   ; 9175: a6 f4       ..
    lda #3                                                            ; 9177: a9 03       ..
    rts                                                               ; 9179: 60          `

; &917a referenced 1 time by &9171
.c917a
    pla                                                               ; 917a: 68          h
    phx                                                               ; 917b: da          .
; &917c referenced 2 times by &9168, &916d
.c917c
    cli                                                               ; 917c: 58          X
    phx                                                               ; 917d: da          .
    jsr Get_CMOS_bit6                                                 ; 917e: 20 5d 8f     ].
    sta CMOS_byte_copy                                                ; 9181: 8d d8 c2    ...
    asl a                                                             ; 9184: 0a          .
    bpl c9190                                                         ; 9185: 10 09       ..
    jsr OSBYTE_last_break_type                                        ; 9187: 20 63 8f     c.
    beq c9190                                                         ; 918a: f0 04       ..
    pla                                                               ; 918c: 68          h
    lda #&56 ; 'V'                                                    ; 918d: a9 56       .V
    pha                                                               ; 918f: 48          H
; &9190 referenced 2 times by &9185, &918a
.c9190
    jsr print_string                                                  ; 9190: 20 57 8c     W.
    equs "Acorn VFS", &0d, &80+&0d                                    ; 9193: 41 63 6f... Aco

    clc                                                               ; 919e: 18          .
;  Select LVFS
;  ===========
;  Stack now holds:
;    top-1: Key pressed, &FF=none or *adfs, &41='A', &43='F' or *fadfs or
;                        Serv08+Dir+Hard/PowerBreak, &79='->', &00/&08=Serv12
;    top-2: Boot flag, &00=boot, <>&00=no boot
; 
; &919f referenced 2 times by &915f, &9457
.c919f
    php                                                               ; 919f: 08          .
    lda #6                                                            ; 91a0: a9 06       ..
    jsr c8f26                                                         ; 91a2: 20 26 8f     &.
    php                                                               ; 91a5: 08          .
    sei                                                               ; 91a6: 78          x
    jsr sub_cb6e5                                                     ; 91a7: 20 e5 b6     ..
    lda os_interlace_flag                                             ; 91aa: ad 91 02    ...
    beq c91b2                                                         ; 91ad: f0 03       ..
    jmp cabf7                                                         ; 91af: 4c f7 ab    L..

; &91b2 referenced 1 time by &91ad
.c91b2
    sta l093a                                                         ; 91b2: 8d 3a 09    .:.
    jsr sub_cb6e5                                                     ; 91b5: 20 e5 b6     ..
    plp                                                               ; 91b8: 28          (
    stz lc22f                                                         ; 91b9: 9c 2f c2    ./.
    stz screen_memory_flag                                            ; 91bc: 9c d7 c2    ...
    jsr Get_CMOS_bit6                                                 ; 91bf: 20 5d 8f     ].
    sta CMOS_byte_copy                                                ; 91c2: 8d d8 c2    ...
    ldy #&0d                                                          ; 91c5: a0 0d       ..
; &91c7 referenced 1 time by &91ce
.loop_c91c7
    lda osvector_table,y                                              ; 91c7: b9 e7 92    ...
    sta filev,y                                                       ; 91ca: 99 12 02    ...
    dey                                                               ; 91cd: 88          .
    bpl loop_c91c7                                                    ; 91ce: 10 f7       ..
; osbyte read address of rom pointer
    lda #&a8                                                          ; 91d0: a9 a8       ..
    jsr OSBYTE_YFFX0                                                  ; 91d2: 20 83 84     ..
    stx l00b4                                                         ; 91d5: 86 b4       ..
    sty l00b5                                                         ; 91d7: 84 b5       ..
    ldy #&2f ; '/'                                                    ; 91d9: a0 2f       ./
    ldx #&14                                                          ; 91db: a2 14       ..
; &91dd referenced 1 time by &91ea
.loop_c91dd
    lda l92f5,x                                                       ; 91dd: bd f5 92    ...
    cmp #&ff                                                          ; 91e0: c9 ff       ..
    bne c91e6                                                         ; 91e2: d0 02       ..
    lda romsel_copy                                                   ; 91e4: a5 f4       ..
; &91e6 referenced 1 time by &91e2
.c91e6
    sta (l00b4),y                                                     ; 91e6: 91 b4       ..
    dey                                                               ; 91e8: 88          .
    dex                                                               ; 91e9: ca          .
    bpl loop_c91dd                                                    ; 91ea: 10 f1       ..
    lda #osbyte_issue_service_request                                 ; 91ec: a9 8f       ..
    ldx #&0f                                                          ; 91ee: a2 0f       ..
    ldy #&ff                                                          ; 91f0: a0 ff       ..
    jsr osbyte                                                        ; 91f2: 20 f4 ff     ..            ; Issue paged ROM service call, Reason X=15 - Vectors claimed
    jsr sub_c9b8b                                                     ; 91f5: 20 8b 9b     ..
    jsr sub_c9851                                                     ; 91f8: 20 51 98     Q.
    ldy #&fb                                                          ; 91fb: a0 fb       ..
; &91fd referenced 1 time by &9203
.loop_c91fd
    lda (l00ba),y                                                     ; 91fd: b1 ba       ..
    sta lc300,y                                                       ; 91ff: 99 00 c3    ...
    dey                                                               ; 9202: 88          .
    bne loop_c91fd                                                    ; 9203: d0 f8       ..
    lda (l00ba),y                                                     ; 9205: b1 ba       ..
    sta lc300,y                                                       ; 9207: 99 00 c3    ...
    lda lc320                                                         ; 920a: ad 20 c3    . .
    and #4                                                            ; 920d: 29 04       ).
    sta tube_used_zp                                                  ; 920f: 85 cd       ..
    jsr Function_entered_via_rts_onstack                              ; 9211: 20 f8 9b     ..
    jsr sub_c8f46                                                     ; 9214: 20 46 8f     F.
    bne c921d                                                         ; 9217: d0 04       ..
    lda #&20 ; ' '                                                    ; 9219: a9 20       .
    tsb tube_used_zp                                                  ; 921b: 04 cd       ..
; &921d referenced 1 time by &9217
.c921d
    ldy #3                                                            ; 921d: a0 03       ..
; &921f referenced 1 time by &9226
.loop_c921f
    lda lc314,y                                                       ; 921f: b9 14 c3    ...
    sta lc22c,y                                                       ; 9222: 99 2c c2    .,.
    dey                                                               ; 9225: 88          .
    bpl loop_c921f                                                    ; 9226: 10 f7       ..
    jsr update_tube_present_flag                                      ; 9228: 20 d0 92     ..
    lda lc22f                                                         ; 922b: ad 2f c2    ./.
    cmp #&ff                                                          ; 922e: c9 ff       ..
    bne c9240                                                         ; 9230: d0 0e       ..
    stz lc22e                                                         ; 9232: 9c 2e c2    ...
    stz lc22d                                                         ; 9235: 9c 2d c2    .-.
    stz lc22f                                                         ; 9238: 9c 2f c2    ./.
    lda #2                                                            ; 923b: a9 02       ..
    sta lc22c                                                         ; 923d: 8d 2c c2    .,.
; &9240 referenced 1 time by &9230
.c9240
    plp                                                               ; 9240: 28          (
    bcs c9248                                                         ; 9241: b0 05       ..
    lda #&1b                                                          ; 9243: a9 1b       ..
    jsr sub_cab93                                                     ; 9245: 20 93 ab     ..
; &9248 referenced 1 time by &9241
.c9248
    pla                                                               ; 9248: 68          h
    cmp #&56 ; 'V'                                                    ; 9249: c9 56       .V
    bne c9250                                                         ; 924b: d0 03       ..
    jsr sub_c8459                                                     ; 924d: 20 59 84     Y.
; &9250 referenced 1 time by &924b
.c9250
    jsr c880d                                                         ; 9250: 20 0d 88     ..
    ldx lc317                                                         ; 9253: ae 17 c3    ...
    inx                                                               ; 9256: e8          .
    beq c92aa                                                         ; 9257: f0 51       .Q
    jsr sub_ca1c3                                                     ; 9259: 20 c3 a1     ..
    lda lc318                                                         ; 925c: ad 18 c3    ...
    cmp #2                                                            ; 925f: c9 02       ..
    bne c92a7                                                         ; 9261: d0 44       .D
    lda lc319                                                         ; 9263: ad 19 c3    ...
    ora lc31a                                                         ; 9266: 0d 1a c3    ...
    ora lc31b                                                         ; 9269: 0d 1b c3    ...
    bne c92a7                                                         ; 926c: d0 39       .9
    lda #<zeroLIB_string                                              ; 926e: a9 df       ..
    sta l00b4                                                         ; 9270: 85 b4       ..
    lda #>zeroLIB_string                                              ; 9272: a9 92       ..
    sta l00b5                                                         ; 9274: 85 b5       ..
    jsr sub_c8b5f                                                     ; 9276: 20 5f 8b     _.
    bne c92a7                                                         ; 9279: d0 2c       .,
; &927b referenced 1 time by &9286
.loop_c927b
    ldy #3                                                            ; 927b: a0 03       ..
    lda (l00b6),y                                                     ; 927d: b1 b6       ..
    bmi c9288                                                         ; 927f: 30 07       0.
    jsr c87af                                                         ; 9281: 20 af 87     ..
    bne c92a7                                                         ; 9284: d0 21       .!
    beq loop_c927b                                                    ; 9286: f0 f3       ..
; &9288 referenced 1 time by &927f
.c9288
    ldx #2                                                            ; 9288: a2 02       ..
    ldy #&18                                                          ; 928a: a0 18       ..
; &928c referenced 1 time by &9293
.loop_c928c
    lda (l00b6),y                                                     ; 928c: b1 b6       ..
    sta lc318,x                                                       ; 928e: 9d 18 c3    ...
    dey                                                               ; 9291: 88          .
    dex                                                               ; 9292: ca          .
    bpl loop_c928c                                                    ; 9293: 10 f7       ..
    lda lc317                                                         ; 9295: ad 17 c3    ...
    sta lc31b                                                         ; 9298: 8d 1b c3    ...
    ldy #9                                                            ; 929b: a0 09       ..
; &929d referenced 1 time by &92a5
.loop_c929d
    lda (l00b6),y                                                     ; 929d: b1 b6       ..
    and #&7f                                                          ; 929f: 29 7f       ).
    sta lc30a,y                                                       ; 92a1: 99 0a c3    ...
    dey                                                               ; 92a4: 88          .
    bpl loop_c929d                                                    ; 92a5: 10 f6       ..
; &92a7 referenced 4 times by &9261, &926c, &9279, &9284
.c92a7
    jsr c880d                                                         ; 92a7: 20 0d 88     ..
; &92aa referenced 1 time by &9257
.c92aa
    jsr update_tube_present_flag                                      ; 92aa: 20 d0 92     ..
    pla                                                               ; 92ad: 68          h
    pha                                                               ; 92ae: 48          H
    bne c92ca                                                         ; 92af: d0 19       ..
    ldx lc317                                                         ; 92b1: ae 17 c3    ...
    inx                                                               ; 92b4: e8          .
    bne c92bd                                                         ; 92b5: d0 06       ..
    stx lc26f                                                         ; 92b7: 8e 6f c2    .o.
    jsr sub_c9867                                                     ; 92ba: 20 67 98     g.
; &92bd referenced 1 time by &92b5
.c92bd
    ldy lc1fd                                                         ; 92bd: ac fd c1    ...
    beq c92ca                                                         ; 92c0: f0 08       ..
    ldx bootcommand_pointer_table-1,y                                 ; 92c2: be 69 8f    .i.
    ldy #>bootcommand_pointer_table                                   ; 92c5: a0 8f       ..
    jsr oscli                                                         ; 92c7: 20 f7 ff     ..
; &92ca referenced 2 times by &92af, &92c0
.c92ca
    ldx romsel_copy                                                   ; 92ca: a6 f4       ..
    ply                                                               ; 92cc: 7a          z
    lda #0                                                            ; 92cd: a9 00       ..
    rts                                                               ; 92cf: 60          `

; osbyte read tube presents
; &92d0 referenced 2 times by &9228, &92aa
.update_tube_present_flag
    lda #&ea                                                          ; 92d0: a9 ea       ..
    jsr OSBYTE_YFFX0                                                  ; 92d2: 20 83 84     ..
    lda #&80                                                          ; 92d5: a9 80       ..
    trb tube_used_zp                                                  ; 92d7: 14 cd       ..
    inx                                                               ; 92d9: e8          .
    bne c92de                                                         ; 92da: d0 02       ..
    tsb tube_used_zp                                                  ; 92dc: 04 cd       ..
; &92de referenced 1 time by &92da
.c92de
    rts                                                               ; 92de: 60          `

.zeroLIB_string
    equs ":0.LIB*"                                                    ; 92df: 3a 30 2e... :0.
    equb &0d                                                          ; 92e6: 0d          .
; &92e7 referenced 1 time by &91c7
.osvector_table
    equw &ff1b, &ff1e, &ff21, &ff24, &ff27, &ff2a, &ff2d              ; 92e7: 1b ff 1e... ...
; &92f5 referenced 1 time by &91dd
.l92f5
    equw vector1                                                      ; 92f5: f1 8b       ..
    equb &ff                                                          ; 92f7: ff          .
    equw sub_c9c1d                                                    ; 92f8: 1d 9c       ..
    equb &ff                                                          ; 92fa: ff          .
    equw sub_c9eaf                                                    ; 92fb: af 9e       ..
    equb &ff                                                          ; 92fd: ff          .
    equw sub_c9fa5                                                    ; 92fe: a5 9f       ..
    equb &ff                                                          ; 9300: ff          .
    equw sub_ca28c                                                    ; 9301: 8c a2       ..
    equb &ff                                                          ; 9303: ff          .
    equw sub_ca03c                                                    ; 9304: 3c a0       <.
    equb &ff                                                          ; 9306: ff          .
    equw sub_c95d6                                                    ; 9307: d6 95       ..
    equb &ff                                                          ; 9309: ff          .

.Service_handler_OfferHiddenStaticWorkspace
    cpy #&cf                                                          ; 930a: c0 cf       ..
    bcs c9310                                                         ; 930c: b0 02       ..
    ldy #&cf                                                          ; 930e: a0 cf       ..
; &9310 referenced 1 time by &930c
.c9310
    rts                                                               ; 9310: 60          `

.Service_handler_OfferHiddenDynamicWorkspace
    tya                                                               ; 9311: 98          .
    cmp #&d9                                                          ; 9312: c9 d9       ..
    bcs c9320                                                         ; 9314: b0 0a       ..
    sta rom_private_byte,x                                            ; 9316: 9d f0 0d    ...
    clc                                                               ; 9319: 18          .
    adc #4                                                            ; 931a: 69 04       i.
; &931c referenced 1 time by &9323
.loop_c931c
    tay                                                               ; 931c: a8          .
    lda #&22 ; '"'                                                    ; 931d: a9 22       ."
    rts                                                               ; 931f: 60          `

; &9320 referenced 1 time by &9314
.c9320
    stz rom_private_byte,x                                            ; 9320: 9e f0 0d    ...
    bra loop_c931c                                                    ; 9323: 80 f7       ..
.Service_handler_DynamicWorkspaceRequirements
    dey                                                               ; 9325: 88          .
    dey                                                               ; 9326: 88          .
    dey                                                               ; 9327: 88          .
    dey                                                               ; 9328: 88          .
    rts                                                               ; 9329: 60          `

.Service_handler_InformMosofNameRequirements
    ldx #&15                                                          ; 932a: a2 15       ..
; &932c referenced 1 time by &9333
.loop_c932c
    lda l933a,x                                                       ; 932c: bd 3a 93    .:.
    sta (os_text_ptr),y                                               ; 932f: 91 f2       ..
    iny                                                               ; 9331: c8          .
    dex                                                               ; 9332: ca          .
    bpl loop_c932c                                                    ; 9333: 10 f7       ..
    lda #&25 ; '%'                                                    ; 9335: a9 25       .%
; &9337 referenced 2 times by &9361, &9422
.c9337
    ldx romsel_copy                                                   ; 9337: a6 f4       ..
    rts                                                               ; 9339: 60          `

; &933a referenced 1 time by &932c
.l933a
    equb &0a                                                          ; 933a: 0a          .
    equs "YP     "                                                    ; 933b: 59 50 20... YP
; &9342 referenced 2 times by &9441, &9581
.vfs_string
    equs "sfv"                                                        ; 9342: 73 66 76    sfv

.Service_handler_CloseAllFiles
    phy                                                               ; 9345: 5a          Z
    jsr sub_c9b68                                                     ; 9346: 20 68 9b     h.
    ldy #&ac                                                          ; 9349: a0 ac       ..
    ldx #9                                                            ; 934b: a2 09       ..
    lda #0                                                            ; 934d: a9 00       ..
; &934f referenced 1 time by &9353
.loop_c934f
    ora (l00ba),y                                                     ; 934f: 11 ba       ..
    iny                                                               ; 9351: c8          .
    dex                                                               ; 9352: ca          .
    bpl loop_c934f                                                    ; 9353: 10 fa       ..
    tax                                                               ; 9355: aa          .
    beq c935e                                                         ; 9356: f0 06       ..
    jsr sub_c9154                                                     ; 9358: 20 54 91     T.
    jsr sub_ca039                                                     ; 935b: 20 39 a0     9.
; &935e referenced 1 time by &9356
.c935e
    ply                                                               ; 935e: 7a          z
    lda #&26 ; '&'                                                    ; 935f: a9 26       .&
    bra c9337                                                         ; 9361: 80 d4       ..
.Service_handler_ResetOccured
    php                                                               ; 9363: 08          .
    sei                                                               ; 9364: 78          x
    stz vfs_100Hz_timer                                               ; 9365: 9c 95 0d    ...
    stz vfs_flags2                                                    ; 9368: 9c 96 0d    ...
    stz vfs_flags1                                                    ; 936b: 9c 92 0d    ...
    lda #&ff                                                          ; 936e: a9 ff       ..
    sta vfs_25Hz_timer_hi                                             ; 9370: 8d 94 0d    ...
    jsr sub_cb228                                                     ; 9373: 20 28 b2     (.
    lda #osbyte_increment_polling_semaphore                           ; 9376: a9 16       ..
    sta l0923                                                         ; 9378: 8d 23 09    .#.
    jsr osbyte                                                        ; 937b: 20 f4 ff     ..            ; Electron and Master: Increment polling semaphore
    lda lffb7                                                         ; 937e: ad b7 ff    ...
    sta l00a8                                                         ; 9381: 85 a8       ..
    lda lffb8                                                         ; 9383: ad b8 ff    ...
    sta l00a9                                                         ; 9386: 85 a9       ..
    ldy #5                                                            ; 9388: a0 05       ..
; &938a referenced 1 time by &9394
.loop_c938a
    lda (l00a8),y                                                     ; 938a: b1 a8       ..
    cmp userv,y                                                       ; 938c: d9 00 02    ...
    bne c9399                                                         ; 938f: d0 08       ..
    dey                                                               ; 9391: 88          .
    cpy #3                                                            ; 9392: c0 03       ..
    bne loop_c938a                                                    ; 9394: d0 f4       ..
    stz l0923                                                         ; 9396: 9c 23 09    .#.
; &9399 referenced 1 time by &938f
.c9399
    lda #osbyte_read_rom_ptr_table_low                                ; 9399: a9 a8       ..
    ldx #0                                                            ; 939b: a2 00       ..
    ldy #&ff                                                          ; 939d: a0 ff       ..
    jsr osbyte                                                        ; 939f: 20 f4 ff     ..            ; Read address of ROM pointer table
    stx l00a8                                                         ; 93a2: 86 a8       ..             ; X=value of address of ROM pointer table (low byte)
    sty l00a9                                                         ; 93a4: 84 a9       ..             ; Y=value of address of ROM pointer table (high byte)
    stx l091b                                                         ; 93a6: 8e 1b 09    ...
    sty l091c                                                         ; 93a9: 8c 1c 09    ...
    lda bytev                                                         ; 93ac: ad 0a 02    ...
    sta vfs_old_bytev1                                                ; 93af: 8d 97 0d    ...
    lda bytev+1                                                       ; 93b2: ad 0b 02    ...
    sta vfs_old_bytev2                                                ; 93b5: 8d 98 0d    ...
    ldy #&0f                                                          ; 93b8: a0 0f       ..
    sty bytev                                                         ; 93ba: 8c 0a 02    ...
    ldx #&ff                                                          ; 93bd: a2 ff       ..
    stx bytev+1                                                       ; 93bf: 8e 0b 02    ...
    lda (l00a8),y                                                     ; 93c2: b1 a8       ..
    sta l091d                                                         ; 93c4: 8d 1d 09    ...
    lda #<OSBYTE_Extended_Vectorcode                                  ; 93c7: a9 b6       ..
    sta (l00a8),y                                                     ; 93c9: 91 a8       ..
    iny                                                               ; 93cb: c8          .
    lda (l00a8),y                                                     ; 93cc: b1 a8       ..
    sta l091e                                                         ; 93ce: 8d 1e 09    ...
    lda #>OSBYTE_Extended_Vectorcode                                  ; 93d1: a9 b4       ..
    sta (l00a8),y                                                     ; 93d3: 91 a8       ..
    iny                                                               ; 93d5: c8          .
    lda (l00a8),y                                                     ; 93d6: b1 a8       ..
    sta l091f                                                         ; 93d8: 8d 1f 09    ...
    lda romsel_copy                                                   ; 93db: a5 f4       ..
    sta (l00a8),y                                                     ; 93dd: 91 a8       ..
    lda l0923                                                         ; 93df: ad 23 09    .#.
    bne c9420                                                         ; 93e2: d0 3c       .<
    lda irq1v                                                         ; 93e4: ad 04 02    ...
    sta vfs_old_irq1v1a                                               ; 93e7: 8d 9d 0d    ...
    lda irq1v+1                                                       ; 93ea: ad 05 02    ...
    sta vfs_old_irq1v2a                                               ; 93ed: 8d 9e 0d    ...
    lda #&20 ; ' '                                                    ; 93f0: a9 20       .
    sta vfs_irq1                                                      ; 93f2: 8d 99 0d    ...
    ldy #6                                                            ; 93f5: a0 06       ..
    sty vfs_irq2                                                      ; 93f7: 8c 9a 0d    ...
    lda #&ff                                                          ; 93fa: a9 ff       ..
    sta vfs_old_irq1v1                                                ; 93fc: 8d 9b 0d    ...
    lda #&40 ; '@'                                                    ; 93ff: a9 40       .@
    sta vfs_old_irq1v2                                                ; 9401: 8d 9c 0d    ...
    lda #>IRQ1_vector_entry                                           ; 9404: a9 99       ..
    sta irq1v                                                         ; 9406: 8d 04 02    ...
    lda #<IRQ1_vector_entry                                           ; 9409: a9 0d       ..
    sta irq1v+1                                                       ; 940b: 8d 05 02    ...
    lda #<Extended_IRQ1_Vector                                        ; 940e: a9 4f       .O
    sta (l00a8),y                                                     ; 9410: 91 a8       ..
    iny                                                               ; 9412: c8          .
    lda #>Extended_IRQ1_Vector                                        ; 9413: a9 b5       ..
    sta (l00a8),y                                                     ; 9415: 91 a8       ..
    iny                                                               ; 9417: c8          .
    lda romsel_copy                                                   ; 9418: a5 f4       ..
    sta (l00a8),y                                                     ; 941a: 91 a8       ..
    jsr sub_cb1e3                                                     ; 941c: 20 e3 b1     ..
    plp                                                               ; 941f: 28          (
; &9420 referenced 1 time by &93e2
.c9420
    lda #&27 ; '''                                                    ; 9420: a9 27       .'
    jmp c9337                                                         ; 9422: 4c 37 93    L7.

.Service_handler_UnrecognisedCommand
    phy                                                               ; 9425: 5a          Z
    lda #&ff                                                          ; 9426: a9 ff       ..
    pha                                                               ; 9428: 48          H
    lda (os_text_ptr),y                                               ; 9429: b1 f2       ..
    ora #&20 ; ' '                                                    ; 942b: 09 20       .
    cmp #&6c ; 'l'                                                    ; 942d: c9 6c       .l
    bne c9436                                                         ; 942f: d0 05       ..
    pla                                                               ; 9431: 68          h
    lda #&56 ; 'V'                                                    ; 9432: a9 56       .V
    pha                                                               ; 9434: 48          H
    iny                                                               ; 9435: c8          .
; &9436 referenced 1 time by &942f
.c9436
    ldx #2                                                            ; 9436: a2 02       ..
; &9438 referenced 1 time by &9447
.loop_c9438
    lda (os_text_ptr),y                                               ; 9438: b1 f2       ..
    iny                                                               ; 943a: c8          .
    cmp #&2e ; '.'                                                    ; 943b: c9 2e       ..
    beq c9449                                                         ; 943d: f0 0a       ..
    ora #&20 ; ' '                                                    ; 943f: 09 20       .
    cmp vfs_string,x                                                  ; 9441: dd 42 93    .B.
    bne c945a                                                         ; 9444: d0 14       ..
    dex                                                               ; 9446: ca          .
    bpl loop_c9438                                                    ; 9447: 10 ef       ..
; &9449 referenced 2 times by &943d, &944e
.c9449
    lda (os_text_ptr),y                                               ; 9449: b1 f2       ..
    iny                                                               ; 944b: c8          .
    cmp #&20 ; ' '                                                    ; 944c: c9 20       .
    beq c9449                                                         ; 944e: f0 f9       ..
    bcs c945a                                                         ; 9450: b0 08       ..
    plx                                                               ; 9452: fa          .
    pla                                                               ; 9453: 68          h
    phx                                                               ; 9454: da          .
    phx                                                               ; 9455: da          .
    sec                                                               ; 9456: 38          8
    jmp c919f                                                         ; 9457: 4c 9f 91    L..

; &945a referenced 2 times by &9444, &9450
.c945a
    pla                                                               ; 945a: 68          h
    ply                                                               ; 945b: 7a          z
    lda #4                                                            ; 945c: a9 04       ..
    ldx romsel_copy                                                   ; 945e: a6 f4       ..
    rts                                                               ; 9460: 60          `

.Service_handler_UnrecognisedOSWord
    phy                                                               ; 9461: 5a          Z
    lda l00ef                                                         ; 9462: a5 ef       ..
    cmp #&60 ; '`'                                                    ; 9464: c9 60       .`
    bcc c94d6                                                         ; 9466: 90 6e       .n
    cmp #&65 ; 'e'                                                    ; 9468: c9 65       .e
    bcs c94d6                                                         ; 946a: b0 6a       .j
    lda #0                                                            ; 946c: a9 00       ..
    tay                                                               ; 946e: a8          .
    jsr osargs                                                        ; 946f: 20 da ff     ..            ; Get filing system number (A=0, Y=0)
    ; A is the filing system number:
    ;     A=0, no filing system selected
    ;     A=1, 1200 baud CFS
    ;     A=2, 300 baud CFS
    ;     A=3, ROM filing system
    ;     A=4, Disc filing system
    ;     A=5, Network filing system
    ;     A=6, Teletext filing system
    ;     A=7, IEEE filing system
    ;     A=8, ADFS
    ;     A=9, Host filing system
    ;     A=10, Videodisc filing system
    cmp #&0a                                                          ; 9472: c9 0a       ..             ; A=filing system number
    beq c9479                                                         ; 9474: f0 03       ..
    jsr sub_c9154                                                     ; 9476: 20 54 91     T.
; &9479 referenced 1 time by &9474
.c9479
    lda l00ef                                                         ; 9479: a5 ef       ..
    cmp #&64 ; 'd'                                                    ; 947b: c9 64       .d
    bne c9494                                                         ; 947d: d0 15       ..
    ldx #0                                                            ; 947f: a2 00       ..
    ldy #&ce                                                          ; 9481: a0 ce       ..
    lda #&c8                                                          ; 9483: a9 c8       ..
    jsr sub_cab93                                                     ; 9485: 20 93 ab     ..
    ldy #&0f                                                          ; 9488: a0 0f       ..
; &948a referenced 1 time by &9490
.loop_c948a
    lda lce00,y                                                       ; 948a: b9 00 ce    ...
    sta (l00f0),y                                                     ; 948d: 91 f0       ..
    dey                                                               ; 948f: 88          .
    bpl loop_c948a                                                    ; 9490: 10 f8       ..
    bmi c94d0                                                         ; 9492: 30 3c       0<
; &9494 referenced 1 time by &947d
.c9494
    cmp #&62 ; 'b'                                                    ; 9494: c9 62       .b
    bne c94dc                                                         ; 9496: d0 44       .D
    lda l00f0                                                         ; 9498: a5 f0       ..
    sta l00ba                                                         ; 949a: 85 ba       ..
    lda l00f1                                                         ; 949c: a5 f1       ..
    sta l00bb                                                         ; 949e: 85 bb       ..
    ldy #&0f                                                          ; 94a0: a0 0f       ..
; &94a2 referenced 1 time by &94a8
.loop_c94a2
    lda (l00ba),y                                                     ; 94a2: b1 ba       ..
    sta lc215,y                                                       ; 94a4: 99 15 c2    ...
    dey                                                               ; 94a7: 88          .
    bpl loop_c94a2                                                    ; 94a8: 10 f8       ..
    lda lc21a                                                         ; 94aa: ad 1a c2    ...
    and #&1d                                                          ; 94ad: 29 1d       ).
    cmp #8                                                            ; 94af: c9 08       ..
    beq c94c4                                                         ; 94b1: f0 11       ..
; &94b3 referenced 1 time by &94c7
.loop_c94b3
    ldx #&15                                                          ; 94b3: a2 15       ..
    ldy #&c2                                                          ; 94b5: a0 c2       ..
    inc lc317                                                         ; 94b7: ee 17 c3    ...
    beq c94bf                                                         ; 94ba: f0 03       ..
    dec lc317                                                         ; 94bc: ce 17 c3    ...
; &94bf referenced 1 time by &94ba
.c94bf
    jsr access_scsi_drive                                             ; 94bf: 20 a7 80     ..
    bra c94cc                                                         ; 94c2: 80 08       ..
; &94c4 referenced 1 time by &94b1
.c94c4
    lda lc21e                                                         ; 94c4: ad 1e c2    ...
    bne loop_c94b3                                                    ; 94c7: d0 ea       ..
    jsr sub_c887e                                                     ; 94c9: 20 7e 88     ~.
; &94cc referenced 1 time by &94c2
.c94cc
    ldy #0                                                            ; 94cc: a0 00       ..
    sta (l00ba),y                                                     ; 94ce: 91 ba       ..
; &94d0 referenced 5 times by &9492, &94ea, &94fc, &9510, &9d25
.c94d0
    ldx romsel_copy                                                   ; 94d0: a6 f4       ..
    ply                                                               ; 94d2: 7a          z
    lda #0                                                            ; 94d3: a9 00       ..
    rts                                                               ; 94d5: 60          `

; &94d6 referenced 3 times by &9466, &946a, &9501
.c94d6
    ldx romsel_copy                                                   ; 94d6: a6 f4       ..
    ply                                                               ; 94d8: 7a          z
    lda #8                                                            ; 94d9: a9 08       ..
    rts                                                               ; 94db: 60          `

; &94dc referenced 1 time by &9496
.c94dc
    cmp #&63 ; 'c'                                                    ; 94dc: c9 63       .c
    bne c94ec                                                         ; 94de: d0 0c       ..
    ldy #4                                                            ; 94e0: a0 04       ..
; &94e2 referenced 1 time by &94e8
.loop_c94e2
    lda lc2d0,y                                                       ; 94e2: b9 d0 c2    ...
    sta (l00f0),y                                                     ; 94e5: 91 f0       ..
    dey                                                               ; 94e7: 88          .
    bpl loop_c94e2                                                    ; 94e8: 10 f8       ..
    bmi c94d0                                                         ; 94ea: 30 e4       0.
; &94ec referenced 1 time by &94de
.c94ec
    cmp #&60 ; '`'                                                    ; 94ec: c9 60       .`
    bne c94ff                                                         ; 94ee: d0 0f       ..
    lda lc8fa                                                         ; 94f0: ad fa c8    ...
    ldy #0                                                            ; 94f3: a0 00       ..
    sta (l00f0),y                                                     ; 94f5: 91 f0       ..
    lda tube_used_zp                                                  ; 94f7: a5 cd       ..
    iny                                                               ; 94f9: c8          .
    sta (l00f0),y                                                     ; 94fa: 91 f0       ..
    jmp c94d0                                                         ; 94fc: 4c d0 94    L..

; &94ff referenced 1 time by &94ee
.c94ff
    cmp #&61 ; 'a'                                                    ; 94ff: c9 61       .a
    bne c94d6                                                         ; 9501: d0 d3       ..
    jsr sub_c98c2                                                     ; 9503: 20 c2 98     ..
    ldy #3                                                            ; 9506: a0 03       ..
; &9508 referenced 1 time by &950e
.loop_c9508
    lda lc215,y                                                       ; 9508: b9 15 c2    ...
    sta (l00f0),y                                                     ; 950b: 91 f0       ..
    dey                                                               ; 950d: 88          .
    bpl loop_c9508                                                    ; 950e: 10 f8       ..
    bra c94d0                                                         ; 9510: 80 be       ..
; &9512 referenced 2 times by &9531, &9590
.sub_c9512
    jsr print_string                                                  ; 9512: 20 57 8c     W.
    equs &0d, "Videodisc FS 1.70", &80+&0d                            ; 9515: 0d 56 69... .Vi

    rts                                                               ; 9528: 60          `

.Service_handler_StarHELP
    tya                                                               ; 9529: 98          .
    pha                                                               ; 952a: 48          H
    lda (os_text_ptr),y                                               ; 952b: b1 f2       ..
    cmp #&20 ; ' '                                                    ; 952d: c9 20       .
    bcs c9574                                                         ; 952f: b0 43       .C
    jsr sub_c9512                                                     ; 9531: 20 12 95     ..
    jsr print_string                                                  ; 9534: 20 57 8c     W.
    equs "  VFS, Video, Mouse, Trackerball", &80+&0d                  ; 9537: 20 20 56...   V

; &9558 referenced 2 times by &9568, &9598
.c9558
    pla                                                               ; 9558: 68          h
    tay                                                               ; 9559: a8          .
    ldx romsel_copy                                                   ; 955a: a6 f4       ..
    lda #9                                                            ; 955c: a9 09       ..
; &955e referenced 1 time by &9564
.loop_c955e
    rts                                                               ; 955e: 60          `

; &955f referenced 2 times by &956a, &956f
.sub_c955f
    iny                                                               ; 955f: c8          .
    lda (os_text_ptr),y                                               ; 9560: b1 f2       ..
    cmp #&20 ; ' '                                                    ; 9562: c9 20       .
    bcs loop_c955e                                                    ; 9564: b0 f8       ..
    pla                                                               ; 9566: 68          h
    pla                                                               ; 9567: 68          h
    bcc c9558                                                         ; 9568: 90 ee       ..
; &956a referenced 3 times by &956d, &9584, &958e
.c956a
    jsr sub_c955f                                                     ; 956a: 20 5f 95     _.
    bne c956a                                                         ; 956d: d0 fb       ..
; &956f referenced 1 time by &9572
.loop_c956f
    jsr sub_c955f                                                     ; 956f: 20 5f 95     _.
    beq loop_c956f                                                    ; 9572: f0 fb       ..
; &9574 referenced 1 time by &952f
.c9574
    jsr sub_ca7db                                                     ; 9574: 20 db a7     ..
    ldx #2                                                            ; 9577: a2 02       ..
; &9579 referenced 1 time by &9588
.loop_c9579
    lda (os_text_ptr),y                                               ; 9579: b1 f2       ..
    cmp #&2e ; '.'                                                    ; 957b: c9 2e       ..
    beq c9590                                                         ; 957d: f0 11       ..
    ora #&20 ; ' '                                                    ; 957f: 09 20       .
    cmp vfs_string,x                                                  ; 9581: dd 42 93    .B.
    bne c956a                                                         ; 9584: d0 e4       ..
    iny                                                               ; 9586: c8          .
    dex                                                               ; 9587: ca          .
    bpl loop_c9579                                                    ; 9588: 10 ef       ..
    lda (os_text_ptr),y                                               ; 958a: b1 f2       ..
    cmp #&21 ; '!'                                                    ; 958c: c9 21       .!
    bcs c956a                                                         ; 958e: b0 da       ..
; &9590 referenced 1 time by &957d
.c9590
    jsr sub_c9512                                                     ; 9590: 20 12 95     ..
    ldx #0                                                            ; 9593: a2 00       ..
; &9595 referenced 1 time by &95cc
.c9595
    lda vfs_command_table,x                                           ; 9595: bd b4 96    ...
    bmi c9558                                                         ; 9598: 30 be       0.
    jsr print_string                                                  ; 959a: 20 57 8c     W.
    equs " ", &80+' '                                                 ; 959d: 20 a0        .

    ldy #9                                                            ; 959f: a0 09       ..
; &95a1 referenced 1 time by &95ab
.loop_c95a1
    lda vfs_command_table,x                                           ; 95a1: bd b4 96    ...
    bmi c95ad                                                         ; 95a4: 30 07       0.
    jsr print_char                                                    ; 95a6: 20 28 97     (.
    inx                                                               ; 95a9: e8          .
    dey                                                               ; 95aa: 88          .
    bpl loop_c95a1                                                    ; 95ab: 10 f4       ..
; &95ad referenced 2 times by &95a4, &95b1
.c95ad
    jsr print_space                                                   ; 95ad: 20 22 97     ".
    dey                                                               ; 95b0: 88          .
    bpl c95ad                                                         ; 95b1: 10 fa       ..
    phx                                                               ; 95b3: da          .
    lda vfs_command_table+2,x                                         ; 95b4: bd b6 96    ...
    pha                                                               ; 95b7: 48          H
    lsr a                                                             ; 95b8: 4a          J
    lsr a                                                             ; 95b9: 4a          J
    lsr a                                                             ; 95ba: 4a          J
    lsr a                                                             ; 95bb: 4a          J
    jsr sub_c8c32                                                     ; 95bc: 20 32 8c     2.
    pla                                                               ; 95bf: 68          h
    and #&0f                                                          ; 95c0: 29 0f       ).
    jsr sub_c8c32                                                     ; 95c2: 20 32 8c     2.
    jsr c9726                                                         ; 95c5: 20 26 97     &.
    plx                                                               ; 95c8: fa          .
    inx                                                               ; 95c9: e8          .
    inx                                                               ; 95ca: e8          .
    inx                                                               ; 95cb: e8          .
    bra c9595                                                         ; 95cc: 80 c7       ..
; &95ce referenced 1 time by &8c37
.string_spec_list_pointers
    equb        <string_Null,   <string_list_spec                     ; 95ce: b3 69       .i
    equb     <string_ob_spec, <string_starob_spec                     ; 95d0: 75 7f       u.
    equb       <string_drive,       <string_sp_lp                     ; 95d2: 8b 95       ..
    equb        <string_LWRE,       <string_title                     ; 95d4: 9f ac       ..

.sub_c95d6
    stx l00b4                                                         ; 95d6: 86 b4       ..
    sty l00b5                                                         ; 95d8: 84 b5       ..
    sta lc2d6                                                         ; 95da: 8d d6 c2    ...
    tax                                                               ; 95dd: aa          .
    bmi c95f3                                                         ; 95de: 30 13       0.
    cmp #&0c                                                          ; 95e0: c9 0c       ..
    bcs c95f3                                                         ; 95e2: b0 0f       ..
    stz lc2d5                                                         ; 95e4: 9c d5 c2    ...
    lda l9600,x                                                       ; 95e7: bd 00 96    ...
    pha                                                               ; 95ea: 48          H
    lda l95f4,x                                                       ; 95eb: bd f4 95    ...
    pha                                                               ; 95ee: 48          H
    ldx l00b4                                                         ; 95ef: a6 b4       ..
    ldy l00b5                                                         ; 95f1: a4 b5       ..
; &95f3 referenced 2 times by &95de, &95e2
.c95f3
    rts                                                               ; 95f3: 60          `

; &95f4 referenced 1 time by &95eb
.l95f4
    equb <(sub_c9701-1)                                               ; 95f4: 00          .
    equb <(sub_c9e86-1)                                               ; 95f5: 85          .
    equb <(sub_c99bd-1)                                               ; 95f6: bc          .
    equb <(sub_c960c-1)                                               ; 95f7: 0b          .
    equb <(sub_c99bd-1)                                               ; 95f8: bc          .
    equb <(sub_c8d84-1)                                               ; 95f9: 83          .
    equb <(sub_c9c14-1)                                               ; 95fa: 13          .
    equb <(sub_c96fc-1)                                               ; 95fb: fb          .
    equb <(sub_c97c8-1)                                               ; 95fc: c7          .
    equb <(sub_c8de9-1)                                               ; 95fd: e8          .
    equb <(sub_c8e9d-1)                                               ; 95fe: 9c          .
    equb <(sub_c99bd-1)                                               ; 95ff: bc          .
; &9600 referenced 1 time by &95e7
.l9600
    equb >(sub_c9701-1)                                               ; 9600: 97          .
    equb >(sub_c9e86-1)                                               ; 9601: 9e          .
    equb >(sub_c99bd-1)                                               ; 9602: 99          .
    equb >(sub_c960c-1)                                               ; 9603: 96          .
    equb >(sub_c99bd-1)                                               ; 9604: 99          .
    equb >(sub_c8d84-1)                                               ; 9605: 8d          .
    equb >(sub_c9c14-1)                                               ; 9606: 9c          .
    equb >(sub_c96fc-1)                                               ; 9607: 96          .
    equb >(sub_c97c8-1)                                               ; 9608: 97          .
    equb >(sub_c8de9-1)                                               ; 9609: 8d          .
    equb >(sub_c8e9d-1)                                               ; 960a: 8e          .
    equb >(sub_c99bd-1)                                               ; 960b: 99          .

.sub_c960c
    jsr sub_cb80a                                                     ; 960c: 20 0a b8     ..
    jsr ensure_drive                                                  ; 960f: 20 e0 82     ..
    lda #&a2                                                          ; 9612: a9 a2       ..
    sta l00b8                                                         ; 9614: 85 b8       ..
    lda #&c2                                                          ; 9616: a9 c2       ..
    sta l00b9                                                         ; 9618: 85 b9       ..
    jsr sub_c9aef                                                     ; 961a: 20 ef 9a     ..
    ldx #&fd                                                          ; 961d: a2 fd       ..
; &961f referenced 2 times by &963f, &9651
.c961f
    inx                                                               ; 961f: e8          .
    inx                                                               ; 9620: e8          .
    ldy #&ff                                                          ; 9621: a0 ff       ..
; &9623 referenced 2 times by &962c, &9632
.c9623
    inx                                                               ; 9623: e8          .
    iny                                                               ; 9624: c8          .
    lda vfs_command_table,x                                           ; 9625: bd b4 96    ...
    bmi c9644                                                         ; 9628: 30 1a       0.
    cmp (l00b4),y                                                     ; 962a: d1 b4       ..
    beq c9623                                                         ; 962c: f0 f5       ..
    ora #&20 ; ' '                                                    ; 962e: 09 20       .
    cmp (l00b4),y                                                     ; 9630: d1 b4       ..
    beq c9623                                                         ; 9632: f0 ef       ..
    dex                                                               ; 9634: ca          .
; &9635 referenced 1 time by &9639
.loop_c9635
    inx                                                               ; 9635: e8          .
    lda vfs_command_table,x                                           ; 9636: bd b4 96    ...
    bpl loop_c9635                                                    ; 9639: 10 fa       ..
    lda (l00b4),y                                                     ; 963b: b1 b4       ..
    cmp #&2e ; '.'                                                    ; 963d: c9 2e       ..
    bne c961f                                                         ; 963f: d0 de       ..
    iny                                                               ; 9641: c8          .
    bne c9653                                                         ; 9642: d0 0f       ..
; &9644 referenced 1 time by &9628
.c9644
    tya                                                               ; 9644: 98          .
    beq c9660                                                         ; 9645: f0 19       ..
    lda (l00b4),y                                                     ; 9647: b1 b4       ..
    and #&5f ; '_'                                                    ; 9649: 29 5f       )_
    cmp #&41 ; 'A'                                                    ; 964b: c9 41       .A
    bcc c9653                                                         ; 964d: 90 04       ..
    cmp #&5b ; '['                                                    ; 964f: c9 5b       .[
    bcc c961f                                                         ; 9651: 90 cc       ..
; &9653 referenced 2 times by &9642, &964d
.c9653
    tya                                                               ; 9653: 98          .
    clc                                                               ; 9654: 18          .
    adc l00b4                                                         ; 9655: 65 b4       e.
    sta l00b4                                                         ; 9657: 85 b4       ..
    bcc c965d                                                         ; 9659: 90 02       ..
    inc l00b5                                                         ; 965b: e6 b5       ..
; &965d referenced 1 time by &9659
.c965d
    jsr sub_c9aef                                                     ; 965d: 20 ef 9a     ..
; &9660 referenced 1 time by &9645
.c9660
    lda vfs_command_table,x                                           ; 9660: bd b4 96    ...
    pha                                                               ; 9663: 48          H
    lda vfs_command_table+1,x                                         ; 9664: bd b5 96    ...
    pha                                                               ; 9667: 48          H
    rts                                                               ; 9668: 60          `

.string_list_spec
    equs "<List Spec>"                                                ; 9669: 3c 4c 69... <Li
    equb 0                                                            ; 9674: 00          .
.string_ob_spec
    equs "<Ob Spec>"                                                  ; 9675: 3c 4f 62... <Ob
    equb 0                                                            ; 967e: 00          .
.string_starob_spec
    equs "<*Ob Spec*>"                                                ; 967f: 3c 2a 4f... <*O
    equb 0                                                            ; 968a: 00          .
.string_drive
    equs "(<Drive>)"                                                  ; 968b: 28 3c 44... (<D
    equb 0                                                            ; 9694: 00          .
.string_sp_lp
    equs "<SP> <LP>"                                                  ; 9695: 3c 53 50... <SP
    equb 0                                                            ; 969e: 00          .
.string_LWRE
    equs "(L)(W)(R)(E)"                                               ; 969f: 28 4c 29... (L)
    equb 0                                                            ; 96ab: 00          .
.string_title
    equs "<Title>"                                                    ; 96ac: 3c 54 69... <Ti
.string_Null
    equb 0                                                            ; 96b3: 00          .
; &96b4 referenced 5 times by &9595, &95a1, &9625, &9636, &9660
.vfs_command_table
    equs "BACK"                                                       ; 96b4: 42 41 43... BAC
; &96b5 referenced 1 time by &9664
; &96b6 referenced 1 time by &95b4
    equb >(BACK_command-1)                                            ; 96b8: 9a          .
    equb <(BACK_command-1)                                            ; 96b9: b6          .
    equb 0                                                            ; 96ba: 00          .
    equs "BYE"                                                        ; 96bb: 42 59 45    BYE
    equb >(BYE_command-1)                                             ; 96be: 97          .
    equb <(BYE_command-1)                                             ; 96bf: c8          .
    equb 0                                                            ; 96c0: 00          .
    equs "DIR"                                                        ; 96c1: 44 49 52    DIR
    equb >(DIR_command-1)                                             ; 96c4: 8e          .
    equb <(DIR_command-1)                                             ; 96c5: f4          .
    equs " DISMOUNT"                                                  ; 96c6: 20 44 49...  DI
    equb >(DISMOUNT_command-1)                                        ; 96cf: 98          .
    equb <(DISMOUNT_command-1)                                        ; 96d0: 03          .
    equs "@FREE"                                                      ; 96d1: 40 46 52... @FR
    equb >(FREE_command-1)                                            ; 96d6: 97          .
    equb <(FREE_command-1)                                            ; 96d7: 4e          N
    equb 0                                                            ; 96d8: 00          .
    equs "LCAT"                                                       ; 96d9: 4c 43 41... LCA
    equb >(LCAT_command-1)                                            ; 96dd: 9a          .
    equb <(LCAT_command-1)                                            ; 96de: 9e          .
    equb 0                                                            ; 96df: 00          .
    equs "LEX"                                                        ; 96e0: 4c 45 58    LEX
    equb >(LEX_command-1)                                             ; 96e3: 9a          .
    equb <(LEX_command-1)                                             ; 96e4: aa          .
    equb 0                                                            ; 96e5: 00          .
    equs "LIB"                                                        ; 96e6: 4c 49 42    LIB
    equb >(LIB_command-1)                                             ; 96e9: 9a          .
    equb <(LIB_command-1)                                             ; 96ea: 63          c
    equs "0MAP"                                                       ; 96eb: 30 4d 41... 0MA
    equb >(MAP_command-1)                                             ; 96ef: 97          .
    equb <(MAP_command-1)                                             ; 96f0: 7d          }
    equb 0                                                            ; 96f1: 00          .
    equs "MOUNT"                                                      ; 96f2: 4d 4f 55... MOU
    equb >(MOUNT_command-1)                                           ; 96f7: 98          .
    equb <(MOUNT_command-1)                                           ; 96f8: 63          c
    equb &40                                                          ; 96f9: 40          @
    equb >(sub_c99bd-1)                                               ; 96fa: 99          .
    equb <(sub_c99bd-1)                                               ; 96fb: bc          .

.sub_c96fc
    ldx #&50 ; 'P'                                                    ; 96fc: a2 50       .P
    ldy #&59 ; 'Y'                                                    ; 96fe: a0 59       .Y
    rts                                                               ; 9700: 60          `

.sub_c9701
    ldx l00b4                                                         ; 9701: a6 b4       ..
    beq c970f                                                         ; 9703: f0 0a       ..
    dex                                                               ; 9705: ca          .
    bne c9716                                                         ; 9706: d0 0e       ..
    lda #4                                                            ; 9708: a9 04       ..
    tsb tube_used_zp                                                  ; 970a: 04 cd       ..
    tya                                                               ; 970c: 98          .
    bne c9713                                                         ; 970d: d0 04       ..
; &970f referenced 1 time by &9703
.c970f
    lda #4                                                            ; 970f: a9 04       ..
    trb tube_used_zp                                                  ; 9711: 14 cd       ..
; &9713 referenced 1 time by &970d
.c9713
    jmp c880d                                                         ; 9713: 4c 0d 88    L..

; &9716 referenced 1 time by &9706
.c9716
    jsr generate_error_inline                                         ; 9716: 20 26 83     &.
    equs &cb, "Bad opt", 0                                            ; 9719: cb 42 61... .Ba

; &9722 referenced 8 times by &8c50, &8c99, &8cb2, &8cc9, &8dab, &8ee1, &8ee4, &95ad
.print_space
    lda #&20 ; ' '                                                    ; 9722: a9 20       .
    bra print_char                                                    ; 9724: 80 02       ..
; &9726 referenced 5 times by &8da5, &8dcf, &8ef2, &95c5, &97c1
.c9726
    lda #&0d                                                          ; 9726: a9 0d       ..
; &9728 referenced 14 times by &8c87, &8ca8, &8cba, &8cc6, &8cdd, &8d0f, &8dcc, &8eba, &8ff2, &90eb, &95a6, &9724, &994d, &9959
.print_char
    phx                                                               ; 9728: da          .
    phy                                                               ; 9729: 5a          Z
    pha                                                               ; 972a: 48          H
; osbyte set *spool file handle to zero
    lda #&c7                                                          ; 972b: a9 c7       ..
    ldy #0                                                            ; 972d: a0 00       ..
    jsr OSBYTE_X0                                                     ; 972f: 20 85 84     ..
    cpx #&50 ; 'P'                                                    ; 9732: e0 50       .P
    bcc c973f                                                         ; 9734: 90 09       ..
    cpx #&5a ; 'Z'                                                    ; 9736: e0 5a       .Z
    bcs c973f                                                         ; 9738: b0 05       ..
    jsr osbyte                                                        ; 973a: 20 f4 ff     ..
    ldx #0                                                            ; 973d: a2 00       ..
; &973f referenced 2 times by &9734, &9738
.c973f
    pla                                                               ; 973f: 68          h
    pha                                                               ; 9740: 48          H
    jsr osasci                                                        ; 9741: 20 e3 ff     ..            ; Write character
    lda #osbyte_read_write_spool_file_handle                          ; 9744: a9 c7       ..
    ldy #&ff                                                          ; 9746: a0 ff       ..
    jsr osbyte                                                        ; 9748: 20 f4 ff     ..            ; Read/Write *SPOOL file handle
    pla                                                               ; 974b: 68          h
    ply                                                               ; 974c: 7a          z
    plx                                                               ; 974d: fa          .
    rts                                                               ; 974e: 60          `

.FREE_command
    jsr sub_c98c2                                                     ; 974f: 20 c2 98     ..
    jsr sub_c98de                                                     ; 9752: 20 de 98     ..
    jsr print_string                                                  ; 9755: 20 57 8c     W.
    equs "Free", &80+&0d                                              ; 9758: 46 72 65... Fre

    jsr sub_c98c2                                                     ; 975d: 20 c2 98     ..
    ldy #1                                                            ; 9760: a0 01       ..
    ldx #2                                                            ; 9762: a2 02       ..
    sec                                                               ; 9764: 38          8
; &9765 referenced 1 time by &9770
.loop_c9765
    lda lc0fb,y                                                       ; 9765: b9 fb c0    ...
    sbc lc215,y                                                       ; 9768: f9 15 c2    ...
    sta lc215,y                                                       ; 976b: 99 15 c2    ...
    iny                                                               ; 976e: c8          .
    dex                                                               ; 976f: ca          .
    bpl loop_c9765                                                    ; 9770: 10 f3       ..
    jsr sub_c98de                                                     ; 9772: 20 de 98     ..
    jsr print_string                                                  ; 9775: 20 57 8c     W.
    equs "Used", &80+&0d                                              ; 9778: 55 73 65... Use

; &977d referenced 1 time by &9798
.loop_c977d
    rts                                                               ; 977d: 60          `

.MAP_command
    jsr print_string                                                  ; 977e: 20 57 8c     W.
    equs "Address :  Length", &80+&0d                                 ; 9781: 41 64 64... Add

    ldx #0                                                            ; 9793: a2 00       ..
; &9795 referenced 1 time by &97c6
.c9795
    cpx lc1fe                                                         ; 9795: ec fe c1    ...
    beq loop_c977d                                                    ; 9798: f0 e3       ..
    inx                                                               ; 979a: e8          .
    inx                                                               ; 979b: e8          .
    inx                                                               ; 979c: e8          .
    stx l00c6                                                         ; 979d: 86 c6       ..
    ldy #2                                                            ; 979f: a0 02       ..
; &97a1 referenced 1 time by &97a9
.loop_c97a1
    dex                                                               ; 97a1: ca          .
    lda pydis_end,x                                                   ; 97a2: bd 00 c0    ...
    jsr hex_byte_print                                                ; 97a5: 20 d1 8c     ..
    dey                                                               ; 97a8: 88          .
    bpl loop_c97a1                                                    ; 97a9: 10 f6       ..
    jsr print_string                                                  ; 97ab: 20 57 8c     W.
    equs "  : ", &80+' '                                              ; 97ae: 20 20 3a...   :

    ldx l00c6                                                         ; 97b3: a6 c6       ..
    ldy #2                                                            ; 97b5: a0 02       ..
; &97b7 referenced 1 time by &97bf
.loop_c97b7
    dex                                                               ; 97b7: ca          .
    lda lc100,x                                                       ; 97b8: bd 00 c1    ...
    jsr hex_byte_print                                                ; 97bb: 20 d1 8c     ..
    dey                                                               ; 97be: 88          .
    bpl loop_c97b7                                                    ; 97bf: 10 f6       ..
    jsr c9726                                                         ; 97c1: 20 26 97     &.
    ldx l00c6                                                         ; 97c4: a6 c6       ..
    bne c9795                                                         ; 97c6: d0 cd       ..
.sub_c97c8
    rts                                                               ; 97c8: 60          `

.BYE_command
    ldx #<SCSI_bye                                                    ; 97c9: a2 d0       ..
    ldy #>SCSI_bye                                                    ; 97cb: a0 97       ..
    jmp access_scsi_drive                                             ; 97cd: 4c a7 80    L..

.SCSI_bye
    equb   0,   0, &c9, &ff, &ff, &1b,   0,   0,   0,   0,   0        ; 97d0: 00 00 c9... ...

; &97db referenced 2 times by &9804, &9864
.sub_c97db
    jsr sub_c9aef                                                     ; 97db: 20 ef 9a     ..
    ldy lc317                                                         ; 97de: ac 17 c3    ...
    iny                                                               ; 97e1: c8          .
    beq c97e5                                                         ; 97e2: f0 01       ..
    dey                                                               ; 97e4: 88          .
; &97e5 referenced 1 time by &97e2
.c97e5
    sty lc26f                                                         ; 97e5: 8c 6f c2    .o.
    ldy #0                                                            ; 97e8: a0 00       ..
    lda (l00b4),y                                                     ; 97ea: b1 b4       ..
    cmp #&20 ; ' '                                                    ; 97ec: c9 20       .
    bcc c9800                                                         ; 97ee: 90 10       ..
    iny                                                               ; 97f0: c8          .
    lda (l00b4),y                                                     ; 97f1: b1 b4       ..
    cmp #&21 ; '!'                                                    ; 97f3: c9 21       .!
    bcs c9801                                                         ; 97f5: b0 0a       ..
    dey                                                               ; 97f7: 88          .
    lda (l00b4),y                                                     ; 97f8: b1 b4       ..
    jsr sub_c8692                                                     ; 97fa: 20 92 86     ..
    sta lc26f                                                         ; 97fd: 8d 6f c2    .o.
; &9800 referenced 1 time by &97ee
.c9800
    rts                                                               ; 9800: 60          `

; &9801 referenced 1 time by &97f5
.c9801
    jmp c85ab                                                         ; 9801: 4c ab 85    L..

.DISMOUNT_command
    jsr sub_c97db                                                     ; 9804: 20 db 97     ..
    ldx #9                                                            ; 9807: a2 09       ..
; &9809 referenced 1 time by &9823
.loop_c9809
    lda lc3ac,x                                                       ; 9809: bd ac c3    ...
    beq c9822                                                         ; 980c: f0 14       ..
    lda lc3b6,x                                                       ; 980e: bd b6 c3    ...
    and #&e0                                                          ; 9811: 29 e0       ).
    cmp lc26f                                                         ; 9813: cd 6f c2    .o.
    bne c9822                                                         ; 9816: d0 0a       ..
    clc                                                               ; 9818: 18          .
    txa                                                               ; 9819: 8a          .
    adc #&50 ; 'P'                                                    ; 981a: 69 50       iP
    tay                                                               ; 981c: a8          .
    lda #0                                                            ; 981d: a9 00       ..
    jsr sub_ca03c                                                     ; 981f: 20 3c a0     <.
; &9822 referenced 2 times by &980c, &9816
.c9822
    dex                                                               ; 9822: ca          .
    bpl loop_c9809                                                    ; 9823: 10 e4       ..
    lda lc317                                                         ; 9825: ad 17 c3    ...
    cmp lc26f                                                         ; 9828: cd 6f c2    .o.
    bne c9891                                                         ; 982b: d0 64       .d
    lda #&ff                                                          ; 982d: a9 ff       ..
    sta lc317                                                         ; 982f: 8d 17 c3    ...
    sta lc316                                                         ; 9832: 8d 16 c3    ...
    ldx #0                                                            ; 9835: a2 00       ..
    jsr sub_c983c                                                     ; 9837: 20 3c 98     <.
    bmi c9891                                                         ; 983a: 30 55       0U
; &983c referenced 4 times by &8466, &8469, &9837, &98b3
.sub_c983c
    ldy #9                                                            ; 983c: a0 09       ..
; &983e referenced 1 time by &9846
.loop_c983e
    lda unset_string-2,y                                              ; 983e: b9 47 98    .G.
    sta lc300,x                                                       ; 9841: 9d 00 c3    ...
    inx                                                               ; 9844: e8          .
    dey                                                               ; 9845: 88          .
    bpl loop_c983e                                                    ; 9846: 10 f6       ..
; &9847 referenced 1 time by &983e
    rts                                                               ; 9848: 60          `

.unset_string
    equb &0d                                                          ; 9849: 0d          .
    equs '"', "tesnU", '"'                                            ; 984a: 22 74 65... "te

; &9851 referenced 2 times by &91f8, &986d
.sub_c9851
    stz lc204                                                         ; 9851: 9c 04 c2    ...
    stz lc208                                                         ; 9854: 9c 08 c2    ...
    stz lc20c                                                         ; 9857: 9c 0c c2    ...
    stz lc210                                                         ; 985a: 9c 10 c2    ...
    stz lc214                                                         ; 985d: 9c 14 c2    ...
    inc lc204                                                         ; 9860: ee 04 c2    ...
    rts                                                               ; 9863: 60          `

.MOUNT_command
    jsr sub_c97db                                                     ; 9864: 20 db 97     ..
; &9867 referenced 1 time by &92ba
.sub_c9867
    lda lc26f                                                         ; 9867: ad 6f c2    .o.
    sta lc317                                                         ; 986a: 8d 17 c3    ...
    jsr sub_c9851                                                     ; 986d: 20 51 98     Q.
    ldx #<SCSI_drive_access_data                                      ; 9870: a2 b7       ..
    ldy #>SCSI_drive_access_data                                      ; 9872: a0 98       ..
    jsr access_scsi_drive                                             ; 9874: 20 a7 80     ..
    beq c9886                                                         ; 9877: f0 0d       ..
    pha                                                               ; 9879: 48          H
    lda #&ff                                                          ; 987a: a9 ff       ..
    sta lc317                                                         ; 987c: 8d 17 c3    ...
    sta lc316                                                         ; 987f: 8d 16 c3    ...
    pla                                                               ; 9882: 68          h
    jmp c8270                                                         ; 9883: 4c 70 82    Lp.

; &9886 referenced 1 time by &9877
.c9886
    lda #<dirdata                                                     ; 9886: a9 6a       .j
    sta l00b4                                                         ; 9888: 85 b4       ..
    lda #>dirdata                                                     ; 988a: a9 99       ..
    sta l00b5                                                         ; 988c: 85 b5       ..
    jsr DIR_command                                                   ; 988e: 20 f5 8e     ..
; &9891 referenced 2 times by &982b, &983a
.c9891
    lda lc31f                                                         ; 9891: ad 1f c3    ...
    cmp lc26f                                                         ; 9894: cd 6f c2    .o.
    bne c98a1                                                         ; 9897: d0 08       ..
    lda #&ff                                                          ; 9899: a9 ff       ..
    sta lc31e                                                         ; 989b: 8d 1e c3    ...
    sta lc31f                                                         ; 989e: 8d 1f c3    ...
; &98a1 referenced 1 time by &9897
.c98a1
    lda lc31b                                                         ; 98a1: ad 1b c3    ...
    cmp lc26f                                                         ; 98a4: cd 6f c2    .o.
    bne c98b6                                                         ; 98a7: d0 0d       ..
    lda #&ff                                                          ; 98a9: a9 ff       ..
    sta lc31a                                                         ; 98ab: 8d 1a c3    ...
    sta lc31b                                                         ; 98ae: 8d 1b c3    ...
    ldx #&0a                                                          ; 98b1: a2 0a       ..
    jsr sub_c983c                                                     ; 98b3: 20 3c 98     <.
; &98b6 referenced 1 time by &98a7
.c98b6
    rts                                                               ; 98b6: 60          `

.SCSI_drive_access_data
    equb   0,   0, &c9, &ff, &ff, &1b,   0,   0,   0,   1,   0        ; 98b7: 00 00 c9... ...

; &98c2 referenced 3 times by &9503, &974f, &975d
.sub_c98c2
    lda #0                                                            ; 98c2: a9 00       ..
    ldx #3                                                            ; 98c4: a2 03       ..
; &98c6 referenced 1 time by &98cd
.loop_c98c6
    sta lc215,x                                                       ; 98c6: 9d 15 c2    ...
    sta lc227,x                                                       ; 98c9: 9d 27 c2    .'.
    dex                                                               ; 98cc: ca          .
    bpl loop_c98c6                                                    ; 98cd: 10 f7       ..
    jsr sub_c84a1                                                     ; 98cf: 20 a1 84     ..
    ldx #2                                                            ; 98d2: a2 02       ..
; &98d4 referenced 1 time by &98db
.loop_c98d4
    lda lc25d,x                                                       ; 98d4: bd 5d c2    .].
    sta lc216,x                                                       ; 98d7: 9d 16 c2    ...
    dex                                                               ; 98da: ca          .
    bpl loop_c98d4                                                    ; 98db: 10 f7       ..
    rts                                                               ; 98dd: 60          `

; &98de referenced 2 times by &9752, &9772
.sub_c98de
    lda lc218                                                         ; 98de: ad 18 c2    ...
    jsr hex_byte_print                                                ; 98e1: 20 d1 8c     ..
    lda lc217                                                         ; 98e4: ad 17 c2    ...
    jsr hex_byte_print                                                ; 98e7: 20 d1 8c     ..
    lda lc216                                                         ; 98ea: ad 16 c2    ...
    jsr hex_byte_print                                                ; 98ed: 20 d1 8c     ..
    jsr print_string                                                  ; 98f0: 20 57 8c     W.
    equs " Sectors =", &80+' '                                        ; 98f3: 20 53 65...  Se

    ldx #&1f                                                          ; 98fe: a2 1f       ..
    stx lc233                                                         ; 9900: 8e 33 c2    .3.
    lda #0                                                            ; 9903: a9 00       ..
    ldx #9                                                            ; 9905: a2 09       ..
; &9907 referenced 1 time by &990b
.loop_c9907
    sta lc240,x                                                       ; 9907: 9d 40 c2    .@.
    dex                                                               ; 990a: ca          .
    bpl loop_c9907                                                    ; 990b: 10 fa       ..
; &990d referenced 1 time by &9931
.IRQ1_vector_entry
    asl lc215                                                         ; 990d: 0e 15 c2    ...
    rol lc216                                                         ; 9910: 2e 16 c2    ...
    rol lc217                                                         ; 9913: 2e 17 c2    ...
    rol lc218                                                         ; 9916: 2e 18 c2    ...
    ldx #0                                                            ; 9919: a2 00       ..
    ldy #9                                                            ; 991b: a0 09       ..
; &991d referenced 1 time by &992c
.loop_c991d
    lda lc240,x                                                       ; 991d: bd 40 c2    .@.
    rol a                                                             ; 9920: 2a          *
    cmp #&0a                                                          ; 9921: c9 0a       ..
    bcc c9927                                                         ; 9923: 90 02       ..
    sbc #&0a                                                          ; 9925: e9 0a       ..
; &9927 referenced 1 time by &9923
.c9927
    sta lc240,x                                                       ; 9927: 9d 40 c2    .@.
    inx                                                               ; 992a: e8          .
    dey                                                               ; 992b: 88          .
    bpl loop_c991d                                                    ; 992c: 10 ef       ..
    dec lc233                                                         ; 992e: ce 33 c2    .3.
    bpl IRQ1_vector_entry                                             ; 9931: 10 da       ..
    ldy #&20 ; ' '                                                    ; 9933: a0 20       .
    ldx #8                                                            ; 9935: a2 08       ..
; &9937 referenced 1 time by &995d
.c9937
    bne c993b                                                         ; 9937: d0 02       ..
    ldy #&2c ; ','                                                    ; 9939: a0 2c       .,
; &993b referenced 1 time by &9937
.c993b
    lda lc240,x                                                       ; 993b: bd 40 c2    .@.
    bne c9948                                                         ; 993e: d0 08       ..
    cpy #&2c ; ','                                                    ; 9940: c0 2c       .,
    beq c9948                                                         ; 9942: f0 04       ..
    lda #&20 ; ' '                                                    ; 9944: a9 20       .
    bne c994d                                                         ; 9946: d0 05       ..
; &9948 referenced 2 times by &993e, &9942
.c9948
    ldy #&2c ; ','                                                    ; 9948: a0 2c       .,
    clc                                                               ; 994a: 18          .
    adc #&30 ; '0'                                                    ; 994b: 69 30       i0
; &994d referenced 1 time by &9946
.c994d
    jsr print_char                                                    ; 994d: 20 28 97     (.
    cpx #6                                                            ; 9950: e0 06       ..
    beq c9958                                                         ; 9952: f0 04       ..
    cpx #3                                                            ; 9954: e0 03       ..
    bne c995c                                                         ; 9956: d0 04       ..
; &9958 referenced 1 time by &9952
.c9958
    tya                                                               ; 9958: 98          .
    jsr print_char                                                    ; 9959: 20 28 97     (.
; &995c referenced 1 time by &9956
.c995c
    dex                                                               ; 995c: ca          .
    bpl c9937                                                         ; 995d: 10 d8       ..
    jsr print_string                                                  ; 995f: 20 57 8c     W.
    equs " Bytes", &80+' '                                            ; 9962: 20 42 79...  By

    rts                                                               ; 9969: 60          `

.dirdata
    equb   0, &bd, &15, &c2, &0a, &0a, &0a, &0a, &1d, &16, &c2, &60   ; 996a: 00 bd 15... ...
    equb &20, &d7, &9a, &a5, &b5, &48, &a5, &b4, &48, &20, &d7, &9a   ; 9976: 20 d7 9a...  ..
    equb &a0,   0, &b1, &b4, &c9, &20, &b0, &23, &68, &85, &b4, &8d   ; 9982: a0 00 b1... ...
    equb &40, &c2, &68, &85, &b5, &8d, &41, &c2, &60                  ; 998e: 40 c2 68... @.h

; &9997 referenced 1 time by &99db
.c9997
    jsr sub_c9a93                                                     ; 9997: 20 93 9a     ..
    jsr c880d                                                         ; 999a: 20 0d 88     ..
    lda lc2d6                                                         ; 999d: ad d6 c2    ...
    cmp #&0b                                                          ; 99a0: c9 0b       ..
    beq c99ad                                                         ; 99a2: f0 09       ..
    lda #&0b                                                          ; 99a4: a9 0b       ..
    ldx l00c0                                                         ; 99a6: a6 c0       ..
    ldy l00c1                                                         ; 99a8: a4 c1       ..
    jmp c8f26                                                         ; 99aa: 4c 26 8f    L&.

; &99ad referenced 1 time by &99a2
.c99ad
    jsr generate_error_inline                                         ; 99ad: 20 26 83     &.
    equs &fe, "Bad command", 0                                        ; 99b0: fe 42 61... .Ba

.sub_c99bd
    lda l00b4                                                         ; 99bd: a5 b4       ..
    sta l00c0                                                         ; 99bf: 85 c0       ..
    lda l00b5                                                         ; 99c1: a5 b5       ..
    sta l00c1                                                         ; 99c3: 85 c1       ..
    jsr sub_c89c4                                                     ; 99c5: 20 c4 89     ..
    beq c99e0                                                         ; 99c8: f0 16       ..
    jsr c880d                                                         ; 99ca: 20 0d 88     ..
    lda l00c0                                                         ; 99cd: a5 c0       ..
    sta l00b4                                                         ; 99cf: 85 b4       ..
    lda l00c1                                                         ; 99d1: a5 c1       ..
    sta l00b5                                                         ; 99d3: 85 b5       ..
    jsr sub_c9a80                                                     ; 99d5: 20 80 9a     ..
    jsr sub_c89c4                                                     ; 99d8: 20 c4 89     ..
    bne c9997                                                         ; 99db: d0 ba       ..
    jsr sub_c9a93                                                     ; 99dd: 20 93 9a     ..
; &99e0 referenced 1 time by &99c8
.c99e0
    lda l00b4                                                         ; 99e0: a5 b4       ..
    sta lc2a2                                                         ; 99e2: 8d a2 c2    ...
    lda l00b5                                                         ; 99e5: a5 b5       ..
    sta lc2a3                                                         ; 99e7: 8d a3 c2    ...
    ldy #&0e                                                          ; 99ea: a0 0e       ..
    lda (l00b6),y                                                     ; 99ec: b1 b6       ..
    ldx #2                                                            ; 99ee: a2 02       ..
; &99f0 referenced 1 time by &99f4
.loop_c99f0
    iny                                                               ; 99f0: c8          .
    and (l00b6),y                                                     ; 99f1: 31 b6       1.
    dex                                                               ; 99f3: ca          .
    bpl loop_c99f0                                                    ; 99f4: 10 fa       ..
    inc a                                                             ; 99f6: 1a          .
    bne c9a0c                                                         ; 99f7: d0 13       ..
    ldx l00b6                                                         ; 99f9: a6 b6       ..
    ldy l00b7                                                         ; 99fb: a4 b7       ..
    lda #&40 ; '@'                                                    ; 99fd: a9 40       .@
    jsr sub_ca03c                                                     ; 99ff: 20 3c a0     <.
    sta lc332                                                         ; 9a02: 8d 32 c3    .2.
    ldx #<(starEdot_VFS_dotBOOT)                                      ; 9a05: a2 77       .w
    ldy #>(starEdot_VFS_dotBOOT)                                      ; 9a07: a0 8f       ..
    jmp oscli                                                         ; 9a09: 4c f7 ff    L..

; &9a0c referenced 1 time by &99f7
.c9a0c
    ldy #&0b                                                          ; 9a0c: a0 0b       ..
    lda (l00b6),y                                                     ; 9a0e: b1 b6       ..
    iny                                                               ; 9a10: c8          .
    and (l00b6),y                                                     ; 9a11: 31 b6       1.
    iny                                                               ; 9a13: c8          .
    and (l00b6),y                                                     ; 9a14: 31 b6       1.
    inc a                                                             ; 9a16: 1a          .
    bne c9a21                                                         ; 9a17: d0 08       ..
    jsr generate_error_inline                                         ; 9a19: 20 26 83     &.
    equs &93, "No!", 0                                                ; 9a1c: 93 4e 6f... .No

; &9a21 referenced 1 time by &9a17
.c9a21
    lda #&a5                                                          ; 9a21: a9 a5       ..
    sta lc2a8                                                         ; 9a23: 8d a8 c2    ...
    ldx #&a2                                                          ; 9a26: a2 a2       ..
    ldy #&c2                                                          ; 9a28: a0 c2       ..
    stx l00b8                                                         ; 9a2a: 86 b8       ..
    sty l00b9                                                         ; 9a2c: 84 b9       ..
    jsr sub_c89c4                                                     ; 9a2e: 20 c4 89     ..
    ldy #4                                                            ; 9a31: a0 04       ..
    lda (l00b6),y                                                     ; 9a33: b1 b6       ..
    ldy #0                                                            ; 9a35: a0 00       ..
    ora (l00b6),y                                                     ; 9a37: 11 b6       ..
    bmi c9a3e                                                         ; 9a39: 30 03       0.
    jmp c8a01                                                         ; 9a3b: 4c 01 8a    L..

; &9a3e referenced 1 time by &9a39
.c9a3e
    jsr sub_c8a21                                                     ; 9a3e: 20 21 8a     !.
    lda lc2ab                                                         ; 9a41: ad ab c2    ...
    cmp #&ff                                                          ; 9a44: c9 ff       ..
    bne c9a54                                                         ; 9a46: d0 0c       ..
    lda lc2aa                                                         ; 9a48: ad aa c2    ...
    cmp #&fe                                                          ; 9a4b: c9 fe       ..
    bcc c9a54                                                         ; 9a4d: 90 05       ..
; &9a4f referenced 1 time by &9a56
.loop_c9a4f
    lda #1                                                            ; 9a4f: a9 01       ..
    jmp (lc2a8)                                                       ; 9a51: 6c a8 c2    l..

; &9a54 referenced 2 times by &9a46, &9a4d
.c9a54
    bit tube_used_zp                                                  ; 9a54: 24 cd       $.
    bpl loop_c9a4f                                                    ; 9a56: 10 f7       ..
    jsr c8037                                                         ; 9a58: 20 37 80     7.
; excute code on co pro.
    ldx #&a8                                                          ; 9a5b: a2 a8       ..
    ldy #&c2                                                          ; 9a5d: a0 c2       ..
    lda #4                                                            ; 9a5f: a9 04       ..
    jmp l0406                                                         ; 9a61: 4c 06 04    L..

.LIB_command
    jsr c8e35                                                         ; 9a64: 20 35 8e     5.
    ldy #9                                                            ; 9a67: a0 09       ..
; &9a69 referenced 1 time by &9a70
.loop_c9a69
    lda lc8cc,y                                                       ; 9a69: b9 cc c8    ...
    sta lc30a,y                                                       ; 9a6c: 99 0a c3    ...
    dey                                                               ; 9a6f: 88          .
    bpl loop_c9a69                                                    ; 9a70: 10 f7       ..
    ldy #3                                                            ; 9a72: a0 03       ..
; &9a74 referenced 1 time by &9a7b
.loop_c9a74
    lda lc314,y                                                       ; 9a74: b9 14 c3    ...
    sta lc318,y                                                       ; 9a77: 99 18 c3    ...
    dey                                                               ; 9a7a: 88          .
    bpl loop_c9a74                                                    ; 9a7b: 10 f7       ..
; &9a7d referenced 1 time by &9a91
.loop_c9a7d
    jmp c880d                                                         ; 9a7d: 4c 0d 88    L..

; &9a80 referenced 3 times by &99d5, &9a9f, &9aab
.sub_c9a80
    ldy #3                                                            ; 9a80: a0 03       ..
; &9a82 referenced 1 time by &9a8f
.loop_c9a82
    lda lc314,y                                                       ; 9a82: b9 14 c3    ...
    sta lc230,y                                                       ; 9a85: 99 30 c2    .0.
    lda lc318,y                                                       ; 9a88: b9 18 c3    ...
    sta lc22c,y                                                       ; 9a8b: 99 2c c2    .,.
    dey                                                               ; 9a8e: 88          .
    bpl loop_c9a82                                                    ; 9a8f: 10 f1       ..
    bmi loop_c9a7d                                                    ; 9a91: 30 ea       0.
; &9a93 referenced 4 times by &9997, &99dd, &9aa2, &9aae
.sub_c9a93
    ldy #3                                                            ; 9a93: a0 03       ..
; &9a95 referenced 1 time by &9a9c
.loop_c9a95
    lda lc230,y                                                       ; 9a95: b9 30 c2    .0.
    sta lc22c,y                                                       ; 9a98: 99 2c c2    .,.
    dey                                                               ; 9a9b: 88          .
    bpl loop_c9a95                                                    ; 9a9c: 10 f7       ..
    rts                                                               ; 9a9e: 60          `

.LCAT_command
    jsr sub_c9a80                                                     ; 9a9f: 20 80 9a     ..
    jsr sub_c9a93                                                     ; 9aa2: 20 93 9a     ..
    jsr sub_c8d8a                                                     ; 9aa5: 20 8a 8d     ..
    jmp c880d                                                         ; 9aa8: 4c 0d 88    L..

.LEX_command
    jsr sub_c9a80                                                     ; 9aab: 20 80 9a     ..
    jsr sub_c9a93                                                     ; 9aae: 20 93 9a     ..
    jsr sub_c8dec                                                     ; 9ab1: 20 ec 8d     ..
    jmp c880d                                                         ; 9ab4: 4c 0d 88    L..

.BACK_command
    ldy #3                                                            ; 9ab7: a0 03       ..
; &9ab9 referenced 1 time by &9ac6
.loop_c9ab9
    lda lc31c,y                                                       ; 9ab9: b9 1c c3    ...
    sta lc22c,y                                                       ; 9abc: 99 2c c2    .,.
    lda lc314,y                                                       ; 9abf: b9 14 c3    ...
    sta lc31c,y                                                       ; 9ac2: 99 1c c3    ...
    dey                                                               ; 9ac5: 88          .
    bpl loop_c9ab9                                                    ; 9ac6: 10 f1       ..
    jsr c880d                                                         ; 9ac8: 20 0d 88     ..
    ldy #9                                                            ; 9acb: a0 09       ..
; &9acd referenced 1 time by &9ad4
.loop_c9acd
    lda lc8cc,y                                                       ; 9acd: b9 cc c8    ...
    sta lc300,y                                                       ; 9ad0: 99 00 c3    ...
    dey                                                               ; 9ad3: 88          .
    bpl loop_c9acd                                                    ; 9ad4: 10 f7       ..
    rts                                                               ; 9ad6: 60          `

    equb &a0,   0, &20, &8e, &85, &f0,   3, &c8, &d0, &f8, &c9, &2e   ; 9ad7: a0 00 20... ..
    equb &f0, &f9, &98, &18, &65, &b4, &85, &b4, &90,   2, &e6, &b5   ; 9ae3: f0 f9 98... ...

; &9aef referenced 6 times by &8583, &8657, &8d84, &961a, &965d, &97db
.sub_c9aef
    ldy #0                                                            ; 9aef: a0 00       ..
    clc                                                               ; 9af1: 18          .
    php                                                               ; 9af2: 08          .
; &9af3 referenced 1 time by &9b08
.loop_c9af3
    lda (l00b4),y                                                     ; 9af3: b1 b4       ..
    cmp #&20 ; ' '                                                    ; 9af5: c9 20       .
    bcc c9b0a                                                         ; 9af7: 90 11       ..
    beq c9b07                                                         ; 9af9: f0 0c       ..
    cmp #&22 ; '"'                                                    ; 9afb: c9 22       ."
    bne c9b0a                                                         ; 9afd: d0 0b       ..
    plp                                                               ; 9aff: 28          (
    bcc c9b05                                                         ; 9b00: 90 03       ..
    jmp c85ab                                                         ; 9b02: 4c ab 85    L..

; &9b05 referenced 1 time by &9b00
.c9b05
    sec                                                               ; 9b05: 38          8
    php                                                               ; 9b06: 08          .
; &9b07 referenced 1 time by &9af9
.c9b07
    iny                                                               ; 9b07: c8          .
    bne loop_c9af3                                                    ; 9b08: d0 e9       ..
; &9b0a referenced 2 times by &9af7, &9afd
.c9b0a
    tya                                                               ; 9b0a: 98          .
    plp                                                               ; 9b0b: 28          (
    clc                                                               ; 9b0c: 18          .
    adc l00b4                                                         ; 9b0d: 65 b4       e.
    sta l00b4                                                         ; 9b0f: 85 b4       ..
    bcc c9b15                                                         ; 9b11: 90 02       ..
    inc l00b5                                                         ; 9b13: e6 b5       ..
; &9b15 referenced 1 time by &9b11
.c9b15
    rts                                                               ; 9b15: 60          `

    equb &a0,   0, &b1, &b4, &29, &7f, &c9, &3a, &d0, &f5, &60        ; 9b16: a0 00 b1... ...

; &9b21 referenced 1 time by &9b38
.sub_c9b21
    ldx lc317                                                         ; 9b21: ae 17 c3    ...
    inx                                                               ; 9b24: e8          .
    bne c9b52                                                         ; 9b25: d0 2b       .+
    jsr generate_error_inline3                                        ; 9b27: 20 2d 83     -.
    equs &a9, "No directory", 0                                       ; 9b2a: a9 4e 6f... .No

; &9b38 referenced 2 times by &865d, &8ce0
.check_directory_for_Hugo
    jsr sub_c9b21                                                     ; 9b38: 20 21 9b     !.
    ldx #0                                                            ; 9b3b: a2 00       ..
    lda lc8fa                                                         ; 9b3d: ad fa c8    ...
; &9b40 referenced 1 time by &9b50
.loop_c9b40
    cmp lc400,x                                                       ; 9b40: dd 00 c4    ...
    bne c9b53                                                         ; 9b43: d0 0e       ..
    cmp lc8fa,x                                                       ; 9b45: dd fa c8    ...
    bne c9b53                                                         ; 9b48: d0 09       ..
    inx                                                               ; 9b4a: e8          .
    lda Hugo_string,x                                                 ; 9b4b: bd 9b 84    ...
    cpx #5                                                            ; 9b4e: e0 05       ..
    bne loop_c9b40                                                    ; 9b50: d0 ee       ..
; &9b52 referenced 1 time by &9b25
.c9b52
    rts                                                               ; 9b52: 60          `

; &9b53 referenced 2 times by &9b43, &9b48
.c9b53
    jsr generate_error_inline2                                        ; 9b53: 20 09 83     ..
    equs &a8, "Broken directory", 0                                   ; 9b56: a8 42 72... .Br

; &9b68 referenced 4 times by &885b, &9117, &9346, &9b74
.sub_c9b68
    ldx romsel_copy                                                   ; 9b68: a6 f4       ..
    lda rom_private_byte,x                                            ; 9b6a: bd f0 0d    ...
    sta l00bb                                                         ; 9b6d: 85 bb       ..
    lda #0                                                            ; 9b6f: a9 00       ..
    sta l00ba                                                         ; 9b71: 85 ba       ..
    rts                                                               ; 9b73: 60          `

; &9b74 referenced 2 times by &9b85, &9b8b
.sub_c9b74
    jsr sub_c9b68                                                     ; 9b74: 20 68 9b     h.
    ldy #&fd                                                          ; 9b77: a0 fd       ..
    tya                                                               ; 9b79: 98          .
    clc                                                               ; 9b7a: 18          .
; &9b7b referenced 1 time by &9b7e
.loop_c9b7b
    adc (l00ba),y                                                     ; 9b7b: 71 ba       q.
    dey                                                               ; 9b7d: 88          .
    bne loop_c9b7b                                                    ; 9b7e: d0 fb       ..
    adc (l00ba),y                                                     ; 9b80: 71 ba       q.
    ldy #&fe                                                          ; 9b82: a0 fe       ..
    rts                                                               ; 9b84: 60          `

; &9b85 referenced 2 times by &886d, &913f
.sub_c9b85
    jsr sub_c9b74                                                     ; 9b85: 20 74 9b     t.
    sta (l00ba),y                                                     ; 9b88: 91 ba       ..
; &9b8a referenced 1 time by &9b90
.loop_c9b8a
    rts                                                               ; 9b8a: 60          `

; &9b8b referenced 2 times by &9142, &91f5
.sub_c9b8b
    jsr sub_c9b74                                                     ; 9b8b: 20 74 9b     t.
    cmp (l00ba),y                                                     ; 9b8e: d1 ba       ..
    beq loop_c9b8a                                                    ; 9b90: f0 f8       ..
; &9b92 referenced 5 times by &9baa, &9bb9, &9bbd, &9bc5, &9bcd
.c9b92
    lda #&0f                                                          ; 9b92: a9 0f       ..
    sta lc2ce                                                         ; 9b94: 8d ce c2    ...
    jsr generate_error_inline3                                        ; 9b97: 20 2d 83     -.
    equs &aa, "Bad sum", 0                                            ; 9b9a: aa 42 61... .Ba

; &9ba3 referenced 7 times by &9c27, &9c37, &9e8e, &9ec2, &9fb5, &a03c, &a28c
.sub_c9ba3
    php                                                               ; 9ba3: 08          .
    pha                                                               ; 9ba4: 48          H
    phy                                                               ; 9ba5: 5a          Z
    phx                                                               ; 9ba6: da          .
    lda lc2ce                                                         ; 9ba7: ad ce c2    ...
    bne c9b92                                                         ; 9baa: d0 e6       ..
    jsr sub_c8b6a                                                     ; 9bac: 20 6a 8b     j.
    clc                                                               ; 9baf: 18          .
    ldx #&10                                                          ; 9bb0: a2 10       ..
; &9bb2 referenced 1 time by &9bc3
.loop_c9bb2
    lda lc204,x                                                       ; 9bb2: bd 04 c2    ...
    and #&21 ; '!'                                                    ; 9bb5: 29 21       )!
    beq c9bbf                                                         ; 9bb7: f0 06       ..
    bcs c9b92                                                         ; 9bb9: b0 d7       ..
    cmp #1                                                            ; 9bbb: c9 01       ..
    bne c9b92                                                         ; 9bbd: d0 d3       ..
; &9bbf referenced 1 time by &9bb7
.c9bbf
    dex                                                               ; 9bbf: ca          .
    dex                                                               ; 9bc0: ca          .
    dex                                                               ; 9bc1: ca          .
    dex                                                               ; 9bc2: ca          .
    bpl loop_c9bb2                                                    ; 9bc3: 10 ed       ..
    bcc c9b92                                                         ; 9bc5: 90 cb       ..
    jsr sub_c9bed                                                     ; 9bc7: 20 ed 9b     ..
    cmp lc2c1                                                         ; 9bca: cd c1 c2    ...
    bne c9b92                                                         ; 9bcd: d0 c3       ..
    pha                                                               ; 9bcf: 48          H
    pha                                                               ; 9bd0: 48          H
    ldy #5                                                            ; 9bd1: a0 05       ..
    tsx                                                               ; 9bd3: ba          .
; &9bd4 referenced 1 time by &9bdc
.loop_c9bd4
    lda l0103,x                                                       ; 9bd4: bd 03 01    ...
    sta l0101,x                                                       ; 9bd7: 9d 01 01    ...
    inx                                                               ; 9bda: e8          .
    dey                                                               ; 9bdb: 88          .
    bpl loop_c9bd4                                                    ; 9bdc: 10 f6       ..
    lda #<(Function_entered_via_rts_onstack-1)                        ; 9bde: a9 f7       ..
    sta l0101,x                                                       ; 9be0: 9d 01 01    ...
    lda #>(Function_entered_via_rts_onstack-1)                        ; 9be3: a9 9b       ..
    sta l0102,x                                                       ; 9be5: 9d 02 01    ...
    plx                                                               ; 9be8: fa          .
    ply                                                               ; 9be9: 7a          z
    pla                                                               ; 9bea: 68          h
    plp                                                               ; 9beb: 28          (
    rts                                                               ; 9bec: 60          `

; &9bed referenced 2 times by &9bc7, &9bfc
.sub_c9bed
    ldx #&78 ; 'x'                                                    ; 9bed: a2 78       .x
    txa                                                               ; 9bef: 8a          .
    clc                                                               ; 9bf0: 18          .
; &9bf1 referenced 1 time by &9bf5
.loop_c9bf1
    adc lc383,x                                                       ; 9bf1: 7d 83 c3    }..
    dex                                                               ; 9bf4: ca          .
    bne loop_c9bf1                                                    ; 9bf5: d0 fa       ..
    rts                                                               ; 9bf7: 60          `

; &9bf8 referenced 2 times by &83d3, &9211
.Function_entered_via_rts_onstack
    php                                                               ; 9bf8: 08          .
    pha                                                               ; 9bf9: 48          H
    phy                                                               ; 9bfa: 5a          Z
    phx                                                               ; 9bfb: da          .
    jsr sub_c9bed                                                     ; 9bfc: 20 ed 9b     ..
    sta lc2c1                                                         ; 9bff: 8d c1 c2    ...
    stz lc2ce                                                         ; 9c02: 9c ce c2    ...
    stz lc2d5                                                         ; 9c05: 9c d5 c2    ...
    stz lc2d9                                                         ; 9c08: 9c d9 c2    ...
    plx                                                               ; 9c0b: fa          .
    ply                                                               ; 9c0c: 7a          z
    pla                                                               ; 9c0d: 68          h
    plp                                                               ; 9c0e: 28          (
    rts                                                               ; 9c0f: 60          `

; &9c10 referenced 1 time by &9c1a
.loop_c9c10
    pha                                                               ; 9c10: 48          H
    jmp c8856                                                         ; 9c11: 4c 56 88    LV.

.sub_c9c14
    ldx lc317                                                         ; 9c14: ae 17 c3    ...
    inx                                                               ; 9c17: e8          .
    beq c9c26                                                         ; 9c18: f0 0c       ..
    jmp loop_c9c10                                                    ; 9c1a: 4c 10 9c    L..

.sub_c9c1d
    cpy #0                                                            ; 9c1d: c0 00       ..
    bne c9c37                                                         ; 9c1f: d0 16       ..
    tay                                                               ; 9c21: a8          .
    bne c9c27                                                         ; 9c22: d0 03       ..
    lda #&0a                                                          ; 9c24: a9 0a       ..
; &9c26 referenced 1 time by &9c18
.c9c26
    rts                                                               ; 9c26: 60          `

; &9c27 referenced 1 time by &9c22
.c9c27
    jsr sub_c9ba3                                                     ; 9c27: 20 a3 9b     ..
    stx l00c3                                                         ; 9c2a: 86 c3       ..
    dey                                                               ; 9c2c: 88          .
    bne c9c35                                                         ; 9c2d: d0 06       ..
; &9c2f referenced 1 time by &9c35
.loop_c9c2f
    ldx l00c3                                                         ; 9c2f: a6 c3       ..
    lda #0                                                            ; 9c31: a9 00       ..
    tay                                                               ; 9c33: a8          .
    rts                                                               ; 9c34: 60          `

; &9c35 referenced 1 time by &9c2d
.c9c35
    bra loop_c9c2f                                                    ; 9c35: 80 f8       ..
; &9c37 referenced 1 time by &9c1f
.c9c37
    jsr sub_c9ba3                                                     ; 9c37: 20 a3 9b     ..
; &9c3a referenced 1 time by &a2ee
.sub_c9c3a
    stx l00c3                                                         ; 9c3a: 86 c3       ..
    pha                                                               ; 9c3c: 48          H
    jsr sub_c9e4a                                                     ; 9c3d: 20 4a 9e     J.
    jsr sub_ca012                                                     ; 9c40: 20 12 a0     ..
    pla                                                               ; 9c43: 68          h
    ldy l00cf                                                         ; 9c44: a4 cf       ..
    tax                                                               ; 9c46: aa          .
    bne c9c69                                                         ; 9c47: d0 20       .
    ldx l00c3                                                         ; 9c49: a6 c3       ..
    lda lc37a,y                                                       ; 9c4b: b9 7a c3    .z.
    sta l0000,x                                                       ; 9c4e: 95 00       ..
    lda lc370,y                                                       ; 9c50: b9 70 c3    .p.
    sta l0001,x                                                       ; 9c53: 95 01       ..
    lda lc366,y                                                       ; 9c55: b9 66 c3    .f.
    sta l0002,x                                                       ; 9c58: 95 02       ..
    lda lc35c,y                                                       ; 9c5a: b9 5c c3    .\.
    sta l0003,x                                                       ; 9c5d: 95 03       ..
; &9c5f referenced 2 times by &9ca0, &9ccb
.c9c5f
    jsr c9fc5                                                         ; 9c5f: 20 c5 9f     ..
    lda #0                                                            ; 9c62: a9 00       ..
    ldx l00c3                                                         ; 9c64: a6 c3       ..
    ldy l00c2                                                         ; 9c66: a4 c2       ..
    rts                                                               ; 9c68: 60          `

; &9c69 referenced 1 time by &9c47
.c9c69
    dex                                                               ; 9c69: ca          .
    bne c9cb4                                                         ; 9c6a: d0 48       .H
    lda lc3ac,y                                                       ; 9c6c: b9 ac c3    ...
    bpl c9c71                                                         ; 9c6f: 10 00       ..
; &9c71 referenced 1 time by &9c6f
.c9c71
    ldx l00c3                                                         ; 9c71: a6 c3       ..
    ldy l00cf                                                         ; 9c73: a4 cf       ..
    sec                                                               ; 9c75: 38          8
    lda lc352,y                                                       ; 9c76: b9 52 c3    .R.
    sbc l0000,x                                                       ; 9c79: f5 00       ..
    lda lc348,y                                                       ; 9c7b: b9 48 c3    .H.
    sbc l0001,x                                                       ; 9c7e: f5 01       ..
    lda lc33e,y                                                       ; 9c80: b9 3e c3    .>.
    sbc l0002,x                                                       ; 9c83: f5 02       ..
    lda lc334,y                                                       ; 9c85: b9 34 c3    .4.
    sbc l0003,x                                                       ; 9c88: f5 03       ..
    bcc c9ca3                                                         ; 9c8a: 90 17       ..
    lda l0000,x                                                       ; 9c8c: b5 00       ..
    sta lc37a,y                                                       ; 9c8e: 99 7a c3    .z.
    lda l0001,x                                                       ; 9c91: b5 01       ..
    sta lc370,y                                                       ; 9c93: 99 70 c3    .p.
    lda l0002,x                                                       ; 9c96: b5 02       ..
    sta lc366,y                                                       ; 9c98: 99 66 c3    .f.
    lda l0003,x                                                       ; 9c9b: b5 03       ..
    sta lc35c,y                                                       ; 9c9d: 99 5c c3    .\.
    jmp c9c5f                                                         ; 9ca0: 4c 5f 9c    L_.

; &9ca3 referenced 1 time by &9c8a
.c9ca3
    jsr generate_error_inline                                         ; 9ca3: 20 26 83     &.
    equs &b7, "Outside file", 0                                       ; 9ca6: b7 4f 75... .Ou

; &9cb4 referenced 1 time by &9c6a
.c9cb4
    dex                                                               ; 9cb4: ca          .
    ldx l00c3                                                         ; 9cb5: a6 c3       ..
    lda lc352,y                                                       ; 9cb7: b9 52 c3    .R.
    sta l0000,x                                                       ; 9cba: 95 00       ..
    lda lc348,y                                                       ; 9cbc: b9 48 c3    .H.
    sta l0001,x                                                       ; 9cbf: 95 01       ..
    lda lc33e,y                                                       ; 9cc1: b9 3e c3    .>.
    sta l0002,x                                                       ; 9cc4: 95 02       ..
    lda lc334,y                                                       ; 9cc6: b9 34 c3    .4.
    sta l0003,x                                                       ; 9cc9: 95 03       ..
    jmp c9c5f                                                         ; 9ccb: 4c 5f 9c    L_.

    equb &a9,   0, &4c, &2f, &9c                                      ; 9cce: a9 00 4c... ..L

; &9cd3 referenced 1 time by &9dfd
.sub_c9cd3
    pha                                                               ; 9cd3: 48          H
    jsr ensure_drive                                                  ; 9cd4: 20 e0 82     ..
    jsr sub_c8089                                                     ; 9cd7: 20 89 80     ..
    pla                                                               ; 9cda: 68          h
    jsr c82d6                                                         ; 9cdb: 20 d6 82     ..
    lda lc203,x                                                       ; 9cde: bd 03 c2    ...
    sta lc333                                                         ; 9ce1: 8d 33 c3    .3.
    jsr c82d6                                                         ; 9ce4: 20 d6 82     ..
    lda lc202,x                                                       ; 9ce7: bd 02 c2    ...
    jsr c82d6                                                         ; 9cea: 20 d6 82     ..
    lda lc201,x                                                       ; 9ced: bd 01 c2    ...
    jsr c82d6                                                         ; 9cf0: 20 d6 82     ..
    lda #1                                                            ; 9cf3: a9 01       ..
    jsr c82d6                                                         ; 9cf5: 20 d6 82     ..
    lda #0                                                            ; 9cf8: a9 00       ..
    jmp c82d6                                                         ; 9cfa: 4c d6 82    L..

.Service_handler_UnrecognisedInterrupt
    lda tube_used_zp                                                  ; 9cfd: a5 cd       ..
    and #&21 ; '!'                                                    ; 9cff: 29 21       )!
    cmp #&21 ; '!'                                                    ; 9d01: c9 21       .!
    bne c9d0c                                                         ; 9d03: d0 07       ..
    jsr read_drive_status                                             ; 9d05: 20 74 80     t.
    cmp #&f2                                                          ; 9d08: c9 f2       ..
    beq c9d0f                                                         ; 9d0a: f0 03       ..
; &9d0c referenced 1 time by &9d03
.c9d0c
    lda #5                                                            ; 9d0c: a9 05       ..
    rts                                                               ; 9d0e: 60          `

; &9d0f referenced 1 time by &9d0a
.c9d0f
    phy                                                               ; 9d0f: 5a          Z
    lda #0                                                            ; 9d10: a9 00       ..
    sta scsi_enable_disable_IRQ                                       ; 9d12: 8d 83 fe    ...
    lda #1                                                            ; 9d15: a9 01       ..
    trb tube_used_zp                                                  ; 9d17: 14 cd       ..
    lda scsi_data                                                     ; 9d19: ad 80 fe    ...
    jsr sub_c82eb                                                     ; 9d1c: 20 eb 82     ..
    ora scsi_data                                                     ; 9d1f: 0d 80 fe    ...
    sta lc331                                                         ; 9d22: 8d 31 c3    .1.
    jmp c94d0                                                         ; 9d25: 4c d0 94    L..

; &9d28 referenced 2 times by &9d64, &9de6
.sub_c9d28
    txa                                                               ; 9d28: 8a          .
    stx lc2a1                                                         ; 9d29: 8e a1 c2    ...
    lsr a                                                             ; 9d2c: 4a          J
    lsr a                                                             ; 9d2d: 4a          J
    adc #&c9                                                          ; 9d2e: 69 c9       i.
    sta l00bf                                                         ; 9d30: 85 bf       ..
    lda #0                                                            ; 9d32: a9 00       ..
    sta l00be                                                         ; 9d34: 85 be       ..
    rts                                                               ; 9d36: 60          `

; &9d37 referenced 3 times by &9ef9, &a3ec, &a4fd
.sub_c9d37
    ldx #&10                                                          ; 9d37: a2 10       ..
    stx lc295                                                         ; 9d39: 8e 95 c2    ...
    tay                                                               ; 9d3c: a8          .
; &9d3d referenced 1 time by &9dc5
.c9d3d
    lda lc204,x                                                       ; 9d3d: bd 04 c2    ...
    and #1                                                            ; 9d40: 29 01       ).
    beq c9d47                                                         ; 9d42: f0 03       ..
    stx lc295                                                         ; 9d44: 8e 95 c2    ...
; &9d47 referenced 1 time by &9d42
.c9d47
    lda lc204,x                                                       ; 9d47: bd 04 c2    ...
    bpl c9dbf                                                         ; 9d4a: 10 73       .s
    lda lc201,x                                                       ; 9d4c: bd 01 c2    ...
    cmp lc296                                                         ; 9d4f: cd 96 c2    ...
    bne c9dbf                                                         ; 9d52: d0 6b       .k
    lda lc202,x                                                       ; 9d54: bd 02 c2    ...
    cmp lc297                                                         ; 9d57: cd 97 c2    ...
    bne c9dbf                                                         ; 9d5a: d0 63       .c
    lda lc203,x                                                       ; 9d5c: bd 03 c2    ...
    cmp lc298                                                         ; 9d5f: cd 98 c2    ...
    bne c9dbf                                                         ; 9d62: d0 5b       .[
    jsr sub_c9d28                                                     ; 9d64: 20 28 9d     (.
; &9d67 referenced 1 time by &9e20
.c9d67
    tya                                                               ; 9d67: 98          .
    lsr a                                                             ; 9d68: 4a          J
    and #&40 ; '@'                                                    ; 9d69: 29 40       )@
    ora lc204,x                                                       ; 9d6b: 1d 04 c2    ...
    ror a                                                             ; 9d6e: 6a          j
    and #&e0                                                          ; 9d6f: 29 e0       ).
    ora l00cf                                                         ; 9d71: 05 cf       ..
    php                                                               ; 9d73: 08          .
    clc                                                               ; 9d74: 18          .
    rol a                                                             ; 9d75: 2a          *
    sta lc204,x                                                       ; 9d76: 9d 04 c2    ...
    plp                                                               ; 9d79: 28          (
    bcc c9d9a                                                         ; 9d7a: 90 1e       ..
    ldy #&10                                                          ; 9d7c: a0 10       ..
; &9d7e referenced 1 time by &9d8e
.loop_c9d7e
    lda lc204,y                                                       ; 9d7e: b9 04 c2    ...
    bne c9d8a                                                         ; 9d81: d0 07       ..
    lda #1                                                            ; 9d83: a9 01       ..
    sta lc204,y                                                       ; 9d85: 99 04 c2    ...
    bne c9dbe                                                         ; 9d88: d0 34       .4
; &9d8a referenced 1 time by &9d81
.c9d8a
    dey                                                               ; 9d8a: 88          .
    dey                                                               ; 9d8b: 88          .
    dey                                                               ; 9d8c: 88          .
    dey                                                               ; 9d8d: 88          .
    bpl loop_c9d7e                                                    ; 9d8e: 10 ee       ..
    jsr sub_c9e41                                                     ; 9d90: 20 41 9e     A.
    ror lc204,x                                                       ; 9d93: 7e 04 c2    ~..
    sec                                                               ; 9d96: 38          8
    rol lc204,x                                                       ; 9d97: 3e 04 c2    >..
; &9d9a referenced 1 time by &9d7a
.c9d9a
    inx                                                               ; 9d9a: e8          .
    inx                                                               ; 9d9b: e8          .
    inx                                                               ; 9d9c: e8          .
    inx                                                               ; 9d9d: e8          .
    cpx #&11                                                          ; 9d9e: e0 11       ..
    bcc c9da4                                                         ; 9da0: 90 02       ..
    ldx #0                                                            ; 9da2: a2 00       ..
; &9da4 referenced 1 time by &9da0
.c9da4
    lda lc204,x                                                       ; 9da4: bd 04 c2    ...
    lsr a                                                             ; 9da7: 4a          J
    beq c9dbe                                                         ; 9da8: f0 14       ..
    bcc c9dbe                                                         ; 9daa: 90 12       ..
    clc                                                               ; 9dac: 18          .
    rol a                                                             ; 9dad: 2a          *
    sta lc204,x                                                       ; 9dae: 9d 04 c2    ...
    jsr sub_c9e41                                                     ; 9db1: 20 41 9e     A.
    jsr sub_c9e41                                                     ; 9db4: 20 41 9e     A.
    ror lc204,x                                                       ; 9db7: 7e 04 c2    ~..
    sec                                                               ; 9dba: 38          8
    rol lc204,x                                                       ; 9dbb: 3e 04 c2    >..
; &9dbe referenced 3 times by &9d88, &9da8, &9daa
.c9dbe
    rts                                                               ; 9dbe: 60          `

; &9dbf referenced 4 times by &9d4a, &9d52, &9d5a, &9d62
.c9dbf
    dex                                                               ; 9dbf: ca          .
    dex                                                               ; 9dc0: ca          .
    dex                                                               ; 9dc1: ca          .
    dex                                                               ; 9dc2: ca          .
    bmi c9dc8                                                         ; 9dc3: 30 03       0.
    jmp c9d3d                                                         ; 9dc5: 4c 3d 9d    L=.

; &9dc8 referenced 1 time by &9dc3
.c9dc8
    ldx lc295                                                         ; 9dc8: ae 95 c2    ...
    lda lc296                                                         ; 9dcb: ad 96 c2    ...
    sta lc201,x                                                       ; 9dce: 9d 01 c2    ...
    sta lc2d0                                                         ; 9dd1: 8d d0 c2    ...
    lda lc297                                                         ; 9dd4: ad 97 c2    ...
    sta lc202,x                                                       ; 9dd7: 9d 02 c2    ...
    sta lc2d1                                                         ; 9dda: 8d d1 c2    ...
    lda lc298                                                         ; 9ddd: ad 98 c2    ...
    sta lc203,x                                                       ; 9de0: 9d 03 c2    ...
    sta lc2d2                                                         ; 9de3: 8d d2 c2    ...
    jsr sub_c9d28                                                     ; 9de6: 20 28 9d     (.
    lda lc298                                                         ; 9de9: ad 98 c2    ...
    jsr sub_ca22d                                                     ; 9dec: 20 2d a2     -.
    sty l00b1                                                         ; 9def: 84 b1       ..
    stx l00b0                                                         ; 9df1: 86 b0       ..
    ldx l00b0                                                         ; 9df3: a6 b0       ..
    jmp c9dfb                                                         ; 9df5: 4c fb 9d    L..

; &9df8 referenced 1 time by &9e15
.loop_c9df8
    jmp c8270                                                         ; 9df8: 4c 70 82    Lp.

; &9dfb referenced 1 time by &9df5
.c9dfb
    lda #8                                                            ; 9dfb: a9 08       ..
    jsr sub_c9cd3                                                     ; 9dfd: 20 d3 9c     ..
    jsr wait_for_scsi_REQ                                             ; 9e00: 20 ea 82     ..
    bmi c9e12                                                         ; 9e03: 30 0d       0.
    ldy #0                                                            ; 9e05: a0 00       ..
; &9e07 referenced 1 time by &9e10
.loop_c9e07
    jsr wait_for_scsi_REQ                                             ; 9e07: 20 ea 82     ..
    lda scsi_data                                                     ; 9e0a: ad 80 fe    ...
    sta (l00be),y                                                     ; 9e0d: 91 be       ..
    iny                                                               ; 9e0f: c8          .
    bne loop_c9e07                                                    ; 9e10: d0 f5       ..
; &9e12 referenced 1 time by &9e03
.c9e12
    jsr c8158                                                         ; 9e12: 20 58 81     X.
    bne loop_c9df8                                                    ; 9e15: d0 e1       ..
    ldx l00b0                                                         ; 9e17: a6 b0       ..
    ldy l00b1                                                         ; 9e19: a4 b1       ..
    lda #&81                                                          ; 9e1b: a9 81       ..
    sta lc204,x                                                       ; 9e1d: 9d 04 c2    ...
    jmp c9d67                                                         ; 9e20: 4c 67 9d    Lg.

    equb &a2, &10, &bd,   4, &c2, &29,   1, &d0, &35, &ca, &ca, &ca   ; 9e23: a2 10 bd... ...
    equb &ca, &10, &f3, &4c, &92, &9b                                 ; 9e2f: ca 10 f3... ...

; &9e35 referenced 3 times by &9e51, &9e57, &9e5f
.c9e35
    jsr generate_error_inline                                         ; 9e35: 20 26 83     &.
    equs &de, "Channel", 0                                            ; 9e38: de 43 68... .Ch

; &9e41 referenced 3 times by &9d90, &9db1, &9db4
.sub_c9e41
    dex                                                               ; 9e41: ca          .
    dex                                                               ; 9e42: ca          .
    dex                                                               ; 9e43: ca          .
    dex                                                               ; 9e44: ca          .
    bpl c9e49                                                         ; 9e45: 10 02       ..
    ldx #&10                                                          ; 9e47: a2 10       ..
; &9e49 referenced 1 time by &9e45
.c9e49
    rts                                                               ; 9e49: 60          `

; &9e4a referenced 5 times by &9c3d, &9e88, &9eb1, &a196, &a2b9
.sub_c9e4a
    sty l00c2                                                         ; 9e4a: 84 c2       ..
    sty lc2d5                                                         ; 9e4c: 8c d5 c2    ...
    cpy #&5a ; 'Z'                                                    ; 9e4f: c0 5a       .Z
    bcs c9e35                                                         ; 9e51: b0 e2       ..
    tya                                                               ; 9e53: 98          .
    sec                                                               ; 9e54: 38          8
    sbc #&50 ; 'P'                                                    ; 9e55: e9 50       .P
    bcc c9e35                                                         ; 9e57: 90 dc       ..
    sta l00cf                                                         ; 9e59: 85 cf       ..
    tax                                                               ; 9e5b: aa          .
    lda lc3ac,x                                                       ; 9e5c: bd ac c3    ...
    beq c9e35                                                         ; 9e5f: f0 d4       ..
    rts                                                               ; 9e61: 60          `

; &9e62 referenced 3 times by &9e94, &9ebb, &a34a
.sub_c9e62
    ldx l00cf                                                         ; 9e62: a6 cf       ..
    lda lc334,x                                                       ; 9e64: bd 34 c3    .4.
    cmp lc35c,x                                                       ; 9e67: dd 5c c3    .\.
    bne c9e85                                                         ; 9e6a: d0 19       ..
    lda lc33e,x                                                       ; 9e6c: bd 3e c3    .>.
    cmp lc366,x                                                       ; 9e6f: dd 66 c3    .f.
    bne c9e85                                                         ; 9e72: d0 11       ..
    lda lc348,x                                                       ; 9e74: bd 48 c3    .H.
    cmp lc370,x                                                       ; 9e77: dd 70 c3    .p.
    bne c9e85                                                         ; 9e7a: d0 09       ..
    lda lc352,x                                                       ; 9e7c: bd 52 c3    .R.
    cmp lc37a,x                                                       ; 9e7f: dd 7a c3    .z.
    bne c9e85                                                         ; 9e82: d0 01       ..
    clc                                                               ; 9e84: 18          .
; &9e85 referenced 4 times by &9e6a, &9e72, &9e7a, &9e82
.c9e85
    rts                                                               ; 9e85: 60          `

.sub_c9e86
    ldy l00b4                                                         ; 9e86: a4 b4       ..
    jsr sub_c9e4a                                                     ; 9e88: 20 4a 9e     J.
    ror a                                                             ; 9e8b: 6a          j
    bcs c9e97                                                         ; 9e8c: b0 09       ..
    jsr sub_c9ba3                                                     ; 9e8e: 20 a3 9b     ..
    jsr sub_ca012                                                     ; 9e91: 20 12 a0     ..
    jsr sub_c9e62                                                     ; 9e94: 20 62 9e     b.
; &9e97 referenced 1 time by &9e8c
.c9e97
    ldx #0                                                            ; 9e97: a2 00       ..
    bcs c9e9c                                                         ; 9e99: b0 01       ..
    dex                                                               ; 9e9b: ca          .
; &9e9c referenced 1 time by &9e99
.c9e9c
    ldy l00b5                                                         ; 9e9c: a4 b5       ..
    rts                                                               ; 9e9e: 60          `

; &9e9f referenced 2 times by &9eb9, &9ec0
.c9e9f
    lda lc3ac,x                                                       ; 9e9f: bd ac c3    ...
    and #&c8                                                          ; 9ea2: 29 c8       ).
    sta lc3ac,x                                                       ; 9ea4: 9d ac c3    ...
    jsr generate_error_inline                                         ; 9ea7: 20 26 83     &.
    equs &df, "EOF", 0                                                ; 9eaa: df 45 4f... .EO

.sub_c9eaf
    stx l00c3                                                         ; 9eaf: 86 c3       ..
    jsr sub_c9e4a                                                     ; 9eb1: 20 4a 9e     J.
    ror a                                                             ; 9eb4: 6a          j
    bcs c9ed9                                                         ; 9eb5: b0 22       ."
    and #4                                                            ; 9eb7: 29 04       ).
    bne c9e9f                                                         ; 9eb9: d0 e4       ..
    jsr sub_c9e62                                                     ; 9ebb: 20 62 9e     b.
    bcs c9ed9                                                         ; 9ebe: b0 19       ..
    bne c9e9f                                                         ; 9ec0: d0 dd       ..
    jsr sub_c9ba3                                                     ; 9ec2: 20 a3 9b     ..
    ldx l00cf                                                         ; 9ec5: a6 cf       ..
    lda lc3ac,x                                                       ; 9ec7: bd ac c3    ...
    and #&c0                                                          ; 9eca: 29 c0       ).
    ora #8                                                            ; 9ecc: 09 08       ..
    sta lc3ac,x                                                       ; 9ece: 9d ac c3    ...
    ldy l00c2                                                         ; 9ed1: a4 c2       ..
    ldx l00c3                                                         ; 9ed3: a6 c3       ..
    sec                                                               ; 9ed5: 38          8
    lda #&fe                                                          ; 9ed6: a9 fe       ..
    rts                                                               ; 9ed8: 60          `

; &9ed9 referenced 2 times by &9eb5, &9ebe
.c9ed9
    ldx l00cf                                                         ; 9ed9: a6 cf       ..
    clc                                                               ; 9edb: 18          .
    lda lc3ca,x                                                       ; 9edc: bd ca c3    ...
    adc lc370,x                                                       ; 9edf: 7d 70 c3    }p.
    sta lc296                                                         ; 9ee2: 8d 96 c2    ...
    lda lc3c0,x                                                       ; 9ee5: bd c0 c3    ...
    adc lc366,x                                                       ; 9ee8: 7d 66 c3    }f.
    sta lc297                                                         ; 9eeb: 8d 97 c2    ...
    lda lc3b6,x                                                       ; 9eee: bd b6 c3    ...
    adc lc35c,x                                                       ; 9ef1: 7d 5c c3    }\.
    sta lc298                                                         ; 9ef4: 8d 98 c2    ...
    lda #&40 ; '@'                                                    ; 9ef7: a9 40       .@
    jsr sub_c9d37                                                     ; 9ef9: 20 37 9d     7.
    ldx l00cf                                                         ; 9efc: a6 cf       ..
    ldy lc37a,x                                                       ; 9efe: bc 7a c3    .z.
    lda #0                                                            ; 9f01: a9 00       ..
    sta lc2cf                                                         ; 9f03: 8d cf c2    ...
    jsr sub_c9fa9                                                     ; 9f06: 20 a9 9f     ..
    lda (l00be),y                                                     ; 9f09: b1 be       ..
    ldy l00c2                                                         ; 9f0b: a4 c2       ..
    ldx l00c3                                                         ; 9f0d: a6 c3       ..
    clc                                                               ; 9f0f: 18          .
    rts                                                               ; 9f10: 60          `

    equb &a0,   2, &b9, &14, &c3, &99, &30, &c2, &88, &10, &f7, &ad   ; 9f11: a0 02 b9... ...
    equb &17, &c3, &8d, &33, &c2, &a6, &cf, &bd, &b6, &c3, &29, &e0   ; 9f1d: 17 c3 8d... ...
    equb &8d, &2f, &c2, &bd, &e8, &c3, &8d, &2c, &c2, &bd, &de, &c3   ; 9f29: 8d 2f c2... ./.
    equb &8d, &2d, &c2, &bd, &d4, &c3, &8d, &2e, &c2, &20, &0d, &88   ; 9f35: 8d 2d c2... .-.
    equb &a0,   2, &b9, &30, &c2, &99, &2c, &c2, &88, &10, &f7, &ad   ; 9f41: a0 02 b9... ...
    equb &33, &c2, &8d, &2f, &c2, &20, &d5, &a1, &a6, &cf, &bd, &ca   ; 9f4d: 33 c2 8d... 3..
    equb &c3, &8d, &34, &c2, &bd, &c0, &c3, &8d, &35, &c2, &bd, &b6   ; 9f59: c3 8d 34... ..4
    equb &c3, &29, &1f, &8d, &36, &c2, &a9,   5, &85, &b8, &a9, &c4   ; 9f65: c3 29 1f... .).
    equb &85, &b9, &a6, &cf, &a0,   0, &b1, &b8, &d0,   6, &9d, &ac   ; 9f71: 85 b9 a6... ...
    equb &c3, &4c, &92, &9b, &a0, &19, &b1, &b8, &dd, &f2, &c3, &d0   ; 9f7d: c3 4c 92... .L.
    equb &0e, &88, &b1, &b8, &d9, &1e, &c2, &d0,   6, &88, &c0, &16   ; 9f89: 0e 88 b1... ...
    equb &b0, &f4, &60, &a5, &b8, &18, &69, &1a, &85, &b8, &90, &d4   ; 9f95: b0 f4 60... ..`
    equb &e6, &b9, &b0, &d0                                           ; 9fa1: e6 b9 b0... ...

.sub_c9fa5
    jmp c82c3                                                         ; 9fa5: 4c c3 82    L..

; &9fa8 referenced 1 time by &9fae
.loop_c9fa8
    rts                                                               ; 9fa8: 60          `

; &9fa9 referenced 1 time by &9f06
.sub_c9fa9
    ldx l00cf                                                         ; 9fa9: a6 cf       ..
    inc lc37a,x                                                       ; 9fab: fe 7a c3    .z.
    bne loop_c9fa8                                                    ; 9fae: d0 f8       ..
    bit lc2cf                                                         ; 9fb0: 2c cf c2    ,..
    bmi c9fb8                                                         ; 9fb3: 30 03       0.
    jsr sub_c9ba3                                                     ; 9fb5: 20 a3 9b     ..
; &9fb8 referenced 1 time by &9fb3
.c9fb8
    inc lc370,x                                                       ; 9fb8: fe 70 c3    .p.
    bne c9fc5                                                         ; 9fbb: d0 08       ..
    inc lc366,x                                                       ; 9fbd: fe 66 c3    .f.
    bne c9fc5                                                         ; 9fc0: d0 03       ..
    inc lc35c,x                                                       ; 9fc2: fe 5c c3    .\.
; &9fc5 referenced 5 times by &9c5f, &9fbb, &9fc0, &a161, &a40f
.c9fc5
    jsr sub_ca012                                                     ; 9fc5: 20 12 a0     ..
    pha                                                               ; 9fc8: 48          H
    sec                                                               ; 9fc9: 38          8
    lda lc370,x                                                       ; 9fca: bd 70 c3    .p.
    sbc lc348,x                                                       ; 9fcd: fd 48 c3    .H.
    lda lc366,x                                                       ; 9fd0: bd 66 c3    .f.
    sbc lc33e,x                                                       ; 9fd3: fd 3e c3    .>.
    lda lc35c,x                                                       ; 9fd6: bd 5c c3    .\.
    sbc lc334,x                                                       ; 9fd9: fd 34 c3    .4.
    bcc ca007                                                         ; 9fdc: 90 29       .)
    lda lc37a,x                                                       ; 9fde: bd 7a c3    .z.
    cmp lc352,x                                                       ; 9fe1: dd 52 c3    .R.
    bne c9fea                                                         ; 9fe4: d0 04       ..
    pla                                                               ; 9fe6: 68          h
    ora #4                                                            ; 9fe7: 09 04       ..
    pha                                                               ; 9fe9: 48          H
; &9fea referenced 1 time by &9fe4
.c9fea
    sec                                                               ; 9fea: 38          8
    lda lc348,x                                                       ; 9feb: bd 48 c3    .H.
    sbc lc398,x                                                       ; 9fee: fd 98 c3    ...
    lda lc33e,x                                                       ; 9ff1: bd 3e c3    .>.
    sbc lc38e,x                                                       ; 9ff4: fd 8e c3    ...
    lda lc334,x                                                       ; 9ff7: bd 34 c3    .4.
    sbc lc384,x                                                       ; 9ffa: fd 84 c3    ...
    bcc ca002                                                         ; 9ffd: 90 03       ..
    pla                                                               ; 9fff: 68          h
    bne ca00a                                                         ; a000: d0 08       ..
; &a002 referenced 1 time by &9ffd
.ca002
    pla                                                               ; a002: 68          h
    ora #2                                                            ; a003: 09 02       ..
    bne ca00a                                                         ; a005: d0 03       ..
; &a007 referenced 1 time by &9fdc
.ca007
    pla                                                               ; a007: 68          h
    ora #3                                                            ; a008: 09 03       ..
; &a00a referenced 2 times by &a000, &a005
.ca00a
    bmi ca00e                                                         ; a00a: 30 02       0.
    and #&f9                                                          ; a00c: 29 f9       ).
; &a00e referenced 2 times by &a00a, &a037
.ca00e
    sta lc3ac,x                                                       ; a00e: 9d ac c3    ...
    rts                                                               ; a011: 60          `

; &a012 referenced 5 times by &9c40, &9e91, &9fc5, &a199, &a2bd
.sub_ca012
    ldx l00cf                                                         ; a012: a6 cf       ..
    lda lc3ac,x                                                       ; a014: bd ac c3    ...
    pha                                                               ; a017: 48          H
    and #4                                                            ; a018: 29 04       ).
    beq ca034                                                         ; a01a: f0 18       ..
    lda lc37a,x                                                       ; a01c: bd 7a c3    .z.
    sta lc352,x                                                       ; a01f: 9d 52 c3    .R.
    lda lc370,x                                                       ; a022: bd 70 c3    .p.
    sta lc348,x                                                       ; a025: 9d 48 c3    .H.
    lda lc366,x                                                       ; a028: bd 66 c3    .f.
    sta lc33e,x                                                       ; a02b: 9d 3e c3    .>.
    lda lc35c,x                                                       ; a02e: bd 5c c3    .\.
    sta lc334,x                                                       ; a031: 9d 34 c3    .4.
; &a034 referenced 1 time by &a01a
.ca034
    pla                                                               ; a034: 68          h
    and #&c0                                                          ; a035: 29 c0       ).
    bne ca00e                                                         ; a037: d0 d5       ..
; &a039 referenced 1 time by &935b
.sub_ca039
    lda #0                                                            ; a039: a9 00       ..
    tay                                                               ; a03b: a8          .
; &a03c referenced 2 times by &981f, &99ff
.sub_ca03c
    jsr sub_c9ba3                                                     ; a03c: 20 a3 9b     ..
    stx lc240                                                         ; a03f: 8e 40 c2    .@.
    stx l00b4                                                         ; a042: 86 b4       ..
    stx l00c5                                                         ; a044: 86 c5       ..
    sty l00c4                                                         ; a046: 84 c4       ..
    sty lc241                                                         ; a048: 8c 41 c2    .A.
    sty l00b5                                                         ; a04b: 84 b5       ..
    and #&c0                                                          ; a04d: 29 c0       ).
    ldy #0                                                            ; a04f: a0 00       ..
    sty lc2d5                                                         ; a051: 8c d5 c2    ...
    tay                                                               ; a054: a8          .
    bne ca05a                                                         ; a055: d0 03       ..
    jmp ca170                                                         ; a057: 4c 70 a1    Lp.

; &a05a referenced 1 time by &a055
.ca05a
    lda lc332                                                         ; a05a: ad 32 c3    .2.
    beq ca065                                                         ; a05d: f0 06       ..
    stz lc332                                                         ; a05f: 9c 32 c3    .2.
    ldy l00b5                                                         ; a062: a4 b5       ..
    rts                                                               ; a064: 60          `

; &a065 referenced 1 time by &a05d
.ca065
    tya                                                               ; a065: 98          .
    cmp #&80                                                          ; a066: c9 80       ..
    bne ca06d                                                         ; a068: d0 03       ..
    jsr c82c3                                                         ; a06a: 20 c3 82     ..
; &a06d referenced 1 time by &a068
.ca06d
    and #&40 ; '@'                                                    ; a06d: 29 40       )@
    tay                                                               ; a06f: a8          .
    ldx #9                                                            ; a070: a2 09       ..
; &a072 referenced 1 time by &a078
.loop_ca072
    lda lc3ac,x                                                       ; a072: bd ac c3    ...
    beq ca092                                                         ; a075: f0 1b       ..
    dex                                                               ; a077: ca          .
    bpl loop_ca072                                                    ; a078: 10 f8       ..
    jsr generate_error_inline                                         ; a07a: 20 26 83     &.
    equs &c0, "Too many open files", 0                                ; a07d: c0 54 6f... .To

; &a092 referenced 1 time by &a075
.ca092
    stx l00cf                                                         ; a092: 86 cf       ..
    sty lc2a0                                                         ; a094: 8c a0 c2    ...
    tya                                                               ; a097: 98          .
    bpl ca09d                                                         ; a098: 10 03       ..
    jmp ca16d                                                         ; a09a: 4c 6d a1    Lm.

; &a09d referenced 1 time by &a098
.ca09d
    jsr sub_c8b5f                                                     ; a09d: 20 5f 8b     _.
    beq ca0a7                                                         ; a0a0: f0 05       ..
    lda #0                                                            ; a0a2: a9 00       ..
    jmp ca165                                                         ; a0a4: 4c 65 a1    Le.

; &a0a7 referenced 1 time by &a0a0
.ca0a7
    ldx #9                                                            ; a0a7: a2 09       ..
; &a0a9 referenced 1 time by &a0da
.ca0a9
    lda lc3ac,x                                                       ; a0a9: bd ac c3    ...
    bpl ca0d9                                                         ; a0ac: 10 2b       .+
    lda lc3b6,x                                                       ; a0ae: bd b6 c3    ...
    and #&e0                                                          ; a0b1: 29 e0       ).
    cmp lc317                                                         ; a0b3: cd 17 c3    ...
    bne ca0d9                                                         ; a0b6: d0 21       .!
    lda lc3e8,x                                                       ; a0b8: bd e8 c3    ...
    cmp lc314                                                         ; a0bb: cd 14 c3    ...
    bne ca0d9                                                         ; a0be: d0 19       ..
    lda lc3de,x                                                       ; a0c0: bd de c3    ...
    cmp lc315                                                         ; a0c3: cd 15 c3    ...
    bne ca0d9                                                         ; a0c6: d0 11       ..
    lda lc3d4,x                                                       ; a0c8: bd d4 c3    ...
    cmp lc316                                                         ; a0cb: cd 16 c3    ...
    bne ca0d9                                                         ; a0ce: d0 09       ..
    ldy #&19                                                          ; a0d0: a0 19       ..
    lda (l00b6),y                                                     ; a0d2: b1 b6       ..
    cmp lc3f2,x                                                       ; a0d4: dd f2 c3    ...
    bne ca0d9                                                         ; a0d7: d0 00       ..
; &a0d9 referenced 6 times by &a0ac, &a0b6, &a0be, &a0c6, &a0ce, &a0d7
.ca0d9
    dex                                                               ; a0d9: ca          .
    bpl ca0a9                                                         ; a0da: 10 cd       ..
    ldy #0                                                            ; a0dc: a0 00       ..
    lda (l00b6),y                                                     ; a0de: b1 b6       ..
    bmi ca0e5                                                         ; a0e0: 30 03       0.
    jmp c8a01                                                         ; a0e2: 4c 01 8a    L..

; &a0e5 referenced 1 time by &a0e0
.ca0e5
    ldy #&12                                                          ; a0e5: a0 12       ..
    ldx l00cf                                                         ; a0e7: a6 cf       ..
    lda (l00b6),y                                                     ; a0e9: b1 b6       ..
    sta lc352,x                                                       ; a0eb: 9d 52 c3    .R.
    iny                                                               ; a0ee: c8          .
    lda (l00b6),y                                                     ; a0ef: b1 b6       ..
    sta lc348,x                                                       ; a0f1: 9d 48 c3    .H.
    iny                                                               ; a0f4: c8          .
    lda (l00b6),y                                                     ; a0f5: b1 b6       ..
    sta lc33e,x                                                       ; a0f7: 9d 3e c3    .>.
    iny                                                               ; a0fa: c8          .
    lda (l00b6),y                                                     ; a0fb: b1 b6       ..
    sta lc334,x                                                       ; a0fd: 9d 34 c3    .4.
    ldy #&12                                                          ; a100: a0 12       ..
    ldx l00cf                                                         ; a102: a6 cf       ..
    lda (l00b6),y                                                     ; a104: b1 b6       ..
    sta lc3a2,x                                                       ; a106: 9d a2 c3    ...
    iny                                                               ; a109: c8          .
    lda (l00b6),y                                                     ; a10a: b1 b6       ..
    sta lc398,x                                                       ; a10c: 9d 98 c3    ...
    iny                                                               ; a10f: c8          .
    lda (l00b6),y                                                     ; a110: b1 b6       ..
    sta lc38e,x                                                       ; a112: 9d 8e c3    ...
    iny                                                               ; a115: c8          .
    lda (l00b6),y                                                     ; a116: b1 b6       ..
    sta lc384,x                                                       ; a118: 9d 84 c3    ...
    iny                                                               ; a11b: c8          .
    lda (l00b6),y                                                     ; a11c: b1 b6       ..
    sta lc3ca,x                                                       ; a11e: 9d ca c3    ...
    iny                                                               ; a121: c8          .
    lda (l00b6),y                                                     ; a122: b1 b6       ..
    sta lc3c0,x                                                       ; a124: 9d c0 c3    ...
    iny                                                               ; a127: c8          .
    lda (l00b6),y                                                     ; a128: b1 b6       ..
    ora lc317                                                         ; a12a: 0d 17 c3    ...
    sta lc3b6,x                                                       ; a12d: 9d b6 c3    ...
    iny                                                               ; a130: c8          .
    lda (l00b6),y                                                     ; a131: b1 b6       ..
    sta lc3f2,x                                                       ; a133: 9d f2 c3    ...
    lda lc314                                                         ; a136: ad 14 c3    ...
    sta lc3e8,x                                                       ; a139: 9d e8 c3    ...
    lda lc315                                                         ; a13c: ad 15 c3    ...
    sta lc3de,x                                                       ; a13f: 9d de c3    ...
    lda lc316                                                         ; a142: ad 16 c3    ...
    sta lc3d4,x                                                       ; a145: 9d d4 c3    ...
    lda #0                                                            ; a148: a9 00       ..
    sta lc37a,x                                                       ; a14a: 9d 7a c3    .z.
    sta lc370,x                                                       ; a14d: 9d 70 c3    .p.
    sta lc366,x                                                       ; a150: 9d 66 c3    .f.
    sta lc35c,x                                                       ; a153: 9d 5c c3    .\.
    lda lc2a0                                                         ; a156: ad a0 c2    ...
    sta lc3ac,x                                                       ; a159: 9d ac c3    ...
    txa                                                               ; a15c: 8a          .
    clc                                                               ; a15d: 18          .
    adc #&50 ; 'P'                                                    ; a15e: 69 50       iP
    pha                                                               ; a160: 48          H
    jsr c9fc5                                                         ; a161: 20 c5 9f     ..
    pla                                                               ; a164: 68          h
; &a165 referenced 1 time by &a0a4
.ca165
    jsr c880d                                                         ; a165: 20 0d 88     ..
    ldx l00c5                                                         ; a168: a6 c5       ..
    ldy l00c4                                                         ; a16a: a4 c4       ..
    rts                                                               ; a16c: 60          `

; &a16d referenced 1 time by &a09a
.ca16d
    bit lc2a0                                                         ; a16d: 2c a0 c2    ,..
; &a170 referenced 1 time by &a057
.ca170
    ldy l00c4                                                         ; a170: a4 c4       ..
    bne ca196                                                         ; a172: d0 22       ."
    ldx #9                                                            ; a174: a2 09       ..
; &a176 referenced 1 time by &a17c
.loop_ca176
    lda lc3ac,x                                                       ; a176: bd ac c3    ...
    bne ca187                                                         ; a179: d0 0c       ..
; &a17b referenced 1 time by &a194
.loop_ca17b
    dex                                                               ; a17b: ca          .
    bpl loop_ca176                                                    ; a17c: 10 f8       ..
    jsr ensure_drive                                                  ; a17e: 20 e0 82     ..
    lda #0                                                            ; a181: a9 00       ..
    ldx l00c5                                                         ; a183: a6 c5       ..
    tay                                                               ; a185: a8          .
    rts                                                               ; a186: 60          `

; &a187 referenced 1 time by &a179
.ca187
    txa                                                               ; a187: 8a          .
    clc                                                               ; a188: 18          .
    adc #&50 ; 'P'                                                    ; a189: 69 50       iP
    sta l00b5                                                         ; a18b: 85 b5       ..
    stx l00cf                                                         ; a18d: 86 cf       ..
    jsr sub_ca199                                                     ; a18f: 20 99 a1     ..
    ldx l00cf                                                         ; a192: a6 cf       ..
    bpl loop_ca17b                                                    ; a194: 10 e5       ..
; &a196 referenced 1 time by &a172
.ca196
    jsr sub_c9e4a                                                     ; a196: 20 4a 9e     J.
; &a199 referenced 1 time by &a18f
.sub_ca199
    jsr sub_ca012                                                     ; a199: 20 12 a0     ..
    ldy lc3ac,x                                                       ; a19c: bc ac c3    ...
    stz lc3ac,x                                                       ; a19f: 9e ac c3    ...
    tya                                                               ; a1a2: 98          .
    bpl ca1a5                                                         ; a1a3: 10 00       ..
; &a1a5 referenced 1 time by &a1a3
.ca1a5
    jsr c880d                                                         ; a1a5: 20 0d 88     ..
    lda #0                                                            ; a1a8: a9 00       ..
    ldy l00c4                                                         ; a1aa: a4 c4       ..
    ldx l00c5                                                         ; a1ac: a6 c5       ..
    rts                                                               ; a1ae: 60          `

; &a1af referenced 1 time by &872b
.sub_ca1af
    ldx #9                                                            ; a1af: a2 09       ..
; &a1b1 referenced 1 time by &a1c1
.loop_ca1b1
    lda lc3ac,x                                                       ; a1b1: bd ac c3    ...
    beq ca1c0                                                         ; a1b4: f0 0a       ..
    lda lc3b6,x                                                       ; a1b6: bd b6 c3    ...
    and #&e0                                                          ; a1b9: 29 e0       ).
    cmp lc317                                                         ; a1bb: cd 17 c3    ...
    beq ca1d5                                                         ; a1be: f0 15       ..
; &a1c0 referenced 1 time by &a1b4
.ca1c0
    dex                                                               ; a1c0: ca          .
    bpl loop_ca1b1                                                    ; a1c1: 10 ee       ..
; &a1c3 referenced 1 time by &9259
.sub_ca1c3
    lda lc317                                                         ; a1c3: ad 17 c3    ...
    jsr sub_ca286                                                     ; a1c6: 20 86 a2     ..
    lda lc1fb                                                         ; a1c9: ad fb c1    ...
    sta lc321,x                                                       ; a1cc: 9d 21 c3    .!.
    lda lc1fc                                                         ; a1cf: ad fc c1    ...
    sta lc322,x                                                       ; a1d2: 9d 22 c3    .".
; &a1d5 referenced 1 time by &a1be
.ca1d5
    jsr ca206                                                         ; a1d5: 20 06 a2     ..
; &a1d8 referenced 1 time by &a21f
.ca1d8
    lda lc317                                                         ; a1d8: ad 17 c3    ...
    jsr sub_ca286                                                     ; a1db: 20 86 a2     ..
    lda lc1fb                                                         ; a1de: ad fb c1    ...
    cmp lc321,x                                                       ; a1e1: dd 21 c3    .!.
    bne ca1f5                                                         ; a1e4: d0 0f       ..
    lda lc1fc                                                         ; a1e6: ad fc c1    ...
    cmp lc322,x                                                       ; a1e9: dd 22 c3    .".
    bne ca1f5                                                         ; a1ec: d0 07       ..
    jsr sub_ca221                                                     ; a1ee: 20 21 a2     !.
    sta lc2c2                                                         ; a1f1: 8d c2 c2    ...
    rts                                                               ; a1f4: 60          `

; &a1f5 referenced 2 times by &a1e4, &a1ec
.ca1f5
    jsr generate_error_inline                                         ; a1f5: 20 26 83     &.
    equs &c8, "Disc changed", 0                                       ; a1f8: c8 44 69... .Di

; &a206 referenced 4 times by &a1d5, &a207, &a216, &a234
.ca206
    rts                                                               ; a206: 60          `

; &a207 referenced 2 times by &8745, &a260
.sub_ca207
    jsr ca206                                                         ; a207: 20 06 a2     ..
    lda lc317                                                         ; a20a: ad 17 c3    ...
    jsr sub_ca286                                                     ; a20d: 20 86 a2     ..
    jsr sub_ca221                                                     ; a210: 20 21 a2     !.
    eor lc2c2                                                         ; a213: 4d c2 c2    M..
    beq ca206                                                         ; a216: f0 ee       ..
    ldx #<table2                                                      ; a218: a2 7c       .|
    ldy #>table2                                                      ; a21a: a0 86       ..
    jsr sub_c8261                                                     ; a21c: 20 61 82     a.
    bra ca1d8                                                         ; a21f: 80 b7       ..
; &a221 referenced 3 times by &a1ee, &a210, &a23d
.sub_ca221
    lda #&ff                                                          ; a221: a9 ff       ..
    clc                                                               ; a223: 18          .
; &a224 referenced 1 time by &a227
.loop_ca224
    rol a                                                             ; a224: 2a          *
    dex                                                               ; a225: ca          .
    dex                                                               ; a226: ca          .
    bpl loop_ca224                                                    ; a227: 10 fb       ..
    and lc2c2                                                         ; a229: 2d c2 c2    -..
    rts                                                               ; a22c: 60          `

; &a22d referenced 2 times by &9dec, &a2c5
.sub_ca22d
    and #&e0                                                          ; a22d: 29 e0       ).
    sta lc2cd                                                         ; a22f: 8d cd c2    ...
    phx                                                               ; a232: da          .
    phy                                                               ; a233: 5a          Z
    jsr ca206                                                         ; a234: 20 06 a2     ..
    lda lc2cd                                                         ; a237: ad cd c2    ...
    jsr sub_ca286                                                     ; a23a: 20 86 a2     ..
    jsr sub_ca221                                                     ; a23d: 20 21 a2     !.
    eor lc2c2                                                         ; a240: 4d c2 c2    M..
    beq ca283                                                         ; a243: f0 3e       .>
    lda lc2cd                                                         ; a245: ad cd c2    ...
    tax                                                               ; a248: aa          .
    pha                                                               ; a249: 48          H
    lda lc317                                                         ; a24a: ad 17 c3    ...
    sta lc2cd                                                         ; a24d: 8d cd c2    ...
    ldy lc22f                                                         ; a250: ac 2f c2    ./.
    cpy #&ff                                                          ; a253: c0 ff       ..
    bne ca25d                                                         ; a255: d0 06       ..
    sta lc22f                                                         ; a257: 8d 2f c2    ./.
    sty lc2cd                                                         ; a25a: 8c cd c2    ...
; &a25d referenced 1 time by &a255
.ca25d
    stx lc317                                                         ; a25d: 8e 17 c3    ...
    jsr sub_ca207                                                     ; a260: 20 07 a2     ..
    ldy lc2cd                                                         ; a263: ac cd c2    ...
    sty lc317                                                         ; a266: 8c 17 c3    ...
    cpy #&ff                                                          ; a269: c0 ff       ..
    bne ca276                                                         ; a26b: d0 09       ..
    lda lc22f                                                         ; a26d: ad 2f c2    ./.
    sta lc317                                                         ; a270: 8d 17 c3    ...
    sty lc22f                                                         ; a273: 8c 2f c2    ./.
; &a276 referenced 1 time by &a26b
.ca276
    pla                                                               ; a276: 68          h
    cmp lc317                                                         ; a277: cd 17 c3    ...
    beq ca283                                                         ; a27a: f0 07       ..
    ldx #<table2                                                      ; a27c: a2 7c       .|
    ldy #>table2                                                      ; a27e: a0 86       ..
    jsr sub_c8261                                                     ; a280: 20 61 82     a.
; &a283 referenced 2 times by &a243, &a27a
.ca283
    ply                                                               ; a283: 7a          z
    plx                                                               ; a284: fa          .
    rts                                                               ; a285: 60          `

; &a286 referenced 4 times by &a1c6, &a1db, &a20d, &a23a
.sub_ca286
    lsr a                                                             ; a286: 4a          J
    lsr a                                                             ; a287: 4a          J
    lsr a                                                             ; a288: 4a          J
    lsr a                                                             ; a289: 4a          J
    tax                                                               ; a28a: aa          .
    rts                                                               ; a28b: 60          `

.sub_ca28c
    jsr sub_c9ba3                                                     ; a28c: 20 a3 9b     ..
    sta lc2b4                                                         ; a28f: 8d b4 c2    ...
    sta lc2b5                                                         ; a292: 8d b5 c2    ...
    sty l00c7                                                         ; a295: 84 c7       ..
    stx l00c6                                                         ; a297: 86 c6       ..
    ldy #1                                                            ; a299: a0 01       ..
    ldx #3                                                            ; a29b: a2 03       ..
; &a29d referenced 1 time by &a2a4
.loop_ca29d
    lda (l00c6),y                                                     ; a29d: b1 c6       ..
    sta lc2b7,y                                                       ; a29f: 99 b7 c2    ...
    iny                                                               ; a2a2: c8          .
    dex                                                               ; a2a3: ca          .
    bpl loop_ca29d                                                    ; a2a4: 10 f7       ..
    lda lc2b4                                                         ; a2a6: ad b4 c2    ...
    cmp #5                                                            ; a2a9: c9 05       ..
    bcc ca2b1                                                         ; a2ab: 90 04       ..
    jmp ca57e                                                         ; a2ad: 4c 7e a5    L~.

; &a2b0 referenced 1 time by &a2b2
.loop_ca2b0
    rts                                                               ; a2b0: 60          `

; &a2b1 referenced 1 time by &a2ab
.ca2b1
    tay                                                               ; a2b1: a8          .
    beq loop_ca2b0                                                    ; a2b2: f0 fc       ..
    ldy #0                                                            ; a2b4: a0 00       ..
    lda (l00c6),y                                                     ; a2b6: b1 c6       ..
    tay                                                               ; a2b8: a8          .
    jsr sub_c9e4a                                                     ; a2b9: 20 4a 9e     J.
    php                                                               ; a2bc: 08          .
    jsr sub_ca012                                                     ; a2bd: 20 12 a0     ..
    ldx l00cf                                                         ; a2c0: a6 cf       ..
    lda lc3b6,x                                                       ; a2c2: bd b6 c3    ...
    jsr sub_ca22d                                                     ; a2c5: 20 2d a2     -.
    plp                                                               ; a2c8: 28          (
    bmi ca2d5                                                         ; a2c9: 30 0a       0.
    lda lc2b4                                                         ; a2cb: ad b4 c2    ...
    cmp #3                                                            ; a2ce: c9 03       ..
    bcs ca2d5                                                         ; a2d0: b0 03       ..
    jmp c82c3                                                         ; a2d2: 4c c3 82    L..

; &a2d5 referenced 2 times by &a2c9, &a2d0
.ca2d5
    lda lc2b4                                                         ; a2d5: ad b4 c2    ...
    and #1                                                            ; a2d8: 29 01       ).
    beq ca2ea                                                         ; a2da: f0 0e       ..
    ldy #&0c                                                          ; a2dc: a0 0c       ..
    ldx #3                                                            ; a2de: a2 03       ..
; &a2e0 referenced 1 time by &a2e6
.loop_ca2e0
    lda (l00c6),y                                                     ; a2e0: b1 c6       ..
    sta l00c8,x                                                       ; a2e2: 95 c8       ..
    dey                                                               ; a2e4: 88          .
    dex                                                               ; a2e5: ca          .
    bpl loop_ca2e0                                                    ; a2e6: 10 f8       ..
    lda #1                                                            ; a2e8: a9 01       ..
; &a2ea referenced 1 time by &a2da
.ca2ea
    ldy l00c2                                                         ; a2ea: a4 c2       ..
    ldx #&c8                                                          ; a2ec: a2 c8       ..
    jsr sub_c9c3a                                                     ; a2ee: 20 3a 9c     :.
    clc                                                               ; a2f1: 18          .
    ldx #3                                                            ; a2f2: a2 03       ..
    ldy #5                                                            ; a2f4: a0 05       ..
; &a2f6 referenced 1 time by &a300
.loop_ca2f6
    lda (l00c6),y                                                     ; a2f6: b1 c6       ..
    adc l00c3,y                                                       ; a2f8: 79 c3 00    y..
    sta lc295,y                                                       ; a2fb: 99 95 c2    ...
    iny                                                               ; a2fe: c8          .
    dex                                                               ; a2ff: ca          .
    bpl loop_ca2f6                                                    ; a300: 10 f4       ..
    lda lc2b4                                                         ; a302: ad b4 c2    ...
    sta lc2b5                                                         ; a305: 8d b5 c2    ...
    ldy #9                                                            ; a308: a0 09       ..
    ldx l00cf                                                         ; a30a: a6 cf       ..
    lda lc29a                                                         ; a30c: ad 9a c2    ...
    sta lc37a,x                                                       ; a30f: 9d 7a c3    .z.
    sta (l00c6),y                                                     ; a312: 91 c6       ..
    iny                                                               ; a314: c8          .
    lda lc29b                                                         ; a315: ad 9b c2    ...
    sta lc370,x                                                       ; a318: 9d 70 c3    .p.
    sta (l00c6),y                                                     ; a31b: 91 c6       ..
    iny                                                               ; a31d: c8          .
    lda lc29c                                                         ; a31e: ad 9c c2    ...
    sta lc366,x                                                       ; a321: 9d 66 c3    .f.
    sta (l00c6),y                                                     ; a324: 91 c6       ..
    iny                                                               ; a326: c8          .
    lda lc29d                                                         ; a327: ad 9d c2    ...
    sta lc35c,x                                                       ; a32a: 9d 5c c3    .\.
    sta (l00c6),y                                                     ; a32d: 91 c6       ..
    lda lc2b4                                                         ; a32f: ad b4 c2    ...
    cmp #3                                                            ; a332: c9 03       ..
    bcs ca34a                                                         ; a334: b0 14       ..
; &a336 referenced 2 times by &a34d, &a34f
.ca336
    ldx #3                                                            ; a336: a2 03       ..
    ldy #5                                                            ; a338: a0 05       ..
; &a33a referenced 1 time by &a345
.loop_ca33a
    lda (l00c6),y                                                     ; a33a: b1 c6       ..
    sta lc23b,y                                                       ; a33c: 99 3b c2    .;.
    lda #0                                                            ; a33f: a9 00       ..
    sta (l00c6),y                                                     ; a341: 91 c6       ..
    iny                                                               ; a343: c8          .
    dex                                                               ; a344: ca          .
    bpl loop_ca33a                                                    ; a345: 10 f3       ..
    jmp ca3b8                                                         ; a347: 4c b8 a3    L..

; &a34a referenced 1 time by &a334
.ca34a
    jsr sub_c9e62                                                     ; a34a: 20 62 9e     b.
    bcs ca336                                                         ; a34d: b0 e7       ..
    beq ca336                                                         ; a34f: f0 e5       ..
    stz lc2b5                                                         ; a351: 9c b5 c2    ...
    ldx l00cf                                                         ; a354: a6 cf       ..
    sec                                                               ; a356: 38          8
    lda lc352,x                                                       ; a357: bd 52 c3    .R.
    sbc l00c8                                                         ; a35a: e5 c8       ..
    sta lc240                                                         ; a35c: 8d 40 c2    .@.
    lda lc348,x                                                       ; a35f: bd 48 c3    .H.
    sbc l00c9                                                         ; a362: e5 c9       ..
    sta lc241                                                         ; a364: 8d 41 c2    .A.
    lda lc33e,x                                                       ; a367: bd 3e c3    .>.
    sbc l00ca                                                         ; a36a: e5 ca       ..
    sta lc242                                                         ; a36c: 8d 42 c2    .B.
    lda lc334,x                                                       ; a36f: bd 34 c3    .4.
    sbc l00cb                                                         ; a372: e5 cb       ..
    sta lc243                                                         ; a374: 8d 43 c2    .C.
    ldx #3                                                            ; a377: a2 03       ..
    ldy #5                                                            ; a379: a0 05       ..
    sec                                                               ; a37b: 38          8
; &a37c referenced 1 time by &a385
.loop_ca37c
    lda (l00c6),y                                                     ; a37c: b1 c6       ..
    sbc lc23b,y                                                       ; a37e: f9 3b c2    .;.
    sta (l00c6),y                                                     ; a381: 91 c6       ..
    iny                                                               ; a383: c8          .
    dex                                                               ; a384: ca          .
    bpl loop_ca37c                                                    ; a385: 10 f5       ..
    ldx l00cf                                                         ; a387: a6 cf       ..
    lda lc352,x                                                       ; a389: bd 52 c3    .R.
    sta lc29a                                                         ; a38c: 8d 9a c2    ...
    sta lc37a,x                                                       ; a38f: 9d 7a c3    .z.
    sta (l00c6),y                                                     ; a392: 91 c6       ..
    iny                                                               ; a394: c8          .
    lda lc348,x                                                       ; a395: bd 48 c3    .H.
    sta lc29b                                                         ; a398: 8d 9b c2    ...
    sta lc370,x                                                       ; a39b: 9d 70 c3    .p.
    sta (l00c6),y                                                     ; a39e: 91 c6       ..
    iny                                                               ; a3a0: c8          .
    lda lc33e,x                                                       ; a3a1: bd 3e c3    .>.
    sta lc29c                                                         ; a3a4: 8d 9c c2    ...
    sta lc366,x                                                       ; a3a7: 9d 66 c3    .f.
    sta (l00c6),y                                                     ; a3aa: 91 c6       ..
    iny                                                               ; a3ac: c8          .
    lda lc334,x                                                       ; a3ad: bd 34 c3    .4.
    sta lc29d                                                         ; a3b0: 8d 9d c2    ...
    sta lc35c,x                                                       ; a3b3: 9d 5c c3    .\.
    sta (l00c6),y                                                     ; a3b6: 91 c6       ..
; &a3b8 referenced 1 time by &a347
.ca3b8
    ldy #1                                                            ; a3b8: a0 01       ..
    ldx #3                                                            ; a3ba: a2 03       ..
    clc                                                               ; a3bc: 18          .
; &a3bd referenced 1 time by &a3c6
.loop_ca3bd
    lda lc23f,y                                                       ; a3bd: b9 3f c2    .?.
    adc (l00c6),y                                                     ; a3c0: 71 c6       q.
    sta (l00c6),y                                                     ; a3c2: 91 c6       ..
    iny                                                               ; a3c4: c8          .
    dex                                                               ; a3c5: ca          .
    bpl loop_ca3bd                                                    ; a3c6: 10 f5       ..
    lda l00c8                                                         ; a3c8: a5 c8       ..
    bne ca3cf                                                         ; a3ca: d0 03       ..
    jmp ca459                                                         ; a3cc: 4c 59 a4    LY.

; &a3cf referenced 1 time by &a3ca
.ca3cf
    ldx l00cf                                                         ; a3cf: a6 cf       ..
    clc                                                               ; a3d1: 18          .
    lda lc3ca,x                                                       ; a3d2: bd ca c3    ...
    adc l00c9                                                         ; a3d5: 65 c9       e.
    sta lc296                                                         ; a3d7: 8d 96 c2    ...
    lda lc3c0,x                                                       ; a3da: bd c0 c3    ...
    adc l00ca                                                         ; a3dd: 65 ca       e.
    sta lc297                                                         ; a3df: 8d 97 c2    ...
    lda lc3b6,x                                                       ; a3e2: bd b6 c3    ...
    adc l00cb                                                         ; a3e5: 65 cb       e.
    sta lc298                                                         ; a3e7: 8d 98 c2    ...
    lda #&40 ; '@'                                                    ; a3ea: a9 40       .@
    jsr sub_c9d37                                                     ; a3ec: 20 37 9d     7.
    lda l00c8                                                         ; a3ef: a5 c8       ..
    sta lc2b6                                                         ; a3f1: 8d b6 c2    ...
    stz lc2b7                                                         ; a3f4: 9c b7 c2    ...
    ldx #2                                                            ; a3f7: a2 02       ..
; &a3f9 referenced 1 time by &a401
.loop_ca3f9
    lda lc29b,x                                                       ; a3f9: bd 9b c2    ...
    cmp l00c9,x                                                       ; a3fc: d5 c9       ..
    bne ca41c                                                         ; a3fe: d0 1c       ..
    dex                                                               ; a400: ca          .
    bpl loop_ca3f9                                                    ; a401: 10 f6       ..
    lda lc29a                                                         ; a403: ad 9a c2    ...
    sta lc2b7                                                         ; a406: 8d b7 c2    ...
    jsr sub_ca670                                                     ; a409: 20 70 a6     p.
; &a40c referenced 2 times by &a4da, &a50c
.ca40c
    jsr c880d                                                         ; a40c: 20 0d 88     ..
    jsr c9fc5                                                         ; a40f: 20 c5 9f     ..
; &a412 referenced 1 time by &a5cc
.ca412
    lda #0                                                            ; a412: a9 00       ..
    cmp lc2b5                                                         ; a414: cd b5 c2    ...
    ldx l00c6                                                         ; a417: a6 c6       ..
    ldy l00c7                                                         ; a419: a4 c7       ..
    rts                                                               ; a41b: 60          `

; &a41c referenced 1 time by &a3fe
.ca41c
    jsr sub_ca670                                                     ; a41c: 20 70 a6     p.
    lda #0                                                            ; a41f: a9 00       ..
    sec                                                               ; a421: 38          8
    sbc lc2b6                                                         ; a422: ed b6 c2    ...
    sta lc2b6                                                         ; a425: 8d b6 c2    ...
    clc                                                               ; a428: 18          .
    adc lc2b8                                                         ; a429: 6d b8 c2    m..
    sta lc2b8                                                         ; a42c: 8d b8 c2    ...
    bcc ca43e                                                         ; a42f: 90 0d       ..
    inc lc2b9                                                         ; a431: ee b9 c2    ...
    bne ca43e                                                         ; a434: d0 08       ..
    inc lc2ba                                                         ; a436: ee ba c2    ...
    bne ca43e                                                         ; a439: d0 03       ..
    inc lc2bb                                                         ; a43b: ee bb c2    ...
; &a43e referenced 3 times by &a42f, &a434, &a439
.ca43e
    sec                                                               ; a43e: 38          8
    lda lc240                                                         ; a43f: ad 40 c2    .@.
    sbc lc2b6                                                         ; a442: ed b6 c2    ...
    sta lc240                                                         ; a445: 8d 40 c2    .@.
    bcs ca459                                                         ; a448: b0 0f       ..
    ldy #1                                                            ; a44a: a0 01       ..
; &a44c referenced 1 time by &a457
.loop_ca44c
    lda lc240,y                                                       ; a44c: b9 40 c2    .@.
    sbc #0                                                            ; a44f: e9 00       ..
    sta lc240,y                                                       ; a451: 99 40 c2    .@.
    bcs ca459                                                         ; a454: b0 03       ..
    iny                                                               ; a456: c8          .
    bne loop_ca44c                                                    ; a457: d0 f3       ..
; &a459 referenced 3 times by &a3cc, &a448, &a454
.ca459
    lda lc241                                                         ; a459: ad 41 c2    .A.
    ora lc242                                                         ; a45c: 0d 42 c2    .B.
    ora lc243                                                         ; a45f: 0d 43 c2    .C.
    bne ca467                                                         ; a462: d0 03       ..
    jmp ca4d5                                                         ; a464: 4c d5 a4    L..

; &a467 referenced 1 time by &a462
.ca467
    lda #1                                                            ; a467: a9 01       ..
    sta lc215                                                         ; a469: 8d 15 c2    ...
    ldy #3                                                            ; a46c: a0 03       ..
; &a46e referenced 1 time by &a475
.loop_ca46e
    lda lc2b8,y                                                       ; a46e: b9 b8 c2    ...
    sta lc216,y                                                       ; a471: 99 16 c2    ...
    dey                                                               ; a474: 88          .
    bpl loop_ca46e                                                    ; a475: 10 f7       ..
    lda #8                                                            ; a477: a9 08       ..
    sta lc21a                                                         ; a479: 8d 1a c2    ...
    ldx l00cf                                                         ; a47c: a6 cf       ..
    lda l00c8                                                         ; a47e: a5 c8       ..
    cmp #1                                                            ; a480: c9 01       ..
    lda lc3ca,x                                                       ; a482: bd ca c3    ...
    adc l00c9                                                         ; a485: 65 c9       e.
    sta lc21d                                                         ; a487: 8d 1d c2    ...
    lda lc3c0,x                                                       ; a48a: bd c0 c3    ...
    adc l00ca                                                         ; a48d: 65 ca       e.
    sta lc21c                                                         ; a48f: 8d 1c c2    ...
    lda lc3b6,x                                                       ; a492: bd b6 c3    ...
    adc l00cb                                                         ; a495: 65 cb       e.
    sta lc21b                                                         ; a497: 8d 1b c2    ...
    ldy #4                                                            ; a49a: a0 04       ..
; &a49c referenced 1 time by &a4a3
.loop_ca49c
    lda lc313,y                                                       ; a49c: b9 13 c3    ...
    sta lc22b,y                                                       ; a49f: 99 2b c2    .+.
    dey                                                               ; a4a2: 88          .
    bne loop_ca49c                                                    ; a4a3: d0 f7       ..
    sty lc317                                                         ; a4a5: 8c 17 c3    ...
    sty lc21e                                                         ; a4a8: 8c 1e c2    ...
    sty lc21f                                                         ; a4ab: 8c 1f c2    ...
    sty lc220                                                         ; a4ae: 8c 20 c2    . .
    clc                                                               ; a4b1: 18          .
    ldx #2                                                            ; a4b2: a2 02       ..
; &a4b4 referenced 1 time by &a4c2
.loop_ca4b4
    lda lc241,y                                                       ; a4b4: b9 41 c2    .A.
    sta lc221,y                                                       ; a4b7: 99 21 c2    .!.
    adc lc2b9,y                                                       ; a4ba: 79 b9 c2    y..
    sta lc2b9,y                                                       ; a4bd: 99 b9 c2    ...
    iny                                                               ; a4c0: c8          .
    dex                                                               ; a4c1: ca          .
    bpl loop_ca4b4                                                    ; a4c2: 10 f0       ..
    jsr sub_c8876                                                     ; a4c4: 20 76 88     v.
    lda lc22f                                                         ; a4c7: ad 2f c2    ./.
    sta lc317                                                         ; a4ca: 8d 17 c3    ...
    lda #&ff                                                          ; a4cd: a9 ff       ..
    sta lc22f                                                         ; a4cf: 8d 2f c2    ./.
    sta lc22e                                                         ; a4d2: 8d 2e c2    ...
; &a4d5 referenced 1 time by &a464
.ca4d5
    lda lc29a                                                         ; a4d5: ad 9a c2    ...
    bne ca4dd                                                         ; a4d8: d0 03       ..
    jmp ca40c                                                         ; a4da: 4c 0c a4    L..

; &a4dd referenced 1 time by &a4d8
.ca4dd
    ldx l00cf                                                         ; a4dd: a6 cf       ..
    clc                                                               ; a4df: 18          .
    lda lc3ca,x                                                       ; a4e0: bd ca c3    ...
    adc lc29b                                                         ; a4e3: 6d 9b c2    m..
    sta lc296                                                         ; a4e6: 8d 96 c2    ...
    lda lc3c0,x                                                       ; a4e9: bd c0 c3    ...
    adc lc29c                                                         ; a4ec: 6d 9c c2    m..
    sta lc297                                                         ; a4ef: 8d 97 c2    ...
    lda lc3b6,x                                                       ; a4f2: bd b6 c3    ...
    adc lc29d                                                         ; a4f5: 6d 9d c2    m..
    sta lc298                                                         ; a4f8: 8d 98 c2    ...
    lda #&40 ; '@'                                                    ; a4fb: a9 40       .@
    jsr sub_c9d37                                                     ; a4fd: 20 37 9d     7.
    stz lc2b6                                                         ; a500: 9c b6 c2    ...
    lda lc29a                                                         ; a503: ad 9a c2    ...
    sta lc2b7                                                         ; a506: 8d b7 c2    ...
    jsr sub_ca670                                                     ; a509: 20 70 a6     p.
    jmp ca40c                                                         ; a50c: 4c 0c a4    L..

; &a50f referenced 4 times by &a58f, &a5cf, &a5f9, &a610
.sub_ca50f
    bit tube_used_zp                                                  ; a50f: 24 cd       $.
    bpl ca53c                                                         ; a511: 10 29       .)
    lda lc2ba                                                         ; a513: ad ba c2    ...
    ldx lc2bb                                                         ; a516: ae bb c2    ...
    jsr shadow_to_main                                                ; a519: 20 58 80     X.
    lda lc2ba                                                         ; a51c: ad ba c2    ...
    cmp #&fe                                                          ; a51f: c9 fe       ..
    bcc ca529                                                         ; a521: 90 06       ..
    lda lc2bb                                                         ; a523: ad bb c2    ...
    inc a                                                             ; a526: 1a          .
    beq ca53c                                                         ; a527: f0 13       ..
; &a529 referenced 1 time by &a521
.ca529
    php                                                               ; a529: 08          .
    sei                                                               ; a52a: 78          x
    jsr c8037                                                         ; a52b: 20 37 80     7.
    lda #&40 ; '@'                                                    ; a52e: a9 40       .@
    tsb tube_used_zp                                                  ; a530: 04 cd       ..
; Initalise writing of copro ram
    lda #1                                                            ; a532: a9 01       ..
    ldx #&b8                                                          ; a534: a2 b8       ..
    ldy #&c2                                                          ; a536: a0 c2       ..
    jsr l0406                                                         ; a538: 20 06 04     ..
    plp                                                               ; a53b: 28          (
; &a53c referenced 2 times by &a511, &a527
.ca53c
    stz l00bd                                                         ; a53c: 64 bd       d.
    lda lc2b8                                                         ; a53e: ad b8 c2    ...
    sta l00b2                                                         ; a541: 85 b2       ..
    lda lc2b9                                                         ; a543: ad b9 c2    ...
    sta l00b3                                                         ; a546: 85 b3       ..
    rts                                                               ; a548: 60          `

; &a549 referenced 10 times by &a562, &a577, &a5a3, &a5b2, &a5bc, &a5c6, &a5d4, &a5ea, &a5f6, &a5fe
.ca549
    bit tube_used_zp                                                  ; a549: 24 cd       $.
    bvc ca551                                                         ; a54b: 50 04       P.
    sta tube_host_r3_data                                             ; a54d: 8d e5 fe    ...
    rts                                                               ; a550: 60          `

; &a551 referenced 1 time by &a54b
.ca551
    sty l00bc                                                         ; a551: 84 bc       ..
    ldy l00bd                                                         ; a553: a4 bd       ..
    sta (l00b2),y                                                     ; a555: 91 b2       ..
    inc l00bd                                                         ; a557: e6 bd       ..
    bne ca55d                                                         ; a559: d0 02       ..
    inc l00b3                                                         ; a55b: e6 b3       ..
; &a55d referenced 1 time by &a559
.ca55d
    ldy l00bc                                                         ; a55d: a4 bc       ..
    rts                                                               ; a55f: 60          `

; &a560 referenced 2 times by &a5e5, &a64d
.sub_ca560
    lda #&0a                                                          ; a560: a9 0a       ..
    jsr ca549                                                         ; a562: 20 49 a5     I.
    sec                                                               ; a565: 38          8
    ldx #9                                                            ; a566: a2 09       ..
    ldy #&ff                                                          ; a568: a0 ff       ..
; &a56a referenced 1 time by &a57b
.loop_ca56a
    iny                                                               ; a56a: c8          .
    bcc ca577                                                         ; a56b: 90 0a       ..
    lda (l00b4),y                                                     ; a56d: b1 b4       ..
    and #&7f                                                          ; a56f: 29 7f       ).
    cmp #&21 ; '!'                                                    ; a571: c9 21       .!
    bcs ca577                                                         ; a573: b0 02       ..
    lda #&20 ; ' '                                                    ; a575: a9 20       .
; &a577 referenced 2 times by &a56b, &a573
.ca577
    jsr ca549                                                         ; a577: 20 49 a5     I.
    dex                                                               ; a57a: ca          .
    bpl loop_ca56a                                                    ; a57b: 10 ed       ..
    rts                                                               ; a57d: 60          `

; &a57e referenced 1 time by &a2ad
.ca57e
    sbc #5                                                            ; a57e: e9 05       ..
    tay                                                               ; a580: a8          .
    beq ca58f                                                         ; a581: f0 0c       ..
    dey                                                               ; a583: 88          .
    beq ca5cf                                                         ; a584: f0 49       .I
    dey                                                               ; a586: 88          .
    beq ca5f9                                                         ; a587: f0 70       .p
    dey                                                               ; a589: 88          .
    bne ca5c9                                                         ; a58a: d0 3d       .=
    jmp ca610                                                         ; a58c: 4c 10 a6    L..

; &a58f referenced 1 time by &a581
.ca58f
    jsr sub_ca50f                                                     ; a58f: 20 0f a5     ..
    ldy #&ff                                                          ; a592: a0 ff       ..
; &a594 referenced 1 time by &a5a0
.loop_ca594
    iny                                                               ; a594: c8          .
    lda lc8d9,y                                                       ; a595: b9 d9 c8    ...
    and #&7f                                                          ; a598: 29 7f       ).
    cmp #&20 ; ' '                                                    ; a59a: c9 20       .
    bcc ca5a2                                                         ; a59c: 90 04       ..
    cpy #&13                                                          ; a59e: c0 13       ..
    bne loop_ca594                                                    ; a5a0: d0 f2       ..
; &a5a2 referenced 1 time by &a59c
.ca5a2
    tya                                                               ; a5a2: 98          .
    jsr ca549                                                         ; a5a3: 20 49 a5     I.
    ldy #&ff                                                          ; a5a6: a0 ff       ..
; &a5a8 referenced 1 time by &a5b7
.loop_ca5a8
    iny                                                               ; a5a8: c8          .
    lda lc8d9,y                                                       ; a5a9: b9 d9 c8    ...
    and #&7f                                                          ; a5ac: 29 7f       ).
    cmp #&20 ; ' '                                                    ; a5ae: c9 20       .
    bcc ca5b9                                                         ; a5b0: 90 07       ..
    jsr ca549                                                         ; a5b2: 20 49 a5     I.
    cpy #&13                                                          ; a5b5: c0 13       ..
    bne loop_ca5a8                                                    ; a5b7: d0 ef       ..
; &a5b9 referenced 1 time by &a5b0
.ca5b9
    lda lc1fd                                                         ; a5b9: ad fd c1    ...
    jsr ca549                                                         ; a5bc: 20 49 a5     I.
    lda lc317                                                         ; a5bf: ad 17 c3    ...
    asl a                                                             ; a5c2: 0a          .
    rol a                                                             ; a5c3: 2a          *
    rol a                                                             ; a5c4: 2a          *
    rol a                                                             ; a5c5: 2a          *
    jsr ca549                                                         ; a5c6: 20 49 a5     I.
; &a5c9 referenced 5 times by &a58a, &a5ed, &a623, &a62d, &a66d
.ca5c9
    jsr release_tube                                                  ; a5c9: 20 3f 80     ?.
    jmp ca412                                                         ; a5cc: 4c 12 a4    L..

; &a5cf referenced 1 time by &a584
.ca5cf
    jsr sub_ca50f                                                     ; a5cf: 20 0f a5     ..
    lda #1                                                            ; a5d2: a9 01       ..
    jsr ca549                                                         ; a5d4: 20 49 a5     I.
    lda lc317                                                         ; a5d7: ad 17 c3    ...
    jsr sub_ca5f0                                                     ; a5da: 20 f0 a5     ..
    lda #0                                                            ; a5dd: a9 00       ..
    sta l00b4                                                         ; a5df: 85 b4       ..
    lda #&c3                                                          ; a5e1: a9 c3       ..
; &a5e3 referenced 1 time by &a60d
.ca5e3
    sta l00b5                                                         ; a5e3: 85 b5       ..
    jsr sub_ca560                                                     ; a5e5: 20 60 a5     `.
    lda #0                                                            ; a5e8: a9 00       ..
    jsr ca549                                                         ; a5ea: 20 49 a5     I.
    jmp ca5c9                                                         ; a5ed: 4c c9 a5    L..

; &a5f0 referenced 2 times by &a5da, &a604
.sub_ca5f0
    asl a                                                             ; a5f0: 0a          .
    rol a                                                             ; a5f1: 2a          *
    rol a                                                             ; a5f2: 2a          *
    rol a                                                             ; a5f3: 2a          *
    adc #&30 ; '0'                                                    ; a5f4: 69 30       i0
    jmp ca549                                                         ; a5f6: 4c 49 a5    LI.

; &a5f9 referenced 1 time by &a587
.ca5f9
    jsr sub_ca50f                                                     ; a5f9: 20 0f a5     ..
    lda #1                                                            ; a5fc: a9 01       ..
    jsr ca549                                                         ; a5fe: 20 49 a5     I.
    lda lc31b                                                         ; a601: ad 1b c3    ...
    jsr sub_ca5f0                                                     ; a604: 20 f0 a5     ..
    lda #&0a                                                          ; a607: a9 0a       ..
    sta l00b4                                                         ; a609: 85 b4       ..
    lda #&c3                                                          ; a60b: a9 c3       ..
    jmp ca5e3                                                         ; a60d: 4c e3 a5    L..

; &a610 referenced 1 time by &a58c
.ca610
    jsr sub_ca50f                                                     ; a610: 20 0f a5     ..
    ldy #0                                                            ; a613: a0 00       ..
    sty lc2b5                                                         ; a615: 8c b5 c2    ...
    lda lc8fa                                                         ; a618: ad fa c8    ...
    sta (l00c6),y                                                     ; a61b: 91 c6       ..
    ldy #5                                                            ; a61d: a0 05       ..
    lda (l00c6),y                                                     ; a61f: b1 c6       ..
    sta l00b0                                                         ; a621: 85 b0       ..
    beq ca5c9                                                         ; a623: f0 a4       ..
    ldy #9                                                            ; a625: a0 09       ..
    lda (l00c6),y                                                     ; a627: b1 c6       ..
    sta l00b1                                                         ; a629: 85 b1       ..
    cmp #&2f ; '/'                                                    ; a62b: c9 2f       ./
    bcs ca5c9                                                         ; a62d: b0 9a       ..
    tax                                                               ; a62f: aa          .
    clc                                                               ; a630: 18          .
    lda #5                                                            ; a631: a9 05       ..
    ldy #&c4                                                          ; a633: a0 c4       ..
; &a635 referenced 2 times by &a63a, &a63e
.ca635
    dex                                                               ; a635: ca          .
    bmi ca640                                                         ; a636: 30 08       0.
    adc #&1a                                                          ; a638: 69 1a       i.
    bcc ca635                                                         ; a63a: 90 f9       ..
    iny                                                               ; a63c: c8          .
    clc                                                               ; a63d: 18          .
    bcc ca635                                                         ; a63e: 90 f5       ..
; &a640 referenced 1 time by &a636
.ca640
    sty l00b5                                                         ; a640: 84 b5       ..
    sta l00b4                                                         ; a642: 85 b4       ..
; &a644 referenced 1 time by &a65f
.loop_ca644
    ldy #0                                                            ; a644: a0 00       ..
    lda (l00b4),y                                                     ; a646: b1 b4       ..
    sta lc2b5                                                         ; a648: 8d b5 c2    ...
    beq ca661                                                         ; a64b: f0 14       ..
    jsr sub_ca560                                                     ; a64d: 20 60 a5     `.
    lda l00b4                                                         ; a650: a5 b4       ..
    clc                                                               ; a652: 18          .
    adc #&1a                                                          ; a653: 69 1a       i.
    sta l00b4                                                         ; a655: 85 b4       ..
    bcc ca65b                                                         ; a657: 90 02       ..
    inc l00b5                                                         ; a659: e6 b5       ..
; &a65b referenced 1 time by &a657
.ca65b
    inc l00b1                                                         ; a65b: e6 b1       ..
    dec l00b0                                                         ; a65d: c6 b0       ..
    bne loop_ca644                                                    ; a65f: d0 e3       ..
; &a661 referenced 1 time by &a64b
.ca661
    ldy #5                                                            ; a661: a0 05       ..
    lda l00b0                                                         ; a663: a5 b0       ..
    sta (l00c6),y                                                     ; a665: 91 c6       ..
    ldy #9                                                            ; a667: a0 09       ..
    lda l00b1                                                         ; a669: a5 b1       ..
    sta (l00c6),y                                                     ; a66b: 91 c6       ..
    jmp ca5c9                                                         ; a66d: 4c c9 a5    L..

; &a670 referenced 3 times by &a409, &a41c, &a509
.sub_ca670
    lda lc2b6                                                         ; a670: ad b6 c2    ...
    cmp lc2b7                                                         ; a673: cd b7 c2    ...
    bne ca679                                                         ; a676: d0 01       ..
    rts                                                               ; a678: 60          `

; &a679 referenced 1 time by &a676
.ca679
    bit tube_used_zp                                                  ; a679: 24 cd       $.
    bpl ca6a9                                                         ; a67b: 10 2c       .,
    lda lc2ba                                                         ; a67d: ad ba c2    ...
    ldx lc2bb                                                         ; a680: ae bb c2    ...
    jsr shadow_to_main                                                ; a683: 20 58 80     X.
    lda lc2ba                                                         ; a686: ad ba c2    ...
    cmp #&fe                                                          ; a689: c9 fe       ..
    bcc ca693                                                         ; a68b: 90 06       ..
    lda lc2bb                                                         ; a68d: ad bb c2    ...
    inc a                                                             ; a690: 1a          .
    beq ca6a9                                                         ; a691: f0 16       ..
; &a693 referenced 1 time by &a68b
.ca693
    lda #&40 ; '@'                                                    ; a693: a9 40       .@
    tsb tube_used_zp                                                  ; a695: 04 cd       ..
    jsr c8037                                                         ; a697: 20 37 80     7.
    lda lc2b4                                                         ; a69a: ad b4 c2    ...
    cmp #3                                                            ; a69d: c9 03       ..
; Initalise reading of copro ram
    lda #0                                                            ; a69f: a9 00       ..
    rol a                                                             ; a6a1: 2a          *
    ldx #&b8                                                          ; a6a2: a2 b8       ..
    ldy #&c2                                                          ; a6a4: a0 c2       ..
    jsr l0406                                                         ; a6a6: 20 06 04     ..
; &a6a9 referenced 2 times by &a67b, &a691
.ca6a9
    lda lc2b8                                                         ; a6a9: ad b8 c2    ...
    sec                                                               ; a6ac: 38          8
    sbc lc2b6                                                         ; a6ad: ed b6 c2    ...
    sta l00b2                                                         ; a6b0: 85 b2       ..
    lda lc2b9                                                         ; a6b2: ad b9 c2    ...
    sbc #0                                                            ; a6b5: e9 00       ..
    sta l00b3                                                         ; a6b7: 85 b3       ..
    lda lc2b4                                                         ; a6b9: ad b4 c2    ...
    cmp #3                                                            ; a6bc: c9 03       ..
    ldy lc2b6                                                         ; a6be: ac b6 c2    ...
    php                                                               ; a6c1: 08          .
; &a6c2 referenced 1 time by &a6eb
.ca6c2
    plp                                                               ; a6c2: 28          (
    bit tube_used_zp                                                  ; a6c3: 24 cd       $.
    bvs ca6d5                                                         ; a6c5: 70 0e       p.
    bcc ca6cf                                                         ; a6c7: 90 06       ..
    lda (l00be),y                                                     ; a6c9: b1 be       ..
    sta (l00b2),y                                                     ; a6cb: 91 b2       ..
    bcs ca6e6                                                         ; a6cd: b0 17       ..
; &a6cf referenced 1 time by &a6c7
.ca6cf
    lda (l00b2),y                                                     ; a6cf: b1 b2       ..
    sta (l00be),y                                                     ; a6d1: 91 be       ..
    bcc ca6e6                                                         ; a6d3: 90 11       ..
; &a6d5 referenced 1 time by &a6c5
.ca6d5
    jsr sub_c81cb                                                     ; a6d5: 20 cb 81     ..
    bcc ca6e1                                                         ; a6d8: 90 07       ..
    lda (l00be),y                                                     ; a6da: b1 be       ..
    sta tube_host_r3_data                                             ; a6dc: 8d e5 fe    ...
    bcs ca6e6                                                         ; a6df: b0 05       ..
; &a6e1 referenced 1 time by &a6d8
.ca6e1
    lda tube_host_r3_data                                             ; a6e1: ad e5 fe    ...
    sta (l00be),y                                                     ; a6e4: 91 be       ..
; &a6e6 referenced 3 times by &a6cd, &a6d3, &a6df
.ca6e6
    iny                                                               ; a6e6: c8          .
    php                                                               ; a6e7: 08          .
    cpy lc2b7                                                         ; a6e8: cc b7 c2    ...
    bne ca6c2                                                         ; a6eb: d0 d5       ..
    plp                                                               ; a6ed: 28          (
    jmp release_tube                                                  ; a6ee: 4c 3f 80    L?.

; &a6f1 referenced 1 time by &8fac
.Mouse_service_handler
    cmp #&15                                                          ; a6f1: c9 15       ..
    bne ca6f8                                                         ; a6f3: d0 03       ..
    jmp service_handler_100Hz                                         ; a6f5: 4c 1b b6    L..

; &a6f8 referenced 1 time by &a6f3
.ca6f8
    cmp #4                                                            ; a6f8: c9 04       ..
    bne ca74b                                                         ; a6fa: d0 4f       .O
    php                                                               ; a6fc: 08          .
    pha                                                               ; a6fd: 48          H
    phx                                                               ; a6fe: da          .
    phy                                                               ; a6ff: 5a          Z
    tya                                                               ; a700: 98          .
    clc                                                               ; a701: 18          .
    adc os_text_ptr                                                   ; a702: 65 f2       e.
    sta l00a8                                                         ; a704: 85 a8       ..
    lda os_text_ptr1                                                  ; a706: a5 f3       ..
    adc #0                                                            ; a708: 69 00       i.
    sta l00a9                                                         ; a70a: 85 a9       ..
    ldy #0                                                            ; a70c: a0 00       ..
    lda (l00a8),y                                                     ; a70e: b1 a8       ..
    and #&df                                                          ; a710: 29 df       ).
    cmp #&4c ; 'L'                                                    ; a712: c9 4c       .L
    bne ca720                                                         ; a714: d0 0a       ..
    iny                                                               ; a716: c8          .
    lda (l00a8),y                                                     ; a717: b1 a8       ..
    and #&df                                                          ; a719: 29 df       ).
    cmp #&56 ; 'V'                                                    ; a71b: c9 56       .V
    bne ca747                                                         ; a71d: d0 28       .(
    iny                                                               ; a71f: c8          .
; &a720 referenced 1 time by &a714
.ca720
    ldx #0                                                            ; a720: a2 00       ..
    sty l00aa                                                         ; a722: 84 aa       ..
; &a724 referenced 2 times by &a745, &a74e
.ca724
    lda (l00a8),y                                                     ; a724: b1 a8       ..
    and #&df                                                          ; a726: 29 df       ).
    cmp command_table,x                                               ; a728: dd 9c a7    ...
    beq ca74c                                                         ; a72b: f0 1f       ..
    lda (l00a8),y                                                     ; a72d: b1 a8       ..
    cmp #&2e ; '.'                                                    ; a72f: c9 2e       ..
    beq ca750                                                         ; a731: f0 1d       ..
    lda command_table,x                                               ; a733: bd 9c a7    ...
    bmi ca753                                                         ; a736: 30 1b       0.
    ldy l00aa                                                         ; a738: a4 aa       ..
; &a73a referenced 1 time by &a73e
.loop_ca73a
    inx                                                               ; a73a: e8          .
    lda command_table,x                                               ; a73b: bd 9c a7    ...
    bpl loop_ca73a                                                    ; a73e: 10 fa       ..
    inx                                                               ; a740: e8          .
    inx                                                               ; a741: e8          .
    lda command_table,x                                               ; a742: bd 9c a7    ...
    bpl ca724                                                         ; a745: 10 dd       ..
; &a747 referenced 2 times by &a71d, &a75c
.ca747
    ply                                                               ; a747: 7a          z
    plx                                                               ; a748: fa          .
    pla                                                               ; a749: 68          h
    plp                                                               ; a74a: 28          (
; &a74b referenced 1 time by &a6fa
.ca74b
    rts                                                               ; a74b: 60          `

; &a74c referenced 1 time by &a72b
.ca74c
    inx                                                               ; a74c: e8          .
    iny                                                               ; a74d: c8          .
    bne ca724                                                         ; a74e: d0 d4       ..
; &a750 referenced 1 time by &a731
.ca750
    iny                                                               ; a750: c8          .
    bne ca75e                                                         ; a751: d0 0b       ..
; &a753 referenced 1 time by &a736
.ca753
    dex                                                               ; a753: ca          .
    lda (l00a8),y                                                     ; a754: b1 a8       ..
    cmp #&20 ; ' '                                                    ; a756: c9 20       .
    beq ca75e                                                         ; a758: f0 04       ..
    cmp #&0d                                                          ; a75a: c9 0d       ..
    bne ca747                                                         ; a75c: d0 e9       ..
; &a75e referenced 3 times by &a751, &a758, &a762
.ca75e
    inx                                                               ; a75e: e8          .
    lda command_table,x                                               ; a75f: bd 9c a7    ...
    bpl ca75e                                                         ; a762: 10 fa       ..
    jsr cae59                                                         ; a764: 20 59 ae     Y.
    tya                                                               ; a767: 98          .
    clc                                                               ; a768: 18          .
    adc l00a8                                                         ; a769: 65 a8       e.
    sta l00a8                                                         ; a76b: 85 a8       ..
    bcc ca771                                                         ; a76d: 90 02       ..
    inc l00a8                                                         ; a76f: e6 a8       ..
; &a771 referenced 1 time by &a76d
.ca771
    lda command_table,x                                               ; a771: bd 9c a7    ...
    sta l00ab                                                         ; a774: 85 ab       ..
    lda command_table+1,x                                             ; a776: bd 9d a7    ...
    sta l00aa                                                         ; a779: 85 aa       ..
    lda #osbyte_read_char_at_cursor                                   ; a77b: a9 87       ..
    jsr osbyte                                                        ; a77d: 20 f4 ff     ..            ; Read character at the text cursor, and current screen MODE
    tya                                                               ; a780: 98          .              ; Y is the current screen MODE (0-7)
    and #7                                                            ; a781: 29 07       ).
    pha                                                               ; a783: 48          H
    sei                                                               ; a784: 78          x
    jsr sub_cb228                                                     ; a785: 20 28 b2     (.
    pla                                                               ; a788: 68          h
    sta l0908                                                         ; a789: 8d 08 09    ...
    jsr sub_ca799                                                     ; a78c: 20 99 a7     ..
    jsr sub_cb1e3                                                     ; a78f: 20 e3 b1     ..
    ply                                                               ; a792: 7a          z
    plx                                                               ; a793: fa          .
    pla                                                               ; a794: 68          h
    lda #0                                                            ; a795: a9 00       ..
    plp                                                               ; a797: 28          (
    rts                                                               ; a798: 60          `

; &a799 referenced 2 times by &a78c, &b8a0
.sub_ca799
    jmp (l00aa)                                                       ; a799: 6c aa 00    l..

; &a79c referenced 6 times by &a728, &a733, &a73b, &a742, &a75f, &a771
.command_table
    equs "MOUSE"                                                      ; a79c: 4d 4f 55... MOU
; &a79d referenced 1 time by &a776
    equb >(MOUSE_command)                                             ; a7a1: af          .
    equb <(MOUSE_command)                                             ; a7a2: 6c          l
    equs "POINTER"                                                    ; a7a3: 50 4f 49... POI
    equb >(POINTER_command)                                           ; a7aa: af          .
    equb <(POINTER_command)                                           ; a7ab: da          .
    equs "TMAX"                                                       ; a7ac: 54 4d 41... TMA
    equb >(TMAX_command)                                              ; a7b0: b7          .
    equb <(TMAX_command)                                              ; a7b1: 9b          .
    equs "TRACKERBALL"                                                ; a7b2: 54 52 41... TRA
    equb >(MOUSE_command)                                             ; a7bd: af          .
    equb <(MOUSE_command)                                             ; a7be: 6c          l
    equs "TSET"                                                       ; a7bf: 54 53 45... TSE
    equb >(TSET_command)                                              ; a7c3: b7          .
    equb <(TSET_command)                                              ; a7c4: cc          .
    equb &ff                                                          ; a7c5: ff          .
; &a7c6 referenced 1 time by &a7e7
.VIDEO_string
    equs "VIDEO"                                                      ; a7c6: 56 49 44... VID
; &a7cb referenced 1 time by &aa09
.MOUSE_string
    equs "MOUSE"                                                      ; a7cb: 4d 4f 55... MOU
; &a7d0 referenced 1 time by &aa1b
.TRACKERBALL_string
    equs "TRACKERBALL"                                                ; a7d0: 54 52 41... TRA

; &a7db referenced 1 time by &9574
.sub_ca7db
    tya                                                               ; a7db: 98          .
    pha                                                               ; a7dc: 48          H
    ldx #0                                                            ; a7dd: a2 00       ..
; &a7df referenced 1 time by &a7f3
.loop_ca7df
    lda (os_text_ptr),y                                               ; a7df: b1 f2       ..
    cmp #&2e ; '.'                                                    ; a7e1: c9 2e       ..
    beq ca7fb                                                         ; a7e3: f0 16       ..
    and #&df                                                          ; a7e5: 29 df       ).
    cmp VIDEO_string,x                                                ; a7e7: dd c6 a7    ...
    beq ca7ef                                                         ; a7ea: f0 03       ..
; &a7ec referenced 1 time by &a7f9
.loop_ca7ec
    jmp ca9fc                                                         ; a7ec: 4c fc a9    L..

; &a7ef referenced 1 time by &a7ea
.ca7ef
    iny                                                               ; a7ef: c8          .
    inx                                                               ; a7f0: e8          .
    cpx #5                                                            ; a7f1: e0 05       ..
    bne loop_ca7df                                                    ; a7f3: d0 ea       ..
    lda (os_text_ptr),y                                               ; a7f5: b1 f2       ..
    cmp #&21 ; '!'                                                    ; a7f7: c9 21       .!
    bcs loop_ca7ec                                                    ; a7f9: b0 f1       ..
; &a7fb referenced 1 time by &a7e3
.ca7fb
    jsr print_indexed_string                                          ; a7fb: 20 3d ab     =.
    equs &0a, "AUDIO <0-3> 0-off, 3-on", &0d                          ; a7fe: 0a 41 55... .AU
    equs "CHAPTER <digits> Plays chapter(s)"                          ; a817: 43 48 41... CHA
    equb &0d                                                          ; a838: 0d          .
    equs "EJECT"                                                      ; a839: 45 4a 45... EJE
    equb &0d                                                          ; a83e: 0d          .
    equs "FAST <dir.> Cue or Review"                                  ; a83f: 46 41 53... FAS
    equb &0d                                                          ; a858: 0d          .
    equs "FCODE <string>"                                             ; a859: 46 43 4f... FCO
    equb &0d                                                          ; a867: 0d          .
    equs "FRAME <no.>"                                                ; a868: 46 52 41... FRA
    equb &0d                                                          ; a873: 0d          .
    equs "PLAY <start>,<end> Plays from start to end"                 ; a874: 50 4c 41... PLA
    equb &0d                                                          ; a89e: 0d          .
    equs "(NB *PLAY <RETURN> plays from current frame)"               ; a89f: 28 4e 42... (NB
    equb &0d                                                          ; a8cb: 0d          .
    equs "RESET"                                                      ; a8cc: 52 45 53... RES
    equb &0d                                                          ; a8d1: 0d          .
    equs "SEARCH <no.> As FRAME, but no wait"                         ; a8d2: 53 45 41... SEA
    equb &0d                                                          ; a8f4: 0d          .
    equs "SLOW <speed>,<dir.> Speed from 5 (slow) to 253 (fast)"      ; a8f5: 53 4c 4f... SLO
    equb &0d                                                          ; a92a: 0d          .
    equs "STEP <1/0/255> Stop/step player"                            ; a92b: 53 54 45... STE
    equb &0d                                                          ; a94a: 0d          .
    equs "STILL as FRAME"                                             ; a94b: 53 54 49... STI
    equb &0d                                                          ; a959: 0d          .
    equs "VOCOMPUTER Computer to VDU"                                 ; a95a: 56 4f 43... VOC
    equb &0d                                                          ; a974: 0d          .
    equs "VODISC LV to VDU"                                           ; a975: 56 4f 44... VOD
    equb &0d                                                          ; a985: 0d          .
    equs "VOHIGLIGHT Computer colour highlights LV"                   ; a986: 56 4f 48... VOH
    equb &0d                                                          ; a9ae: 0d          .
    equs "VOSUPERIMPOSE Computer over LV"                             ; a9af: 56 4f 53... VOS
    equb &0d                                                          ; a9cd: 0d          .
    equs "VOTRANSPARENT LV & computer mixed"                          ; a9ce: 56 4f 54... VOT
    equb &0d                                                          ; a9ef: 0d          .
    equs "VP <digit>"                                                 ; a9f0: 56 50 20... VP
    equb &0d, &ea                                                     ; a9fa: 0d ea       ..

; &a9fc referenced 1 time by &a7ec
.ca9fc
    ldx #0                                                            ; a9fc: a2 00       ..
    pla                                                               ; a9fe: 68          h
    pha                                                               ; a9ff: 48          H
    tay                                                               ; aa00: a8          .
; &aa01 referenced 1 time by &aa2f
.caa01
    lda (os_text_ptr),y                                               ; aa01: b1 f2       ..
    cmp #&2e ; '.'                                                    ; aa03: c9 2e       ..
    beq caa37                                                         ; aa05: f0 30       .0
    and #&df                                                          ; aa07: 29 df       ).
    cmp MOUSE_string,x                                                ; aa09: dd cb a7    ...
    beq caa2b                                                         ; aa0c: f0 1d       ..
    pla                                                               ; aa0e: 68          h
    pha                                                               ; aa0f: 48          H
    tay                                                               ; aa10: a8          .
    ldx #0                                                            ; aa11: a2 00       ..
; &aa13 referenced 1 time by &aa27
.loop_caa13
    lda (os_text_ptr),y                                               ; aa13: b1 f2       ..
    cmp #&2e ; '.'                                                    ; aa15: c9 2e       ..
    beq caa37                                                         ; aa17: f0 1e       ..
    and #&df                                                          ; aa19: 29 df       ).
    cmp TRACKERBALL_string,x                                          ; aa1b: dd d0 a7    ...
    beq caa23                                                         ; aa1e: f0 03       ..
; &aa20 referenced 1 time by &aa35
.loop_caa20
    pla                                                               ; aa20: 68          h
    tay                                                               ; aa21: a8          .
    rts                                                               ; aa22: 60          `

; &aa23 referenced 1 time by &aa1e
.caa23
    iny                                                               ; aa23: c8          .
    inx                                                               ; aa24: e8          .
    cpx #&0b                                                          ; aa25: e0 0b       ..
    bne loop_caa13                                                    ; aa27: d0 ea       ..
    beq caa31                                                         ; aa29: f0 06       ..
; &aa2b referenced 1 time by &aa0c
.caa2b
    iny                                                               ; aa2b: c8          .
    inx                                                               ; aa2c: e8          .
    cpx #5                                                            ; aa2d: e0 05       ..
    bne caa01                                                         ; aa2f: d0 d0       ..
; &aa31 referenced 1 time by &aa29
.caa31
    lda (os_text_ptr),y                                               ; aa31: b1 f2       ..
    cmp #&21 ; '!'                                                    ; aa33: c9 21       .!
    bcs loop_caa20                                                    ; aa35: b0 e9       ..
; &aa37 referenced 2 times by &aa05, &aa17
.caa37
    jsr print_indexed_string                                          ; aa37: 20 3d ab     =.
    equs &0a, "MOUSE <1/0>", &0d                                      ; aa3a: 0a 4d 4f... .MO
    equs "TRACKERBALL as *MOUSE"                                      ; aa47: 54 52 41... TRA
    equb &0d                                                          ; aa5c: 0d          .
    equs "POINTER <0/1/2> to hide/show/hide & halt pointer"           ; aa5d: 50 4f 49... POI
    equb &0d                                                          ; aa8d: 0d          .
    equs "NB MODEs 0,1 & 2 only"                                      ; aa8e: 4e 42 20... NB
    equb &0d                                                          ; aaa3: 0d          .
    equs "TMAX <x>,<y> sets boundaries"                               ; aaa4: 54 4d 41... TMA
    equb &0d                                                          ; aac0: 0d          .
    equs "TSET <x>,<y> sets position"                                 ; aac1: 54 53 45... TSE
    equb &0d                                                          ; aadb: 0d          .
    equs " ADVAL(5) is X boundary, (6) is Y,"                         ; aadc: 20 41 44...  AD
    equb &0d                                                          ; aafe: 0d          .
    equs " ADVAL(7) is X coordinate, (8) is Y,"                       ; aaff: 20 41 44...  AD
    equb &0d                                                          ; ab23: 0d          .
    equs " ADVAL(9) is buttons"                                       ; ab24: 20 41 44...  AD
    equb &0d, &ea, &4c, &20, &aa                                      ; ab38: 0d ea 4c... ..L

; &ab3d referenced 2 times by &a7fb, &aa37
.print_indexed_string
    pla                                                               ; ab3d: 68          h
    sta l00b6                                                         ; ab3e: 85 b6       ..
    pla                                                               ; ab40: 68          h
    sta l00b7                                                         ; ab41: 85 b7       ..
    ldy #0                                                            ; ab43: a0 00       ..
    jsr sub_cab56                                                     ; ab45: 20 56 ab     V.
; &ab48 referenced 1 time by &ab50
.loop_cab48
    jsr sub_cab56                                                     ; ab48: 20 56 ab     V.
    bmi cab53                                                         ; ab4b: 30 06       0.
    jsr sub_c8c7a                                                     ; ab4d: 20 7a 8c     z.
    jmp loop_cab48                                                    ; ab50: 4c 48 ab    LH.

; &ab53 referenced 1 time by &ab4b
.cab53
    jmp (l00b6)                                                       ; ab53: 6c b6 00    l..

; &ab56 referenced 2 times by &ab45, &ab48
.sub_cab56
    lda (l00b6),y                                                     ; ab56: b1 b6       ..
    inc l00b6                                                         ; ab58: e6 b6       ..
    bne cab5e                                                         ; ab5a: d0 02       ..
    inc l00b7                                                         ; ab5c: e6 b7       ..
; &ab5e referenced 1 time by &ab5a
.cab5e
    cmp #0                                                            ; ab5e: c9 00       ..
    rts                                                               ; ab60: 60          `

.star_EJECT
    jsr Get_CMOS_byte                                                 ; ab61: 20 76 90     v.
    and #1                                                            ; ab64: 29 01       ).
    beq cab75                                                         ; ab66: f0 0d       ..
    jsr generate_error_inline3                                        ; ab68: 20 2d 83     -.
    equs &94, "No eject", 0                                           ; ab6b: 94 4e 6f... .No

; &ab75 referenced 1 time by &ab66
.cab75
    lda #&27 ; '''                                                    ; ab75: a9 27       .'
; &ab77 referenced 6 times by &ad7e, &ae24, &ae51, &ae56, &ae9c, &aee2
.cab77
    sta lce00                                                         ; ab77: 8d 00 ce    ...
    lda #&0d                                                          ; ab7a: a9 0d       ..
    sta lce01                                                         ; ab7c: 8d 01 ce    ...
; &ab7f referenced 8 times by &abf4, &ac46, &acb5, &acdb, &ad8d, &ae13, &ae44, &aede
.cab7f
    lda #&ca                                                          ; ab7f: a9 ca       ..
; &ab81 referenced 1 time by &ad45
.cab81
    ldx #0                                                            ; ab81: a2 00       ..
    ldy #&ce                                                          ; ab83: a0 ce       ..
; &ab85 referenced 1 time by &ac4e
.cab85
    jsr sub_cab9b                                                     ; ab85: 20 9b ab     ..
    beq cab92                                                         ; ab88: f0 08       ..
    pha                                                               ; ab8a: 48          H
    jsr sub_cb6e5                                                     ; ab8b: 20 e5 b6     ..
    pla                                                               ; ab8e: 68          h
    jmp c8270                                                         ; ab8f: 4c 70 82    Lp.

; &ab92 referenced 2 times by &ab88, &ab96
.cab92
    rts                                                               ; ab92: 60          `

; &ab93 referenced 2 times by &9245, &9485
.sub_cab93
    jsr sub_cab9b                                                     ; ab93: 20 9b ab     ..
    beq cab92                                                         ; ab96: f0 fa       ..
    jmp c8270                                                         ; ab98: 4c 70 82    Lp.

; &ab9b referenced 2 times by &ab85, &ab93
.sub_cab9b
    stx lc216                                                         ; ab9b: 8e 16 c2    ...
    sty lc217                                                         ; ab9e: 8c 17 c2    ...
    ldx #&ff                                                          ; aba1: a2 ff       ..
    stx lc218                                                         ; aba3: 8e 18 c2    ...
    stx lc219                                                         ; aba6: 8e 19 c2    ...
    sta lc21a                                                         ; aba9: 8d 1a c2    ...
    lda #0                                                            ; abac: a9 00       ..
    sta lc215                                                         ; abae: 8d 15 c2    ...
    ldy #4                                                            ; abb1: a0 04       ..
; &abb3 referenced 1 time by &abb7
.loop_cabb3
    sta lc21b,y                                                       ; abb3: 99 1b c2    ...
    dey                                                               ; abb6: 88          .
    bpl loop_cabb3                                                    ; abb7: 10 fa       ..
    inc lc21e                                                         ; abb9: ee 1e c2    ...
    ldx #&15                                                          ; abbc: a2 15       ..
    ldy #&c2                                                          ; abbe: a0 c2       ..
    jmp access_scsi_drive                                             ; abc0: 4c a7 80    L..

; &abc3 referenced 1 time by &ac32
.cabc3
    rts                                                               ; abc3: 60          `

; &abc4 referenced 1 time by &abd9
.loop_cabc4
    jmp caddd                                                         ; abc4: 4c dd ad    L..

.star_VP
    jsr sub_cacba                                                     ; abc7: 20 ba ac     ..
    lda (l00a8),y                                                     ; abca: b1 a8       ..
    cmp #&30 ; '0'                                                    ; abcc: c9 30       .0
    bcc cabdd                                                         ; abce: 90 0d       ..
    cmp #&3a ; ':'                                                    ; abd0: c9 3a       .:
    bcs cabdd                                                         ; abd2: b0 09       ..
    jsr sub_cad9a                                                     ; abd4: 20 9a ad     ..
    cmp #&0a                                                          ; abd7: c9 0a       ..
    bcs loop_cabc4                                                    ; abd9: b0 e9       ..
    ora #&30 ; '0'                                                    ; abdb: 09 30       .0
; &abdd referenced 7 times by &abce, &abd2, &ac12, &ac16, &ac1a, &ac1e, &ac22
.cabdd
    ldx os_interlace_flag                                             ; abdd: ae 91 02    ...
    bne cabf7                                                         ; abe0: d0 15       ..
    sta lce02                                                         ; abe2: 8d 02 ce    ...
    lda #&56 ; 'V'                                                    ; abe5: a9 56       .V
    sta lce00                                                         ; abe7: 8d 00 ce    ...
    lda #&50 ; 'P'                                                    ; abea: a9 50       .P
    sta lce01                                                         ; abec: 8d 01 ce    ...
    lda #&0d                                                          ; abef: a9 0d       ..
    sta lce03                                                         ; abf1: 8d 03 ce    ...
    jmp cab7f                                                         ; abf4: 4c 7f ab    L..

; &abf7 referenced 2 times by &91af, &abe0
.cabf7
    jsr sub_cb6e5                                                     ; abf7: 20 e5 b6     ..
    jsr generate_error_inline                                         ; abfa: 20 26 83     &.
    equs &ad, "Turn interlace on", 0                                  ; abfd: ad 54 75... .Tu

.star_VODISC
    lda #&31 ; '1'                                                    ; ac10: a9 31       .1
    bne cabdd                                                         ; ac12: d0 c9       ..
.star_VOCOMPUTER
    lda #&32 ; '2'                                                    ; ac14: a9 32       .2
    bne cabdd                                                         ; ac16: d0 c5       ..
.star_VOSUPERIMPOSE
    lda #&33 ; '3'                                                    ; ac18: a9 33       .3
    bne cabdd                                                         ; ac1a: d0 c1       ..
.star_VOTRANSPARENT
    lda #&34 ; '4'                                                    ; ac1c: a9 34       .4
    bne cabdd                                                         ; ac1e: d0 bd       ..
.star_VOHIGHLIGHT
    lda #&35 ; '5'                                                    ; ac20: a9 35       .5
    bne cabdd                                                         ; ac22: d0 b9       ..
.star_FCODE
    ldx l00a8                                                         ; ac24: a6 a8       ..
    stx os_text_ptr                                                   ; ac26: 86 f2       ..
    ldy l00a9                                                         ; ac28: a4 a9       ..
    sty os_text_ptr1                                                  ; ac2a: 84 f3       ..
    ldy #0                                                            ; ac2c: a0 00       ..
    sec                                                               ; ac2e: 38          8
    jsr gsinit                                                        ; ac2f: 20 c2 ff     ..
    beq cabc3                                                         ; ac32: f0 8f       ..
    ldx #0                                                            ; ac34: a2 00       ..
; &ac36 referenced 1 time by &ac3f
.loop_cac36
    jsr gsread                                                        ; ac36: 20 c5 ff     ..
    bcs cac41                                                         ; ac39: b0 06       ..
    sta lce00,x                                                       ; ac3b: 9d 00 ce    ...
    inx                                                               ; ac3e: e8          .
    bne loop_cac36                                                    ; ac3f: d0 f5       ..
; &ac41 referenced 1 time by &ac39
.cac41
    lda #&0d                                                          ; ac41: a9 0d       ..
    sta lce00,x                                                       ; ac43: 9d 00 ce    ...
    jmp cab7f                                                         ; ac46: 4c 7f ab    L..

.star_RESET
    jsr cad27                                                         ; ac49: 20 27 ad     '.
    lda #&1b                                                          ; ac4c: a9 1b       ..
    jmp cab85                                                         ; ac4e: 4c 85 ab    L..

.star_CHAPTER
    jsr sub_cacba                                                     ; ac51: 20 ba ac     ..
    lda #&51 ; 'Q'                                                    ; ac54: a9 51       .Q
    sta lce00                                                         ; ac56: 8d 00 ce    ...
; &ac59 referenced 1 time by &ac6b
.loop_cac59
    lda (l00a8),y                                                     ; ac59: b1 a8       ..
    sta lce01,y                                                       ; ac5b: 99 01 ce    ...
    cmp #&0d                                                          ; ac5e: c9 0d       ..
    beq cac6d                                                         ; ac60: f0 0b       ..
    cmp #&20 ; ' '                                                    ; ac62: c9 20       .
    beq cac6d                                                         ; ac64: f0 07       ..
    cmp #&2c ; ','                                                    ; ac66: c9 2c       .,
    beq cac6d                                                         ; ac68: f0 03       ..
    iny                                                               ; ac6a: c8          .
    bne loop_cac59                                                    ; ac6b: d0 ec       ..
; &ac6d referenced 3 times by &ac60, &ac64, &ac68
.cac6d
    tya                                                               ; ac6d: 98          .
    tax                                                               ; ac6e: aa          .
    jsr cae59                                                         ; ac6f: 20 59 ae     Y.
    lda (l00a8),y                                                     ; ac72: b1 a8       ..
    cmp #&0d                                                          ; ac74: c9 0d       ..
    bne cac7c                                                         ; ac76: d0 04       ..
    lda #&53 ; 'S'                                                    ; ac78: a9 53       .S
    bne cacad                                                         ; ac7a: d0 31       .1
; &ac7c referenced 1 time by &ac76
.cac7c
    iny                                                               ; ac7c: c8          .
    lda (l00a8),y                                                     ; ac7d: b1 a8       ..
    cmp #&20 ; ' '                                                    ; ac7f: c9 20       .
    beq cac87                                                         ; ac81: f0 04       ..
    cmp #&0d                                                          ; ac83: c9 0d       ..
    bne cac98                                                         ; ac85: d0 11       ..
; &ac87 referenced 1 time by &ac81
.cac87
    dey                                                               ; ac87: 88          .
    lda (l00a8),y                                                     ; ac88: b1 a8       ..
    and #&df                                                          ; ac8a: 29 df       ).
    cmp #&53 ; 'S'                                                    ; ac8c: c9 53       .S
    beq cacad                                                         ; ac8e: f0 1d       ..
    cmp #&52 ; 'R'                                                    ; ac90: c9 52       .R
    beq cacad                                                         ; ac92: f0 19       ..
    cmp #&4e ; 'N'                                                    ; ac94: c9 4e       .N
    beq cacad                                                         ; ac96: f0 15       ..
; &ac98 referenced 1 time by &ac85
.cac98
    jsr sub_cb6e5                                                     ; ac98: 20 e5 b6     ..
    jsr generate_error_inline                                         ; ac9b: 20 26 83     &.
    equs &ff, "Bad parameter", 0                                      ; ac9e: ff 42 61... .Ba

; &acad referenced 4 times by &ac7a, &ac8e, &ac92, &ac96
.cacad
    sta lce01,x                                                       ; acad: 9d 01 ce    ...
    lda #&0d                                                          ; acb0: a9 0d       ..
    sta lce02,x                                                       ; acb2: 9d 02 ce    ...
    jsr cab7f                                                         ; acb5: 20 7f ab     ..
    bra cacff                                                         ; acb8: 80 45       .E
; &acba referenced 15 times by &abc7, &ac51, &acc8, &acde, &ad67, &adef, &ae16, &ae27, &aea2, &aeb4, &aed3, &af6c, &afda, &b79b, &b7cc
.sub_cacba
    ldy #0                                                            ; acba: a0 00       ..
    rts                                                               ; acbc: 60          `

; &acbd referenced 1 time by &acd8
.sub_cacbd
    lda #&f0                                                          ; acbd: a9 f0       ..
    sta vfs_25Hz_timer_lo                                             ; acbf: 8d 93 0d    ...
    lda #0                                                            ; acc2: a9 00       ..
    sta vfs_25Hz_timer_hi                                             ; acc4: 8d 94 0d    ...
    rts                                                               ; acc7: 60          `

; &acc8 referenced 1 time by &acef
.star_SEARCH
    jsr sub_cacba                                                     ; acc8: 20 ba ac     ..
    lda (l00a8),y                                                     ; accb: b1 a8       ..
    jsr sub_cadd4                                                     ; accd: 20 d4 ad     ..
    lda #&52 ; 'R'                                                    ; acd0: a9 52       .R
    jsr sub_caef7                                                     ; acd2: 20 f7 ae     ..
    sta l093a                                                         ; acd5: 8d 3a 09    .:.
    jsr sub_cacbd                                                     ; acd8: 20 bd ac     ..
    jmp cab7f                                                         ; acdb: 4c 7f ab    L..

.star_STILL
    jsr sub_cacba                                                     ; acde: 20 ba ac     ..
    lda (l00a8),y                                                     ; ace1: b1 a8       ..
    cmp #&0d                                                          ; ace3: c9 0d       ..
    bne star_FRAME                                                    ; ace5: d0 03       ..
    jmp star_STEP                                                     ; ace7: 4c 67 ad    Lg.

; &acea referenced 2 times by &ace5, &aed0
.star_FRAME
    lda #5                                                            ; acea: a9 05       ..
    sta l0939                                                         ; acec: 8d 39 09    .9.
; &acef referenced 1 time by &acfa
.loop_cacef
    jsr star_SEARCH                                                   ; acef: 20 c8 ac     ..
    jsr cad09                                                         ; acf2: 20 09 ad     ..
    bcc cacff                                                         ; acf5: 90 08       ..
    dec l0939                                                         ; acf7: ce 39 09    .9.
    bne loop_cacef                                                    ; acfa: d0 f3       ..
    jmp caddd                                                         ; acfc: 4c dd ad    L..

; &acff referenced 3 times by &acb8, &acf5, &ae9f
.cacff
    lda #&45 ; 'E'                                                    ; acff: a9 45       .E
    sta lce00                                                         ; ad01: 8d 00 ce    ...
    lda #1                                                            ; ad04: a9 01       ..
    jmp cae09                                                         ; ad06: 4c 09 ae    L..

; &ad09 referenced 4 times by &acf2, &ad1e, &ad34, &b88f
.cad09
    lda vfs_25Hz_timer_hi                                             ; ad09: ad 94 0d    ...
    bmi cad27                                                         ; ad0c: 30 19       0.
    bit l00ff                                                         ; ad0e: 24 ff       $.
    bpl cad15                                                         ; ad10: 10 03       ..
    jmp c827f                                                         ; ad12: 4c 7f 82    L..

; &ad15 referenced 1 time by &ad10
.cad15
    jsr sub_cad48                                                     ; ad15: 20 48 ad     H.
    cli                                                               ; ad18: 58          X
    lda lce00                                                         ; ad19: ad 00 ce    ...
    cmp #&41 ; 'A'                                                    ; ad1c: c9 41       .A
    bne cad09                                                         ; ad1e: d0 e9       ..
    lda lce01                                                         ; ad20: ad 01 ce    ...
    cmp #&30 ; '0'                                                    ; ad23: c9 30       .0
    bne cad32                                                         ; ad25: d0 0b       ..
; &ad27 referenced 4 times by &ac49, &ad0c, &ad36, &ad53
.cad27
    stz vfs_25Hz_timer_lo                                             ; ad27: 9c 93 0d    ...
    stz vfs_25Hz_timer_hi                                             ; ad2a: 9c 94 0d    ...
    stz l093a                                                         ; ad2d: 9c 3a 09    .:.
    clc                                                               ; ad30: 18          .
    rts                                                               ; ad31: 60          `

; &ad32 referenced 1 time by &ad25
.cad32
    cmp #&4e ; 'N'                                                    ; ad32: c9 4e       .N
    bne cad09                                                         ; ad34: d0 d3       ..
    jsr cad27                                                         ; ad36: 20 27 ad     '.
    lda l0939                                                         ; ad39: ad 39 09    .9.
    bne cad41                                                         ; ad3c: d0 03       ..
    jmp caddd                                                         ; ad3e: 4c dd ad    L..

; &ad41 referenced 1 time by &ad3c
.cad41
    sec                                                               ; ad41: 38          8
    rts                                                               ; ad42: 60          `

; &ad43 referenced 2 times by &ad48, &b892
.sub_cad43
    lda #&c8                                                          ; ad43: a9 c8       ..
    jmp cab81                                                         ; ad45: 4c 81 ab    L..

; &ad48 referenced 1 time by &ad15
.sub_cad48
    jsr sub_cad43                                                     ; ad48: 20 43 ad     C.
    lda lce00                                                         ; ad4b: ad 00 ce    ...
    cmp #&4f ; 'O'                                                    ; ad4e: c9 4f       .O
    beq cad53                                                         ; ad50: f0 01       ..
    rts                                                               ; ad52: 60          `

; &ad53 referenced 1 time by &ad50
.cad53
    jsr cad27                                                         ; ad53: 20 27 ad     '.
    jsr sub_cb6e5                                                     ; ad56: 20 e5 b6     ..
    jsr generate_error_inline                                         ; ad59: 20 26 83     &.
    equs &93, "Door open", 0                                          ; ad5c: 93 44 6f... .Do

; &ad67 referenced 1 time by &ace7
.star_STEP
    jsr sub_cacba                                                     ; ad67: 20 ba ac     ..
    jsr sub_cad9a                                                     ; ad6a: 20 9a ad     ..
    cmp #&33 ; '3'                                                    ; ad6d: c9 33       .3
    bcc cad75                                                         ; ad6f: 90 04       ..
    cmp #&ce                                                          ; ad71: c9 ce       ..
    bcc caddd                                                         ; ad73: 90 68       .h
; &ad75 referenced 1 time by &ad6f
.cad75
    tay                                                               ; ad75: a8          .
    iny                                                               ; ad76: c8          .
    cpy #3                                                            ; ad77: c0 03       ..
    bcs cad81                                                         ; ad79: b0 06       ..
    lda lad97,y                                                       ; ad7b: b9 97 ad    ...
    jmp cab77                                                         ; ad7e: 4c 77 ab    Lw.

; &ad81 referenced 1 time by &ad79
.cad81
    cmp #0                                                            ; ad81: c9 00       ..
    bmi cad90                                                         ; ad83: 30 0b       0.
    ldy #&2b ; '+'                                                    ; ad85: a0 2b       .+
; &ad87 referenced 1 time by &ad95
.loop_cad87
    sty lce00                                                         ; ad87: 8c 00 ce    ...
    jsr sub_cae67                                                     ; ad8a: 20 67 ae     g.
    jmp cab7f                                                         ; ad8d: 4c 7f ab    L..

; &ad90 referenced 1 time by &ad83
.cad90
    eor #&ff                                                          ; ad90: 49 ff       I.
    inc a                                                             ; ad92: 1a          .
    ldy #&2d ; '-'                                                    ; ad93: a0 2d       .-
    bne loop_cad87                                                    ; ad95: d0 f0       ..
; &ad97 referenced 1 time by &ad7b
.lad97
    equs "M*L"                                                        ; ad97: 4d 2a 4c    M*L

; &ad9a referenced 5 times by &abd4, &ad6a, &adf2, &ae19, &ae4a
.sub_cad9a
    lda #&0d                                                          ; ad9a: a9 0d       ..
; &ad9c referenced 1 time by &ae2c
.sub_cad9c
    sta l00ae                                                         ; ad9c: 85 ae       ..
    lda #0                                                            ; ad9e: a9 00       ..
    sta l00af                                                         ; ada0: 85 af       ..
; &ada2 referenced 1 time by &adcb
.cada2
    lda (l00a8),y                                                     ; ada2: b1 a8       ..
    cmp l00ae                                                         ; ada4: c5 ae       ..
    beq cadce                                                         ; ada6: f0 26       .&
    cmp #&20 ; ' '                                                    ; ada8: c9 20       .
    beq cadce                                                         ; adaa: f0 22       ."
    jsr sub_cadd4                                                     ; adac: 20 d4 ad     ..
    and #&0f                                                          ; adaf: 29 0f       ).
    pha                                                               ; adb1: 48          H
    lda l00af                                                         ; adb2: a5 af       ..
    asl a                                                             ; adb4: 0a          .
    bcs caddd                                                         ; adb5: b0 26       .&
    asl a                                                             ; adb7: 0a          .
    bcs caddd                                                         ; adb8: b0 23       .#
    adc l00af                                                         ; adba: 65 af       e.
    bcs caddd                                                         ; adbc: b0 1f       ..
    asl a                                                             ; adbe: 0a          .
    bcs caddd                                                         ; adbf: b0 1c       ..
    sta l00af                                                         ; adc1: 85 af       ..
    pla                                                               ; adc3: 68          h
    adc l00af                                                         ; adc4: 65 af       e.
    bcs caddd                                                         ; adc6: b0 15       ..
    sta l00af                                                         ; adc8: 85 af       ..
    iny                                                               ; adca: c8          .
    jmp cada2                                                         ; adcb: 4c a2 ad    L..

; &adce referenced 2 times by &ada6, &adaa
.cadce
    jsr cae59                                                         ; adce: 20 59 ae     Y.
    lda l00af                                                         ; add1: a5 af       ..
    rts                                                               ; add3: 60          `

; &add4 referenced 3 times by &accd, &adac, &af13
.sub_cadd4
    cmp #&30 ; '0'                                                    ; add4: c9 30       .0
    bcc caddd                                                         ; add6: 90 05       ..
    cmp #&3a ; ':'                                                    ; add8: c9 3a       .:
    bcs caddd                                                         ; adda: b0 01       ..
    rts                                                               ; addc: 60          `

; &addd referenced 15 times by &abc4, &acfc, &ad3e, &ad73, &adb5, &adb8, &adbc, &adbf, &adc6, &add6, &adda, &adf7, &ae36, &ae3a, &af30
.caddd
    jsr sub_cb6e5                                                     ; addd: 20 e5 b6     ..
; &ade0 referenced 1 time by &b7c9
.cade0
    jsr generate_error_inline                                         ; ade0: 20 26 83     &.
    equs &dc, "Bad number", 0                                         ; ade3: dc 42 61... .Ba

.star_AUDIO
    jsr sub_cacba                                                     ; adef: 20 ba ac     ..
    jsr sub_cad9a                                                     ; adf2: 20 9a ad     ..
    cmp #4                                                            ; adf5: c9 04       ..
    bcs caddd                                                         ; adf7: b0 e4       ..
    pha                                                               ; adf9: 48          H
    ldx #&41 ; 'A'                                                    ; adfa: a2 41       .A
    stx lce00                                                         ; adfc: 8e 00 ce    ...
    and #1                                                            ; adff: 29 01       ).
    jsr cae09                                                         ; ae01: 20 09 ae     ..
    inc lce00                                                         ; ae04: ee 00 ce    ...
    pla                                                               ; ae07: 68          h
    lsr a                                                             ; ae08: 4a          J
; &ae09 referenced 2 times by &ad06, &ae01
.cae09
    ora #&30 ; '0'                                                    ; ae09: 09 30       .0
    sta lce01                                                         ; ae0b: 8d 01 ce    ...
    lda #&0d                                                          ; ae0e: a9 0d       ..
    sta lce02                                                         ; ae10: 8d 02 ce    ...
    jmp cab7f                                                         ; ae13: 4c 7f ab    L..

.star_FAST
    jsr sub_cacba                                                     ; ae16: 20 ba ac     ..
    jsr sub_cad9a                                                     ; ae19: 20 9a ad     ..
    bpl cae22                                                         ; ae1c: 10 04       ..
    lda #&5a ; 'Z'                                                    ; ae1e: a9 5a       .Z
    bne cae24                                                         ; ae20: d0 02       ..
; &ae22 referenced 1 time by &ae1c
.cae22
    lda #&57 ; 'W'                                                    ; ae22: a9 57       .W
; &ae24 referenced 1 time by &ae20
.cae24
    jmp cab77                                                         ; ae24: 4c 77 ab    Lw.

.star_SLOW
    jsr sub_cacba                                                     ; ae27: 20 ba ac     ..
    lda #&2c ; ','                                                    ; ae2a: a9 2c       .,
    jsr sub_cad9c                                                     ; ae2c: 20 9c ad     ..
    sty lce10                                                         ; ae2f: 8c 10 ce    ...
    eor #&ff                                                          ; ae32: 49 ff       I.
    cmp #2                                                            ; ae34: c9 02       ..
    bcc caddd                                                         ; ae36: 90 a5       ..
    cmp #&fb                                                          ; ae38: c9 fb       ..
    bcs caddd                                                         ; ae3a: b0 a1       ..
    jsr sub_cae67                                                     ; ae3c: 20 67 ae     g.
    lda #&53 ; 'S'                                                    ; ae3f: a9 53       .S
    sta lce00                                                         ; ae41: 8d 00 ce    ...
    jsr cab7f                                                         ; ae44: 20 7f ab     ..
    ldy lce10                                                         ; ae47: ac 10 ce    ...
    jsr sub_cad9a                                                     ; ae4a: 20 9a ad     ..
    bpl cae54                                                         ; ae4d: 10 05       ..
    lda #&56 ; 'V'                                                    ; ae4f: a9 56       .V
    jmp cab77                                                         ; ae51: 4c 77 ab    Lw.

; &ae54 referenced 1 time by &ae4d
.cae54
    lda #&55 ; 'U'                                                    ; ae54: a9 55       .U
    jmp cab77                                                         ; ae56: 4c 77 ab    Lw.

; &ae59 referenced 12 times by &a764, &ac6f, &adce, &ae64, &aef4, &aef8, &af6f, &afdd, &b717, &b7a5, &b7d6, &b86a
.cae59
    lda (l00a8),y                                                     ; ae59: b1 a8       ..
    cmp #&2c ; ','                                                    ; ae5b: c9 2c       .,
    beq cae63                                                         ; ae5d: f0 04       ..
    cmp #&20 ; ' '                                                    ; ae5f: c9 20       .
    bne cae66                                                         ; ae61: d0 03       ..
; &ae63 referenced 1 time by &ae5d
.cae63
    iny                                                               ; ae63: c8          .
    bne cae59                                                         ; ae64: d0 f3       ..
; &ae66 referenced 1 time by &ae61
.cae66
    rts                                                               ; ae66: 60          `

; &ae67 referenced 2 times by &ad8a, &ae3c
.sub_cae67
    ldx #&64 ; 'd'                                                    ; ae67: a2 64       .d
    jsr sub_cae8a                                                     ; ae69: 20 8a ae     ..
    pha                                                               ; ae6c: 48          H
    tya                                                               ; ae6d: 98          .
    ora #&30 ; '0'                                                    ; ae6e: 09 30       .0
    sta lce01                                                         ; ae70: 8d 01 ce    ...
    pla                                                               ; ae73: 68          h
    ldx #&0a                                                          ; ae74: a2 0a       ..
    jsr sub_cae8a                                                     ; ae76: 20 8a ae     ..
    ora #&30 ; '0'                                                    ; ae79: 09 30       .0
    sta lce03                                                         ; ae7b: 8d 03 ce    ...
    tya                                                               ; ae7e: 98          .
    ora #&30 ; '0'                                                    ; ae7f: 09 30       .0
    sta lce02                                                         ; ae81: 8d 02 ce    ...
    lda #&0d                                                          ; ae84: a9 0d       ..
    sta lce04                                                         ; ae86: 8d 04 ce    ...
    rts                                                               ; ae89: 60          `

; &ae8a referenced 2 times by &ae69, &ae76
.sub_cae8a
    stx lce11                                                         ; ae8a: 8e 11 ce    ...
    sec                                                               ; ae8d: 38          8
    ldy #&ff                                                          ; ae8e: a0 ff       ..
; &ae90 referenced 1 time by &ae94
.loop_cae90
    sbc lce11                                                         ; ae90: ed 11 ce    ...
    iny                                                               ; ae93: c8          .
    bcs loop_cae90                                                    ; ae94: b0 fa       ..
    adc lce11                                                         ; ae96: 6d 11 ce    m..
    rts                                                               ; ae99: 60          `

; &ae9a referenced 1 time by &aea9
.loop_cae9a
    lda #&4e ; 'N'                                                    ; ae9a: a9 4e       .N
    jsr cab77                                                         ; ae9c: 20 77 ab     w.
    jmp cacff                                                         ; ae9f: 4c ff ac    L..

.star_PLAY
    jsr sub_cacba                                                     ; aea2: 20 ba ac     ..
    lda (l00a8),y                                                     ; aea5: b1 a8       ..
    cmp #&0d                                                          ; aea7: c9 0d       ..
    beq loop_cae9a                                                    ; aea9: f0 ef       ..
    jsr sub_caf33                                                     ; aeab: 20 33 af     3.
    stx l0937                                                         ; aeae: 8e 37 09    .7.
    sty l0938                                                         ; aeb1: 8c 38 09    .8.
    jsr sub_cacba                                                     ; aeb4: 20 ba ac     ..
    jsr caee5                                                         ; aeb7: 20 e5 ae     ..
    jsr sub_caf33                                                     ; aeba: 20 33 af     3.
    lda #&4f ; 'O'                                                    ; aebd: a9 4f       .O
    cpy l0938                                                         ; aebf: cc 38 09    .8.
    beq caec8                                                         ; aec2: f0 04       ..
    bcc caecf                                                         ; aec4: 90 09       ..
    bcs caecd                                                         ; aec6: b0 05       ..
; &aec8 referenced 1 time by &aec2
.caec8
    cpx l0937                                                         ; aec8: ec 37 09    .7.
    bcc caecf                                                         ; aecb: 90 02       ..
; &aecd referenced 1 time by &aec6
.caecd
    lda #&4e ; 'N'                                                    ; aecd: a9 4e       .N
; &aecf referenced 2 times by &aec4, &aecb
.caecf
    pha                                                               ; aecf: 48          H
    jsr star_FRAME                                                    ; aed0: 20 ea ac     ..
    jsr sub_cacba                                                     ; aed3: 20 ba ac     ..
    jsr caee5                                                         ; aed6: 20 e5 ae     ..
    lda #&53 ; 'S'                                                    ; aed9: a9 53       .S
    jsr sub_caef7                                                     ; aedb: 20 f7 ae     ..
    jsr cab7f                                                         ; aede: 20 7f ab     ..
    pla                                                               ; aee1: 68          h
    jmp cab77                                                         ; aee2: 4c 77 ab    Lw.

; &aee5 referenced 3 times by &aeb7, &aed6, &aef2
.caee5
    lda (l00a8),y                                                     ; aee5: b1 a8       ..
    iny                                                               ; aee7: c8          .
    cmp #&20 ; ' '                                                    ; aee8: c9 20       .
    beq caef4                                                         ; aeea: f0 08       ..
    cmp #&0d                                                          ; aeec: c9 0d       ..
    beq caf30                                                         ; aeee: f0 40       .@
    cmp #&2c ; ','                                                    ; aef0: c9 2c       .,
    bne caee5                                                         ; aef2: d0 f1       ..
; &aef4 referenced 1 time by &aeea
.caef4
    jmp cae59                                                         ; aef4: 4c 59 ae    LY.

; &aef7 referenced 2 times by &acd2, &aedb
.sub_caef7
    pha                                                               ; aef7: 48          H
    jsr cae59                                                         ; aef8: 20 59 ae     Y.
; &aefb referenced 1 time by &af00
.loop_caefb
    lda (l00a8),y                                                     ; aefb: b1 a8       ..
    iny                                                               ; aefd: c8          .
    cmp #&30 ; '0'                                                    ; aefe: c9 30       .0
    beq loop_caefb                                                    ; af00: f0 f9       ..
    dey                                                               ; af02: 88          .
    ldx #0                                                            ; af03: a2 00       ..
; &af05 referenced 1 time by &af1f
.loop_caf05
    lda (l00a8),y                                                     ; af05: b1 a8       ..
    cmp #&0d                                                          ; af07: c9 0d       ..
    beq caf21                                                         ; af09: f0 16       ..
    cmp #&20 ; ' '                                                    ; af0b: c9 20       .
    beq caf21                                                         ; af0d: f0 12       ..
    cmp #&2c ; ','                                                    ; af0f: c9 2c       .,
    beq caf21                                                         ; af11: f0 0e       ..
    jsr sub_cadd4                                                     ; af13: 20 d4 ad     ..
    sta lce01,x                                                       ; af16: 9d 01 ce    ...
    inx                                                               ; af19: e8          .
    cpx #6                                                            ; af1a: e0 06       ..
    bcs caf30                                                         ; af1c: b0 12       ..
    iny                                                               ; af1e: c8          .
    bne loop_caf05                                                    ; af1f: d0 e4       ..
; &af21 referenced 3 times by &af09, &af0d, &af11
.caf21
    lda #&46 ; 'F'                                                    ; af21: a9 46       .F
    sta lce00                                                         ; af23: 8d 00 ce    ...
    pla                                                               ; af26: 68          h
    sta lce01,x                                                       ; af27: 9d 01 ce    ...
    lda #&0d                                                          ; af2a: a9 0d       ..
    sta lce02,x                                                       ; af2c: 9d 02 ce    ...
    rts                                                               ; af2f: 60          `

; &af30 referenced 3 times by &aeee, &af1c, &af36
.caf30
    jmp caddd                                                         ; af30: 4c dd ad    L..

; &af33 referenced 2 times by &aeab, &aeba
.sub_caf33
    jsr sub_cb704                                                     ; af33: 20 04 b7     ..
    bcs caf30                                                         ; af36: b0 f8       ..
    pha                                                               ; af38: 48          H
    txa                                                               ; af39: 8a          .
    tay                                                               ; af3a: a8          .
    plx                                                               ; af3b: fa          .
    rts                                                               ; af3c: 60          `

; &af3d referenced 1 time by &af82
.caf3d
    lda vfs_flags1                                                    ; af3d: ad 92 0d    ...
    beq caf4d                                                         ; af40: f0 0b       ..
    lda #&18                                                          ; af42: a9 18       ..
    sta user_via_ier                                                  ; af44: 8d 6e fe    .n.
    jsr cb022                                                         ; af47: 20 22 b0     ".
    stz vfs_flags1                                                    ; af4a: 9c 92 0d    ...
; &af4d referenced 2 times by &af40, &af87
.caf4d
    rts                                                               ; af4d: 60          `

; &af4e referenced 1 time by &af8c
.caf4e
    jsr sub_cb1e3                                                     ; af4e: 20 e3 b1     ..
    jsr generate_error_inline                                         ; af51: 20 26 83     &.
    equs &95, "IRQ already indirected", 0                             ; af54: 95 49 52... .IR

.MOUSE_command
.TRACKERBALL_command
    jsr sub_cacba                                                     ; af6c: 20 ba ac     ..
    jsr cae59                                                         ; af6f: 20 59 ae     Y.
    lda (l00a8),y                                                     ; af72: b1 a8       ..
    cmp #&0d                                                          ; af74: c9 0d       ..
    beq caf84                                                         ; af76: f0 0c       ..
    jsr sub_cb704                                                     ; af78: 20 04 b7     ..
    bcc caf80                                                         ; af7b: 90 03       ..
    jmp cb7c6                                                         ; af7d: 4c c6 b7    L..

; &af80 referenced 1 time by &af7b
.caf80
    and #1                                                            ; af80: 29 01       ).
    beq caf3d                                                         ; af82: f0 b9       ..
; &af84 referenced 1 time by &af76
.caf84
    ldx vfs_flags1                                                    ; af84: ae 92 0d    ...
    bne caf4d                                                         ; af87: d0 c4       ..
    lda l0923                                                         ; af89: ad 23 09    .#.
    bne caf4e                                                         ; af8c: d0 c0       ..
    stx l090d                                                         ; af8e: 8e 0d 09    ...
    stx l0909                                                         ; af91: 8e 09 09    ...
    dex                                                               ; af94: ca          .
    stx vfs_flags1                                                    ; af95: 8e 92 0d    ...
    stx l090a                                                         ; af98: 8e 0a 09    ...
    lda user_via_pcr                                                  ; af9b: ad 6c fe    .l.
    and #&0f                                                          ; af9e: 29 0f       ).
    sta user_via_pcr                                                  ; afa0: 8d 6c fe    .l.
    lda user_via_acr                                                  ; afa3: ad 6b fe    .k.
    and #&fc                                                          ; afa6: 29 fc       ).
    sta user_via_acr                                                  ; afa8: 8d 6b fe    .k.
    lda #&98                                                          ; afab: a9 98       ..
    sta user_via_ier                                                  ; afad: 8d 6e fe    .n.
    lda #0                                                            ; afb0: a9 00       ..
    sta user_via_ddrb                                                 ; afb2: 8d 62 fe    .b.
    lda #&80                                                          ; afb5: a9 80       ..
    sta l0904                                                         ; afb7: 8d 04 09    ...
    lda #2                                                            ; afba: a9 02       ..
    sta l0905                                                         ; afbc: 8d 05 09    ...
    lda #0                                                            ; afbf: a9 00       ..
    sta l0906                                                         ; afc1: 8d 06 09    ...
    lda #2                                                            ; afc4: a9 02       ..
    sta l0907                                                         ; afc6: 8d 07 09    ...
    lda #&7f                                                          ; afc9: a9 7f       ..
    sta l0900                                                         ; afcb: 8d 00 09    ...
    sta l0901                                                         ; afce: 8d 01 09    ...
    lda #0                                                            ; afd1: a9 00       ..
    sta l0902                                                         ; afd3: 8d 02 09    ...
    sta l0903                                                         ; afd6: 8d 03 09    ...
    rts                                                               ; afd9: 60          `

.POINTER_command
    jsr sub_cacba                                                     ; afda: 20 ba ac     ..
    jsr cae59                                                         ; afdd: 20 59 ae     Y.
    lda (l00a8),y                                                     ; afe0: b1 a8       ..
    cmp #&0d                                                          ; afe2: c9 0d       ..
    bne cafea                                                         ; afe4: d0 04       ..
    lda #1                                                            ; afe6: a9 01       ..
    bne caff2                                                         ; afe8: d0 08       ..
; &afea referenced 1 time by &afe4
.cafea
    jsr sub_cb704                                                     ; afea: 20 04 b7     ..
    bcc caff2                                                         ; afed: 90 03       ..
    jmp cb7c6                                                         ; afef: 4c c6 b7    L..

; &aff2 referenced 2 times by &afe8, &afed
.caff2
    ldy #&18                                                          ; aff2: a0 18       ..
    sty user_via_ier                                                  ; aff4: 8c 6e fe    .n.
    pha                                                               ; aff7: 48          H
    and #2                                                            ; aff8: 29 02       ).
    bne cb001                                                         ; affa: d0 05       ..
    lda #&98                                                          ; affc: a9 98       ..
    sta user_via_ier                                                  ; affe: 8d 6e fe    .n.
; &b001 referenced 1 time by &affa
.cb001
    pla                                                               ; b001: 68          h
    and #1                                                            ; b002: 29 01       ).
    beq cb022                                                         ; b004: f0 1c       ..
    lda vfs_flags1                                                    ; b006: ad 92 0d    ...
    beq cb021                                                         ; b009: f0 16       ..
    lda l0909                                                         ; b00b: ad 09 09    ...
    bne cb021                                                         ; b00e: d0 11       ..
    lda #&ff                                                          ; b010: a9 ff       ..
    sta l008f                                                         ; b012: 85 8f       ..
    jsr sub_cb2ed                                                     ; b014: 20 ed b2     ..
    ldy l0904                                                         ; b017: ac 04 09    ...
    dey                                                               ; b01a: 88          .
    sty l090e                                                         ; b01b: 8c 0e 09    ...
    dec l0909                                                         ; b01e: ce 09 09    ...
; &b021 referenced 4 times by &b009, &b00e, &b025, &b063
.cb021
    rts                                                               ; b021: 60          `

; &b022 referenced 2 times by &af47, &b004
.cb022
    lda l0909                                                         ; b022: ad 09 09    ...
    beq cb021                                                         ; b025: f0 fa       ..
    stz l0909                                                         ; b027: 9c 09 09    ...
    lda acccon                                                        ; b02a: ad 34 fe    .4.
    sta l0932                                                         ; b02d: 8d 32 09    .2.
    and #&fb                                                          ; b030: 29 fb       ).
    bit #2                                                            ; b032: 89 02       ..
    beq cb038                                                         ; b034: f0 02       ..
    ora #4                                                            ; b036: 09 04       ..
; &b038 referenced 1 time by &b034
.cb038
    sta acccon                                                        ; b038: 8d 34 fe    .4.
    jsr sub_cb240                                                     ; b03b: 20 40 b2     @.
    lda l0932                                                         ; b03e: ad 32 09    .2.
    sta acccon                                                        ; b041: 8d 34 fe    .4.
    rts                                                               ; b044: 60          `

; &b045 referenced 1 time by &b649
.sub_cb045
    lda l0904                                                         ; b045: ad 04 09    ...
    cmp l090e                                                         ; b048: cd 0e 09    ...
    bne cb065                                                         ; b04b: d0 18       ..
    lda l0906                                                         ; b04d: ad 06 09    ...
    cmp l0910                                                         ; b050: cd 10 09    ...
    bne cb065                                                         ; b053: d0 10       ..
    lda l0905                                                         ; b055: ad 05 09    ...
    cmp l090f                                                         ; b058: cd 0f 09    ...
    bne cb065                                                         ; b05b: d0 08       ..
    lda l0907                                                         ; b05d: ad 07 09    ...
    cmp l0911                                                         ; b060: cd 11 09    ...
    beq cb021                                                         ; b063: f0 bc       ..
; &b065 referenced 3 times by &b04b, &b053, &b05b
.cb065
    lda acccon                                                        ; b065: ad 34 fe    .4.
    sta l0932                                                         ; b068: 8d 32 09    .2.
    and #&fb                                                          ; b06b: 29 fb       ).
    bit #2                                                            ; b06d: 89 02       ..
    beq cb073                                                         ; b06f: f0 02       ..
    ora #4                                                            ; b071: 09 04       ..
; &b073 referenced 1 time by &b06f
.cb073
    sta acccon                                                        ; b073: 8d 34 fe    .4.
    lda l0906                                                         ; b076: ad 06 09    ...
    sta l0910                                                         ; b079: 8d 10 09    ...
    lda l0907                                                         ; b07c: ad 07 09    ...
    sta l0911                                                         ; b07f: 8d 11 09    ...
    lda l0904                                                         ; b082: ad 04 09    ...
    sta l090e                                                         ; b085: 8d 0e 09    ...
    lda l0905                                                         ; b088: ad 05 09    ...
    sta l090f                                                         ; b08b: 8d 0f 09    ...
    cmp l0901                                                         ; b08e: cd 01 09    ...
    bcc cb0a6                                                         ; b091: 90 13       ..
    beq cb097                                                         ; b093: f0 02       ..
    bcs cb09f                                                         ; b095: b0 08       ..
; &b097 referenced 1 time by &b093
.cb097
    lda l0904                                                         ; b097: ad 04 09    ...
    cmp l0900                                                         ; b09a: cd 00 09    ...
    bcc cb0a6                                                         ; b09d: 90 07       ..
; &b09f referenced 1 time by &b095
.cb09f
    lda l090b                                                         ; b09f: ad 0b 09    ...
    ora #1                                                            ; b0a2: 09 01       ..
    bne cb0ab                                                         ; b0a4: d0 05       ..
; &b0a6 referenced 2 times by &b091, &b09d
.cb0a6
    lda l090b                                                         ; b0a6: ad 0b 09    ...
    and #2                                                            ; b0a9: 29 02       ).
; &b0ab referenced 1 time by &b0a4
.cb0ab
    tay                                                               ; b0ab: a8          .
    lda l0907                                                         ; b0ac: ad 07 09    ...
    cmp l0903                                                         ; b0af: cd 03 09    ...
    bcc cb0c5                                                         ; b0b2: 90 11       ..
    beq cb0b8                                                         ; b0b4: f0 02       ..
    bcs cb0c0                                                         ; b0b6: b0 08       ..
; &b0b8 referenced 1 time by &b0b4
.cb0b8
    lda l0906                                                         ; b0b8: ad 06 09    ...
    cmp l0902                                                         ; b0bb: cd 02 09    ...
    bcc cb0c5                                                         ; b0be: 90 05       ..
; &b0c0 referenced 1 time by &b0b6
.cb0c0
    tya                                                               ; b0c0: 98          .
    ora #2                                                            ; b0c1: 09 02       ..
    bne cb0c8                                                         ; b0c3: d0 03       ..
; &b0c5 referenced 2 times by &b0b2, &b0be
.cb0c5
    tya                                                               ; b0c5: 98          .
    and #1                                                            ; b0c6: 29 01       ).
; &b0c8 referenced 1 time by &b0c3
.cb0c8
    cmp l090b                                                         ; b0c8: cd 0b 09    ...
    beq cb0d0                                                         ; b0cb: f0 03       ..
    jsr sub_cb2ed                                                     ; b0cd: 20 ed b2     ..
; &b0d0 referenced 1 time by &b0cb
.cb0d0
    ldy l0904                                                         ; b0d0: ac 04 09    ...
    lda l0908                                                         ; b0d3: ad 08 09    ...
    cmp #2                                                            ; b0d6: c9 02       ..
    bne cb0e9                                                         ; b0d8: d0 0f       ..
    lda l0905                                                         ; b0da: ad 05 09    ...
    cmp #4                                                            ; b0dd: c9 04       ..
    bne cb0e9                                                         ; b0df: d0 08       ..
    cpy #&f8                                                          ; b0e1: c0 f8       ..
    bcc cb0e9                                                         ; b0e3: 90 04       ..
    dey                                                               ; b0e5: 88          .
    dey                                                               ; b0e6: 88          .
    dey                                                               ; b0e7: 88          .
    dey                                                               ; b0e8: 88          .
; &b0e9 referenced 3 times by &b0d8, &b0df, &b0e3
.cb0e9
    ldx l090b                                                         ; b0e9: ae 0b 09    ...
    tya                                                               ; b0ec: 98          .
    sec                                                               ; b0ed: 38          8
    sbc lb9a0,x                                                       ; b0ee: fd a0 b9    ...
    sta l0912                                                         ; b0f1: 8d 12 09    ...
    lda l0905                                                         ; b0f4: ad 05 09    ...
    sbc #0                                                            ; b0f7: e9 00       ..
    sta l0913                                                         ; b0f9: 8d 13 09    ...
    lda lb9a4,x                                                       ; b0fc: bd a4 b9    ...
    clc                                                               ; b0ff: 18          .
    adc l0906                                                         ; b100: 6d 06 09    m..
    sta l0916                                                         ; b103: 8d 16 09    ...
    lda l0907                                                         ; b106: ad 07 09    ...
    adc #0                                                            ; b109: 69 00       i.
    sta l0917                                                         ; b10b: 8d 17 09    ...
    jsr sub_cb44c                                                     ; b10e: 20 4c b4     L.
    ldy romsel_copy                                                   ; b111: a4 f4       ..
    lda rom_private_byte,y                                            ; b113: b9 f0 0d    ...
    inc a                                                             ; b116: 1a          .
    sta l0085                                                         ; b117: 85 85       ..
    lda lb990,x                                                       ; b119: bd 90 b9    ...
    sta l0084                                                         ; b11c: 85 84       ..
    jsr sub_cb240                                                     ; b11e: 20 40 b2     @.
    lda l0912                                                         ; b121: ad 12 09    ...
    sta l0914                                                         ; b124: 8d 14 09    ...
    lda l0913                                                         ; b127: ad 13 09    ...
    sta l0915                                                         ; b12a: 8d 15 09    ...
    lda l008d                                                         ; b12d: a5 8d       ..
    pha                                                               ; b12f: 48          H
    lda l008c                                                         ; b130: a5 8c       ..
    pha                                                               ; b132: 48          H
    lda l008d                                                         ; b133: a5 8d       ..
    pha                                                               ; b135: 48          H
    lda l008c                                                         ; b136: a5 8c       ..
    pha                                                               ; b138: 48          H
    ldx #0                                                            ; b139: a2 00       ..
    stx l008a                                                         ; b13b: 86 8a       ..
; &b13d referenced 2 times by &b196, &b1d1
.cb13d
    ldy #0                                                            ; b13d: a0 00       ..
    sty l0089                                                         ; b13f: 84 89       ..
    lda l008d                                                         ; b141: a5 8d       ..
    bmi cb1a5                                                         ; b143: 30 60       0`
    cmp #&30 ; '0'                                                    ; b145: c9 30       .0
    bcc cb199                                                         ; b147: 90 50       .P
    lda l0913                                                         ; b149: ad 13 09    ...
    bmi cb1a5                                                         ; b14c: 30 57       0W
    cmp #5                                                            ; b14e: c9 05       ..
    bcc cb155                                                         ; b150: 90 03       ..
    jmp cb1d4                                                         ; b152: 4c d4 b1    L..

; &b155 referenced 2 times by &b150, &b180
.cb155
    ldy l0089                                                         ; b155: a4 89       ..
    lda (l008c),y                                                     ; b157: b1 8c       ..
    ldy l008a                                                         ; b159: a4 8a       ..
    sta (l0086),y                                                     ; b15b: 91 86       ..
    inc l0085                                                         ; b15d: e6 85       ..
    lda (l0084),y                                                     ; b15f: b1 84       ..
    dec l0085                                                         ; b161: c6 85       ..
    ldy l0089                                                         ; b163: a4 89       ..
    and (l008c),y                                                     ; b165: 31 8c       1.
    ldy l008a                                                         ; b167: a4 8a       ..
    ora (l0084),y                                                     ; b169: 11 84       ..
    ldy l0089                                                         ; b16b: a4 89       ..
    sta (l008c),y                                                     ; b16d: 91 8c       ..
    inc l008a                                                         ; b16f: e6 8a       ..
    lda l008a                                                         ; b171: a5 8a       ..
    and #&0f                                                          ; b173: 29 0f       ).
    beq cb1ae                                                         ; b175: f0 37       .7
    inc l0089                                                         ; b177: e6 89       ..
    lda l0089                                                         ; b179: a5 89       ..
    clc                                                               ; b17b: 18          .
    adc l008c                                                         ; b17c: 65 8c       e.
    and #7                                                            ; b17e: 29 07       ).
    bne cb155                                                         ; b180: d0 d3       ..
; &b182 referenced 1 time by &b1a2
.cb182
    ldy l0908                                                         ; b182: ac 08 09    ...
    lda l008c                                                         ; b185: a5 8c       ..
    and #&f8                                                          ; b187: 29 f8       ).
    clc                                                               ; b189: 18          .
    adc lb98a,y                                                       ; b18a: 79 8a b9    y..
    sta l008c                                                         ; b18d: 85 8c       ..
    lda l008d                                                         ; b18f: a5 8d       ..
    adc lb98d,y                                                       ; b191: 79 8d b9    y..
    sta l008d                                                         ; b194: 85 8d       ..
    jmp cb13d                                                         ; b196: 4c 3d b1    L=.

; &b199 referenced 1 time by &b147
.cb199
    lda l008c                                                         ; b199: a5 8c       ..
    and #7                                                            ; b19b: 29 07       ).
    clc                                                               ; b19d: 18          .
    adc l008a                                                         ; b19e: 65 8a       e.
    sta l008a                                                         ; b1a0: 85 8a       ..
    jmp cb182                                                         ; b1a2: 4c 82 b1    L..

; &b1a5 referenced 2 times by &b143, &b14c
.cb1a5
    lda l008a                                                         ; b1a5: a5 8a       ..
    and #&f0                                                          ; b1a7: 29 f0       ).
    clc                                                               ; b1a9: 18          .
    adc #&10                                                          ; b1aa: 69 10       i.
    sta l008a                                                         ; b1ac: 85 8a       ..
; &b1ae referenced 1 time by &b175
.cb1ae
    lda l0912                                                         ; b1ae: ad 12 09    ...
    clc                                                               ; b1b1: 18          .
    adc #&10                                                          ; b1b2: 69 10       i.
    sta l0912                                                         ; b1b4: 8d 12 09    ...
    bcc cb1bc                                                         ; b1b7: 90 03       ..
    inc l0913                                                         ; b1b9: ee 13 09    ...
; &b1bc referenced 1 time by &b1b7
.cb1bc
    pla                                                               ; b1bc: 68          h
    clc                                                               ; b1bd: 18          .
    adc #8                                                            ; b1be: 69 08       i.
    sta l008c                                                         ; b1c0: 85 8c       ..
    pla                                                               ; b1c2: 68          h
    adc #0                                                            ; b1c3: 69 00       i.
    sta l008d                                                         ; b1c5: 85 8d       ..
    pha                                                               ; b1c7: 48          H
    lda l008c                                                         ; b1c8: a5 8c       ..
    pha                                                               ; b1ca: 48          H
    lda l008a                                                         ; b1cb: a5 8a       ..
    cmp #&40 ; '@'                                                    ; b1cd: c9 40       .@
    beq cb1d4                                                         ; b1cf: f0 03       ..
    jmp cb13d                                                         ; b1d1: 4c 3d b1    L=.

; &b1d4 referenced 2 times by &b152, &b1cf
.cb1d4
    pla                                                               ; b1d4: 68          h
    pla                                                               ; b1d5: 68          h
    pla                                                               ; b1d6: 68          h
    sta l008e                                                         ; b1d7: 85 8e       ..
    pla                                                               ; b1d9: 68          h
    sta l008f                                                         ; b1da: 85 8f       ..
    lda l0932                                                         ; b1dc: ad 32 09    .2.
    sta acccon                                                        ; b1df: 8d 34 fe    .4.
    rts                                                               ; b1e2: 60          `

; &b1e3 referenced 6 times by &941c, &a78f, &af4e, &b2dd, &b64c, &b7c6
.sub_cb1e3
    lda l008e                                                         ; b1e3: a5 8e       ..
    sta l0924                                                         ; b1e5: 8d 24 09    .$.
    lda l008f                                                         ; b1e8: a5 8f       ..
    sta l0925                                                         ; b1ea: 8d 25 09    .%.
    ldx #&0c                                                          ; b1ed: a2 0c       ..
; &b1ef referenced 1 time by &b1f5
.loop_cb1ef
    lda l0926,x                                                       ; b1ef: bd 26 09    .&.
    sta l0084,x                                                       ; b1f2: 95 84       ..
    dex                                                               ; b1f4: ca          .
    bpl loop_cb1ef                                                    ; b1f5: 10 f8       ..
; &b1f7 referenced 5 times by &b228, &b516, &b527, &b531, &b547
.sub_cb1f7
    pha                                                               ; b1f7: 48          H
    phx                                                               ; b1f8: da          .
    phy                                                               ; b1f9: 5a          Z
    lda l0084                                                         ; b1fa: a5 84       ..
    pha                                                               ; b1fc: 48          H
    lda l0085                                                         ; b1fd: a5 85       ..
    pha                                                               ; b1ff: 48          H
    ldx romsel_copy                                                   ; b200: a6 f4       ..
    lda rom_private_byte,x                                            ; b202: bd f0 0d    ...
    clc                                                               ; b205: 18          .
    adc #3                                                            ; b206: 69 03       i.
    sta l0085                                                         ; b208: 85 85       ..
    lda #&40 ; '@'                                                    ; b20a: a9 40       .@
    sta l0084                                                         ; b20c: 85 84       ..
    ldy #&32 ; '2'                                                    ; b20e: a0 32       .2
; &b210 referenced 1 time by &b21c
.loop_cb210
    ldx l0900,y                                                       ; b210: be 00 09    ...
    lda (l0084),y                                                     ; b213: b1 84       ..
    sta l0900,y                                                       ; b215: 99 00 09    ...
    txa                                                               ; b218: 8a          .
    sta (l0084),y                                                     ; b219: 91 84       ..
    dey                                                               ; b21b: 88          .
    bpl loop_cb210                                                    ; b21c: 10 f2       ..
    pla                                                               ; b21e: 68          h
    sta l0085                                                         ; b21f: 85 85       ..
    pla                                                               ; b221: 68          h
    sta l0084                                                         ; b222: 85 84       ..
    ply                                                               ; b224: 7a          z
    plx                                                               ; b225: fa          .
    pla                                                               ; b226: 68          h
    rts                                                               ; b227: 60          `

; &b228 referenced 3 times by &9373, &a785, &b63e
.sub_cb228
    jsr sub_cb1f7                                                     ; b228: 20 f7 b1     ..
    ldx #&0c                                                          ; b22b: a2 0c       ..
; &b22d referenced 1 time by &b233
.loop_cb22d
    lda l0084,x                                                       ; b22d: b5 84       ..
    sta l0926,x                                                       ; b22f: 9d 26 09    .&.
    dex                                                               ; b232: ca          .
    bpl loop_cb22d                                                    ; b233: 10 f8       ..
    lda l0924                                                         ; b235: ad 24 09    .$.
    sta l008e                                                         ; b238: 85 8e       ..
    lda l0925                                                         ; b23a: ad 25 09    .%.
    sta l008f                                                         ; b23d: 85 8f       ..
; &b23f referenced 1 time by &b24e
.loop_cb23f
    rts                                                               ; b23f: 60          `

; &b240 referenced 2 times by &b03b, &b11e
.sub_cb240
    ldy romsel_copy                                                   ; b240: a4 f4       ..
    lda rom_private_byte,y                                            ; b242: b9 f0 0d    ...
    clc                                                               ; b245: 18          .
    adc #3                                                            ; b246: 69 03       i.
    sta l0087                                                         ; b248: 85 87       ..
    stz l0086                                                         ; b24a: 64 86       d.
    lda l008f                                                         ; b24c: a5 8f       ..
    bmi loop_cb23f                                                    ; b24e: 30 ef       0.
    pha                                                               ; b250: 48          H
    lda l008e                                                         ; b251: a5 8e       ..
    pha                                                               ; b253: 48          H
    ldy #0                                                            ; b254: a0 00       ..
    sty l008a                                                         ; b256: 84 8a       ..
; &b258 referenced 2 times by &b29c, &b2c0
.cb258
    ldy #0                                                            ; b258: a0 00       ..
    sty l0089                                                         ; b25a: 84 89       ..
    lda l008f                                                         ; b25c: a5 8f       ..
    bmi cb2c5                                                         ; b25e: 30 65       0e
    cmp #&30 ; '0'                                                    ; b260: c9 30       .0
    bcc cb2d1                                                         ; b262: 90 6d       .m
    lda l0915                                                         ; b264: ad 15 09    ...
    bmi cb2c5                                                         ; b267: 30 5c       0\
    cmp #5                                                            ; b269: c9 05       ..
    bcs cb2c2                                                         ; b26b: b0 55       .U
; &b26d referenced 1 time by &b286
.loop_cb26d
    ldy l008a                                                         ; b26d: a4 8a       ..
    lda (l0086),y                                                     ; b26f: b1 86       ..
    ldy l0089                                                         ; b271: a4 89       ..
    sta (l008e),y                                                     ; b273: 91 8e       ..
    inc l008a                                                         ; b275: e6 8a       ..
    lda l008a                                                         ; b277: a5 8a       ..
    and #&0f                                                          ; b279: 29 0f       ).
    beq cb29f                                                         ; b27b: f0 22       ."
    inc l0089                                                         ; b27d: e6 89       ..
    lda l0089                                                         ; b27f: a5 89       ..
    clc                                                               ; b281: 18          .
    adc l008e                                                         ; b282: 65 8e       e.
    and #7                                                            ; b284: 29 07       ).
    bne loop_cb26d                                                    ; b286: d0 e5       ..
; &b288 referenced 1 time by &b2da
.cb288
    ldy l0908                                                         ; b288: ac 08 09    ...
    lda l008e                                                         ; b28b: a5 8e       ..
    and #&f8                                                          ; b28d: 29 f8       ).
    clc                                                               ; b28f: 18          .
    adc lb98a,y                                                       ; b290: 79 8a b9    y..
    sta l008e                                                         ; b293: 85 8e       ..
    lda l008f                                                         ; b295: a5 8f       ..
    adc lb98d,y                                                       ; b297: 79 8d b9    y..
    sta l008f                                                         ; b29a: 85 8f       ..
    jmp cb258                                                         ; b29c: 4c 58 b2    LX.

; &b29f referenced 2 times by &b27b, &b2ce
.cb29f
    lda l0914                                                         ; b29f: ad 14 09    ...
    clc                                                               ; b2a2: 18          .
    adc #&10                                                          ; b2a3: 69 10       i.
    sta l0914                                                         ; b2a5: 8d 14 09    ...
    bcc cb2ad                                                         ; b2a8: 90 03       ..
    inc l0915                                                         ; b2aa: ee 15 09    ...
; &b2ad referenced 1 time by &b2a8
.cb2ad
    pla                                                               ; b2ad: 68          h
    clc                                                               ; b2ae: 18          .
    adc #8                                                            ; b2af: 69 08       i.
    sta l008e                                                         ; b2b1: 85 8e       ..
    pla                                                               ; b2b3: 68          h
    adc #0                                                            ; b2b4: 69 00       i.
    sta l008f                                                         ; b2b6: 85 8f       ..
    pha                                                               ; b2b8: 48          H
    lda l008e                                                         ; b2b9: a5 8e       ..
    pha                                                               ; b2bb: 48          H
    ldy l008a                                                         ; b2bc: a4 8a       ..
    cpy #&40 ; '@'                                                    ; b2be: c0 40       .@
    bne cb258                                                         ; b2c0: d0 96       ..
; &b2c2 referenced 1 time by &b26b
.cb2c2
    pla                                                               ; b2c2: 68          h
    pla                                                               ; b2c3: 68          h
    rts                                                               ; b2c4: 60          `

; &b2c5 referenced 2 times by &b25e, &b267
.cb2c5
    lda l008a                                                         ; b2c5: a5 8a       ..
    and #&f0                                                          ; b2c7: 29 f0       ).
    clc                                                               ; b2c9: 18          .
    adc #&10                                                          ; b2ca: 69 10       i.
    sta l008a                                                         ; b2cc: 85 8a       ..
    jmp cb29f                                                         ; b2ce: 4c 9f b2    L..

; &b2d1 referenced 1 time by &b262
.cb2d1
    lda l008e                                                         ; b2d1: a5 8e       ..
    and #7                                                            ; b2d3: 29 07       ).
    clc                                                               ; b2d5: 18          .
    adc l008a                                                         ; b2d6: 65 8a       e.
    sta l008a                                                         ; b2d8: 85 8a       ..
    jmp cb288                                                         ; b2da: 4c 88 b2    L..

; &b2dd referenced 1 time by &b2fc
.loop_cb2dd
    jsr sub_cb1e3                                                     ; b2dd: 20 e3 b1     ..
    jsr generate_error_inline                                         ; b2e0: 20 26 83     &.
    equs &ad, "Bad MODE", 0                                           ; b2e3: ad 42 61... .Ba

; &b2ed referenced 2 times by &b014, &b0cd
.sub_cb2ed
    sta l090b                                                         ; b2ed: 8d 0b 09    ...
    asl a                                                             ; b2f0: 0a          .
    asl a                                                             ; b2f1: 0a          .
    asl a                                                             ; b2f2: 0a          .
    asl a                                                             ; b2f3: 0a          .
    asl a                                                             ; b2f4: 0a          .
    asl a                                                             ; b2f5: 0a          .
    tay                                                               ; b2f6: a8          .
    lda l0908                                                         ; b2f7: ad 08 09    ...
    cmp #3                                                            ; b2fa: c9 03       ..
    bcs loop_cb2dd                                                    ; b2fc: b0 df       ..
    pha                                                               ; b2fe: 48          H
    clc                                                               ; b2ff: 18          .
    adc #&b9                                                          ; b300: 69 b9       i.
    sta l0085                                                         ; b302: 85 85       ..
    lda #&a8                                                          ; b304: a9 a8       ..
    sta l0084                                                         ; b306: 85 84       ..
    pla                                                               ; b308: 68          h
    clc                                                               ; b309: 18          .
    adc #&bc                                                          ; b30a: 69 bc       i.
    sta l0087                                                         ; b30c: 85 87       ..
    lda #&a8                                                          ; b30e: a9 a8       ..
    sta l0086                                                         ; b310: 85 86       ..
    ldx romsel_copy                                                   ; b312: a6 f4       ..
    lda rom_private_byte,x                                            ; b314: bd f0 0d    ...
    inc a                                                             ; b317: 1a          .
    sta l008d                                                         ; b318: 85 8d       ..
    stz l008c                                                         ; b31a: 64 8c       d.
    sty l008a                                                         ; b31c: 84 8a       ..
    ldy #0                                                            ; b31e: a0 00       ..
    sty l0089                                                         ; b320: 84 89       ..
; &b322 referenced 1 time by &b33e
.loop_cb322
    ldy l008a                                                         ; b322: a4 8a       ..
    lda (l0084),y                                                     ; b324: b1 84       ..
    ldy l0089                                                         ; b326: a4 89       ..
    sta (l008c),y                                                     ; b328: 91 8c       ..
    ldy l008a                                                         ; b32a: a4 8a       ..
    lda (l0086),y                                                     ; b32c: b1 86       ..
    ldy l0089                                                         ; b32e: a4 89       ..
    inc l008d                                                         ; b330: e6 8d       ..
    sta (l008c),y                                                     ; b332: 91 8c       ..
    dec l008d                                                         ; b334: c6 8d       ..
    inc l008a                                                         ; b336: e6 8a       ..
    inc l0089                                                         ; b338: e6 89       ..
    ldy l0089                                                         ; b33a: a4 89       ..
    cpy #&40 ; '@'                                                    ; b33c: c0 40       .@
    bne loop_cb322                                                    ; b33e: d0 e2       ..
    stz l0084                                                         ; b340: 64 84       d.
    lda #&40 ; '@'                                                    ; b342: a9 40       .@
    sta l0086                                                         ; b344: 85 86       ..
    ldx romsel_copy                                                   ; b346: a6 f4       ..
    lda rom_private_byte,x                                            ; b348: bd f0 0d    ...
    inc a                                                             ; b34b: 1a          .
    sta l0085                                                         ; b34c: 85 85       ..
    sta l0087                                                         ; b34e: 85 87       ..
    lda #0                                                            ; b350: a9 00       ..
    sta l0088                                                         ; b352: 85 88       ..
    jsr sub_cb36b                                                     ; b354: 20 6b b3     k.
    stz l0084                                                         ; b357: 64 84       d.
    lda #&40 ; '@'                                                    ; b359: a9 40       .@
    sta l0086                                                         ; b35b: 85 86       ..
    ldx romsel_copy                                                   ; b35d: a6 f4       ..
    lda rom_private_byte,x                                            ; b35f: bd f0 0d    ...
    clc                                                               ; b362: 18          .
    adc #2                                                            ; b363: 69 02       i.
    sta l0085                                                         ; b365: 85 85       ..
    sta l0087                                                         ; b367: 85 87       ..
    dec l0088                                                         ; b369: c6 88       ..
; &b36b referenced 1 time by &b354
.sub_cb36b
    lda l0908                                                         ; b36b: ad 08 09    ...
    beq cb3c1                                                         ; b36e: f0 51       .Q
    cmp #1                                                            ; b370: c9 01       ..
    beq cb377                                                         ; b372: f0 03       ..
    jmp cb3fe                                                         ; b374: 4c fe b3    L..

; &b377 referenced 1 time by &b372
.cb377
    jsr sub_cb37d                                                     ; b377: 20 7d b3     }.
    jsr sub_cb37d                                                     ; b37a: 20 7d b3     }.
; &b37d referenced 2 times by &b377, &b37a
.sub_cb37d
    ldx #0                                                            ; b37d: a2 00       ..
; &b37f referenced 1 time by &b3ad
.cb37f
    lda l0088                                                         ; b37f: a5 88       ..
    cmp #&ff                                                          ; b381: c9 ff       ..
    lda #0                                                            ; b383: a9 00       ..
    php                                                               ; b385: 08          .
; &b386 referenced 1 time by &b3a7
.cb386
    sta l008a                                                         ; b386: 85 8a       ..
    txa                                                               ; b388: 8a          .
    ora l008a                                                         ; b389: 05 8a       ..
    tay                                                               ; b38b: a8          .
    lda (l0084),y                                                     ; b38c: b1 84       ..
    plp                                                               ; b38e: 28          (
    bcs cb395                                                         ; b38f: b0 04       ..
    and #&ef                                                          ; b391: 29 ef       ).
    bcc cb397                                                         ; b393: 90 02       ..
; &b395 referenced 1 time by &b38f
.cb395
    ora #&10                                                          ; b395: 09 10       ..
; &b397 referenced 1 time by &b393
.cb397
    bit l0088                                                         ; b397: 24 88       $.
    bmi cb39c                                                         ; b399: 30 01       0.
    clc                                                               ; b39b: 18          .
; &b39c referenced 1 time by &b399
.cb39c
    ror a                                                             ; b39c: 6a          j
    php                                                               ; b39d: 08          .
    sta (l0086),y                                                     ; b39e: 91 86       ..
    lda l008a                                                         ; b3a0: a5 8a       ..
    clc                                                               ; b3a2: 18          .
    adc #&10                                                          ; b3a3: 69 10       i.
    cmp #&40 ; '@'                                                    ; b3a5: c9 40       .@
    bne cb386                                                         ; b3a7: d0 dd       ..
    plp                                                               ; b3a9: 28          (
    inx                                                               ; b3aa: e8          .
    cpx #&10                                                          ; b3ab: e0 10       ..
    bne cb37f                                                         ; b3ad: d0 d0       ..
; &b3af referenced 3 times by &b3d5, &b43d, &b449
.cb3af
    lda l0085                                                         ; b3af: a5 85       ..
    sta l0087                                                         ; b3b1: 85 87       ..
    lda l0086                                                         ; b3b3: a5 86       ..
    sta l0084                                                         ; b3b5: 85 84       ..
    clc                                                               ; b3b7: 18          .
    adc #&40 ; '@'                                                    ; b3b8: 69 40       i@
    sta l0086                                                         ; b3ba: 85 86       ..
    bcc cb3c0                                                         ; b3bc: 90 02       ..
    inc l0087                                                         ; b3be: e6 87       ..
; &b3c0 referenced 1 time by &b3bc
.cb3c0
    rts                                                               ; b3c0: 60          `

; &b3c1 referenced 1 time by &b36e
.cb3c1
    jsr sub_cb3c7                                                     ; b3c1: 20 c7 b3     ..
    jsr sub_cb3c7                                                     ; b3c4: 20 c7 b3     ..
; &b3c7 referenced 2 times by &b3c1, &b3c4
.sub_cb3c7
    jsr sub_cb3d8                                                     ; b3c7: 20 d8 b3     ..
    lda l0085                                                         ; b3ca: a5 85       ..
    sta l0087                                                         ; b3cc: 85 87       ..
    lda l0086                                                         ; b3ce: a5 86       ..
    sta l0084                                                         ; b3d0: 85 84       ..
    jsr sub_cb3d8                                                     ; b3d2: 20 d8 b3     ..
    jmp cb3af                                                         ; b3d5: 4c af b3    L..

; &b3d8 referenced 2 times by &b3c7, &b3d2
.sub_cb3d8
    ldx #0                                                            ; b3d8: a2 00       ..
; &b3da referenced 1 time by &b3fb
.cb3da
    lda l0088                                                         ; b3da: a5 88       ..
    cmp #&ff                                                          ; b3dc: c9 ff       ..
    lda #0                                                            ; b3de: a9 00       ..
    php                                                               ; b3e0: 08          .
; &b3e1 referenced 1 time by &b3f5
.loop_cb3e1
    sta l008a                                                         ; b3e1: 85 8a       ..
    txa                                                               ; b3e3: 8a          .
    ora l008a                                                         ; b3e4: 05 8a       ..
    tay                                                               ; b3e6: a8          .
    lda (l0084),y                                                     ; b3e7: b1 84       ..
    plp                                                               ; b3e9: 28          (
    ror a                                                             ; b3ea: 6a          j
    php                                                               ; b3eb: 08          .
    sta (l0086),y                                                     ; b3ec: 91 86       ..
    lda l008a                                                         ; b3ee: a5 8a       ..
    clc                                                               ; b3f0: 18          .
    adc #&10                                                          ; b3f1: 69 10       i.
    cmp #&40 ; '@'                                                    ; b3f3: c9 40       .@
    bne loop_cb3e1                                                    ; b3f5: d0 ea       ..
    plp                                                               ; b3f7: 28          (
    inx                                                               ; b3f8: e8          .
    cpx #&10                                                          ; b3f9: e0 10       ..
    bne cb3da                                                         ; b3fb: d0 dd       ..
    rts                                                               ; b3fd: 60          `

; &b3fe referenced 1 time by &b374
.cb3fe
    jsr cb440                                                         ; b3fe: 20 40 b4     @.
    jsr sub_cb407                                                     ; b401: 20 07 b4     ..
    jmp cb440                                                         ; b404: 4c 40 b4    L@.

; &b407 referenced 1 time by &b401
.sub_cb407
    ldx #0                                                            ; b407: a2 00       ..
; &b409 referenced 1 time by &b43b
.cb409
    lda l0088                                                         ; b409: a5 88       ..
    cmp #&ff                                                          ; b40b: c9 ff       ..
    lda #0                                                            ; b40d: a9 00       ..
    php                                                               ; b40f: 08          .
; &b410 referenced 1 time by &b435
.cb410
    sta l008a                                                         ; b410: 85 8a       ..
    txa                                                               ; b412: 8a          .
    ora l008a                                                         ; b413: 05 8a       ..
    tay                                                               ; b415: a8          .
    lda (l0084),y                                                     ; b416: b1 84       ..
    and #&aa                                                          ; b418: 29 aa       ).
    lsr a                                                             ; b41a: 4a          J
    plp                                                               ; b41b: 28          (
    bcc cb426                                                         ; b41c: 90 08       ..
    bit l0088                                                         ; b41e: 24 88       $.
    bpl cb424                                                         ; b420: 10 02       ..
    ora #&aa                                                          ; b422: 09 aa       ..
; &b424 referenced 1 time by &b420
.cb424
    ora #2                                                            ; b424: 09 02       ..
; &b426 referenced 1 time by &b41c
.cb426
    sta (l0086),y                                                     ; b426: 91 86       ..
    lda (l0084),y                                                     ; b428: b1 84       ..
    and #&55 ; 'U'                                                    ; b42a: 29 55       )U
    lsr a                                                             ; b42c: 4a          J
    php                                                               ; b42d: 08          .
    lda l008a                                                         ; b42e: a5 8a       ..
    clc                                                               ; b430: 18          .
    adc #&10                                                          ; b431: 69 10       i.
    cmp #&40 ; '@'                                                    ; b433: c9 40       .@
    bne cb410                                                         ; b435: d0 d9       ..
    plp                                                               ; b437: 28          (
    inx                                                               ; b438: e8          .
    cpx #&10                                                          ; b439: e0 10       ..
    bne cb409                                                         ; b43b: d0 cc       ..
    jmp cb3af                                                         ; b43d: 4c af b3    L..

; &b440 referenced 2 times by &b3fe, &b404
.cb440
    ldy #&3f ; '?'                                                    ; b440: a0 3f       .?
; &b442 referenced 1 time by &b447
.loop_cb442
    lda (l0084),y                                                     ; b442: b1 84       ..
    sta (l0086),y                                                     ; b444: 91 86       ..
    dey                                                               ; b446: 88          .
    bpl loop_cb442                                                    ; b447: 10 f9       ..
    jmp cb3af                                                         ; b449: 4c af b3    L..

; &b44c referenced 1 time by &b10e
.sub_cb44c
    lda l0917                                                         ; b44c: ad 17 09    ...
    sta l008c                                                         ; b44f: 85 8c       ..
    lda l0916                                                         ; b451: ad 16 09    ...
    lsr l008c                                                         ; b454: 46 8c       F.
    ror a                                                             ; b456: 6a          j
    lsr l008c                                                         ; b457: 46 8c       F.
    ror a                                                             ; b459: 6a          j
    sta l0916                                                         ; b45a: 8d 16 09    ...
    lsr a                                                             ; b45d: 4a          J
    lsr a                                                             ; b45e: 4a          J
    lsr a                                                             ; b45f: 4a          J
    tax                                                               ; b460: aa          .
    lda l0913                                                         ; b461: ad 13 09    ...
    bpl cb467                                                         ; b464: 10 01       ..
    inx                                                               ; b466: e8          .
; &b467 referenced 1 time by &b464
.cb467
    lda l008c                                                         ; b467: a5 8c       ..
    beq cb47b                                                         ; b469: f0 10       ..
    txa                                                               ; b46b: 8a          .
    clc                                                               ; b46c: 18          .
    adc #&20 ; ' '                                                    ; b46d: 69 20       i
    tax                                                               ; b46f: aa          .
    lda l0916                                                         ; b470: ad 16 09    ...
    eor #7                                                            ; b473: 49 07       I.
    sta l0916                                                         ; b475: 8d 16 09    ...
    dec l0916                                                         ; b478: ce 16 09    ...
; &b47b referenced 1 time by &b469
.cb47b
    lda lb965,x                                                       ; b47b: bd 65 b9    .e.
    sta l008d                                                         ; b47e: 85 8d       ..
    lda lb943,x                                                       ; b480: bd 43 b9    .C.
    sta l008c                                                         ; b483: 85 8c       ..
    lda l0913                                                         ; b485: ad 13 09    ...
    bpl cb48d                                                         ; b488: 10 03       ..
    clc                                                               ; b48a: 18          .
    adc #5                                                            ; b48b: 69 05       i.
; &b48d referenced 1 time by &b488
.cb48d
    sta l0088                                                         ; b48d: 85 88       ..
    lda l0912                                                         ; b48f: ad 12 09    ...
    lsr l0088                                                         ; b492: 46 88       F.
    ror a                                                             ; b494: 6a          j
    and #&f8                                                          ; b495: 29 f8       ).
    clc                                                               ; b497: 18          .
    adc l008c                                                         ; b498: 65 8c       e.
    sta l008c                                                         ; b49a: 85 8c       ..
    lda l0088                                                         ; b49c: a5 88       ..
    adc l008d                                                         ; b49e: 65 8d       e.
    sta l008d                                                         ; b4a0: 85 8d       ..
    lda l0916                                                         ; b4a2: ad 16 09    ...
    and #7                                                            ; b4a5: 29 07       ).
    eor #7                                                            ; b4a7: 49 07       I.
    ora l008c                                                         ; b4a9: 05 8c       ..
    sta l008c                                                         ; b4ab: 85 8c       ..
    lda l0912                                                         ; b4ad: ad 12 09    ...
    lsr a                                                             ; b4b0: 4a          J
    lsr a                                                             ; b4b1: 4a          J
    and #3                                                            ; b4b2: 29 03       ).
    tax                                                               ; b4b4: aa          .
    rts                                                               ; b4b5: 60          `

.OSBYTE_Extended_Vectorcode
    cmp #&80                                                          ; b4b6: c9 80       ..
    beq cb50a                                                         ; b4b8: f0 50       .P
; &b4ba referenced 2 times by &b50e, &b512
.cb4ba
    pha                                                               ; b4ba: 48          H
    lda vfs_old_bytev2                                                ; b4bb: ad 98 0d    ...
    cmp #&ff                                                          ; b4be: c9 ff       ..
    beq cb4c6                                                         ; b4c0: f0 04       ..
    pla                                                               ; b4c2: 68          h
    jmp (vfs_old_bytev1)                                              ; b4c3: 6c 97 0d    l..

; &b4c6 referenced 1 time by &b4c0
.cb4c6
    php                                                               ; b4c6: 08          .
    sei                                                               ; b4c7: 78          x
    phx                                                               ; b4c8: da          .
    phy                                                               ; b4c9: 5a          Z
    ldx #3                                                            ; b4ca: a2 03       ..
; &b4cc referenced 1 time by &b4d0
.loop_cb4cc
    lda l00a8,x                                                       ; b4cc: b5 a8       ..
    pha                                                               ; b4ce: 48          H
    dex                                                               ; b4cf: ca          .
    bpl loop_cb4cc                                                    ; b4d0: 10 fa       ..
    ldy romsel_copy                                                   ; b4d2: a4 f4       ..
    lda rom_private_byte,y                                            ; b4d4: b9 f0 0d    ...
    clc                                                               ; b4d7: 18          .
    adc #3                                                            ; b4d8: 69 03       i.
    sta l00ab                                                         ; b4da: 85 ab       ..
    stz l00aa                                                         ; b4dc: 64 aa       d.
    ldy #&5b ; '['                                                    ; b4de: a0 5b       .[
    lda (l00aa),y                                                     ; b4e0: b1 aa       ..
    clc                                                               ; b4e2: 18          .
    adc #&4e ; 'N'                                                    ; b4e3: 69 4e       iN
    sta l00a8                                                         ; b4e5: 85 a8       ..
    iny                                                               ; b4e7: c8          .
    lda (l00aa),y                                                     ; b4e8: b1 aa       ..
    sta l00a9                                                         ; b4ea: 85 a9       ..
    lda #&5d ; ']'                                                    ; b4ec: a9 5d       .]
    sta l00aa                                                         ; b4ee: 85 aa       ..
    ldy #2                                                            ; b4f0: a0 02       ..
; &b4f2 referenced 1 time by &b4f7
.loop_cb4f2
    lda (l00aa),y                                                     ; b4f2: b1 aa       ..
    sta (l00a8),y                                                     ; b4f4: 91 a8       ..
    dey                                                               ; b4f6: 88          .
    bpl loop_cb4f2                                                    ; b4f7: 10 f9       ..
    ldx #0                                                            ; b4f9: a2 00       ..
; &b4fb referenced 1 time by &b501
.loop_cb4fb
    pla                                                               ; b4fb: 68          h
    sta l00a8,x                                                       ; b4fc: 95 a8       ..
    inx                                                               ; b4fe: e8          .
    cpx #4                                                            ; b4ff: e0 04       ..
    bne loop_cb4fb                                                    ; b501: d0 f8       ..
    ply                                                               ; b503: 7a          z
    plx                                                               ; b504: fa          .
    plp                                                               ; b505: 28          (
    pla                                                               ; b506: 68          h
    jmp lff4e                                                         ; b507: 4c 4e ff    LN.

; ADVAL handler
; &b50a referenced 1 time by &b4b8
.cb50a
    cpx #9                                                            ; b50a: e0 09       ..
    beq cb52f                                                         ; b50c: f0 21       .!
    bcs cb4ba                                                         ; b50e: b0 aa       ..
    cpx #5                                                            ; b510: e0 05       ..
    bcc cb4ba                                                         ; b512: 90 a6       ..
    php                                                               ; b514: 08          .
    sei                                                               ; b515: 78          x
    jsr sub_cb1f7                                                     ; b516: 20 f7 b1     ..
    txa                                                               ; b519: 8a          .
    asl a                                                             ; b51a: 0a          .
    adc #&f6                                                          ; b51b: 69 f6       i.
    tay                                                               ; b51d: a8          .
    lda l0900,y                                                       ; b51e: b9 00 09    ...
    tax                                                               ; b521: aa          .
    iny                                                               ; b522: c8          .
    lda l0900,y                                                       ; b523: b9 00 09    ...
    tay                                                               ; b526: a8          .
    jsr sub_cb1f7                                                     ; b527: 20 f7 b1     ..
    plp                                                               ; b52a: 28          (
; &b52b referenced 1 time by &b54d
.cb52b
    lda #&80                                                          ; b52b: a9 80       ..
    clv                                                               ; b52d: b8          .
    rts                                                               ; b52e: 60          `

; ADVAL(9) - read buttons
; &b52f referenced 1 time by &b50c
.cb52f
    php                                                               ; b52f: 08          .
    sei                                                               ; b530: 78          x
    jsr sub_cb1f7                                                     ; b531: 20 f7 b1     ..
    jsr sub_cb65b                                                     ; b534: 20 5b b6     [.
    lda user_via_orb_irb                                              ; b537: ad 60 fe    .`.
    cpx #0                                                            ; b53a: e0 00       ..
    beq cb542                                                         ; b53c: f0 04       ..
    rol a                                                             ; b53e: 2a          *
    rol a                                                             ; b53f: 2a          *
    rol a                                                             ; b540: 2a          *
    rol a                                                             ; b541: 2a          *
; &b542 referenced 1 time by &b53c
.cb542
    and #7                                                            ; b542: 29 07       ).
    eor #7                                                            ; b544: 49 07       I.
    tax                                                               ; b546: aa          .
    jsr sub_cb1f7                                                     ; b547: 20 f7 b1     ..
    plp                                                               ; b54a: 28          (
    ldy #0                                                            ; b54b: a0 00       ..
    beq cb52b                                                         ; b54d: f0 dc       ..
.Extended_IRQ1_Vector
    cld                                                               ; b54f: d8          .
    lda user_via_ier                                                  ; b550: ad 6e fe    .n.
    and user_via_ifr                                                  ; b553: 2d 6d fe    -m.
    and #&18                                                          ; b556: 29 18       ).
    bne cb567                                                         ; b558: d0 0d       ..
    lda #>(rts_call_via_rti)                                          ; b55a: a9 b5       ..
    pha                                                               ; b55c: 48          H
    lda #<(rts_call_via_rti)                                          ; b55d: a9 66       .f
    pha                                                               ; b55f: 48          H
    php                                                               ; b560: 08          .
    lda l00fc                                                         ; b561: a5 fc       ..
    jmp (vfs_old_irq1v1a)                                             ; b563: 6c 9d 0d    l..

.rts_call_via_rti
    rts                                                               ; b566: 60          `

; Mouse has moved
; &b567 referenced 1 time by &b558
.cb567
    phx                                                               ; b567: da          .
    ldx user_via_orb_irb                                              ; b568: ae 60 fe    .`.
    phy                                                               ; b56b: 5a          Z
    tay                                                               ; b56c: a8          .
    lda l0084                                                         ; b56d: a5 84       ..
    pha                                                               ; b56f: 48          H
    lda l0085                                                         ; b570: a5 85       ..
    pha                                                               ; b572: 48          H
    phx                                                               ; b573: da          .
    phy                                                               ; b574: 5a          Z
    ldy romsel_copy                                                   ; b575: a4 f4       ..
    lda rom_private_byte,y                                            ; b577: b9 f0 0d    ...
    clc                                                               ; b57a: 18          .
    adc #3                                                            ; b57b: 69 03       i.
    sta l0085                                                         ; b57d: 85 85       ..
    lda #&44 ; 'D'                                                    ; b57f: a9 44       .D
    sta l0084                                                         ; b581: 85 84       ..
    jsr sub_cb6d4                                                     ; b583: 20 d4 b6     ..
    ply                                                               ; b586: 7a          z
    jsr sub_cb65b                                                     ; b587: 20 5b b6     [.
    tya                                                               ; b58a: 98          .
    and #&10                                                          ; b58b: 29 10       ).
    beq cb5cc                                                         ; b58d: f0 3d       .=
    pla                                                               ; b58f: 68          h
    pha                                                               ; b590: 48          H
    and lb6cc,x                                                       ; b591: 3d cc b6    =..
    beq cb5b3                                                         ; b594: f0 1d       ..
    lda l0905                                                         ; b596: ad 05 09    ...
    cmp #4                                                            ; b599: c9 04       ..
    bne cb5a4                                                         ; b59b: d0 07       ..
    lda l0904                                                         ; b59d: ad 04 09    ...
    cmp #&fc                                                          ; b5a0: c9 fc       ..
    bcs cb5cc                                                         ; b5a2: b0 28       .(
; &b5a4 referenced 1 time by &b59b
.cb5a4
    lda l0904                                                         ; b5a4: ad 04 09    ...
    adc #4                                                            ; b5a7: 69 04       i.
    sta l0904                                                         ; b5a9: 8d 04 09    ...
    bcc cb5b1                                                         ; b5ac: 90 03       ..
    inc l0905                                                         ; b5ae: ee 05 09    ...
; &b5b1 referenced 1 time by &b5ac
.cb5b1
    bra cb5cc                                                         ; b5b1: 80 19       ..
; &b5b3 referenced 1 time by &b594
.cb5b3
    lda l0904                                                         ; b5b3: ad 04 09    ...
    ora l0905                                                         ; b5b6: 0d 05 09    ...
    beq cb5cc                                                         ; b5b9: f0 11       ..
    lda l0904                                                         ; b5bb: ad 04 09    ...
    sec                                                               ; b5be: 38          8
    sbc #4                                                            ; b5bf: e9 04       ..
    sta l0904                                                         ; b5c1: 8d 04 09    ...
    lda l0905                                                         ; b5c4: ad 05 09    ...
    sbc #0                                                            ; b5c7: e9 00       ..
    sta l0905                                                         ; b5c9: 8d 05 09    ...
; &b5cc referenced 4 times by &b58d, &b5a2, &b5b1, &b5b9
.cb5cc
    tya                                                               ; b5cc: 98          .
    and #8                                                            ; b5cd: 29 08       ).
    beq cb609                                                         ; b5cf: f0 38       .8
    pla                                                               ; b5d1: 68          h
    and lb6cb,x                                                       ; b5d2: 3d cb b6    =..
    beq cb5f1                                                         ; b5d5: f0 1a       ..
    lda l0907                                                         ; b5d7: ad 07 09    ...
    cmp #3                                                            ; b5da: c9 03       ..
    lda l0906                                                         ; b5dc: ad 06 09    ...
    bcc cb5e5                                                         ; b5df: 90 04       ..
    cmp #&fc                                                          ; b5e1: c9 fc       ..
    bcs cb60a                                                         ; b5e3: b0 25       .%
; &b5e5 referenced 1 time by &b5df
.cb5e5
    adc #4                                                            ; b5e5: 69 04       i.
    sta l0906                                                         ; b5e7: 8d 06 09    ...
    bcc cb60a                                                         ; b5ea: 90 1e       ..
    inc l0907                                                         ; b5ec: ee 07 09    ...
    bra cb60a                                                         ; b5ef: 80 19       ..
; &b5f1 referenced 1 time by &b5d5
.cb5f1
    lda l0906                                                         ; b5f1: ad 06 09    ...
    ora l0907                                                         ; b5f4: 0d 07 09    ...
    beq cb60a                                                         ; b5f7: f0 11       ..
    lda l0906                                                         ; b5f9: ad 06 09    ...
    sec                                                               ; b5fc: 38          8
    sbc #4                                                            ; b5fd: e9 04       ..
    sta l0906                                                         ; b5ff: 8d 06 09    ...
    bcs cb60a                                                         ; b602: b0 06       ..
    dec l0907                                                         ; b604: ce 07 09    ...
    bra cb60a                                                         ; b607: 80 01       ..
; &b609 referenced 1 time by &b5cf
.cb609
    pla                                                               ; b609: 68          h
; &b60a referenced 6 times by &b5e3, &b5ea, &b5ef, &b5f7, &b602, &b607
.cb60a
    lda user_via_orb_irb                                              ; b60a: ad 60 fe    .`.
    jsr sub_cb6d4                                                     ; b60d: 20 d4 b6     ..
    pla                                                               ; b610: 68          h
    sta l0085                                                         ; b611: 85 85       ..
    pla                                                               ; b613: 68          h
    sta l0084                                                         ; b614: 85 84       ..
    ply                                                               ; b616: 7a          z
    plx                                                               ; b617: fa          .
    lda l00fc                                                         ; b618: a5 fc       ..
    rts                                                               ; b61a: 60          `

; Service &15 - 100Hz poll - check if mouse has moved
; &b61b referenced 1 time by &a6f5
.service_handler_100Hz
    php                                                               ; b61b: 08          .
    dec vfs_100Hz_timer                                               ; b61c: ce 95 0d    ...
    bpl cb652                                                         ; b61f: 10 31       .1
    pha                                                               ; b621: 48          H
    lda #4                                                            ; b622: a9 04       ..
    sta vfs_100Hz_timer                                               ; b624: 8d 95 0d    ...
    lda vfs_25Hz_timer_hi                                             ; b627: ad 94 0d    ...
    bmi cb637                                                         ; b62a: 30 0b       0.
    lda vfs_25Hz_timer_lo                                             ; b62c: ad 93 0d    ...
    bne cb634                                                         ; b62f: d0 03       ..
    dec vfs_25Hz_timer_hi                                             ; b631: ce 94 0d    ...
; &b634 referenced 1 time by &b62f
.cb634
    dec vfs_25Hz_timer_lo                                             ; b634: ce 93 0d    ...
; &b637 referenced 1 time by &b62a
.cb637
    lda vfs_flags1                                                    ; b637: ad 92 0d    ...
    beq cb651                                                         ; b63a: f0 15       ..
    phx                                                               ; b63c: da          .
    phy                                                               ; b63d: 5a          Z
    jsr sub_cb228                                                     ; b63e: 20 28 b2     (.
    jsr sub_cb67e                                                     ; b641: 20 7e b6     ~.
    lda l0909                                                         ; b644: ad 09 09    ...
    beq cb64c                                                         ; b647: f0 03       ..
    jsr sub_cb045                                                     ; b649: 20 45 b0     E.
; &b64c referenced 1 time by &b647
.cb64c
    jsr sub_cb1e3                                                     ; b64c: 20 e3 b1     ..
    ply                                                               ; b64f: 7a          z
    plx                                                               ; b650: fa          .
; &b651 referenced 1 time by &b63a
.cb651
    pla                                                               ; b651: 68          h
; &b652 referenced 1 time by &b61f
.cb652
    dey                                                               ; b652: 88          .
    cpy #0                                                            ; b653: c0 00       ..
    bne cb659                                                         ; b655: d0 02       ..
    lda #0                                                            ; b657: a9 00       ..
; &b659 referenced 1 time by &b655
.cb659
    plp                                                               ; b659: 28          (
    rts                                                               ; b65a: 60          `

; Check pointing device type
; &b65b referenced 3 times by &b534, &b587, &b67e
.sub_cb65b
    ldx l090a                                                         ; b65b: ae 0a 09    ...
    bpl cb67d                                                         ; b65e: 10 1d       ..
    ldx #0                                                            ; b660: a2 00       ..
    lda user_via_orb_irb                                              ; b662: ad 60 fe    .`.
    and #&e0                                                          ; b665: 29 e0       ).
    cmp #&e0                                                          ; b667: c9 e0       ..
    bne cb678                                                         ; b669: d0 0d       ..
    lda user_via_orb_irb                                              ; b66b: ad 60 fe    .`.
    and #&18                                                          ; b66e: 29 18       ).
    cmp #&18                                                          ; b670: c9 18       ..
    bne cb67a                                                         ; b672: d0 06       ..
    ldx #7                                                            ; b674: a2 07       ..
    bne cb67d                                                         ; b676: d0 05       ..
; &b678 referenced 1 time by &b669
.cb678
    ldx #7                                                            ; b678: a2 07       ..
; &b67a referenced 1 time by &b672
.cb67a
    stx l090a                                                         ; b67a: 8e 0a 09    ...
; &b67d referenced 2 times by &b65e, &b676
.cb67d
    rts                                                               ; b67d: 60          `

; Check if button state has changed
; &b67e referenced 1 time by &b641
.sub_cb67e
    jsr sub_cb65b                                                     ; b67e: 20 5b b6     [.
    lda user_via_orb_irb                                              ; b681: ad 60 fe    .`.
    and lb6c7,x                                                       ; b684: 3d c7 b6    =..
    cmp l090d                                                         ; b687: cd 0d 09    ...
    beq cb698                                                         ; b68a: f0 0c       ..
    cmp l090c                                                         ; b68c: cd 0c 09    ...
    sta l090c                                                         ; b68f: 8d 0c 09    ...
    beq cb697                                                         ; b692: f0 03       ..
    sta l090d                                                         ; b694: 8d 0d 09    ...
; &b697 referenced 2 times by &b692, &b6a1
.cb697
    rts                                                               ; b697: 60          `

; Button state has changed - generate keypress
; &b698 referenced 1 time by &b68a
.cb698
    stz l090d                                                         ; b698: 9c 0d 09    ...
    lda l090c                                                         ; b69b: ad 0c 09    ...
    cmp lb6c7,x                                                       ; b69e: dd c7 b6    ...
    beq cb697                                                         ; b6a1: f0 f4       ..
    ldy #&0d                                                          ; b6a3: a0 0d       ..
    and lb6c8,x                                                       ; b6a5: 3d c8 b6    =..
    beq cb6bf                                                         ; b6a8: f0 15       ..
    lda l090c                                                         ; b6aa: ad 0c 09    ...
    ldy #&c0                                                          ; b6ad: a0 c0       ..
    and lb6ca,x                                                       ; b6af: 3d ca b6    =..
    beq cb6bf                                                         ; b6b2: f0 0b       ..
    lda #osbyte_read_write_tab_char                                   ; b6b4: a9 db       ..
    ldx #0                                                            ; b6b6: a2 00       ..
    ldy #&ff                                                          ; b6b8: a0 ff       ..
    jsr osbyte                                                        ; b6ba: 20 f4 ff     ..            ; Read TAB key character
    txa                                                               ; b6bd: 8a          .              ; X=value of TAB key character
    tay                                                               ; b6be: a8          .
; &b6bf referenced 2 times by &b6a8, &b6b2
.cb6bf
    lda #osbyte_insert_input_buffer                                   ; b6bf: a9 99       ..
    ldx #0                                                            ; b6c1: a2 00       ..
    jmp osbyte                                                        ; b6c3: 4c f4 ff    L..            ; Insert character Y into keyboard buffer

    equb &18                                                          ; b6c6: 18          .
; &b6c7 referenced 2 times by &b684, &b69e
.lb6c7
    equb 7                                                            ; b6c7: 07          .
; &b6c8 referenced 1 time by &b6a5
.lb6c8
    equb 1, 2                                                         ; b6c8: 01 02       ..
; &b6ca referenced 1 time by &b6af
.lb6ca
    equb 4                                                            ; b6ca: 04          .
; &b6cb referenced 1 time by &b5d2
.lb6cb
    equb &10                                                          ; b6cb: 10          .
; &b6cc referenced 1 time by &b591
.lb6cc
    equb   8,   5, &e0, &20, &40, &80,   4,   1                       ; b6cc: 08 05 e0... ...

; &b6d4 referenced 2 times by &b583, &b60d
.sub_cb6d4
    ldy #6                                                            ; b6d4: a0 06       ..
; &b6d6 referenced 1 time by &b6e2
.loop_cb6d6
    ldx l0904,y                                                       ; b6d6: be 04 09    ...
    lda (l0084),y                                                     ; b6d9: b1 84       ..
    sta l0904,y                                                       ; b6db: 99 04 09    ...
    txa                                                               ; b6de: 8a          .
    sta (l0084),y                                                     ; b6df: 91 84       ..
    dey                                                               ; b6e1: 88          .
    bpl loop_cb6d6                                                    ; b6e2: 10 f2       ..
    rts                                                               ; b6e4: 60          `

; &b6e5 referenced 9 times by &91a7, &91b5, &ab8b, &abf7, &ac98, &ad56, &addd, &b882, &b8a3
.sub_cb6e5
    ldx romsel_copy                                                   ; b6e5: a6 f4       ..
    lda rom_private_byte,x                                            ; b6e7: bd f0 0d    ...
    clc                                                               ; b6ea: 18          .
    adc #3                                                            ; b6eb: 69 03       i.
    sta l00ad                                                         ; b6ed: 85 ad       ..
    lda #&73 ; 's'                                                    ; b6ef: a9 73       .s
    sta l00ac                                                         ; b6f1: 85 ac       ..
    ldy #7                                                            ; b6f3: a0 07       ..
; &b6f5 referenced 1 time by &b701
.loop_cb6f5
    ldx l0933,y                                                       ; b6f5: be 33 09    .3.
    lda (l00ac),y                                                     ; b6f8: b1 ac       ..
    sta l0933,y                                                       ; b6fa: 99 33 09    .3.
    txa                                                               ; b6fd: 8a          .
    sta (l00ac),y                                                     ; b6fe: 91 ac       ..
    dey                                                               ; b700: 88          .
    bpl loop_cb6f5                                                    ; b701: 10 f2       ..
    rts                                                               ; b703: 60          `

; &b704 referenced 7 times by &af33, &af78, &afea, &b79e, &b7a8, &b7cf, &b7d9
.sub_cb704
    ldx #3                                                            ; b704: a2 03       ..
; &b706 referenced 1 time by &b70b
.loop_cb706
    lda l093b,x                                                       ; b706: bd 3b 09    .;.
    pha                                                               ; b709: 48          H
    dex                                                               ; b70a: ca          .
    bpl loop_cb706                                                    ; b70b: 10 f9       ..
    lda #0                                                            ; b70d: a9 00       ..
    sta l093b                                                         ; b70f: 8d 3b 09    .;.
    sta l093c                                                         ; b712: 8d 3c 09    .<.
    sec                                                               ; b715: 38          8
    php                                                               ; b716: 08          .
    jsr cae59                                                         ; b717: 20 59 ae     Y.
; &b71a referenced 1 time by &b77a
.cb71a
    lda (l00a8),y                                                     ; b71a: b1 a8       ..
    cmp #&20 ; ' '                                                    ; b71c: c9 20       .
    beq cb77f                                                         ; b71e: f0 5f       ._
    cmp #&2c ; ','                                                    ; b720: c9 2c       .,
    beq cb77f                                                         ; b722: f0 5b       .[
    cmp #&0d                                                          ; b724: c9 0d       ..
    beq cb77f                                                         ; b726: f0 57       .W
    cmp #&30 ; '0'                                                    ; b728: c9 30       .0
    bcc cb77c                                                         ; b72a: 90 50       .P
    cmp #&3a ; ':'                                                    ; b72c: c9 3a       .:
    bcs cb77c                                                         ; b72e: b0 4c       .L
    lda l093b                                                         ; b730: ad 3b 09    .;.
    sta l093d                                                         ; b733: 8d 3d 09    .=.
    lda l093c                                                         ; b736: ad 3c 09    .<.
    sta l093e                                                         ; b739: 8d 3e 09    .>.
    lda l093b                                                         ; b73c: ad 3b 09    .;.
    asl a                                                             ; b73f: 0a          .
    rol l093c                                                         ; b740: 2e 3c 09    .<.
    bcs cb77c                                                         ; b743: b0 37       .7
    asl a                                                             ; b745: 0a          .
    rol l093c                                                         ; b746: 2e 3c 09    .<.
    bcs cb77c                                                         ; b749: b0 31       .1
    adc l093d                                                         ; b74b: 6d 3d 09    m=.
    sta l093b                                                         ; b74e: 8d 3b 09    .;.
    lda l093c                                                         ; b751: ad 3c 09    .<.
    adc l093e                                                         ; b754: 6d 3e 09    m>.
    bcs cb77c                                                         ; b757: b0 23       .#
    sta l093c                                                         ; b759: 8d 3c 09    .<.
    asl l093b                                                         ; b75c: 0e 3b 09    .;.
    rol l093c                                                         ; b75f: 2e 3c 09    .<.
    bcs cb77c                                                         ; b762: b0 18       ..
    lda (l00a8),y                                                     ; b764: b1 a8       ..
    and #&0f                                                          ; b766: 29 0f       ).
    clc                                                               ; b768: 18          .
    adc l093b                                                         ; b769: 6d 3b 09    m;.
    sta l093b                                                         ; b76c: 8d 3b 09    .;.
    bcc cb776                                                         ; b76f: 90 05       ..
    inc l093c                                                         ; b771: ee 3c 09    .<.
    beq cb77c                                                         ; b774: f0 06       ..
; &b776 referenced 1 time by &b76f
.cb776
    plp                                                               ; b776: 28          (
    clc                                                               ; b777: 18          .
    php                                                               ; b778: 08          .
    iny                                                               ; b779: c8          .
    bne cb71a                                                         ; b77a: d0 9e       ..
; &b77c referenced 7 times by &b72a, &b72e, &b743, &b749, &b757, &b762, &b774
.cb77c
    plp                                                               ; b77c: 28          (
    sec                                                               ; b77d: 38          8
    php                                                               ; b77e: 08          .
; &b77f referenced 3 times by &b71e, &b722, &b726
.cb77f
    plp                                                               ; b77f: 28          (
    lda l093b                                                         ; b780: ad 3b 09    .;.
    sta l00af                                                         ; b783: 85 af       ..
    ldx l093c                                                         ; b785: ae 3c 09    .<.
    pla                                                               ; b788: 68          h
    sta l093b                                                         ; b789: 8d 3b 09    .;.
    pla                                                               ; b78c: 68          h
    sta l093c                                                         ; b78d: 8d 3c 09    .<.
    pla                                                               ; b790: 68          h
    sta l093d                                                         ; b791: 8d 3d 09    .=.
    pla                                                               ; b794: 68          h
    sta l093e                                                         ; b795: 8d 3e 09    .>.
    lda l00af                                                         ; b798: a5 af       ..
    rts                                                               ; b79a: 60          `

.TMAX_command
    jsr sub_cacba                                                     ; b79b: 20 ba ac     ..
    jsr sub_cb704                                                     ; b79e: 20 04 b7     ..
    bcs cb7c6                                                         ; b7a1: b0 23       .#
    phx                                                               ; b7a3: da          .
    pha                                                               ; b7a4: 48          H
    jsr cae59                                                         ; b7a5: 20 59 ae     Y.
    jsr sub_cb704                                                     ; b7a8: 20 04 b7     ..
    bcs cb7c4                                                         ; b7ab: b0 17       ..
    ldy #2                                                            ; b7ad: a0 02       ..
    jsr cb7b9                                                         ; b7af: 20 b9 b7     ..
    pla                                                               ; b7b2: 68          h
    plx                                                               ; b7b3: fa          .
    dec l090e                                                         ; b7b4: ce 0e 09    ...
    ldy #0                                                            ; b7b7: a0 00       ..
; &b7b9 referenced 3 times by &b7af, &b7f0, &b807
.cb7b9
    and #&fc                                                          ; b7b9: 29 fc       ).
    sta l0900,y                                                       ; b7bb: 99 00 09    ...
    txa                                                               ; b7be: 8a          .
    iny                                                               ; b7bf: c8          .
    sta l0900,y                                                       ; b7c0: 99 00 09    ...
    rts                                                               ; b7c3: 60          `

; &b7c4 referenced 2 times by &b7ab, &b7dc
.cb7c4
    pla                                                               ; b7c4: 68          h
    pla                                                               ; b7c5: 68          h
; &b7c6 referenced 4 times by &af7d, &afef, &b7a1, &b7d2
.cb7c6
    jsr sub_cb1e3                                                     ; b7c6: 20 e3 b1     ..
    jmp cade0                                                         ; b7c9: 4c e0 ad    L..

.TSET_command
    jsr sub_cacba                                                     ; b7cc: 20 ba ac     ..
    jsr sub_cb704                                                     ; b7cf: 20 04 b7     ..
    bcs cb7c6                                                         ; b7d2: b0 f2       ..
    phx                                                               ; b7d4: da          .
    pha                                                               ; b7d5: 48          H
    jsr cae59                                                         ; b7d6: 20 59 ae     Y.
    jsr sub_cb704                                                     ; b7d9: 20 04 b7     ..
    bcs cb7c4                                                         ; b7dc: b0 e6       ..
    cpx #4                                                            ; b7de: e0 04       ..
    bcc cb7ee                                                         ; b7e0: 90 0c       ..
    txa                                                               ; b7e2: 8a          .
    bpl cb7ea                                                         ; b7e3: 10 05       ..
    lda #0                                                            ; b7e5: a9 00       ..
    tax                                                               ; b7e7: aa          .
    beq cb7ee                                                         ; b7e8: f0 04       ..
; &b7ea referenced 1 time by &b7e3
.cb7ea
    lda #&fc                                                          ; b7ea: a9 fc       ..
    ldx #3                                                            ; b7ec: a2 03       ..
; &b7ee referenced 2 times by &b7e0, &b7e8
.cb7ee
    ldy #6                                                            ; b7ee: a0 06       ..
    jsr cb7b9                                                         ; b7f0: 20 b9 b7     ..
    pla                                                               ; b7f3: 68          h
    plx                                                               ; b7f4: fa          .
    cpx #5                                                            ; b7f5: e0 05       ..
    bcc cb805                                                         ; b7f7: 90 0c       ..
    txa                                                               ; b7f9: 8a          .
    bpl cb801                                                         ; b7fa: 10 05       ..
    lda #0                                                            ; b7fc: a9 00       ..
    tax                                                               ; b7fe: aa          .
    beq cb805                                                         ; b7ff: f0 04       ..
; &b801 referenced 1 time by &b7fa
.cb801
    lda #&fc                                                          ; b801: a9 fc       ..
    ldx #4                                                            ; b803: a2 04       ..
; &b805 referenced 2 times by &b7f7, &b7ff
.cb805
    ldy #4                                                            ; b805: a0 04       ..
    jmp cb7b9                                                         ; b807: 4c b9 b7    L..

; &b80a referenced 1 time by &960c
.sub_cb80a
    stx l00a8                                                         ; b80a: 86 a8       ..
    sty l00a9                                                         ; b80c: 84 a9       ..
    ldy #0                                                            ; b80e: a0 00       ..
    lda (l00a8),y                                                     ; b810: b1 a8       ..
    and #&df                                                          ; b812: 29 df       ).
    cmp #&4c ; 'L'                                                    ; b814: c9 4c       .L
    bne cb822                                                         ; b816: d0 0a       ..
    iny                                                               ; b818: c8          .
    lda (l00a8),y                                                     ; b819: b1 a8       ..
    and #&df                                                          ; b81b: 29 df       ).
    cmp #&56 ; 'V'                                                    ; b81d: c9 56       .V
    bne cb849                                                         ; b81f: d0 28       .(
    iny                                                               ; b821: c8          .
; &b822 referenced 1 time by &b816
.cb822
    ldx #0                                                            ; b822: a2 00       ..
    sty l00aa                                                         ; b824: 84 aa       ..
; &b826 referenced 2 times by &b847, &b84c
.cb826
    lda (l00a8),y                                                     ; b826: b1 a8       ..
    and #&df                                                          ; b828: 29 df       ).
    cmp star_command_table,x                                          ; b82a: dd a9 b8    ...
    beq cb84a                                                         ; b82d: f0 1b       ..
    lda (l00a8),y                                                     ; b82f: b1 a8       ..
    cmp #&2e ; '.'                                                    ; b831: c9 2e       ..
    beq cb84e                                                         ; b833: f0 19       ..
    lda star_command_table,x                                          ; b835: bd a9 b8    ...
    bmi cb851                                                         ; b838: 30 17       0.
    ldy l00aa                                                         ; b83a: a4 aa       ..
; &b83c referenced 1 time by &b840
.loop_cb83c
    inx                                                               ; b83c: e8          .
    lda star_command_table,x                                          ; b83d: bd a9 b8    ...
    bpl loop_cb83c                                                    ; b840: 10 fa       ..
    inx                                                               ; b842: e8          .
    inx                                                               ; b843: e8          .
    lda star_command_table,x                                          ; b844: bd a9 b8    ...
    bpl cb826                                                         ; b847: 10 dd       ..
; &b849 referenced 2 times by &b81f, &b85e
.cb849
    rts                                                               ; b849: 60          `

; &b84a referenced 1 time by &b82d
.cb84a
    inx                                                               ; b84a: e8          .
    iny                                                               ; b84b: c8          .
    bne cb826                                                         ; b84c: d0 d8       ..
; &b84e referenced 1 time by &b833
.cb84e
    iny                                                               ; b84e: c8          .
    bne cb860                                                         ; b84f: d0 0f       ..
; &b851 referenced 1 time by &b838
.cb851
    dex                                                               ; b851: ca          .
    lda (l00a8),y                                                     ; b852: b1 a8       ..
    cmp #&20 ; ' '                                                    ; b854: c9 20       .
    beq cb860                                                         ; b856: f0 08       ..
    cmp #&22 ; '"'                                                    ; b858: c9 22       ."
    beq cb860                                                         ; b85a: f0 04       ..
    cmp #&0d                                                          ; b85c: c9 0d       ..
    bne cb849                                                         ; b85e: d0 e9       ..
; &b860 referenced 4 times by &b84f, &b856, &b85a, &b864
.cb860
    inx                                                               ; b860: e8          .
    lda star_command_table,x                                          ; b861: bd a9 b8    ...
    bpl cb860                                                         ; b864: 10 fa       ..
    cpx #&22 ; '"'                                                    ; b866: e0 22       ."
    beq cb86d                                                         ; b868: f0 03       ..
    jsr cae59                                                         ; b86a: 20 59 ae     Y.
; &b86d referenced 1 time by &b868
.cb86d
    tya                                                               ; b86d: 98          .
    clc                                                               ; b86e: 18          .
    adc l00a8                                                         ; b86f: 65 a8       e.
    sta l00a8                                                         ; b871: 85 a8       ..
    bcc cb877                                                         ; b873: 90 02       ..
    inc l00a8                                                         ; b875: e6 a8       ..
; &b877 referenced 1 time by &b873
.cb877
    lda star_command_table,x                                          ; b877: bd a9 b8    ...
    sta l00ab                                                         ; b87a: 85 ab       ..
    lda star_command_table+1,x                                        ; b87c: bd aa b8    ...
    sta l00aa                                                         ; b87f: 85 aa       ..
    phx                                                               ; b881: da          .
    jsr sub_cb6e5                                                     ; b882: 20 e5 b6     ..
    plx                                                               ; b885: fa          .
    cpx #&94                                                          ; b886: e0 94       ..
    beq cb89d                                                         ; b888: f0 13       ..
    lda l093a                                                         ; b88a: ad 3a 09    .:.
    beq cb892                                                         ; b88d: f0 03       ..
    jsr cad09                                                         ; b88f: 20 09 ad     ..
; &b892 referenced 1 time by &b88d
.cb892
    jsr sub_cad43                                                     ; b892: 20 43 ad     C.
    ldx #0                                                            ; b895: a2 00       ..
; &b897 referenced 1 time by &b89b
.loop_cb897
    stz lce00,x                                                       ; b897: 9e 00 ce    ...
    dex                                                               ; b89a: ca          .
    bne loop_cb897                                                    ; b89b: d0 fa       ..
; &b89d referenced 1 time by &b888
.cb89d
    stz l0939                                                         ; b89d: 9c 39 09    .9.
    jsr sub_ca799                                                     ; b8a0: 20 99 a7     ..
    jsr sub_cb6e5                                                     ; b8a3: 20 e5 b6     ..
    pla                                                               ; b8a6: 68          h
    pla                                                               ; b8a7: 68          h
    rts                                                               ; b8a8: 60          `

; &b8a9 referenced 6 times by &b82a, &b835, &b83d, &b844, &b861, &b877
.star_command_table
    equb &41                                                          ; b8a9: 41          A
; &b8aa referenced 1 time by &b87c
    equs "UDIO"                                                       ; b8aa: 55 44 49... UDI
    equb >(star_AUDIO)                                                ; b8ae: ad          .
    equb <(star_AUDIO)                                                ; b8af: ef          .
    equs "CHAPTER"                                                    ; b8b0: 43 48 41... CHA
    equb >(star_CHAPTER)                                              ; b8b7: ac          .
    equb <(star_CHAPTER)                                              ; b8b8: 51          Q
    equs "EJECT"                                                      ; b8b9: 45 4a 45... EJE
    equb >(star_EJECT)                                                ; b8be: ab          .
    equb <(star_EJECT)                                                ; b8bf: 61          a
    equs "FAST"                                                       ; b8c0: 46 41 53... FAS
    equb >(star_FAST)                                                 ; b8c4: ae          .
    equb <(star_FAST)                                                 ; b8c5: 16          .
    equs "FCODE"                                                      ; b8c6: 46 43 4f... FCO
    equb >(star_FCODE)                                                ; b8cb: ac          .
    equb <(star_FCODE)                                                ; b8cc: 24          $
    equs "FRAME"                                                      ; b8cd: 46 52 41... FRA
    equb >(star_FRAME)                                                ; b8d2: ac          .
    equb <(star_FRAME)                                                ; b8d3: ea          .
    equs "PLAY"                                                       ; b8d4: 50 4c 41... PLA
    equb >(star_PLAY)                                                 ; b8d8: ae          .
    equb <(star_PLAY)                                                 ; b8d9: a2          .
    equs "SEARCH"                                                     ; b8da: 53 45 41... SEA
    equb >(star_SEARCH)                                               ; b8e0: ac          .
    equb <(star_SEARCH)                                               ; b8e1: c8          .
    equs "SLOW"                                                       ; b8e2: 53 4c 4f... SLO
    equb >(star_SLOW)                                                 ; b8e6: ae          .
    equb <(star_SLOW)                                                 ; b8e7: 27          '
    equs "STEP"                                                       ; b8e8: 53 54 45... STE
    equb >(star_STEP)                                                 ; b8ec: ad          .
    equb <(star_STEP)                                                 ; b8ed: 67          g
    equs "STILL"                                                      ; b8ee: 53 54 49... STI
    equb >(star_STILL)                                                ; b8f3: ac          .
    equb <(star_STILL)                                                ; b8f4: de          .
    equs "VOCOMPUTER"                                                 ; b8f5: 56 4f 43... VOC
    equb >(star_VOCOMPUTER)                                           ; b8ff: ac          .
    equb <(star_VOCOMPUTER)                                           ; b900: 14          .
    equs "VODISC"                                                     ; b901: 56 4f 44... VOD
    equb >(star_VODISC)                                               ; b907: ac          .
    equb <(star_VODISC)                                               ; b908: 10          .
    equs "VOHIGHLIGHT"                                                ; b909: 56 4f 48... VOH
    equb >(star_VOHIGHLIGHT)                                          ; b914: ac          .
    equb <(star_VOHIGHLIGHT)                                          ; b915: 20
    equs "VOSUPERIMPOSE"                                              ; b916: 56 4f 53... VOS
    equb >(star_VOSUPERIMPOSE)                                        ; b923: ac          .
    equb <(star_VOSUPERIMPOSE)                                        ; b924: 18          .
    equs "VOTRANSPARENT"                                              ; b925: 56 4f 54... VOT
    equb >(star_VOTRANSPARENT)                                        ; b932: ac          .
    equb <(star_VOTRANSPARENT)                                        ; b933: 1c          .
    equb &56, &50                                                     ; b934: 56 50       VP
    equb >(star_VP)                                                   ; b936: ab          .
    equb <(star_VP)                                                   ; b937: c7          .
    equs "RESET"                                                      ; b938: 52 45 53... RES
    equb >(star_RESET)                                                ; b93d: ac          .
    equb <(star_RESET)                                                ; b93e: 49          I
    equb &ff, &10, &10, &10                                           ; b93f: ff 10 10... ...
; &b943 referenced 1 time by &b480
.lb943
    equb &80,   0, &80,   0, &80,   0, &80,   0, &80,   0, &80,   0   ; b943: 80 00 80... ...
    equb &80,   0, &80,   0, &80,   0, &80,   0, &80,   0, &80,   0   ; b94f: 80 00 80... ...
    equb &80,   0, &80,   0, &80,   0, &80,   0, &80,   0             ; b95b: 80 00 80... ...
; &b965 referenced 1 time by &b47b
.lb965
    equs "}{xvsqnligdb_]ZXUSPNKIFDA?<:7520-+"                         ; b965: 7d 7b 78... }{x
    equb 1, 2, 4                                                      ; b987: 01 02 04    ...
; &b98a referenced 2 times by &b18a, &b290
.lb98a
    equb &80, &80, &80                                                ; b98a: 80 80 80    ...
; &b98d referenced 2 times by &b191, &b297
.lb98d
    equb 2, 2, 2                                                      ; b98d: 02 02 02    ...
; &b990 referenced 1 time by &b119
.lb990
    equb   0, &40, &80, &c0,   0, &40, &80, &c0,   0,   0,   0,   0   ; b990: 00 40 80... .@.
    equb   1,   1,   1,   1                                           ; b99c: 01 01 01... ...
; &b9a0 referenced 1 time by &b0ee
.lb9a0
    equb &14, &18,   4, &28                                           ; b9a0: 14 18 04... ...
; &b9a4 referenced 1 time by &b0fc
.lb9a4
    equb &1c, &14,   4,   4,   0,   0,   0,   0,   0,   0             ; b9a4: 1c 14 04... ...
    equs "???"                                                        ; b9ae: 3f 3f 3f    ???
    equb   0,   0,   0,   0,   0,   0,   0,   0, &fc, &fc, &fc, &fc   ; b9b1: 00 00 00... ...
    equb &fc, &ff, &ff, &ff, &fc, &fc, &fc, &fc, &fc,   0,   0,   0   ; b9bd: fc ff ff... ...
    equb   0,   0,   0,   0,   0, &f0, &f0, &f0,   0,   0,   0,   0   ; b9c9: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; b9d5: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   3,   3, &0f   ; b9e1: 00 00 00... ...
    equb &0f, &0f,   3,   3,   0,   0,   0,   0,   0,   0,   0,   0   ; b9ed: 0f 0f 03... ...
    equb &3f, &ff, &c0,   0,   0,   0, &c0, &ff, &3f,   3,   0,   0   ; b9f9: 3f ff c0... ?..
    equb   0,   0,   0,   0,   0, &f0, &f0                            ; ba05: 00 00 00... ...
    equs "<<<"                                                        ; ba0c: 3c 3c 3c    <<<
    equb &f0, &f0, &c0, &c0, &f0, &f0, &3c, &3c,   0,   0,   0,   0   ; ba0f: f0 f0 c0... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; ba1b: 00 00 00... ...
    equb   0,   0                                                     ; ba27: 00 00       ..
    equs "0<?????3"                                                   ; ba29: 30 3c 3f... 0<?
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, &c0   ; ba31: 00 00 00... ...
    equb &f0, &fc, &c0, &c0, &f0, &f0, &3c, &3c, &0f, &0f,   0,   0   ; ba3d: f0 fc c0... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; ba49: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; ba55: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; ba61: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; ba6d: 00 00 00... ...
    equb   0,   0,   0,   3, &0f, &3f,   3,   3, &0f, &0f, &3c, &3c   ; ba79: 00 00 00... ...
    equb &f0, &f0,   0,   0, &0c, &3c, &fc, &fc, &fc, &fc, &fc, &cc   ; ba85: f0 f0 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; ba91: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; ba9d: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   7,   7,   7,   0,   0,   0,   0   ; baa9: 00 00 00... ...
    equb   0,   0,   0,   0, &0e, &0e, &0e, &0e, &0e, &0f, &0f, &0f   ; bab5: 00 00 00... ...
    equb &0e, &0e, &0e, &0e, &0e,   0,   0,   0,   0,   0,   0,   0   ; bac1: 0e 0e 0e... ...
    equb   0, &0c, &0c, &0c,   0,   0,   0,   0,   0,   0,   0,   0   ; bacd: 00 0c 0c... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bad9: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   1,   1,   3,   3,   3,   1,   1   ; bae5: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   7, &0f,   8,   0   ; baf1: 00 00 00... ...
    equb   0,   0,   8, &0f,   7,   1,   0,   0,   0,   0,   0,   0   ; bafd: 00 00 08... ...
    equb   0, &0c, &0c,   6,   6,   6, &0c, &0c,   8,   8, &0c, &0c   ; bb09: 00 0c 0c... ...
    equb   6,   6,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bb15: 06 06 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   4,   6,   7,   7   ; bb21: 00 00 00... ...
    equb   7,   7,   7,   5,   0,   0,   0,   0,   0,   0,   0,   0   ; bb2d: 07 07 07... ...
    equb   0,   0,   0,   8, &0c, &0e,   8,   8, &0c, &0c,   6,   6   ; bb39: 00 00 00... ...
    equb   3,   3,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bb45: 03 03 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bb51: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bb5d: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bb69: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   1,   3,   7,   1,   1   ; bb75: 00 00 00... ...
    equb   3,   3,   6,   6, &0c, &0c,   0,   0,   2,   6, &0e, &0e   ; bb81: 03 03 06... ...
    equb &0e, &0e, &0e, &0a,   0,   0,   0,   0,   0,   0,   0,   0   ; bb8d: 0e 0e 0e... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bb99: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bba5: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   1,   1,   1,   1   ; bbb1: 00 00 00... ...
    equb   1,   3,   3,   3,   1,   1,   1,   1,   1,   0,   0,   0   ; bbbd: 01 03 03... ...
    equb   0,   0,   0,   0,   0,   2,   2,   2,   0,   0,   0,   0   ; bbc9: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bbd5: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1,   1   ; bbe1: 00 00 00... ...
    equb   1,   1,   1,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bbed: 01 01 01... ...
    equb   3,   3,   0,   0,   0,   0,   0,   3,   3,   1,   0,   0   ; bbf9: 03 03 00... ...
    equb   0,   0,   0,   0,   0,   0,   2,   2,   2,   2,   2,   0   ; bc05: 00 00 00... ...
    equb   0,   0,   2,   2,   2,   2,   0,   0,   0,   0,   0,   0   ; bc11: 00 00 02... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bc1d: 00 00 00... ...
    equb   1,   1,   1,   1,   1,   1,   1,   1,   0,   0,   0,   0   ; bc29: 01 01 01... ...
    equb   0,   0,   0,   0,   0,   0,   2,   2,   3,   3,   2,   2   ; bc35: 00 00 00... ...
    equb   1,   1,   1,   1,   0,   0,   0,   0,   0,   0,   0,   0   ; bc41: 01 01 01... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   2,   2,   0,   0   ; bc4d: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bc59: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bc65: 00 00 00... ...
    equb   0,   0,   0,   0,   1,   1,   0,   0,   0,   0,   1,   1   ; bc71: 00 00 00... ...
    equb   3,   3,   1,   1,   2,   2,   2,   2,   0,   0,   0,   0   ; bc7d: 03 03 01... ...
    equb   2,   2,   2,   2,   2,   2,   2,   2,   0,   0,   0,   0   ; bc89: 02 02 02... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bc95: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0, &fc, &fc, &fc, &fc, &fc   ; bca1: 00 00 00... ...
    equb   0,   0,   0,   0,   0, &fc, &fc, &fc, &fc, &fc, &ff,   0   ; bcad: 00 00 00... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bcb9: 00 00 00... ...
    equb   0,   0, &ff, &ff, &ff, &ff, &ff, &ff,   3,   3,   3,   3   ; bcc5: 00 00 ff... ...
    equb   3, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bcd1: 03 ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bcdd: ff ff ff... ...
    equb &fc, &f0, &f0, &c0, &c0, &c0, &f0, &f0, &fc, &ff, &ff, &ff   ; bce9: fc f0 f0... ...
    equb &ff, &ff, &ff, &c0,   0,   0,   0                            ; bcf5: ff ff ff... ...
    equs "???"                                                        ; bcfc: 3f 3f 3f    ???
    equb   0,   0,   0, &c0, &fc, &fc, &ff, &ff, &ff, &ff, &0f,   3   ; bcff: 00 00 00... ...
    equb   3,   0,   0,   0,   3,   3, &0f, &0f,   3,   3,   0,   0   ; bd0b: 03 00 00... ...
    equb &c3, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bd17: c3 ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff, &0f,   3,   0,   0,   0,   0,   0   ; bd23: ff ff ff... ...
    equb   0,   0,   0, &fc, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bd2f: 00 00 00... ...
    equb &3f, &0f,   3,   0,   3, &0f,   3,   3,   0,   0, &c0, &c0   ; bd3b: 3f 0f 03... ?..
    equb &f0, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bd47: f0 ff ff... ...
    equb &ff, &ff, &3f, &3f, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bd53: ff ff 3f... ..?
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bd5f: ff ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &fc, &fc   ; bd6b: ff ff ff... ...
    equb &ff, &ff, &ff, &ff, &fc, &f0, &c0,   0, &c0, &f0, &c0, &c0   ; bd77: ff ff ff... ...
    equb   0,   0,   3,   3, &0f, &f0, &c0,   0,   0,   0,   0,   0   ; bd83: 00 00 03... ...
    equb   0,   0,   0, &3f, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bd8f: 00 00 00... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bd9b: ff ff ff... ...
    equb &ff, &ee, &ee, &ee, &ee, &ee,   0,   0,   0,   0,   0, &ee   ; bda7: ff ee ee... ...
    equb &ee, &ee, &ee, &ee, &ff,   0,   0,   0,   0,   0,   0,   0   ; bdb3: ee ee ee... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0, &ff, &ff, &ff, &ff   ; bdbf: 00 00 00... ...
    equb &ff, &ff, &11, &11, &11, &11, &11, &ff, &ff, &ff, &ff, &ff   ; bdcb: ff ff 11... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bdd7: ff ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ee, &cc, &cc, &88, &88, &88   ; bde3: ff ff ff... ...
    equb &cc, &cc, &ee, &ff, &ff, &ff, &ff, &ff, &ff, &88,   0,   0   ; bdef: cc cc ee... ...
    equb   0                                                          ; bdfb: 00          .
    equs "www"                                                        ; bdfc: 77 77 77    www
    equb   0,   0,   0, &88, &ee, &ee, &ff, &ff, &ff, &ff, &33, &11   ; bdff: 00 00 00... ...
    equb &11,   0,   0,   0, &11, &11, &33, &33, &11, &11,   0,   0   ; be0b: 11 00 00... ...
    equb &99, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; be17: 99 ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff, &33, &11,   0,   0,   0,   0,   0   ; be23: ff ff ff... ...
    equb   0,   0,   0, &ee, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; be2f: 00 00 00... ...
    equb &77, &33, &11,   0, &11, &33, &11, &11,   0,   0, &88, &88   ; be3b: 77 33 11... w3.
    equb &cc, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; be47: cc ff ff... ...
    equb &ff, &ff, &77, &77, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; be53: ff ff 77... ..w
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; be5f: ff ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ee, &ee   ; be6b: ff ff ff... ...
    equb &ff, &ff, &ff, &ff, &ee, &cc, &88,   0, &88, &cc, &88, &88   ; be77: ff ff ff... ...
    equb   0,   0, &11, &11, &33, &cc, &88,   0,   0,   0,   0,   0   ; be83: 00 00 11... ...
    equb   0,   0,   0, &77, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; be8f: 00 00 00... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; be9b: ff ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &aa, &aa, &aa, &ff, &ff   ; bea7: ff ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff,   0,   0,   0,   0,   0,   0,   0   ; beb3: ff ff ff... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0, &ff                  ; bebf: 00 00 00... ...
    equs "UUUUUU"                                                     ; bec8: 55 55 55... UUU
    equb 0, 0, 0                                                      ; bece: 00 00 00    ...
    equs "UUUUUU"                                                     ; bed1: 55 55 55... UUU
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bed7: ff ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &aa, &aa,   0,   0,   0,   0   ; bee3: ff ff ff... ...
    equb   0, &aa, &aa, &ff, &ff, &ff, &ff, &ff, &ff,   0,   0,   0   ; beef: 00 aa aa... ...
    equb   0,   0,   0,   0,   0,   0,   0,   0, &aa, &aa, &aa, &aa   ; befb: 00 00 00... ...
    equb &ff, &ff, &55, &55,   0,   0,   0,   0,   0                  ; bf07: ff ff 55... ..U
    equs "UUU"                                                        ; bf10: 55 55 55    UUU
    equb   0,   0,   0,   0, &55, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bf13: 00 00 00... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff,   0,   0,   0   ; bf1f: ff ff ff... ...
    equb   0,   0,   0,   0,   0,   0,   0, &ff, &ff, &ff, &ff, &ff   ; bf2b: 00 00 00... ...
    equb &ff, &ff, &55, &55,   0,   0,   0,   0,   0,   0,   0,   0   ; bf37: ff ff 55... ..U
    equb   0,   0, &aa, &aa, &ff, &ff, &ff, &ff, &ff, &ff, &55, &55   ; bf43: 00 00 aa... ...
    equb &ff, &ff                                                     ; bf4f: ff ff       ..
    equs "UUUU"                                                       ; bf51: 55 55 55... UUU
    equb   0,   0, &55, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bf55: 00 00 55... ..U
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bf61: ff ff ff... ...
    equb &aa, &aa, &ff, &ff, &aa, &aa, &aa, &aa,   0,   0, &aa, &ff   ; bf6d: aa aa ff... ...
    equb &aa, &aa,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bf79: aa aa 00... ...
    equb &55, &55, &ff,   0,   0,   0,   0,   0,   0,   0,   0,   0   ; bf85: 55 55 ff... UU.
    equb   0, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bf91: 00 ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bf9d: ff ff ff... ...
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff   ; bfa9: ff ff ff... ...
    equb &ff, &ff                                                     ; bfb5: ff ff       ..
    equs "Many thanks to :-  Jonathan Griffiths, Tony Engeham, Chr"   ; bfb7: 4d 61 6e... Man
    equs "is Turner & Hu"                                             ; bfef: 69 73 20... is
; &bffd referenced 1 time by &8baf
.lbffd
    equb &67, &65                                                     ; bffd: 67 65       ge
; &bfff referenced 2 times by &8b90, &8be0
.lbfff
    equb &0d                                                          ; bfff: 0d          .
.pydis_end

; Label references by decreasing frequency:
;     l00b6:                             78
;     l00a8:                             55
;     l00b4:                             42
;     lc317:                             39
;     tube_used_zp:                      34
;     l008a:                             32
;     l00c6:                             28
;     l0084:                             26
;     romsel_copy:                       24
;     l008c:                             23
;     l00b7:                             22
;     l00cf:                             22
;     l00b5:                             21
;     generate_error_inline:             21
;     scsi_data:                         21
;     l00b0:                             20
;     os_text_ptr:                       20
;     lc22f:                             18
;     l00ba:                             17
;     wait_for_scsi_REQ:                 17
;     c880d:                             17
;     print_string:                      17
;     rom_private_byte:                  16
;     lc204:                             16
;     lc3ac:                             16
;     l0089:                             15
;     sub_c858e:                         15
;     sub_cacba:                         15
;     caddd:                             15
;     lc215:                             15
;     lce00:                             15
;     l0085:                             14
;     l0086:                             14
;     l00b2:                             14
;     l0904:                             14
;     print_char:                        14
;     osbyte:                            14
;     lc22b:                             13
;     l008d:                             12
;     l00aa:                             12
;     l00b3:                             12
;     l00b8:                             12
;     cae59:                             12
;     lc314:                             12
;     l008e:                             11
;     l00af:                             11
;     l00c3:                             11
;     l0100:                             11
;     lc22c:                             11
;     l0088:                             10
;     l0905:                             10
;     l0906:                             10
;     l093b:                             10
;     l093c:                             10
;     ca549:                             10
;     lc240:                             10
;     lc35c:                             10
;     lc366:                             10
;     lc370:                             10
;     lc37a:                             10
;     acccon:                            10
;     l008f:                              9
;     l0907:                              9
;     hex_byte_print:                     9
;     sub_cb6e5:                          9
;     lc21b:                              9
;     lc22e:                              9
;     lc2d5:                              9
;     lc334:                              9
;     lc33e:                              9
;     lc348:                              9
;     lc3b6:                              9
;     lce01:                              9
;     l00b1:                              8
;     l0900:                              8
;     Get_CMOS_byte:                      8
;     print_space:                        8
;     cab7f:                              8
;     lc217:                              8
;     lc21e:                              8
;     lc26f:                              8
;     lc2b4:                              8
;     lc2b6:                              8
;     lc352:                              8
;     tube_host_r3_data:                  8
;     l0087:                              7
;     l00be:                              7
;     l0406:                              7
;     l0916:                              7
;     vfs_flags1:                         7
;     access_scsi_drive:                  7
;     c8270:                              7
;     sub_c82f7:                          7
;     c8b7a:                              7
;     sub_c9ba3:                          7
;     cabdd:                              7
;     sub_cb704:                          7
;     cb77c:                              7
;     lc218:                              7
;     lc21a:                              7
;     lc221:                              7
;     lc300:                              7
;     l00a9:                              6
;     l00f0:                              6
;     l0908:                              6
;     l0909:                              6
;     l0912:                              6
;     l0913:                              6
;     vfs_25Hz_timer_hi:                  6
;     c8158:                              6
;     c82d6:                              6
;     ensure_drive:                       6
;     c85ab:                              6
;     c87af:                              6
;     sub_c8c3e:                          6
;     sub_c9aef:                          6
;     ca0d9:                              6
;     command_table:                      6
;     cab77:                              6
;     sub_cb1e3:                          6
;     cb60a:                              6
;     star_command_table:                 6
;     lc216:                              6
;     lc21d:                              6
;     lc298:                              6
;     lc2b5:                              6
;     lc2b7:                              6
;     lc2cd:                              6
;     lc316:                              6
;     lc333:                              6
;     user_via_orb_irb:                   6
;     l00c2:                              5
;     l00c8:                              5
;     l090b:                              5
;     read_drive_status:                  5
;     c8123:                              5
;     sub_c8261:                          5
;     c82c3:                              5
;     sub_c8459:                          5
;     OSBYTE_YFFX0:                       5
;     sub_c8b5f:                          5
;     l908f:                              5
;     c94d0:                              5
;     vfs_command_table:                  5
;     c9726:                              5
;     c9b92:                              5
;     sub_c9e4a:                          5
;     c9fc5:                              5
;     sub_ca012:                          5
;     ca5c9:                              5
;     sub_cad9a:                          5
;     sub_cb1f7:                          5
;     lc1fe:                              5
;     lc219:                              5
;     lc296:                              5
;     lc297:                              5
;     lc29a:                              5
;     lc2b8:                              5
;     lc2b9:                              5
;     lc2ba:                              5
;     lc2bb:                              5
;     lc2d2:                              5
;     lc31b:                              5
;     lc3c0:                              5
;     lc3ca:                              5
;     lc8fa:                              5
;     lce02:                              5
;     user_via_ier:                       5
;     l0000:                              4
;     l0001:                              4
;     l0002:                              4
;     l0003:                              4
;     l00b9:                              4
;     l00c4:                              4
;     l00c5:                              4
;     l00c9:                              4
;     l0101:                              4
;     l090c:                              4
;     l090d:                              4
;     l090e:                              4
;     l0923:                              4
;     l0932:                              4
;     l0939:                              4
;     l093a:                              4
;     vfs_25Hz_timer_lo:                  4
;     c8037:                              4
;     release_tube:                       4
;     shadow_to_main:                     4
;     c863b:                              4
;     c86b8:                              4
;     c889e:                              4
;     sub_c89c4:                          4
;     c8b41:                              4
;     c8b47:                              4
;     sub_c8c7a:                          4
;     c90e8:                              4
;     c92a7:                              4
;     sub_c983c:                          4
;     sub_c9a93:                          4
;     sub_c9b68:                          4
;     c9dbf:                              4
;     c9e85:                              4
;     ca206:                              4
;     sub_ca286:                          4
;     sub_ca50f:                          4
;     cacad:                              4
;     cad09:                              4
;     cad27:                              4
;     cb021:                              4
;     cb5cc:                              4
;     cb7c6:                              4
;     cb860:                              4
;     lc1fd:                              4
;     lc21c:                              4
;     lc220:                              4
;     lc222:                              4
;     lc241:                              4
;     lc25d:                              4
;     lc262:                              4
;     lc295:                              4
;     lc29b:                              4
;     lc2a2:                              4
;     lc2c0:                              4
;     lc2c2:                              4
;     lc2ce:                              4
;     lc2d0:                              4
;     screen_memory_flag:                 4
;     lc315:                              4
;     lc318:                              4
;     l00ab:                              3
;     l00ac:                              3
;     l00bd:                              3
;     l00c0:                              3
;     l00c1:                              3
;     l00ca:                              3
;     l00cb:                              3
;     scsi_status_zp:                     3
;     l090a:                              3
;     l0914:                              3
;     l0915:                              3
;     l093d:                              3
;     l093e:                              3
;     vfs_100Hz_timer:                    3
;     c8072:                              3
;     set_scsi_to_command_mode:           3
;     sub_c81cb:                          3
;     c8258:                              3
;     c825d:                              3
;     generate_error_inline2:             3
;     generate_error_inline3:             3
;     nibble_to_asciihexdigit:            3
;     sub_c857c:                          3
;     c85f5:                              3
;     c85fb:                              3
;     c861c:                              3
;     table3:                             3
;     c8904:                              3
;     c89d8:                              3
;     c8a01:                              3
;     c8b69:                              3
;     c8e35:                              3
;     c8eb7:                              3
;     Get_CMOS_bit6:                      3
;     Service_handler_NOP:                3
;     c9008:                              3
;     c903a:                              3
;     c9069:                              3
;     c94d6:                              3
;     c956a:                              3
;     sub_c98c2:                          3
;     sub_c9a80:                          3
;     sub_c9d37:                          3
;     c9dbe:                              3
;     c9e35:                              3
;     sub_c9e41:                          3
;     sub_c9e62:                          3
;     sub_ca221:                          3
;     ca43e:                              3
;     ca459:                              3
;     sub_ca670:                          3
;     ca6e6:                              3
;     ca75e:                              3
;     cac6d:                              3
;     cacff:                              3
;     sub_cadd4:                          3
;     caee5:                              3
;     caf21:                              3
;     caf30:                              3
;     cb065:                              3
;     cb0e9:                              3
;     sub_cb228:                          3
;     cb3af:                              3
;     sub_cb65b:                          3
;     cb77f:                              3
;     cb7b9:                              3
;     pydis_end:                          3
;     lc0ff:                              3
;     lc100:                              3
;     lc201:                              3
;     lc202:                              3
;     lc203:                              3
;     lc21f:                              3
;     lc223:                              3
;     lc29c:                              3
;     lc29d:                              3
;     lc2a0:                              3
;     CMOS_byte_copy:                     3
;     lc31c:                              3
;     lc31f:                              3
;     lc332:                              3
;     lc8cc:                              3
;     lce11:                              3
;     oscli:                              3
;     l00ae:                              2
;     l00bb:                              2
;     l00bc:                              2
;     l00c7:                              2
;     l00ef:                              2
;     os_text_ptr1:                       2
;     l00fc:                              2
;     irq1v:                              2
;     irq1v+1:                            2
;     bytev:                              2
;     bytev+1:                            2
;     os_interlace_flag:                  2
;     l0901:                              2
;     l0902:                              2
;     l0903:                              2
;     l090f:                              2
;     l0910:                              2
;     l0911:                              2
;     l0917:                              2
;     l0924:                              2
;     l0925:                              2
;     l0926:                              2
;     l0933:                              2
;     l0937:                              2
;     l0938:                              2
;     vfs_old_bytev1:                     2
;     vfs_old_bytev2:                     2
;     vfs_old_irq1v1a:                    2
;     claim_tube:                         2
;     c80fd:                              2
;     c817f:                              2
;     c818c:                              2
;     c81a1:                              2
;     sub_c81b0:                          2
;     c81bd:                              2
;     sub_c81c2:                          2
;     c81d3:                              2
;     c8267:                              2
;     hex_byte_on_stack:                  2
;     sub_c842c:                          2
;     sub_c843c:                          2
;     c8442:                              2
;     c847b:                              2
;     sub_c848a:                          2
;     sub_c8583:                          2
;     c859e:                              2
;     sub_c85a1:                          2
;     c85c7:                              2
;     c860c:                              2
;     c8619:                              2
;     c863f:                              2
;     c8660:                              2
;     c867b:                              2
;     sub_c8692:                          2
;     sub_c86bb:                          2
;     c877b:                              2
;     c87cc:                              2
;     c880a:                              2
;     c8856:                              2
;     sub_c8876:                          2
;     sub_c887e:                          2
;     c88a7:                              2
;     c88c7:                              2
;     c88da:                              2
;     c891c:                              2
;     c8930:                              2
;     c89d9:                              2
;     c89e8:                              2
;     sub_c8ada:                          2
;     c8b17:                              2
;     sub_c8b42:                          2
;     c8b4a:                              2
;     sub_c8b6a:                          2
;     c8bcc:                              2
;     c8c1f:                              2
;     sub_c8c32:                          2
;     print_X_spaces:                     2
;     sub_c8c94:                          2
;     sub_c8ce0:                          2
;     c8d92:                              2
;     c8dd2:                              2
;     c8def:                              2
;     sub_c8e05:                          2
;     c8e26:                              2
;     sub_c8e27:                          2
;     c8ea5:                              2
;     c8ed1:                              2
;     c8f26:                              2
;     sub_c8f46:                          2
;     OSBYTE_last_break_type:             2
;     c900d:                              2
;     sub_c9038:                          2
;     sub_c906a:                          2
;     sub_c906e:                          2
;     sub_c9072:                          2
;     c90d5:                              2
;     sub_c90db:                          2
;     c90f8:                              2
;     sub_c9154:                          2
;     c917c:                              2
;     c9190:                              2
;     c919f:                              2
;     c92ca:                              2
;     update_tube_present_flag:           2
;     c9337:                              2
;     vfs_string:                         2
;     c9449:                              2
;     c945a:                              2
;     sub_c9512:                          2
;     c9558:                              2
;     sub_c955f:                          2
;     c95ad:                              2
;     c95f3:                              2
;     c961f:                              2
;     c9623:                              2
;     c9653:                              2
;     c973f:                              2
;     sub_c97db:                          2
;     c9822:                              2
;     sub_c9851:                          2
;     c9891:                              2
;     sub_c98de:                          2
;     c9948:                              2
;     c9a54:                              2
;     c9b0a:                              2
;     check_directory_for_Hugo:           2
;     c9b53:                              2
;     sub_c9b74:                          2
;     sub_c9b85:                          2
;     sub_c9b8b:                          2
;     sub_c9bed:                          2
;     Function_entered_via_rts_onstack:   2
;     c9c5f:                              2
;     sub_c9d28:                          2
;     c9e9f:                              2
;     c9ed9:                              2
;     ca00a:                              2
;     ca00e:                              2
;     sub_ca03c:                          2
;     ca1f5:                              2
;     sub_ca207:                          2
;     sub_ca22d:                          2
;     ca283:                              2
;     ca2d5:                              2
;     ca336:                              2
;     ca40c:                              2
;     ca53c:                              2
;     sub_ca560:                          2
;     ca577:                              2
;     sub_ca5f0:                          2
;     ca635:                              2
;     ca6a9:                              2
;     ca724:                              2
;     ca747:                              2
;     sub_ca799:                          2
;     caa37:                              2
;     print_indexed_string:               2
;     sub_cab56:                          2
;     cab92:                              2
;     sub_cab93:                          2
;     sub_cab9b:                          2
;     cabf7:                              2
;     star_FRAME:                         2
;     sub_cad43:                          2
;     cadce:                              2
;     cae09:                              2
;     sub_cae67:                          2
;     sub_cae8a:                          2
;     caecf:                              2
;     sub_caef7:                          2
;     sub_caf33:                          2
;     caf4d:                              2
;     caff2:                              2
;     cb022:                              2
;     cb0a6:                              2
;     cb0c5:                              2
;     cb13d:                              2
;     cb155:                              2
;     cb1a5:                              2
;     cb1d4:                              2
;     sub_cb240:                          2
;     cb258:                              2
;     cb29f:                              2
;     cb2c5:                              2
;     sub_cb2ed:                          2
;     sub_cb37d:                          2
;     sub_cb3c7:                          2
;     sub_cb3d8:                          2
;     cb440:                              2
;     cb4ba:                              2
;     cb67d:                              2
;     cb697:                              2
;     cb6bf:                              2
;     lb6c7:                              2
;     sub_cb6d4:                          2
;     cb7c4:                              2
;     cb7ee:                              2
;     cb805:                              2
;     cb826:                              2
;     cb849:                              2
;     lb98a:                              2
;     lb98d:                              2
;     lbfff:                              2
;     lc1fb:                              2
;     lc1fc:                              2
;     lc214:                              2
;     lc22d:                              2
;     lc230:                              2
;     lc233:                              2
;     lc23b:                              2
;     lc242:                              2
;     lc243:                              2
;     lc2a8:                              2
;     lc2c1:                              2
;     lc2cf:                              2
;     lc2d6:                              2
;     lc2d9:                              2
;     lc2fe:                              2
;     lc30a:                              2
;     lc313:                              2
;     lc31a:                              2
;     lc320:                              2
;     lc321:                              2
;     lc322:                              2
;     lc384:                              2
;     lc38e:                              2
;     lc398:                              2
;     lc3d4:                              2
;     lc3de:                              2
;     lc3e8:                              2
;     lc3f2:                              2
;     lc400:                              2
;     lc8d9:                              2
;     lce03:                              2
;     lce10:                              2
;     user_via_acr:                       2
;     user_via_pcr:                       2
;     scsi_status_byte:                   2
;     scsi_enable_disable_IRQ:            2
;     l00ad:                              1
;     l00bf:                              1
;     l00f1:                              1
;     l00ff:                              1
;     l0102:                              1
;     l0103:                              1
;     l0104:                              1
;     userv:                              1
;     filev:                              1
;     fscv:                               1
;     l091b:                              1
;     l091c:                              1
;     l091d:                              1
;     l091e:                              1
;     l091f:                              1
;     vfs_flags2:                         1
;     vfs_irq1:                           1
;     vfs_irq2:                           1
;     vfs_old_irq1v1:                     1
;     vfs_old_irq1v2:                     1
;     vfs_old_irq1v2a:                    1
;     loop_c802b:                         1
;     c803e:                              1
;     c804c:                              1
;     c8054:                              1
;     loop_c8075:                         1
;     sub_c8089:                          1
;     loop_c808c:                         1
;     loop_c809c:                         1
;     c80d3:                              1
;     c80d6:                              1
;     c80e8:                              1
;     loop_c80ee:                         1
;     c80f0:                              1
;     c810a:                              1
;     c8111:                              1
;     c8137:                              1
;     c813c:                              1
;     c8144:                              1
;     c8150:                              1
;     loop_c815b:                         1
;     c8175:                              1
;     c817d:                              1
;     c8186:                              1
;     loop_c8193:                         1
;     sub_c81c3:                          1
;     sub_c81ce:                          1
;     c81cf:                              1
;     c81db:                              1
;     loop_c81e3:                         1
;     c81f4:                              1
;     loop_c81fa:                         1
;     c820c:                              1
;     loop_c821e:                         1
;     loop_c8224:                         1
;     c823f:                              1
;     c827f:                              1
;     c828f:                              1
;     c82aa:                              1
;     sub_c82dc:                          1
;     sub_c82eb:                          1
;     loop_c82ec:                         1
;     c8304:                              1
;     loop_c8317:                         1
;     c8320:                              1
;     sub_c832f:                          1
;     loop_c833b:                         1
;     c8356:                              1
;     c835e:                              1
;     c8361:                              1
;     loop_c8363:                         1
;     loop_c838a:                         1
;     c838d:                              1
;     c8393:                              1
;     c8399:                              1
;     loop_c83a1:                         1
;     c83ca:                              1
;     c83cd:                              1
;     c83ce:                              1
;     c83d6:                              1
;     c83fc:                              1
;     at_string:                          1
;     nochannel_string:                   1
;     sub_c8419:                          1
;     c842b:                              1
;     c8453:                              1
;     c8457:                              1
;     loop_c845d:                         1
;     loop_c846f:                         1
;     OSBYTE_X0:                          1
;     sub_c8492:                          1
;     Hugo_string:                        1
;     loop_c84a0:                         1
;     sub_c84a1:                          1
;     loop_c84ac:                         1
;     loop_c84b5:                         1
;     c8582:                              1
;     c85a0:                              1
;     loop_c85a3:                         1
;     c85b8:                              1
;     loop_c85ba:                         1
;     c85f1:                              1
;     c85f6:                              1
;     loop_c861d:                         1
;     loop_c8636:                         1
;     c8639:                              1
;     sub_c8657:                          1
;     c8679:                              1
;     c86a5:                              1
;     c86b0:                              1
;     sub_c86c0:                          1
;     c86d8:                              1
;     c86e1:                              1
;     c86e4:                              1
;     c86f5:                              1
;     c86f8:                              1
;     loop_c870e:                         1
;     c8717:                              1
;     c873a:                              1
;     c8748:                              1
;     c875b:                              1
;     c8775:                              1
;     c877a:                              1
;     c8784:                              1
;     c878a:                              1
;     loop_c878c:                         1
;     c879e:                              1
;     loop_c87a1:                         1
;     loop_c87ac:                         1
;     c87ba:                              1
;     c87c6:                              1
;     c87d8:                              1
;     loop_c87e0:                         1
;     c87e9:                              1
;     loop_c87eb:                         1
;     loop_c87f8:                         1
;     c8824:                              1
;     loop_c882d:                         1
;     loop_c8860:                         1
;     loop_c8875:                         1
;     c88ed:                              1
;     c88f2:                              1
;     c88ff:                              1
;     c8905:                              1
;     sub_c8938:                          1
;     c8950:                              1
;     c8976:                              1
;     c8979:                              1
;     loop_c8984:                         1
;     c899e:                              1
;     loop_c89a5:                         1
;     c89bb:                              1
;     c89bd:                              1
;     c89be:                              1
;     c89c1:                              1
;     loop_c89cb:                         1
;     c89d0:                              1
;     c89d6:                              1
;     loop_c89e1:                         1
;     c89e4:                              1
;     sub_c8a21:                          1
;     loop_c8a28:                         1
;     c8a34:                              1
;     loop_c8a38:                         1
;     c8a41:                              1
;     loop_c8a54:                         1
;     loop_c8a61:                         1
;     sub_c8a73:                          1
;     sub_c8a76:                          1
;     loop_c8a7a:                         1
;     loop_c8a87:                         1
;     loop_c8a97:                         1
;     c8ad4:                              1
;     c8ad7:                              1
;     c8ae6:                              1
;     loop_c8aeb:                         1
;     c8af9:                              1
;     loop_c8aff:                         1
;     c8b0a:                              1
;     loop_c8b10:                         1
;     loop_c8b1e:                         1
;     loop_c8b2c:                         1
;     l8b59:                              1
;     sub_c8b89:                          1
;     loop_c8b90:                         1
;     c8bac:                              1
;     loop_c8baf:                         1
;     loop_c8bbe:                         1
;     sub_c8bdc:                          1
;     loop_c8be0:                         1
;     loop_c8bea:                         1
;     c8c0d:                              1
;     l8c20:                              1
;     l8c21:                              1
;     loop_c8c40:                         1
;     loop_c8c5f:                         1
;     c8c69:                              1
;     loop_c8ca0:                         1
;     c8cac:                              1
;     loop_c8caf:                         1
;     c8cb8:                              1
;     l8ccc:                              1
;     sub_c8cda:                          1
;     sub_c8d7b:                          1
;     sub_c8d8a:                          1
;     c8dab:                              1
;     c8dae:                              1
;     c8dbb:                              1
;     c8dcf:                              1
;     opt4_string_table_pointer:          1
;     sub_c8dec:                          1
;     c8e19:                              1
;     c8e25:                              1
;     loop_c8e3a:                         1
;     loop_c8e45:                         1
;     c8e48:                              1
;     c8e4d:                              1
;     loop_c8e55:                         1
;     c8e5e:                              1
;     loop_c8e60:                         1
;     loop_c8e6d:                         1
;     sub_c8eb0:                          1
;     c8eb6:                              1
;     c8eda:                              1
;     c8eec:                              1
;     c8ef2:                              1
;     DIR_command:                        1
;     loop_c8efa:                         1
;     c8f0d:                              1
;     loop_c8f12:                         1
;     l8f29:                              1
;     sub_c8f4f:                          1
;     c8f5c:                              1
;     c8f69:                              1
;     l8f79:                              1
;     l8f82:                              1
;     l8f86:                              1
;     l8f90:                              1
;     service_handler:                    1
;     c8fb7:                              1
;     c8fb9:                              1
;     c8fc0:                              1
;     loop_c8fcc:                         1
;     c8fd1:                              1
;     loop_c8fef:                         1
;     c8ffe:                              1
;     c900b:                              1
;     c9010:                              1
;     c901c:                              1
;     c9028:                              1
;     c9034:                              1
;     c903c:                              1
;     c9049:                              1
;     sub_c9083:                          1
;     c90b8:                              1
;     c90d0:                              1
;     c90d8:                              1
;     c90f3:                              1
;     c9111:                              1
;     loop_c911b:                         1
;     c9124:                              1
;     c913f:                              1
;     c9142:                              1
;     c9150:                              1
;     loop_c9153:                         1
;     Initalise_filesystem:               1
;     c917a:                              1
;     c91b2:                              1
;     loop_c91c7:                         1
;     loop_c91dd:                         1
;     c91e6:                              1
;     loop_c91fd:                         1
;     c921d:                              1
;     loop_c921f:                         1
;     c9240:                              1
;     c9248:                              1
;     c9250:                              1
;     loop_c927b:                         1
;     c9288:                              1
;     loop_c928c:                         1
;     loop_c929d:                         1
;     c92aa:                              1
;     c92bd:                              1
;     c92de:                              1
;     osvector_table:                     1
;     l92f5:                              1
;     c9310:                              1
;     loop_c931c:                         1
;     c9320:                              1
;     loop_c932c:                         1
;     l933a:                              1
;     loop_c934f:                         1
;     c935e:                              1
;     loop_c938a:                         1
;     c9399:                              1
;     c9420:                              1
;     c9436:                              1
;     loop_c9438:                         1
;     c9479:                              1
;     loop_c948a:                         1
;     c9494:                              1
;     loop_c94a2:                         1
;     loop_c94b3:                         1
;     c94bf:                              1
;     c94c4:                              1
;     c94cc:                              1
;     c94dc:                              1
;     loop_c94e2:                         1
;     c94ec:                              1
;     c94ff:                              1
;     loop_c9508:                         1
;     loop_c955e:                         1
;     loop_c956f:                         1
;     c9574:                              1
;     loop_c9579:                         1
;     c9590:                              1
;     c9595:                              1
;     loop_c95a1:                         1
;     string_spec_list_pointers:          1
;     l95f4:                              1
;     l9600:                              1
;     loop_c9635:                         1
;     c9644:                              1
;     c965d:                              1
;     c9660:                              1
;     l96b5:                              1
;     l96b6:                              1
;     c970f:                              1
;     c9713:                              1
;     c9716:                              1
;     loop_c9765:                         1
;     loop_c977d:                         1
;     c9795:                              1
;     loop_c97a1:                         1
;     loop_c97b7:                         1
;     c97e5:                              1
;     c9800:                              1
;     c9801:                              1
;     loop_c9809:                         1
;     loop_c983e:                         1
;     l9847:                              1
;     sub_c9867:                          1
;     c9886:                              1
;     c98a1:                              1
;     c98b6:                              1
;     loop_c98c6:                         1
;     loop_c98d4:                         1
;     loop_c9907:                         1
;     IRQ1_vector_entry:                  1
;     loop_c991d:                         1
;     c9927:                              1
;     c9937:                              1
;     c993b:                              1
;     c994d:                              1
;     c9958:                              1
;     c995c:                              1
;     c9997:                              1
;     c99ad:                              1
;     c99e0:                              1
;     loop_c99f0:                         1
;     c9a0c:                              1
;     c9a21:                              1
;     c9a3e:                              1
;     loop_c9a4f:                         1
;     loop_c9a69:                         1
;     loop_c9a74:                         1
;     loop_c9a7d:                         1
;     loop_c9a82:                         1
;     loop_c9a95:                         1
;     loop_c9ab9:                         1
;     loop_c9acd:                         1
;     loop_c9af3:                         1
;     c9b05:                              1
;     c9b07:                              1
;     c9b15:                              1
;     sub_c9b21:                          1
;     loop_c9b40:                         1
;     c9b52:                              1
;     loop_c9b7b:                         1
;     loop_c9b8a:                         1
;     loop_c9bb2:                         1
;     c9bbf:                              1
;     loop_c9bd4:                         1
;     loop_c9bf1:                         1
;     loop_c9c10:                         1
;     c9c26:                              1
;     c9c27:                              1
;     loop_c9c2f:                         1
;     c9c35:                              1
;     c9c37:                              1
;     sub_c9c3a:                          1
;     c9c69:                              1
;     c9c71:                              1
;     c9ca3:                              1
;     c9cb4:                              1
;     sub_c9cd3:                          1
;     c9d0c:                              1
;     c9d0f:                              1
;     c9d3d:                              1
;     c9d47:                              1
;     c9d67:                              1
;     loop_c9d7e:                         1
;     c9d8a:                              1
;     c9d9a:                              1
;     c9da4:                              1
;     c9dc8:                              1
;     loop_c9df8:                         1
;     c9dfb:                              1
;     loop_c9e07:                         1
;     c9e12:                              1
;     c9e49:                              1
;     c9e97:                              1
;     c9e9c:                              1
;     loop_c9fa8:                         1
;     sub_c9fa9:                          1
;     c9fb8:                              1
;     c9fea:                              1
;     ca002:                              1
;     ca007:                              1
;     ca034:                              1
;     sub_ca039:                          1
;     ca05a:                              1
;     ca065:                              1
;     ca06d:                              1
;     loop_ca072:                         1
;     ca092:                              1
;     ca09d:                              1
;     ca0a7:                              1
;     ca0a9:                              1
;     ca0e5:                              1
;     ca165:                              1
;     ca16d:                              1
;     ca170:                              1
;     loop_ca176:                         1
;     loop_ca17b:                         1
;     ca187:                              1
;     ca196:                              1
;     sub_ca199:                          1
;     ca1a5:                              1
;     sub_ca1af:                          1
;     loop_ca1b1:                         1
;     ca1c0:                              1
;     sub_ca1c3:                          1
;     ca1d5:                              1
;     ca1d8:                              1
;     loop_ca224:                         1
;     ca25d:                              1
;     ca276:                              1
;     loop_ca29d:                         1
;     loop_ca2b0:                         1
;     ca2b1:                              1
;     loop_ca2e0:                         1
;     ca2ea:                              1
;     loop_ca2f6:                         1
;     loop_ca33a:                         1
;     ca34a:                              1
;     loop_ca37c:                         1
;     ca3b8:                              1
;     loop_ca3bd:                         1
;     ca3cf:                              1
;     loop_ca3f9:                         1
;     ca412:                              1
;     ca41c:                              1
;     loop_ca44c:                         1
;     ca467:                              1
;     loop_ca46e:                         1
;     loop_ca49c:                         1
;     loop_ca4b4:                         1
;     ca4d5:                              1
;     ca4dd:                              1
;     ca529:                              1
;     ca551:                              1
;     ca55d:                              1
;     loop_ca56a:                         1
;     ca57e:                              1
;     ca58f:                              1
;     loop_ca594:                         1
;     ca5a2:                              1
;     loop_ca5a8:                         1
;     ca5b9:                              1
;     ca5cf:                              1
;     ca5e3:                              1
;     ca5f9:                              1
;     ca610:                              1
;     ca640:                              1
;     loop_ca644:                         1
;     ca65b:                              1
;     ca661:                              1
;     ca679:                              1
;     ca693:                              1
;     ca6c2:                              1
;     ca6cf:                              1
;     ca6d5:                              1
;     ca6e1:                              1
;     Mouse_service_handler:              1
;     ca6f8:                              1
;     ca720:                              1
;     loop_ca73a:                         1
;     ca74b:                              1
;     ca74c:                              1
;     ca750:                              1
;     ca753:                              1
;     ca771:                              1
;     command_table+1:                    1
;     VIDEO_string:                       1
;     MOUSE_string:                       1
;     TRACKERBALL_string:                 1
;     sub_ca7db:                          1
;     loop_ca7df:                         1
;     loop_ca7ec:                         1
;     ca7ef:                              1
;     ca7fb:                              1
;     ca9fc:                              1
;     caa01:                              1
;     loop_caa13:                         1
;     loop_caa20:                         1
;     caa23:                              1
;     caa2b:                              1
;     caa31:                              1
;     loop_cab48:                         1
;     cab53:                              1
;     cab5e:                              1
;     cab75:                              1
;     cab81:                              1
;     cab85:                              1
;     loop_cabb3:                         1
;     cabc3:                              1
;     loop_cabc4:                         1
;     loop_cac36:                         1
;     cac41:                              1
;     loop_cac59:                         1
;     cac7c:                              1
;     cac87:                              1
;     cac98:                              1
;     sub_cacbd:                          1
;     star_SEARCH:                        1
;     loop_cacef:                         1
;     cad15:                              1
;     cad32:                              1
;     cad41:                              1
;     sub_cad48:                          1
;     cad53:                              1
;     star_STEP:                          1
;     cad75:                              1
;     cad81:                              1
;     loop_cad87:                         1
;     cad90:                              1
;     lad97:                              1
;     sub_cad9c:                          1
;     cada2:                              1
;     cade0:                              1
;     cae22:                              1
;     cae24:                              1
;     cae54:                              1
;     cae63:                              1
;     cae66:                              1
;     loop_cae90:                         1
;     loop_cae9a:                         1
;     caec8:                              1
;     caecd:                              1
;     caef4:                              1
;     loop_caefb:                         1
;     loop_caf05:                         1
;     caf3d:                              1
;     caf4e:                              1
;     caf80:                              1
;     caf84:                              1
;     cafea:                              1
;     cb001:                              1
;     cb038:                              1
;     sub_cb045:                          1
;     cb073:                              1
;     cb097:                              1
;     cb09f:                              1
;     cb0ab:                              1
;     cb0b8:                              1
;     cb0c0:                              1
;     cb0c8:                              1
;     cb0d0:                              1
;     cb182:                              1
;     cb199:                              1
;     cb1ae:                              1
;     cb1bc:                              1
;     loop_cb1ef:                         1
;     loop_cb210:                         1
;     loop_cb22d:                         1
;     loop_cb23f:                         1
;     loop_cb26d:                         1
;     cb288:                              1
;     cb2ad:                              1
;     cb2c2:                              1
;     cb2d1:                              1
;     loop_cb2dd:                         1
;     loop_cb322:                         1
;     sub_cb36b:                          1
;     cb377:                              1
;     cb37f:                              1
;     cb386:                              1
;     cb395:                              1
;     cb397:                              1
;     cb39c:                              1
;     cb3c0:                              1
;     cb3c1:                              1
;     cb3da:                              1
;     loop_cb3e1:                         1
;     cb3fe:                              1
;     sub_cb407:                          1
;     cb409:                              1
;     cb410:                              1
;     cb424:                              1
;     cb426:                              1
;     loop_cb442:                         1
;     sub_cb44c:                          1
;     cb467:                              1
;     cb47b:                              1
;     cb48d:                              1
;     cb4c6:                              1
;     loop_cb4cc:                         1
;     loop_cb4f2:                         1
;     loop_cb4fb:                         1
;     cb50a:                              1
;     cb52b:                              1
;     cb52f:                              1
;     cb542:                              1
;     cb567:                              1
;     cb5a4:                              1
;     cb5b1:                              1
;     cb5b3:                              1
;     cb5e5:                              1
;     cb5f1:                              1
;     cb609:                              1
;     service_handler_100Hz:              1
;     cb634:                              1
;     cb637:                              1
;     cb64c:                              1
;     cb651:                              1
;     cb652:                              1
;     cb659:                              1
;     cb678:                              1
;     cb67a:                              1
;     sub_cb67e:                          1
;     cb698:                              1
;     lb6c8:                              1
;     lb6ca:                              1
;     lb6cb:                              1
;     lb6cc:                              1
;     loop_cb6d6:                         1
;     loop_cb6f5:                         1
;     loop_cb706:                         1
;     cb71a:                              1
;     cb776:                              1
;     cb7ea:                              1
;     cb801:                              1
;     sub_cb80a:                          1
;     cb822:                              1
;     loop_cb83c:                         1
;     cb84a:                              1
;     cb84e:                              1
;     cb851:                              1
;     cb86d:                              1
;     cb877:                              1
;     cb892:                              1
;     loop_cb897:                         1
;     cb89d:                              1
;     lb8aa:                              1
;     lb943:                              1
;     lb965:                              1
;     lb990:                              1
;     lb9a0:                              1
;     lb9a4:                              1
;     lbffd:                              1
;     lc0fb:                              1
;     lc0fd:                              1
;     lc1ff:                              1
;     lc208:                              1
;     lc20c:                              1
;     lc210:                              1
;     lc226:                              1
;     lc227:                              1
;     lc228:                              1
;     lc229:                              1
;     lc22a:                              1
;     lc23f:                              1
;     lc25e:                              1
;     lc25f:                              1
;     lc263:                              1
;     lc2a1:                              1
;     lc2a3:                              1
;     lc2aa:                              1
;     lc2ab:                              1
;     lc2d1:                              1
;     lc2d3:                              1
;     lc319:                              1
;     lc31e:                              1
;     lc331:                              1
;     lc383:                              1
;     lc3a2:                              1
;     lce04:                              1
;     user_via_ddrb:                      1
;     user_via_ifr:                       1
;     scsi_nSEL:                          1
;     lff4e:                              1
;     lffb7:                              1
;     lffb8:                              1
;     gsinit:                             1
;     gsread:                             1
;     osargs:                             1
;     osasci:                             1

; Automatically generated labels:
;     c8037
;     c803e
;     c804c
;     c8054
;     c8072
;     c80d3
;     c80d6
;     c80e8
;     c80f0
;     c80fd
;     c810a
;     c8111
;     c8123
;     c8137
;     c813c
;     c8144
;     c8150
;     c8158
;     c8175
;     c817d
;     c817f
;     c8186
;     c818c
;     c81a1
;     c81bd
;     c81cf
;     c81d3
;     c81db
;     c81f4
;     c820c
;     c823f
;     c8258
;     c825d
;     c8267
;     c8270
;     c827f
;     c828f
;     c82aa
;     c82c3
;     c82d6
;     c8304
;     c8320
;     c8356
;     c835e
;     c8361
;     c838d
;     c8393
;     c8399
;     c83ca
;     c83cd
;     c83ce
;     c83d6
;     c83fc
;     c842b
;     c8442
;     c8453
;     c8457
;     c847b
;     c8582
;     c859e
;     c85a0
;     c85ab
;     c85b8
;     c85c7
;     c85f1
;     c85f5
;     c85f6
;     c85fb
;     c860c
;     c8619
;     c861c
;     c8639
;     c863b
;     c863f
;     c8660
;     c8679
;     c867b
;     c86a5
;     c86b0
;     c86b8
;     c86d8
;     c86e1
;     c86e4
;     c86f5
;     c86f8
;     c8717
;     c873a
;     c8748
;     c875b
;     c8775
;     c877a
;     c877b
;     c8784
;     c878a
;     c879e
;     c87af
;     c87ba
;     c87c6
;     c87cc
;     c87d8
;     c87e9
;     c880a
;     c880d
;     c8824
;     c8856
;     c889e
;     c88a7
;     c88c7
;     c88da
;     c88ed
;     c88f2
;     c88ff
;     c8904
;     c8905
;     c891c
;     c8930
;     c8950
;     c8976
;     c8979
;     c899e
;     c89bb
;     c89bd
;     c89be
;     c89c1
;     c89d0
;     c89d6
;     c89d8
;     c89d9
;     c89e4
;     c89e8
;     c8a01
;     c8a34
;     c8a41
;     c8ad4
;     c8ad7
;     c8ae6
;     c8af9
;     c8b0a
;     c8b17
;     c8b41
;     c8b47
;     c8b4a
;     c8b69
;     c8b7a
;     c8bac
;     c8bcc
;     c8c0d
;     c8c1f
;     c8c69
;     c8cac
;     c8cb8
;     c8d92
;     c8dab
;     c8dae
;     c8dbb
;     c8dcf
;     c8dd2
;     c8def
;     c8e19
;     c8e25
;     c8e26
;     c8e35
;     c8e48
;     c8e4d
;     c8e5e
;     c8ea5
;     c8eb6
;     c8eb7
;     c8ed1
;     c8eda
;     c8eec
;     c8ef2
;     c8f0d
;     c8f26
;     c8f5c
;     c8f69
;     c8fb7
;     c8fb9
;     c8fc0
;     c8fd1
;     c8ffe
;     c9008
;     c900b
;     c900d
;     c9010
;     c901c
;     c9028
;     c9034
;     c903a
;     c903c
;     c9049
;     c9069
;     c90b8
;     c90d0
;     c90d5
;     c90d8
;     c90e8
;     c90f3
;     c90f8
;     c9111
;     c9124
;     c913f
;     c9142
;     c9150
;     c917a
;     c917c
;     c9190
;     c919f
;     c91b2
;     c91e6
;     c921d
;     c9240
;     c9248
;     c9250
;     c9288
;     c92a7
;     c92aa
;     c92bd
;     c92ca
;     c92de
;     c9310
;     c9320
;     c9337
;     c935e
;     c9399
;     c9420
;     c9436
;     c9449
;     c945a
;     c9479
;     c9494
;     c94bf
;     c94c4
;     c94cc
;     c94d0
;     c94d6
;     c94dc
;     c94ec
;     c94ff
;     c9558
;     c956a
;     c9574
;     c9590
;     c9595
;     c95ad
;     c95f3
;     c961f
;     c9623
;     c9644
;     c9653
;     c965d
;     c9660
;     c970f
;     c9713
;     c9716
;     c9726
;     c973f
;     c9795
;     c97e5
;     c9800
;     c9801
;     c9822
;     c9886
;     c9891
;     c98a1
;     c98b6
;     c9927
;     c9937
;     c993b
;     c9948
;     c994d
;     c9958
;     c995c
;     c9997
;     c99ad
;     c99e0
;     c9a0c
;     c9a21
;     c9a3e
;     c9a54
;     c9b05
;     c9b07
;     c9b0a
;     c9b15
;     c9b52
;     c9b53
;     c9b92
;     c9bbf
;     c9c26
;     c9c27
;     c9c35
;     c9c37
;     c9c5f
;     c9c69
;     c9c71
;     c9ca3
;     c9cb4
;     c9d0c
;     c9d0f
;     c9d3d
;     c9d47
;     c9d67
;     c9d8a
;     c9d9a
;     c9da4
;     c9dbe
;     c9dbf
;     c9dc8
;     c9dfb
;     c9e12
;     c9e35
;     c9e49
;     c9e85
;     c9e97
;     c9e9c
;     c9e9f
;     c9ed9
;     c9fb8
;     c9fc5
;     c9fea
;     ca002
;     ca007
;     ca00a
;     ca00e
;     ca034
;     ca05a
;     ca065
;     ca06d
;     ca092
;     ca09d
;     ca0a7
;     ca0a9
;     ca0d9
;     ca0e5
;     ca165
;     ca16d
;     ca170
;     ca187
;     ca196
;     ca1a5
;     ca1c0
;     ca1d5
;     ca1d8
;     ca1f5
;     ca206
;     ca25d
;     ca276
;     ca283
;     ca2b1
;     ca2d5
;     ca2ea
;     ca336
;     ca34a
;     ca3b8
;     ca3cf
;     ca40c
;     ca412
;     ca41c
;     ca43e
;     ca459
;     ca467
;     ca4d5
;     ca4dd
;     ca529
;     ca53c
;     ca549
;     ca551
;     ca55d
;     ca577
;     ca57e
;     ca58f
;     ca5a2
;     ca5b9
;     ca5c9
;     ca5cf
;     ca5e3
;     ca5f9
;     ca610
;     ca635
;     ca640
;     ca65b
;     ca661
;     ca679
;     ca693
;     ca6a9
;     ca6c2
;     ca6cf
;     ca6d5
;     ca6e1
;     ca6e6
;     ca6f8
;     ca720
;     ca724
;     ca747
;     ca74b
;     ca74c
;     ca750
;     ca753
;     ca75e
;     ca771
;     ca7ef
;     ca7fb
;     ca9fc
;     caa01
;     caa23
;     caa2b
;     caa31
;     caa37
;     cab53
;     cab5e
;     cab75
;     cab77
;     cab7f
;     cab81
;     cab85
;     cab92
;     cabc3
;     cabdd
;     cabf7
;     cac41
;     cac6d
;     cac7c
;     cac87
;     cac98
;     cacad
;     cacff
;     cad09
;     cad15
;     cad27
;     cad32
;     cad41
;     cad53
;     cad75
;     cad81
;     cad90
;     cada2
;     cadce
;     caddd
;     cade0
;     cae09
;     cae22
;     cae24
;     cae54
;     cae59
;     cae63
;     cae66
;     caec8
;     caecd
;     caecf
;     caee5
;     caef4
;     caf21
;     caf30
;     caf3d
;     caf4d
;     caf4e
;     caf80
;     caf84
;     cafea
;     caff2
;     cb001
;     cb021
;     cb022
;     cb038
;     cb065
;     cb073
;     cb097
;     cb09f
;     cb0a6
;     cb0ab
;     cb0b8
;     cb0c0
;     cb0c5
;     cb0c8
;     cb0d0
;     cb0e9
;     cb13d
;     cb155
;     cb182
;     cb199
;     cb1a5
;     cb1ae
;     cb1bc
;     cb1d4
;     cb258
;     cb288
;     cb29f
;     cb2ad
;     cb2c2
;     cb2c5
;     cb2d1
;     cb377
;     cb37f
;     cb386
;     cb395
;     cb397
;     cb39c
;     cb3af
;     cb3c0
;     cb3c1
;     cb3da
;     cb3fe
;     cb409
;     cb410
;     cb424
;     cb426
;     cb440
;     cb467
;     cb47b
;     cb48d
;     cb4ba
;     cb4c6
;     cb50a
;     cb52b
;     cb52f
;     cb542
;     cb567
;     cb5a4
;     cb5b1
;     cb5b3
;     cb5cc
;     cb5e5
;     cb5f1
;     cb609
;     cb60a
;     cb634
;     cb637
;     cb64c
;     cb651
;     cb652
;     cb659
;     cb678
;     cb67a
;     cb67d
;     cb697
;     cb698
;     cb6bf
;     cb71a
;     cb776
;     cb77c
;     cb77f
;     cb7b9
;     cb7c4
;     cb7c6
;     cb7ea
;     cb7ee
;     cb801
;     cb805
;     cb822
;     cb826
;     cb849
;     cb84a
;     cb84e
;     cb851
;     cb860
;     cb86d
;     cb877
;     cb892
;     cb89d
;     l0000
;     l0001
;     l0002
;     l0003
;     l0084
;     l0085
;     l0086
;     l0087
;     l0088
;     l0089
;     l008a
;     l008c
;     l008d
;     l008e
;     l008f
;     l00a8
;     l00a9
;     l00aa
;     l00ab
;     l00ac
;     l00ad
;     l00ae
;     l00af
;     l00b0
;     l00b1
;     l00b2
;     l00b3
;     l00b4
;     l00b5
;     l00b6
;     l00b7
;     l00b8
;     l00b9
;     l00ba
;     l00bb
;     l00bc
;     l00bd
;     l00be
;     l00bf
;     l00c0
;     l00c1
;     l00c2
;     l00c3
;     l00c4
;     l00c5
;     l00c6
;     l00c7
;     l00c8
;     l00c9
;     l00ca
;     l00cb
;     l00cf
;     l00ef
;     l00f0
;     l00f1
;     l00fc
;     l00ff
;     l0100
;     l0101
;     l0102
;     l0103
;     l0104
;     l0406
;     l0900
;     l0901
;     l0902
;     l0903
;     l0904
;     l0905
;     l0906
;     l0907
;     l0908
;     l0909
;     l090a
;     l090b
;     l090c
;     l090d
;     l090e
;     l090f
;     l0910
;     l0911
;     l0912
;     l0913
;     l0914
;     l0915
;     l0916
;     l0917
;     l091b
;     l091c
;     l091d
;     l091e
;     l091f
;     l0923
;     l0924
;     l0925
;     l0926
;     l0932
;     l0933
;     l0937
;     l0938
;     l0939
;     l093a
;     l093b
;     l093c
;     l093d
;     l093e
;     l8b59
;     l8c20
;     l8c21
;     l8ccc
;     l8f29
;     l8f79
;     l8f82
;     l8f86
;     l8f90
;     l908f
;     l92f5
;     l933a
;     l95f4
;     l9600
;     l96b5
;     l96b6
;     l9847
;     lad97
;     lb6c7
;     lb6c8
;     lb6ca
;     lb6cb
;     lb6cc
;     lb8aa
;     lb943
;     lb965
;     lb98a
;     lb98d
;     lb990
;     lb9a0
;     lb9a4
;     lbffd
;     lbfff
;     lc0fb
;     lc0fd
;     lc0ff
;     lc100
;     lc1fb
;     lc1fc
;     lc1fd
;     lc1fe
;     lc1ff
;     lc201
;     lc202
;     lc203
;     lc204
;     lc208
;     lc20c
;     lc210
;     lc214
;     lc215
;     lc216
;     lc217
;     lc218
;     lc219
;     lc21a
;     lc21b
;     lc21c
;     lc21d
;     lc21e
;     lc21f
;     lc220
;     lc221
;     lc222
;     lc223
;     lc226
;     lc227
;     lc228
;     lc229
;     lc22a
;     lc22b
;     lc22c
;     lc22d
;     lc22e
;     lc22f
;     lc230
;     lc233
;     lc23b
;     lc23f
;     lc240
;     lc241
;     lc242
;     lc243
;     lc25d
;     lc25e
;     lc25f
;     lc262
;     lc263
;     lc26f
;     lc295
;     lc296
;     lc297
;     lc298
;     lc29a
;     lc29b
;     lc29c
;     lc29d
;     lc2a0
;     lc2a1
;     lc2a2
;     lc2a3
;     lc2a8
;     lc2aa
;     lc2ab
;     lc2b4
;     lc2b5
;     lc2b6
;     lc2b7
;     lc2b8
;     lc2b9
;     lc2ba
;     lc2bb
;     lc2c0
;     lc2c1
;     lc2c2
;     lc2cd
;     lc2ce
;     lc2cf
;     lc2d0
;     lc2d1
;     lc2d2
;     lc2d3
;     lc2d5
;     lc2d6
;     lc2d9
;     lc2fe
;     lc300
;     lc30a
;     lc313
;     lc314
;     lc315
;     lc316
;     lc317
;     lc318
;     lc319
;     lc31a
;     lc31b
;     lc31c
;     lc31e
;     lc31f
;     lc320
;     lc321
;     lc322
;     lc331
;     lc332
;     lc333
;     lc334
;     lc33e
;     lc348
;     lc352
;     lc35c
;     lc366
;     lc370
;     lc37a
;     lc383
;     lc384
;     lc38e
;     lc398
;     lc3a2
;     lc3ac
;     lc3b6
;     lc3c0
;     lc3ca
;     lc3d4
;     lc3de
;     lc3e8
;     lc3f2
;     lc400
;     lc8cc
;     lc8d9
;     lc8fa
;     lce00
;     lce01
;     lce02
;     lce03
;     lce04
;     lce10
;     lce11
;     lff4e
;     lffb7
;     lffb8
;     loop_c802b
;     loop_c8075
;     loop_c808c
;     loop_c809c
;     loop_c80ee
;     loop_c815b
;     loop_c8193
;     loop_c81e3
;     loop_c81fa
;     loop_c821e
;     loop_c8224
;     loop_c82ec
;     loop_c8317
;     loop_c833b
;     loop_c8363
;     loop_c838a
;     loop_c83a1
;     loop_c845d
;     loop_c846f
;     loop_c84a0
;     loop_c84ac
;     loop_c84b5
;     loop_c85a3
;     loop_c85ba
;     loop_c861d
;     loop_c8636
;     loop_c870e
;     loop_c878c
;     loop_c87a1
;     loop_c87ac
;     loop_c87e0
;     loop_c87eb
;     loop_c87f8
;     loop_c882d
;     loop_c8860
;     loop_c8875
;     loop_c8984
;     loop_c89a5
;     loop_c89cb
;     loop_c89e1
;     loop_c8a28
;     loop_c8a38
;     loop_c8a54
;     loop_c8a61
;     loop_c8a7a
;     loop_c8a87
;     loop_c8a97
;     loop_c8aeb
;     loop_c8aff
;     loop_c8b10
;     loop_c8b1e
;     loop_c8b2c
;     loop_c8b90
;     loop_c8baf
;     loop_c8bbe
;     loop_c8be0
;     loop_c8bea
;     loop_c8c40
;     loop_c8c5f
;     loop_c8ca0
;     loop_c8caf
;     loop_c8e3a
;     loop_c8e45
;     loop_c8e55
;     loop_c8e60
;     loop_c8e6d
;     loop_c8efa
;     loop_c8f12
;     loop_c8fcc
;     loop_c8fef
;     loop_c911b
;     loop_c9153
;     loop_c91c7
;     loop_c91dd
;     loop_c91fd
;     loop_c921f
;     loop_c927b
;     loop_c928c
;     loop_c929d
;     loop_c931c
;     loop_c932c
;     loop_c934f
;     loop_c938a
;     loop_c9438
;     loop_c948a
;     loop_c94a2
;     loop_c94b3
;     loop_c94e2
;     loop_c9508
;     loop_c955e
;     loop_c956f
;     loop_c9579
;     loop_c95a1
;     loop_c9635
;     loop_c9765
;     loop_c977d
;     loop_c97a1
;     loop_c97b7
;     loop_c9809
;     loop_c983e
;     loop_c98c6
;     loop_c98d4
;     loop_c9907
;     loop_c991d
;     loop_c99f0
;     loop_c9a4f
;     loop_c9a69
;     loop_c9a74
;     loop_c9a7d
;     loop_c9a82
;     loop_c9a95
;     loop_c9ab9
;     loop_c9acd
;     loop_c9af3
;     loop_c9b40
;     loop_c9b7b
;     loop_c9b8a
;     loop_c9bb2
;     loop_c9bd4
;     loop_c9bf1
;     loop_c9c10
;     loop_c9c2f
;     loop_c9d7e
;     loop_c9df8
;     loop_c9e07
;     loop_c9fa8
;     loop_ca072
;     loop_ca176
;     loop_ca17b
;     loop_ca1b1
;     loop_ca224
;     loop_ca29d
;     loop_ca2b0
;     loop_ca2e0
;     loop_ca2f6
;     loop_ca33a
;     loop_ca37c
;     loop_ca3bd
;     loop_ca3f9
;     loop_ca44c
;     loop_ca46e
;     loop_ca49c
;     loop_ca4b4
;     loop_ca56a
;     loop_ca594
;     loop_ca5a8
;     loop_ca644
;     loop_ca73a
;     loop_ca7df
;     loop_ca7ec
;     loop_caa13
;     loop_caa20
;     loop_cab48
;     loop_cabb3
;     loop_cabc4
;     loop_cac36
;     loop_cac59
;     loop_cacef
;     loop_cad87
;     loop_cae90
;     loop_cae9a
;     loop_caefb
;     loop_caf05
;     loop_cb1ef
;     loop_cb210
;     loop_cb22d
;     loop_cb23f
;     loop_cb26d
;     loop_cb2dd
;     loop_cb322
;     loop_cb3e1
;     loop_cb442
;     loop_cb4cc
;     loop_cb4f2
;     loop_cb4fb
;     loop_cb6d6
;     loop_cb6f5
;     loop_cb706
;     loop_cb83c
;     loop_cb897
;     sub_c8089
;     sub_c81b0
;     sub_c81c2
;     sub_c81c3
;     sub_c81cb
;     sub_c81ce
;     sub_c8261
;     sub_c82dc
;     sub_c82eb
;     sub_c82f7
;     sub_c832f
;     sub_c8419
;     sub_c842c
;     sub_c843c
;     sub_c8459
;     sub_c848a
;     sub_c8492
;     sub_c84a1
;     sub_c857c
;     sub_c8583
;     sub_c858e
;     sub_c85a1
;     sub_c8657
;     sub_c8692
;     sub_c86bb
;     sub_c86c0
;     sub_c8876
;     sub_c887e
;     sub_c8938
;     sub_c89c4
;     sub_c8a16
;     sub_c8a21
;     sub_c8a73
;     sub_c8a76
;     sub_c8ab9
;     sub_c8ada
;     sub_c8b42
;     sub_c8b5f
;     sub_c8b6a
;     sub_c8b89
;     sub_c8bdc
;     sub_c8c32
;     sub_c8c3e
;     sub_c8c7a
;     sub_c8c94
;     sub_c8cda
;     sub_c8ce0
;     sub_c8d7b
;     sub_c8d84
;     sub_c8d8a
;     sub_c8de9
;     sub_c8dec
;     sub_c8e05
;     sub_c8e27
;     sub_c8e9d
;     sub_c8eb0
;     sub_c8f46
;     sub_c8f4f
;     sub_c9038
;     sub_c906a
;     sub_c906e
;     sub_c9072
;     sub_c9083
;     sub_c90db
;     sub_c9154
;     sub_c9512
;     sub_c955f
;     sub_c95d6
;     sub_c960c
;     sub_c96fc
;     sub_c9701
;     sub_c97c8
;     sub_c97db
;     sub_c983c
;     sub_c9851
;     sub_c9867
;     sub_c98c2
;     sub_c98de
;     sub_c99bd
;     sub_c9a80
;     sub_c9a93
;     sub_c9aef
;     sub_c9b21
;     sub_c9b68
;     sub_c9b74
;     sub_c9b85
;     sub_c9b8b
;     sub_c9ba3
;     sub_c9bed
;     sub_c9c14
;     sub_c9c1d
;     sub_c9c3a
;     sub_c9cd3
;     sub_c9d28
;     sub_c9d37
;     sub_c9e41
;     sub_c9e4a
;     sub_c9e62
;     sub_c9e86
;     sub_c9eaf
;     sub_c9fa5
;     sub_c9fa9
;     sub_ca012
;     sub_ca039
;     sub_ca03c
;     sub_ca199
;     sub_ca1af
;     sub_ca1c3
;     sub_ca207
;     sub_ca221
;     sub_ca22d
;     sub_ca286
;     sub_ca28c
;     sub_ca50f
;     sub_ca560
;     sub_ca5f0
;     sub_ca670
;     sub_ca799
;     sub_ca7db
;     sub_cab56
;     sub_cab93
;     sub_cab9b
;     sub_cacba
;     sub_cacbd
;     sub_cad43
;     sub_cad48
;     sub_cad9a
;     sub_cad9c
;     sub_cadd4
;     sub_cae67
;     sub_cae8a
;     sub_caef7
;     sub_caf33
;     sub_cb045
;     sub_cb1e3
;     sub_cb1f7
;     sub_cb228
;     sub_cb240
;     sub_cb2ed
;     sub_cb36b
;     sub_cb37d
;     sub_cb3c7
;     sub_cb3d8
;     sub_cb407
;     sub_cb44c
;     sub_cb65b
;     sub_cb67e
;     sub_cb6d4
;     sub_cb6e5
;     sub_cb704
;     sub_cb80a
    assert &80+&0d == &8d
    assert &80+' ' == &a0
    assert &80+'(' == &a8
    assert &80+':' == &ba
    assert <(BACK_command-1) == &b6
    assert <(BYE_command-1) == &c8
    assert <(DIR_command-1) == &f4
    assert <(DISMOUNT_command-1) == &03
    assert <(FREE_command-1) == &4e
    assert <(Function_entered_via_rts_onstack-1) == &f7
    assert <(LCAT_command-1) == &9e
    assert <(LEX_command-1) == &aa
    assert <(LIB_command-1) == &63
    assert <(MAP_command-1) == &7d
    assert <(MOUNT_command-1) == &63
    assert <(MOUSE_command) == &6c
    assert <(POINTER_command) == &da
    assert <(Service_handler_AbsoluteWorkSpaceClaim-1) == &06
    assert <(Service_handler_Autoboot-1) == &60
    assert <(Service_handler_CloseAllFiles-1) == &44
    assert <(Service_handler_DynamicWorkspaceRequirements-1) == &24
    assert <(Service_handler_InformMosofNameRequirements-1) == &29
    assert <(Service_handler_NOP-1) == &b5
    assert <(Service_handler_OfferHiddenDynamicWorkspace-1) == &10
    assert <(Service_handler_OfferHiddenStaticWorkspace-1) == &09
    assert <(Service_handler_PrivateWorkSpaceClaim-1) == &07
    assert <(Service_handler_ResetOccured-1) == &62
    assert <(Service_handler_StarHELP-1) == &28
    assert <(Service_handler_UnkownConfigureOption-1) == &e2
    assert <(Service_handler_UnkownStatusOption-1) == &ac
    assert <(Service_handler_UnrecognisedCommand-1) == &24
    assert <(Service_handler_UnrecognisedInterrupt-1) == &fc
    assert <(Service_handler_UnrecognisedOSWord-1) == &60
    assert <(TMAX_command) == &9b
    assert <(TSET_command) == &cc
    assert <(rts_call_via_rti) == &66
    assert <(starEdot_VFS_dotBOOT) == &77
    assert <(star_AUDIO) == &ef
    assert <(star_CHAPTER) == &51
    assert <(star_EJECT) == &61
    assert <(star_FAST) == &16
    assert <(star_FCODE) == &24
    assert <(star_FRAME) == &ea
    assert <(star_PLAY) == &a2
    assert <(star_RESET) == &49
    assert <(star_SEARCH) == &c8
    assert <(star_SLOW) == &27
    assert <(star_STEP) == &67
    assert <(star_STILL) == &de
    assert <(star_VOCOMPUTER) == &14
    assert <(star_VODISC) == &10
    assert <(star_VOHIGHLIGHT) == &20
    assert <(star_VOSUPERIMPOSE) == &18
    assert <(star_VOTRANSPARENT) == &1c
    assert <(star_VP) == &c7
    assert <(sub_c8d84-1) == &83
    assert <(sub_c8de9-1) == &e8
    assert <(sub_c8e9d-1) == &9c
    assert <(sub_c960c-1) == &0b
    assert <(sub_c96fc-1) == &fb
    assert <(sub_c9701-1) == &00
    assert <(sub_c97c8-1) == &c7
    assert <(sub_c99bd-1) == &bc
    assert <(sub_c9c14-1) == &13
    assert <(sub_c9e86-1) == &85
    assert <Extended_IRQ1_Vector == &4f
    assert <IRQ1_vector_entry == &0d
    assert <OSBYTE_Extended_Vectorcode == &b6
    assert <SCSI_bye == &d0
    assert <SCSI_drive_access_data == &b7
    assert <String_dollarBOOT == &6f
    assert <dirdata == &6a
    assert <starEdot == &7c
    assert <starEdot_VFS_dotBOOT == &77
    assert <starLOAD_boot == &6d
    assert <starSPdot == &7f
    assert <string_Exec == &e5
    assert <string_LWRE == &9f
    assert <string_Load == &dd
    assert <string_Null == &b3
    assert <string_Off == &d9
    assert <string_Run == &e1
    assert <string_drive == &8b
    assert <string_list_spec == &69
    assert <string_ob_spec == &75
    assert <string_sp_lp == &95
    assert <string_starob_spec == &7f
    assert <string_title == &ac
    assert <table1 == &82
    assert <table2 == &7c
    assert <table3 == &87
    assert <unknown_table1 == &42
    assert <zeroLIB_string == &df
    assert >(BACK_command-1) == &9a
    assert >(BYE_command-1) == &97
    assert >(DIR_command-1) == &8e
    assert >(DISMOUNT_command-1) == &98
    assert >(FREE_command-1) == &97
    assert >(Function_entered_via_rts_onstack-1) == &9b
    assert >(LCAT_command-1) == &9a
    assert >(LEX_command-1) == &9a
    assert >(LIB_command-1) == &9a
    assert >(MAP_command-1) == &97
    assert >(MOUNT_command-1) == &98
    assert >(MOUSE_command) == &af
    assert >(POINTER_command) == &af
    assert >(Service_handler_AbsoluteWorkSpaceClaim-1) == &91
    assert >(Service_handler_Autoboot-1) == &91
    assert >(Service_handler_CloseAllFiles-1) == &93
    assert >(Service_handler_DynamicWorkspaceRequirements-1) == &93
    assert >(Service_handler_InformMosofNameRequirements-1) == &93
    assert >(Service_handler_NOP-1) == &8f
    assert >(Service_handler_OfferHiddenDynamicWorkspace-1) == &93
    assert >(Service_handler_OfferHiddenStaticWorkspace-1) == &93
    assert >(Service_handler_PrivateWorkSpaceClaim-1) == &91
    assert >(Service_handler_ResetOccured-1) == &93
    assert >(Service_handler_StarHELP-1) == &95
    assert >(Service_handler_UnkownConfigureOption-1) == &8f
    assert >(Service_handler_UnkownStatusOption-1) == &90
    assert >(Service_handler_UnrecognisedCommand-1) == &94
    assert >(Service_handler_UnrecognisedInterrupt-1) == &9c
    assert >(Service_handler_UnrecognisedOSWord-1) == &94
    assert >(TMAX_command) == &b7
    assert >(TSET_command) == &b7
    assert >(rts_call_via_rti) == &b5
    assert >(starEdot_VFS_dotBOOT) == &8f
    assert >(star_AUDIO) == &ad
    assert >(star_CHAPTER) == &ac
    assert >(star_EJECT) == &ab
    assert >(star_FAST) == &ae
    assert >(star_FCODE) == &ac
    assert >(star_FRAME) == &ac
    assert >(star_PLAY) == &ae
    assert >(star_RESET) == &ac
    assert >(star_SEARCH) == &ac
    assert >(star_SLOW) == &ae
    assert >(star_STEP) == &ad
    assert >(star_STILL) == &ac
    assert >(star_VOCOMPUTER) == &ac
    assert >(star_VODISC) == &ac
    assert >(star_VOHIGHLIGHT) == &ac
    assert >(star_VOSUPERIMPOSE) == &ac
    assert >(star_VOTRANSPARENT) == &ac
    assert >(star_VP) == &ab
    assert >(sub_c8d84-1) == &8d
    assert >(sub_c8de9-1) == &8d
    assert >(sub_c8e9d-1) == &8e
    assert >(sub_c960c-1) == &96
    assert >(sub_c96fc-1) == &96
    assert >(sub_c9701-1) == &97
    assert >(sub_c97c8-1) == &97
    assert >(sub_c99bd-1) == &99
    assert >(sub_c9c14-1) == &9c
    assert >(sub_c9e86-1) == &9e
    assert >Extended_IRQ1_Vector == &b5
    assert >IRQ1_vector_entry == &99
    assert >OSBYTE_Extended_Vectorcode == &b4
    assert >SCSI_bye == &97
    assert >SCSI_drive_access_data == &98
    assert >bootcommand_pointer_table == &8f
    assert >dirdata == &99
    assert >starEdot == &84
    assert >string_Off == &8d
    assert >string_list_spec == &96
    assert >table1 == &8e
    assert >table2 == &86
    assert >table3 == &86
    assert >unknown_table1 == &8f
    assert >zeroLIB_string == &92
    assert bootcommand_pointer_table-1 == &8f69
    assert copyright - rom_header == &16
    assert l0001-1 == &00
    assert l8c20+1 == &8c21
    assert osbyte_acknowledge_escape == &7e
    assert osbyte_increment_polling_semaphore == &16
    assert osbyte_insert_input_buffer == &99
    assert osbyte_issue_service_request == &8f
    assert osbyte_read_char_at_cursor == &87
    assert osbyte_read_cmos_ram == &a1
    assert osbyte_read_rom_ptr_table_low == &a8
    assert osbyte_read_text_cursor_pos == &86
    assert osbyte_read_write_spool_file_handle == &c7
    assert osbyte_read_write_tab_char == &db
    assert osbyte_scan_keyboard_from_16 == &7a
    assert osbyte_write_cmos_ram == &a2
    assert star_command_table+1 == &b8aa
    assert sub_c8a16-1 == &8a15
    assert sub_c8ab9-1 == &8ab8
    assert sub_c95d6 == &95d6
    assert sub_c9c1d == &9c1d
    assert sub_c9eaf == &9eaf
    assert sub_c9fa5 == &9fa5
    assert sub_ca03c == &a03c
    assert sub_ca28c == &a28c
    assert unset_string-2 == &9847
    assert vector1 == &8bf1
    assert vfs_command_table+1 == &96b5
    assert vfs_command_table+2 == &96b6

save pydis_start, pydis_end
