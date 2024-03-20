BUILDDIR=../build
SCRIPTS=../scripts

AS=ca65
ASFLAGS=-g --relax-checks --auto-import
LD=ld65
LDFLAGS=
DA65=da65
DBGSYMS=$(SCRIPTS)/ld65debugsymbols.pl

# this is used when generating symbols
ROMNO=1

ADFS=			adfs
IDE_DRIVERS=		IDE_Driver IDE_DriverBGET IDE_DriverBPUT IDE_DriverBGETBPUT IDE_DriverSvc5
IDE_DRIVERS_F=		IDE_Driver_Fast IDE_DriverBGET IDE_DriverBPUT IDE_DriverBGETBPUT IDE_DriverSvc5
SCSI_DRIVERS=		SCSI_Driver SCSI_DriverBGET SCSI_DriverBPUT SCSI_DriverBGETBPUT SCSI_DriverSvc5
SCSI2_DRIVERS=		SCSI2_Driver SCSI2_DriverBGET SCSI2_DriverBPUT SCSI2_DriverBGETBPUT SCSI2_DriverSvc5
MMC_DRIVERS=		MMC_Driver MMC_DriverBGET MMC_DriverBPUT MMC MMC_UserPort MMC_DriverBGETBPUT MMC_DriverSvc5
STARMAP=		starmap
FLOPPY_DRIVERS= 	floppy floppy_nmi_A floppy_nmi_B floppy_nmi_C floppy_nmi_D
FLOPPY_DRIVERS_ELK= 	floppy floppy_elk floppy_nmi_A floppy_nmi_D
TUBE_DRIVERS=		TubeCheckAddrAndClaim TubeStartXfer

.PHONY: all compares comparedirs

all:: ensure-ROMNAME dir-${ROMNAME} $(BUILDDIR)/$(ROMNAME).rom $(BUILDDIR)/$(ROMNAME).noi

ensure-%:
	@ if [ "${${*}}" = "" ]; then \
        	echo "Environment variable $* not set"; \
        	exit 1; \
    	fi

dir-%:
	$(shell mkdir -p $(BUILDDIR))
	$(shell mkdir -p $(addprefix $(BUILDDIR)/, ${*}))


OBJS_masIDE= 		$(ADFS) $(IDE_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS) 
OBJS_masSCSI=   	$(ADFS) $(SCSI_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
OBJS_masMMC_hog_SD= 	$(ADFS) $(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) 
OBJS_masMMC_hog_SDT= 	$(ADFS) $(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP)
OBJS_masMMC_hog_SD2= 	$(ADFS) $(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) 
OBJS_masMMC_hog_SD2T= 	$(ADFS) $(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) 
OBJS_masMMC_hog_SD3= 	$(ADFS) $(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) 
OBJS_masMMC_hog_SD3T= 	$(ADFS) $(MMC_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) 
OBJS_masBM_XDFS= 	$(ADFS) $(SCSI_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
OBJS_bbcIDE= 		$(ADFS) $(IDE_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
OBJS_bbcIDE_hog=	$(ADFS) $(IDE_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
OBJS_bbcIDE_hog_JGH_133r23=$(ADFS) $(IDE_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
OBJS_bbcIDEF= 		$(ADFS) $(IDE_DRIVERS_F) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
OBJS_bbcSCSI= 		$(ADFS) $(SCSI_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
OBJS_bbcSCSI_AH=	$(ADFS) $(SCSI_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
OBJS_bbcSCS2= 		$(ADFS) $(SCSI2_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
OBJS_elkIDE=		$(ADFS) $(IDE_DRIVERS) 		$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS)
OBJS_elkSCSI= 		$(ADFS) $(SCSI_DRIVERS) 	$(TUBE_DRIVERS) $(STARMAP) $(FLOPPY_DRIVERS_ELK)

LINK_masIDE=		default
LINK_masSCSI=		default
LINK_bbcIDE=		default
LINK_bbcIDE_hog=	default
LINK_bbcIDE_hog_JGH_133r23=default
LINK_bbcIDEF=		default
LINK_bbcSCSI=		default
LINK_bbcSCSI_AH=	default
LINK_bbcSCS2=		default
LINK_elkIDE=		default
LINK_elkSCSI=		elkSCSI
LINK_masMMC_hog_SD=	masMMC_hog
LINK_masMMC_hog_SDT=	masMMC_hog
LINK_masMMC_hog_SD2=	masMMC_hog
LINK_masMMC_hog_SD2T=	masMMC_hog
LINK_masMMC_hog_SD3=	masMMC_hog
LINK_masMMC_hog_SD3T=	masMMC_hog
LINK_masBM_XDFS=	default

.PRECIOUS: $(addsuffix /config.inc, $(addprefix $(BUILDDIR)/, $(ROMNAMES)))

$(BUILDDIR)/%/config.inc: configs/%.inc
	cp $< $@

$(BUILDDIR)/$(ROMNAME)/%.o $(BUILDDIR)/$(ROMNAME)/%.lst: %.asm $(BUILDDIR)/$(ROMNAME)/config.inc
	$(AS) $(ASFLAGS) $(ASFLAGS2) -I $(BUILDDIR)/$(ROMNAME) -I includes $< -o $@ -v -l $(basename $@).lst

$(BUILDDIR)/%.rom $(BUILDDIR)/%.dbg: \
		$(addprefix $(BUILDDIR)/${ROMNAME}/, $(addsuffix .o, ${OBJS_${ROMNAME}})) \
		$(addprefix linkscripts/, $(addsuffix .lnk.cfg, ${LINK_${ROMNAME}}))
	$(LD) $(LDFLAGS) --dbgfile $(basename $@).dbg -C $(filter %.lnk.cfg, $^) -o $@ -m $(basename $@).map $(filter %.o, $^)
	$(SCRIPTS)/ca65lstupdate.pl $(basename $@).dbg $(BUILDDIR)/$(ROMNAME)

$(BUILDDIR)/%.noi: $(BUILDDIR)/%.dbg
	$(DBGSYMS) --romno "$(ROMNO)" $< $@

clean::
	-rm $(BUILDDIR)/*.rom
	-rm $(BUILDDIR)/*.map
	-rm $(BUILDDIR)/*.dbg
	-rm $(BUILDDIR)/*.noi
	-rm $(BUILDDIR)/config.inc
	-rm $(BUILDDIR)/$(ROMNAME)/*.lst
	-rm $(BUILDDIR)/$(ROMNAME)/*.lst.rel
	-rm $(BUILDDIR)/$(ROMNAME)/*.o
