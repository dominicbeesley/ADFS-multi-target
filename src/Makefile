AS=beebasm
ASFLAGS=
DA65=da65 --cpu 65c02
ROMS=masIDE.rom masMMC.rom masSCSI.rom bbcSCSI.rom bbcIDE.rom elkIDE.rom  bbcSCS2.rom bbcIDEF.rom
TARGETS = $(ROMS) adfsroms.ssd
# this is used when generating symbols
ROMNO=E

IDE_DRIVERS=	IDE_Driver.asm IDE_DriverBGET.asm IDE_DriverBPUT.asm IDE_DriverBGETBPUT.asm IDE_DriverSvc5.asm
IDE_DRIVERS_F=	IDE_Driver_Fast.asm IDE_DriverBGET.asm IDE_DriverBPUT.asm IDE_DriverBGETBPUT.asm IDE_DriverSvc5.asm
SCSI_DRIVERS=	SCSI_Driver.asm SCSI_DriverBGET.asm SCSI_DriverBPUT.asm SCSI_DriverBGETBPUT.asm SCSI_DriverSvc5.asm
SCSI2_DRIVERS=	SCSI2_Driver.asm SCSI2_DriverBGET.asm SCSI2_DriverBPUT.asm SCSI2_DriverBGETBPUT.asm SCSI2_DriverSvc5.asm
MMC_DRIVERS=	MMC_Driver.asm MMC_DriverBGET.asm MMC_DriverBPUT.asm MMC.asm MMC_UserPort.asm MMC_DriverBGETBPUT.asm MMC_DriverSvc5.asm

TUBE_DRIVERS=	TubeCheckAddrAndClaim.asm TubeStartXfer.asm
.PHONY: all compares comparedirs

define exec
$(1)

endef

all:: $(TARGETS)

adfsroms.ssd: $(ROMS)
	#dfs tool from https://github.com/dominicbeesley/dfs-0.4	
	dfs form -80 adfsroms.ssd
	dfs title adfsroms.ssd "ADFS_DOB"
#	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS100" adfsroms.ssd elkSCSI.rom
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS103" adfsroms.ssd elkIDE.rom
#	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS107" adfsroms.ssd elkMMC.rom

	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS130" adfsroms.ssd bbcSCSI.rom
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS133" adfsroms.ssd bbcIDE.rom
#	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS137" adfsroms.ssd bbcMMC.rom
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS134" adfsroms.ssd bbcSCS2.rom
	
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS150" adfsroms.ssd masSCSI.rom
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS153" adfsroms.ssd masIDE.rom
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS157" adfsroms.ssd masMMC.rom

	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS13F" adfsroms.ssd bbcIDEF.rom

	dfs read -w "*.*" -i -d ~/hostfs/roms65 adfsroms.ssd


compares: all comparedirs \
	compares/org/masIDE.da.s \
	compares/org/masMMC.da.s \
	compares/org/masSCSI.da.s \
	compares/org/bbcIDE.da.s \
	compares/org/bbcSCSI.da.s \
	compares/org/elkIDE.da.s \
	compares/new/masIDE.da.s \
	compares/new/masMMC.da.s \
	compares/new/masSCSI.da.s \
	compares/new/bbcIDE.da.s \
	compares/new/bbcSCSI.da.s \
	compares/new/elkIDE.da.s


comparedirs:
	-mkdir -p compares
	-mkdir -p compares/org
	-mkdir -p compares/new

compares/org/masIDE.da.s: ../orgroms/adfs153.rom
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@
compares/org/masMMC.da.s: ../orgroms/adfs157.rom
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@
compares/org/masSCSI.da.s: ../orgroms/adfs150.rom
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@
compares/org/bbcSCSI.da.s: ../orgroms/ADFS130
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@
compares/org/bbcIDE.da.s: ../orgroms/ADFS133
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@
compares/org/elkIDE.da.s: ../orgroms/ADFS103
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@

compares/new/%.da.s: %.rom
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@


masMMC.rom: adfs.asm $(MMC_DRIVERS) $(TUBE_DRIVERS)
bbcIDE.rom: adfs.asm $(IDE_DRIVERS) $(TUBE_DRIVERS)
bbcIDEF.rom: adfs.asm $(IDE_DRIVERS_F) $(TUBE_DRIVERS)
elkIDE.rom: adfs.asm $(IDE_DRIVERS) $(TUBE_DRIVERS)
masIDE.rom: adfs.asm $(IDE_DRIVERS) $(TUBE_DRIVERS)

bbcSCSI.rom: adfs.asm $(SCSI_DRIVERS) $(TUBE_DRIVERS)
masSCSI.rom: adfs.asm $(SCSI_DRIVERS) $(TUBE_DRIVERS)

bbcSCS2.rom: adfs.asm $(SCSI2_DRIVERS) $(TUBE_DRIVERS)

%.rom %.lst: %.asm 
		$(AS) -i $< -o $@ -v -d > $(basename $@).lst
		scripts/beebasmlst2sym.pl -r $(ROMNO) <$(basename $@).lst >$(basename $@).noi
clean::
	-rm *.rom
	-rm *.lst
	-rm compares/*.da.s
	-rm compares/org/*.da.s
	-rm compares/new/*.da.s
	-rm *.ssd
	-rm *.noi
