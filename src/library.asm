		.include "config.inc"
		.include "os.inc"
		.include "workspace.inc"
		.include "hardware.inc"

		.segment "rom_header_lib"

L8000:		lda	#$00				; Do-nothing language entry
L8002:		rts					; Doubles up to claim service call
		jmp	ServiceEntry			; Jump to service handler
		.byte	$82				; Service ROM, 6502 code
		.byte	copyright-L8000-1		; Offset to (C) string
		.byte	VERSION & $FF			; Binary version number
		.byte	"PRES E00 ADFS Library",0
copyright:	.byte	"(C) 1987 PRES"
.ifdef ELK_PRES_E00_126
		.byte	",by B0" 
.endif
		.byte	0

;; Map of main ROM:
; 8000-ADFF main routines
; AE00-B100 space for library routines to be paged in
; B100-BFFF workspace

;; Map of Library ROM:
; (1.20):
; 8000-81FF OSBYTE 5A routines, ROM header, etc
; 8200-83FF scratch space
; (1.26/3.31):
; 8000-83FD Rom service routines, ROM header, etc
; 83FD-83FF scratch space
; 8400 start of first module
; ...
; A4FF end of last module
; (1.26/3.31):
; A500-A7FF AQRinit
; 
; BB00-BBFF saved C00 space
; BC00-BFFF saved E00-11FF space

		.segment "rom_main_lib"

; Table of page numbers by module
ModuleTable:
.byte $84, $87, $89, $8b, $8c, $8d, $8f, $92
.byte $93, $94, $95, $96, $97, $9a, $9b, $9c
.byte $9d, $9f, $a0, $a2

.ifdef ELK_PRES_E00_330
;; Handler for service call &10
; (*EXEC/*SPOOL files about to close / change of FS imminent)
L8047:		sta	saveA
		tya
		pha				; save Y
		jsr	L81FF
		pla				; restore Y
		tay
		lda	#$10			; don't claim the  call
		rts
.endif

;;; Service Entry Point for library ROM
ServiceEntry:
.ifdef ELK_PRES_E00_331
		sta	$FCDC			; Unlock ABR slots 0/2
		sta	$FCDE			; Unlock ABR slots 1/3
		sta	$FCDA			; Unlock AP6/7 high bank
		sta	$FCD8			; Unlock AP6/7 low bank
.endif
.ifdef ELK_PRES_E00_330
		cmp	#$10			; Service call 10 - *EXEC/*SPOOL files about to close
						; (change of FS imminent)
		beq	L8047
.endif
L8041:		cmp	#$07			; Service call 7 - OSBYTE
		bne	L8002			; otherwise return
L8045:		sta	saveA			; save input A
.if .def(ELK_PRES_E00_126) && (!.def(ELK_PRES_E00_331))
		sta	$FCDC			; Unlock ABR slots 0/2
		sta	$FCDE			; Unlock ABR slots 1/3
.endif
		lda	$EF			; MOS stores A for OSBYTE here
		cmp	#OSBYTE_5A_ROMSTAT	; 5A is the only one we're interested in
		beq	osbyte_5A_handler
		lda	saveA			; restore A and return
		rts

;;
; handler for OSBYTE A=&5A, X=255
; used by non-E00 PRES ADFS to detect presence of E00 ADFS and disable itself
L8052:		ldx	#$00
		stx	$100
		jmp	L8172			; return with call claimed

; handler for OSBYTE A=&5A, X=254
; Save current contents of &C00
L805A:		ldx	#$00
L805C:		lda	$0C00,x
		tay
		lda	$BB00,x			; swap BB00 saved data with C00
		sta	$0C00,x
		tya
		sta	$BB00,x
		dex
		bne	L805C			; loop
		jmp	L8172			; claim call and return

; handler for OSBYTE A=&5A, X=253
; (Kill ADFS 1.2x and restart ADFS 1.xx)
L8070:		ldx	ZP_MOS_CURROM
		lda	#$FE			; "Killed" status
		;; NB this assumes that FS ROM is one slot below Library ROM
		sta	SYSVARS_DF0_PWSKPTAB - 1,x
						; cur ROM - 1 (FS ROM)
		sta	SYSVARS_DF0_PWSKPTAB,x	; cur ROM (library ROM)

		ldx	#$0F			; Loop: check through all ROMS
L807C:		lda	SYSVARS_DF0_PWSKPTAB,x
.ifdef ELK_PRES_E00_126
		and	#$BF
.else
		ldy	sysvar_BREAK_LAST_TYPE
		cpy	#$01			; last BREAK was power on reset?
		bne	L808C
		cmp	#$FF			; Check for FF (on power on reset)
		beq	L80A0			; yes: done
		bne	L8090			; branch always taken - next loop
.endif

L808C:		cmp	#$BF			; Is it a disabled ADFS 1.00/1.1x?
		beq	L80A0
L8090:		dex
		bpl	L807C			; loop

L8093:		ldx	ZP_MOS_CURROM		; disable current ROM - 1 (FS)
		lda	#$FF			; and current ROM (lib ROM)
		sta	SYSVARS_DF0_PWSKPTAB - 1,x
		sta	SYSVARS_DF0_PWSKPTAB,x
		jmp	($FFFC)			; reset vector

;
L80A0:		lda	#$00			; found ADFS 1.00/1.1x (ROM# in X)
		sta	SYSVARS_DF0_PWSKPTAB,x	; enable/reinitialize it
.ifdef ELK_PRES_E00_126
		beq	L8090			; branch always taken - check remainder of ROMs
.else
		beq	L8093			; branch always taken - disable 1.2x
.endif

;;
.ifdef ELK_PRES_E00_126
; OSBYTE &5A/X=250
L80A8:		jmp	L81EE
.endif

;;
osbyte_5A_handler:
L80A7:
		stx	saveX			; Save X and Y
		sty	saveY
		ldx	$F0			; X from OSBYTE call
		cpx	#$FC			; First check OSBYTE X=252
		beq	L80E5			; (regardless of whether we've been disabled)

		ldx	ZP_MOS_CURROM		; Not X=252 - check if we're disabled
		lda	SYSVARS_DF0_PWSKPTAB,x
		bpl	L80C3			; disabled (bit7 on library ROM)?
		ldx	saveX			; yes -> restore X, Y
		ldy	saveY
		lda	#$07
		rts				; and restore call number A=7

L80C3:		ldx	$F0			; Not disabled - check other calls
		cpx	#$FF			; OSBYTE X=255?
		beq	L8052
		cpx	#$FE			; OSBYTE X=254?
		beq	L805A
		cpx	#$FD			; OSBYTE X=253?
		beq	L8070
.ifdef ELK_PRES_E00_126
		; New calls
		cpx	#$FB			; OSBYTE X=251?
		beq	L811A
		cpx	#$FA			; OSBYTE X=250?
		beq	L80A8
.endif
		cpx	#$14			; number of modules
		bcc	PageInModule		; X<$14 -> L810E

		; Bad module number error
		pla				; discard return address
		pla				; from stack
		; should probably be ldx #(end_r100 - start_r100)
		; - otherwise need to check this is enough bytes
		ldx	#$1E
L80D9:		lda	L80FA,x			; copy code down to $100
		sta	$100,x			; to execute BRK
		dex
		bpl	L80D9			; loop
		jmp	$100			; run it

; handler for OSBYTE A=&5A, X=252 (&FC)
L80E5:		ldx	$0DCE
		lda	#$FF
		sta	SYSVARS_DF0_PWSKPTAB,x
		ldx	ZP_MOS_CURROM
		lda	#$00
		sta	SYSVARS_DF0_PWSKPTAB - 1,x
		sta	SYSVARS_DF0_PWSKPTAB,x
		jmp	($FFFC)			; reset vector

;;; *** Copied down to $100 and run there ***
L80FA:
;.org $100
start_r100:
		brk
		.byte $00
		.byte "Bad Module number", 0
end_r100:
;.reloc

.ifdef ELK_PRES_E00_126
; OSBYTE &5A/X=251
; Initialize AQR
L811A:		jsr	loadModA5		; Copy module at A500->A7FF down to F00
		jsr	starAQR_run
		jsr	restoreE00
		jmp	L8172
.endif

;; Module paging in routine
; (OSBYTE A=&5A, X=20, Y=main ROM number)
; This code copies 3 pages from the library ROM into 
; $AE00->$B0FF in the main ROM by doing the following:
; 1. Save existing contents of E00->11FF into the library ROM at BC00->BFFF
; 2. Copy a relocation routine from the library ROM down to E00
; 3. Copy the 3 pages from the library ROM down to F00->11FF
; 4. Run the relocation routine at E00 which:
;    a. Selects the main ROM
;    b. Copies 3 pages from F00->11FF up to AE00->B0FF
;    c. Switches back to the library ROM and returns
;
; Entered with x a "module number", which indexes into the table at L802D
; $F1 (MOS saved Y register from OSBYTE) must contain ROM number of the main ROM

PageInModule:
L810E:		; Update the code below to get the right 3 pages
		; Load first page from module table at &802D
		lda	ModuleTable,x		; table of page numbers to copy
		sta	L813D+2			; $xx00 (first page)
		tax
		inx
		stx	L8143+2			; $xx00 (second page)
		inx
		stx	L8149+2			; $xx00 (third page)

		; Save a copy of E00->11FF first
		ldx	#$00			; loop over $100 bytes
.ifdef ELK_PRES_E00_126
		; Ensure low bytes all start at zero
		stx	L813D+1
		stx	L8143+1
		stx	L8149+1
		jsr	L819A
		jsr	$0E00
		jsr	restoreE00		; L81D0
servExit:
L8172:		ldx	saveX
		ldy	saveY
		jmp	L8000
.endif

.ifdef ELK_PRES_E00_126
.segment "rom_main_lib_2"
;; Copy module at A500->A7FF down to F00
loadModA5:
L8182:		ldx	#$00
		stx	L813D+1
		stx	L8143+1
		stx	L8149+1
		ldx	#$A5
		stx	L813D+2
		inx
		stx	L8143+2
		inx
		stx	L8149+2
		; fall through
.endif

;; Save E00->11FF into BC00->BFFF, copy down L817B routine to E00->EFF and
;;  module (prev setup by saving locations into L813D/L8143/L8149) to
;;  F00->11FF
.ifdef ELK_PRES_E00_126
L819A:		ldx	#$00
		; fall through
.endif

L811F:		lda	$0E00,x			; Save E00->11FF
		sta	$BC00,x			; in BC00->BFFF
		lda	$0F00,x
		sta	$BD00,x
		lda	$1000,x
		sta	$BE00,x
		lda	$1100,x
		sta	$BF00,x

		; Next
		lda	L817B,x			; Copy L817B down to E00
		sta	$0E00,x			; (this is the initial routine)
		; 3 pages used for the subsequent routine
.ifdef ELK_PRES_E00_331
L813D:		lda	$9F00,x			; $9F00 is replaced with $xx00
.elseif .def(ELK_PRES_E00_126)
L813D:		lda	$FF00,x			; $FF00 is replaced with $xx00
.else
L813D:		lda	$9C00,x			; $9C00 is replaced with $xx00
.endif
		sta	$0F00,x
.ifdef ELK_PRES_E00_331
L8143:		lda	$A000,x			; $A000 -> $xx00
.elseif .def(ELK_PRES_E00_126)
L8143:		lda	$FF00,x			; $FF00 -> $xx00
.else
L8143:		lda	$9D00,x			; $9D00 -> $xx00
.endif
		sta	$1000,x
.ifdef ELK_PRES_E00_331
L8149:		lda	$A100,x			; $A100 -> $xx00
.elseif .def(ELK_PRES_E00_126)
L8149:		lda	$FF00,x			; $FF00 -> $xx00
.else
L8149:		lda	$9E00,x			; $9E00 -> $xx00
.endif
		sta	$1100,x
		dex				; loop
		bne	L811F
.ifdef ELK_PRES_E00_126
		rts
.else
		jsr	L817B_run		; ($0E00) run the routine
		; fall through
.endif

		; restore $E00->$11FF
restoreE00:	ldx	#$00
L8157:		lda	$BC00,x
		sta	$0E00,x
		lda	$BD00,x
		sta	$0F00,x
		lda	$BE00,x
		sta	$1000,x
		lda	$BF00,x
		sta	$1100,x
		dex
		bne	L8157			; loop
.ifdef ELK_PRES_E00_126
		rts

.ifdef ELK_PRES_E00_330
;; Handler for service call &10 (*SPOOL/*EXEC about to close)
L81FF:		; do the same as OSBYTE &5A/X=250
.endif

;; Handler for OSBYTE &5A/X=250
; Copy routine at L8219 down to F00 then run it
L81EE:		ldx	#<L8219			; $19
		stx	L813D+1
		stx	L8143+1
		stx	L8149+1
		ldy	#>L8219			; $82
		sty	L813D+2
		iny
		sty	L8143+2
		iny
		sty	L8149+2
		jsr	L819A			; copy it down to F00
		jsr	L8219_run		; $0F00
		cmp	#$FF			; returned FF? -> claim and return
		beq	L8213			; -> otherwise, reset
.ifndef ELK_PRES_E00_330
		jmp	($FFFC)			; reset vector
.endif

L8213:		jsr	restoreE00		; L81D0
		jmp	L8172			; claim call and return
.else ; ELK_PRES_E00_126
; (falls through from end of restoreE00)
L8172:		ldx	saveX			; restore X
		ldy	saveY			; restore Y
		jmp	L8000			; return A=0 (claim call)
.endif

;;; Runs at E00
.segment "E00_libcopy"
;L817B:
L817B = __E00_libcopy_LOAD__
L817B_run:
		lda	ZP_MOS_CURROM		; Save library ROM number on stack
		pha
		lda	$F1			; Y from OSBYTE call
		sta	ZP_MOS_CURROM
		sta	ROMSEL			; ROMSEL register
		ldx	#$00
L8187:		lda	$0F00,x			; copy pages from F00 up to AE00
		sta	$AE00,x
		lda	$1000,x
		sta	$AF00,x
		lda	$1100,x
		sta	$B000,x
		dex				; loop
		bne	L8187
		lda	WKSP_ADFS_CUR_E00_MODULE ; flag is bit 7
		and	#$7F			; clear it to signal OK
		sta	WKSP_ADFS_CUR_E00_MODULE
		pla				; Restore library ROM
		sta	ZP_MOS_CURROM
		sta	ROMSEL
		rts

.ifdef ELK_PRES_E00_126
.segment "F00_libcopy"
;; routine runs at F00
;L8219:
L8219 = __F00_libcopy_LOAD__

;; routine for OSBYTE A=&5A/X=250 (kill Acorn ADFS 1.00 and reset if it was active)
L8219_run:
		php
		sei
		;; Look for the Acorn ADFS ROM
		ldy	ZP_MOS_CURROM		; save current ROM
L821E:		ldx	#$0F			; check ROMS from 15 down
L821F:		jsr	selectROM		; $F46
		; Check for "Acorn ADFS" string at $8009
		lda	$8009
		cmp	#'A'			; $41
		bne	L823E
		lda	$800D
		cmp	#'n'			; $6E
		bne	L823E
		lda	$800F
		cmp	#'A'			; $41
		bne	L823E
		lda	$8012
		cmp	#'S'			; $53
		beq	L824A			; got it
		; otherwise, check the next ROM
L823E:		dex
		bpl	L821F
L8241:		tya				; checked them all, didn't find it
		tax				; restore the original ROM
		jsr	L825F			;$F46
L8246:		lda	#$FF			; and return &FF (failed)
						; (NB if we previously found Acorn ADFS
		plp				; then this will return that ROM #
		rts				; instead of &FF)

		; found the Acorn ADFS ROM - ROM # is in X
L824A:		lda	SYSVARS_DF0_PWSKPTAB,x	; status
		cmp	#$FF
		beq	L823E			; Already killed. Try next ROM
		cmp	#$BF
		beq	L823E			; Already killed. Try next ROM
		lda	#$FF			; Kill it
		sta	SYSVARS_DF0_PWSKPTAB,x
		stx	L8246+1			;($F2E) ROM# is value to return in A
		bne	L8241			; branch always taken

		; Select ROM in X
selectROM:
L825F:		stx	L8267+1			;($F4F) save into code selecting which ROM
.ifdef ELK_PRES_E00_330
		ldx	#$0C			; switch out to high ROM first
.else
		ldx	#$0F			; switch out to high ROM first
.endif
		jsr	L8269			;$F50
L8267:		ldx	#$00			; now switch in our ROM
L8269:		stx	ROMSEL
		stx	ZP_MOS_CURROM
		rts
.endif

.ifndef ELK_PRES_E00_126
; empty segment
.segment "rom_main_lib_2"
; empty segment
.segment "F00_libcopy"
.endif

.ifdef ELK_PRES_E00_126
saveA = $83FF
saveX = $83FE
saveY = $83FD
.else
saveA = $8200					; Location for saved A
saveX = $8201					; Location for saved X
saveY = $8202					; Location for saved Y
.endif
