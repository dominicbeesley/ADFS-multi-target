BUILDDIR=build
SCRIPTS=../scripts

AS=ca65
ASFLAGS=-g --relax-checks --auto-import
LD=ld65
LDFLAGS=
DA65=da65
ROMNAMES= 	masIDE \
		masMMC_hog_SD \
		masMMC_hog_SDT \
		masMMC_hog_SD2 \
		masMMC_hog_SD2T \
		masMMC_hog_SD3 \
		masMMC_hog_SD3T \
		masSCSI \
		bbcSCSI \
		bbcSCSI_AH \
		bbcIDE \
		elkIDE \
		elkSCSI \
		bbcSCS2 \
		bbcIDEF
ROMS=$(addsuffix .rom, $(addprefix $(BUILDDIR)/, $(ROMNAMES)))
DBGSYMS=$(SCRIPTS)/ld65debugsymbols.pl

##	masBM_XDFS.rom \


TARGETS = $(BUILDDIR)/ $(ROMS) $(BUILDDIR)/adfsroms.ssd
# this is used when generating symbols
ROMNO=D

IDE_DRIVERS=	IDE_Driver IDE_DriverBGET IDE_DriverBPUT IDE_DriverBGETBPUT IDE_DriverSvc5
IDE_DRIVERS_F=	IDE_Driver_Fast IDE_DriverBGET IDE_DriverBPUT IDE_DriverBGETBPUT IDE_DriverSvc5
SCSI_DRIVERS=	SCSI_Driver SCSI_DriverBGET SCSI_DriverBPUT SCSI_DriverBGETBPUT SCSI_DriverSvc5
SCSI2_DRIVERS=	SCSI2_Driver SCSI2_DriverBGET SCSI2_DriverBPUT SCSI2_DriverBGETBPUT SCSI2_DriverSvc5
MMC_DRIVERS=	MMC_Driver MMC_DriverBGET MMC_DriverBPUT MMC MMC_UserPort MMC_DriverBGETBPUT MMC_DriverSvc5
STARMAP=	starmap
FLOPPY_DRIVERS= floppy floppy_nmi_A floppy_nmi_B floppy_nmi_C floppy_nmi_D
TUBE_DRIVERS=	TubeCheckAddrAndClaim TubeStartXfer

.PHONY: all compares comparedirs


define exec
$(1)

endef

SS:=	$(shell mkdir -p $(BUILDDIR))
SS2:=	$(shell mkdir -p $(addprefix $(BUILDDIR)/, $(ROMNAMES)))


all:: $(TARGETS) $(addsuffix .noi, $(basename $(filter %.rom, $(TARGETS))))




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



$(BUILDDIR)/masIDE.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/masIDE/, adfs 	\
	$(IDE_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)))
$(BUILDDIR)/masSCSI.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/masSCSI/, adfs \
    $(SCSI_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)))
$(BUILDDIR)/masMMC_hog_SD.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/masMMC_hog_SD/, adfs \
	$(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) ))
$(BUILDDIR)/masMMC_hog_SDT.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/masMMC_hog_SDT/, adfs \
	$(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) ))
$(BUILDDIR)/masMMC_hog_SD2.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/masMMC_hog_SD2/, adfs \
	$(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) ))
$(BUILDDIR)/masMMC_hog_SD2T.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/masMMC_hog_SD2T/, adfs \
	$(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) ))
$(BUILDDIR)/masMMC_hog_SD3.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/masMMC_hog_SD3/, adfs \
	$(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) ))
$(BUILDDIR)/masMMC_hog_SD3T.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/masMMC_hog_SD3T/, adfs \
	$(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) ))
$(BUILDDIR)/masBM_XDFS.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/masBM_XDFS/, adfs \
	$(SCSI_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)))
$(BUILDDIR)/bbcIDE.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/bbcIDE/, adfs \
	$(IDE_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)))
$(BUILDDIR)/bbcIDEF.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/bbcIDEF/, adfs \
	$(IDE_DRIVERS_F) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)))
$(BUILDDIR)/bbcSCSI.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/bbcSCSI/, adfs \
	$(SCSI_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)))
$(BUILDDIR)/bbcSCSI_AH.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/bbcSCSI_AH/, adfs \
	$(SCSI_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)))
$(BUILDDIR)/bbcSCS2.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/bbcSCS2/, adfs \
	$(SCSI2_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)))
$(BUILDDIR)/elkIDE.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/elkIDE/, adfs \
	$(IDE_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)))
$(BUILDDIR)/elkSCSI.rom: $(addsuffix .o, $(addprefix $(BUILDDIR)/elkSCSI/, adfs \
	$(SCSI_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)))


.PRECIOUS: $(addsuffix /config.inc, $(addprefix $(BUILDDIR)/, $(ROMNAMES)))

$(BUILDDIR)/%/config.inc: configs/%.inc
	cp $< $@

$(BUILDDIR)/masIDE/%.o $(BUILDDIR)/masIDE/%.lst: %.asm $(BUILDDIR)/masIDE/config.inc
	$(AS) $(ASFLAGS) $(ASFLAGS2) -I $(BUILDDIR)/masIDE -I includes $< -o $@ -v -l $(basename $@).lst
	
$(BUILDDIR)/masIDE.rom $(BUILDDIR)/masIDE.dbg: rom.lnk.cfg
	$(LD) $(LDFLAGS) --dbgfile $(basename $@).dbg -C rom.lnk.cfg -o $@ $(filter %.o, $^)
	$(SCRIPTS)/ca65lstupdate.pl $(basename $@).dbg $(BUILDDIR)/masIDE

$(BUILDDIR)/%.noi: $(BUILDDIR)/%.dbg
	$(DBGSYMS) --romno "1" $< $@

clean::
	-rm $(BUILDDIR)/*.rom
	-rm $(BUILDDIR)/*.lst
	-rm $(BUILDDIR)/*.dbg
	-rm $(BUILDDIR)/*.noi
	-rm $(BUILDDIR)/*.o
	-rm compares/org/*.da.s
	-rm compares/org/Hoglet15x/*.da.s
	-rm compares/new/*.da.s
	-rm compares/new/Hoglet15x/*.da.s
	-rm $(BUILDDIR)/*.ssd
