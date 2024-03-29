BUILDDIR=build


AS=beebasm
ASFLAGS=
DA65=da65
ROMS=$(addprefix $(BUILDDIR)/, \
	masIDE.rom \
	masMMC_hog_SD.rom \
	masMMC_hog_SDT.rom \
	masMMC_hog_SD2.rom \
	masMMC_hog_SD2T.rom \
	masMMC_hog_SD3.rom \
	masMMC_hog_SD3T.rom \
	masBM_XDFS.rom \
	masSCSI.rom \
	bbcSCSI.rom \
	bbcSCSI_AH.rom \
	bbcIDE.rom \
	elkIDE.rom \
	elkSCSI.rom \
	bbcSCS2.rom \
	bbcIDEF.rom \
	)

TARGETS = $(BUILDDIR)/ $(ROMS) $(BUILDDIR)/adfsroms.ssd
# this is used when generating symbols
ROMNO=D

IDE_DRIVERS=	IDE_Driver.asm IDE_DriverBGET.asm IDE_DriverBPUT.asm IDE_DriverBGETBPUT.asm IDE_DriverSvc5.asm
IDE_DRIVERS_F=	IDE_Driver_Fast.asm IDE_DriverBGET.asm IDE_DriverBPUT.asm IDE_DriverBGETBPUT.asm IDE_DriverSvc5.asm
SCSI_DRIVERS=	SCSI_Driver.asm SCSI_DriverBGET.asm SCSI_DriverBPUT.asm SCSI_DriverBGETBPUT.asm SCSI_DriverSvc5.asm
SCSI2_DRIVERS=	SCSI2_Driver.asm SCSI2_DriverBGET.asm SCSI2_DriverBPUT.asm SCSI2_DriverBGETBPUT.asm SCSI2_DriverSvc5.asm
MMC_DRIVERS=	MMC_Driver.asm MMC_DriverBGET.asm MMC_DriverBPUT.asm MMC.asm MMC_UserPort.asm MMC_DriverBGETBPUT.asm MMC_DriverSvc5.asm
STARMAP=	starmap.asm
FLOPPY_DRIVERS= floppy_nmi_A.asm floppy_nmi_B.asm floppy_nmi_C.asm floppy_nmi_D.asm

TUBE_DRIVERS=	TubeCheckAddrAndClaim.asm TubeStartXfer.asm
.PHONY: all compares comparedirs


define exec
$(1)

endef

all:: $(TARGETS)

$(BUILDDIR)/adfsroms.ssd: $(ROMS)
	#dfs tool from https://github.com/dominicbeesley/dfs-0.4	
	dfs form -80 $@
	dfs title $@ "ADFS_DOB"
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS100" $@ $(BUILDDIR)/elkSCSI.rom
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS103" $@ $(BUILDDIR)/elkIDE.rom
#	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS107" $@ elkMMC.rom

	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS130" $@ $(BUILDDIR)/bbcSCSI.rom
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFSH30" $@ $(BUILDDIR)/bbcSCSI_AH.rom
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS133" $@ $(BUILDDIR)/bbcIDE.rom
#	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS137" $@ bbcMMC.rom
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS134" $@ $(BUILDDIR)/bbcSCS2.rom
	
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS150" $@ $(BUILDDIR)/masSCSI.rom
	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS153" $@ $(BUILDDIR)/masIDE.rom

	dfs add -l 0xFFFF8000 -e 0xFFFF8000 -f "ADFS13F" $@ $(BUILDDIR)/bbcIDEF.rom

	dfs read -w "*.*" -i -d ~/hostfs/roms65 $@


HOGLETORGS=$(addsuffix .da.s, $(addprefix compares/org/Hoglet15x/, $(notdir $(filter-out %.md, $(wildcard orgroms/Hoglet15x/*)))))

compares: all comparedirs \
	compares/org/masIDE.da.s \
	compares/org/masSCSI.da.s \
	compares/org/bbcIDE.da.s \
	compares/org/bbcSCSI.da.s \
	compares/org/elkIDE.da.s \
	compares/org/elkSCSI.da.s \
	compares/new/masIDE.da.s \
	compares/new/Hoglet15x/SD.da.s \
	compares/new/Hoglet15x/SDT.da.s \
	compares/new/Hoglet15x/SD2.da.s \
	compares/new/Hoglet15x/SD2T.da.s \
	compares/new/Hoglet15x/SD3.da.s \
	compares/new/Hoglet15x/SD3T.da.s \
	compares/new/Hoglet15x/ORIG.da.s \
	compares/new/Hoglet15x/IDE.da.s \
	compares/new/Hoglet15x/XDFS.da.s \
	compares/new/masSCSI.da.s \
	compares/new/bbcIDE.da.s \
	compares/new/bbcSCSI.da.s \
	compares/new/elkIDE.da.s \
	compares/new/elkSCSI.da.s \
	$(HOGLETORGS)

comparedirs:
	-mkdir -p compares
	-mkdir -p compares/org
	-mkdir -p compares/org/Hoglet15x
	-mkdir -p compares/new
	-mkdir -p compares/new/Hoglet15x

$(BUILDDIR)/:
	-mkdir -p $(BUILDDIR)

compares/org/Hoglet15x/%.da.s: orgroms/Hoglet15x/%
	$(DA65)  --cpu 65c02 --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@
compares/org/masIDE.da.s: orgroms/ADFS153
	$(DA65)  --cpu 65c02 --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@
compares/org/masSCSI.da.s: orgroms/ADFS150
	$(DA65)  --cpu 65c02 --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@
compares/org/bbcSCSI.da.s: orgroms/ADFS130
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@
compares/org/bbcIDE.da.s: orgroms/ADFS133
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@
compares/org/elkSCSI.da.s: orgroms/ADFS100
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@
compares/org/elkIDE.da.s: orgroms/ADFS103
	$(DA65) --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@

compares/new/mas%.da.s: $(BUILDDIR)/mas%.rom
	$(DA65)  --cpu 65c02 --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@
compares/new/bbc%.da.s: $(BUILDDIR)/bbc%.rom
	$(DA65)  --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@
compares/new/elk%.da.s: $(BUILDDIR)/elk%.rom
	$(DA65)  --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@

compares/new/Hoglet15x/%.da.s:$(BUILDDIR)/masMMC_hog_%.rom
	$(DA65) --cpu 65c02 --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@

compares/new/Hoglet15x/%.da.s:$(BUILDDIR)/masBM_%.rom
	$(DA65) --cpu 65c02 --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@


#duplicates of our ROMS to compare against Hoglet's
compares/new/Hoglet15x/ORIG.da.s:compares/new/masSCSI.da.s
	cp $< $@
compares/new/Hoglet15x/IDE.da.s:compares/new/masIDE.da.s
	cp $< $@



$(BUILDDIR)/masIDE.rom: adfs.asm $(IDE_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
$(BUILDDIR)/masSCSI.rom: adfs.asm $(SCSI_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
$(BUILDDIR)/masMMC_hog_SD.rom: adfs.asm $(MMC_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) 
$(BUILDDIR)/masMMC_hog_SDT.rom: adfs.asm $(MMC_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) 
$(BUILDDIR)/masMMC_hog_SD2.rom: adfs.asm $(MMC_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) 
$(BUILDDIR)/masMMC_hog_SD2T.rom: adfs.asm $(MMC_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) 
$(BUILDDIR)/masMMC_hog_SD3.rom: adfs.asm $(MMC_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) 
$(BUILDDIR)/masMMC_hog_SD3T.rom: adfs.asm $(MMC_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) 
$(BUILDDIR)/masBM_XDFS.rom: adfs.asm $(SCSI_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
$(BUILDDIR)/bbcIDE.rom: adfs.asm $(IDE_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
$(BUILDDIR)/bbcIDEF.rom: adfs.asm $(IDE_DRIVERS_F) $(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
$(BUILDDIR)/bbcSCSI.rom: adfs.asm $(SCSI_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
$(BUILDDIR)/bbcSCSI_AH.rom: adfs.asm $(SCSI_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
$(BUILDDIR)/bbcSCS2.rom: adfs.asm $(SCSI2_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
$(BUILDDIR)/elkIDE.rom: adfs.asm $(IDE_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
$(BUILDDIR)/elkSCSI.rom: adfs.asm $(SCSI_DRIVERS) $(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)



$(BUILDDIR)/%.rom $(BUILDDIR)/%.lst: %.asm 
		$(AS) $(ASFLAGS) $(ASFLAGS2) -i $< -o $@ -v -d > $(basename $@).lst
		scripts/beebasmlst2sym.pl -r $(ROMNO) <$(basename $@).lst >$(basename $@).noi
clean::
	-rm $(BUILDDIR)/*.rom
	-rm $(BUILDDIR)/*.lst
	-rm $(BUILDDIR)/*.noi
	-rm compares/org/*.da.s
	-rm compares/org/Hoglet15x/*.da.s
	-rm compares/new/*.da.s
	-rm compares/new/Hoglet15x/*.da.s
	-rm $(BUILDDIR)/*.ssd
