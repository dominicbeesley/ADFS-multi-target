DA65=da65
BUILDDIR=build


ROMNAMES= 	masIDE \
		masMMC_hog_SD \
		masMMC_hog_SDT \
		masMMC_hog_SD2 \
		masMMC_hog_SD2T \
		masMMC_hog_SD3 \
		masMMC_hog_SD3T \
		masBM_XDFS \
		masSCSI \
		bbcSCSI \
		bbcSCSI_AH \
		bbcIDE \
		elkIDE \
		elkSCSI \
		bbcSCS2 \
		bbcIDEF \
		bbcIDE_hog \
		bbcIDE_hog_JGH_133r23 \
		bbcIDE_hog_DC


ROMS=$(addsuffix .rom, $(addprefix $(BUILDDIR)/, $(ROMNAMES)))

TARGETS = $(BUILDDIR)/ $(ROMS) $(BUILDDIR)/adfsroms.ssd

all:: roms ssd compares

roms: $(ROMS)

.PHONY: FORCE

$(BUILDDIR)/%.rom: FORCE
	make -C src ROMNAME=${*}

ssd: roms $(BUILDDIR)/adfsroms.ssd

$(BUILDDIR)/adfsroms.ssd:
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


HOG15x_ORGS=$(addsuffix .da.s, $(addprefix compares/org/Hoglet15x/, $(notdir $(filter-out %.md, $(wildcard orgroms/Hoglet15x/*)))))
HOG13x_ORGS=$(addsuffix .da.s, $(addprefix compares/org/Hoglet13x/, $(notdir $(basename $(wildcard orgroms/Hoglet13x/*.rom)))))

COMPARES=	compares/org/masIDE.da.s \
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
	$(HOG15x_ORGS) \
	$(HOG13x_ORGS) \
	compares/new/Hoglet13x/ADFS130.da.s \
	compares/new/Hoglet13x/ADFS133.da.s \
	compares/new/Hoglet13x/DC133.da.s \
	compares/new/Hoglet13x/JGH133.da.s \
	compares/new/Hoglet13x/ELK100.da.s \
	compares/new/Hoglet13x/ELK103.da.s \


compares: roms comparedirs $(COMPARES)

comparedirs:
	-mkdir -p compares
	-mkdir -p compares/org
	-mkdir -p compares/org/Hoglet15x
	-mkdir -p compares/org/Hoglet13x
	-mkdir -p compares/new
	-mkdir -p compares/new/Hoglet15x
	-mkdir -p compares/new/Hoglet13x

compares/org/Hoglet13x/%.da.s: orgroms/Hoglet13x/%.rom
	$(DA65)  --comments 4 --start-addr 0x8000 $< >$@
	sed -i 1,4d $@
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

compares/new/Hoglet13x/ADFS130.da.s:compares/new/bbcSCSI.da.s
	cp $< $@
compares/new/Hoglet13x/ADFS133.da.s:compares/new/bbcIDE_hog.da.s
	cp $< $@
compares/new/Hoglet13x/JGH133.da.s:compares/new/bbcIDE_hog_JGH_133r23.da.s
	cp $< $@
compares/new/Hoglet13x/DC133.da.s:compares/new/bbcIDE_hog_DC.da.s
	cp $< $@
compares/new/Hoglet13x/ELK100.da.s:compares/new/elkSCSI.da.s
	cp $< $@
compares/new/Hoglet13x/ELK103.da.s:compares/new/elkIDE.da.s
	cp $< $@


clean: $(addprefix clean-, $(ROMNAMES))
	-rm $(COMPARES)
	-rm $(BUILDDIR)/adfsroms.ssd

clean-%:
	make -C src clean ROMNAME=${*}	