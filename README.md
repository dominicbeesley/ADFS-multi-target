# ADFS-multi-target
 Acorn ADFS built for BBC/ELK/MAS SCSI/SCSI2/IDE/MMC

 This is an attempt to make a single-source ADFS. It is by no means finished and any suggestions / pull requests
 will be welcome.

 The existing versions of ADFS listed below should be produced byte-perfectly and the Makefile has a target for producing comparison disassemblies to compare against original roms (included in the orgroms folder):


| Machine	| ROM # | HD    | Builds| Cmp   | Notes
|---------------|-------|-------|-------|-------|---------
| Electron      | 100   | SCSI  | Y     | Y     |
|               | 103   | IDE   | Y     | Y     |
|               | 107   | MMC   | N     |       | 
| BBC B/+       | 130   | SCSI  | Y     | Y     |
|               | 133   | IDE   | Y     | Y     |
|               | 137   | MMC   | N     |       | 
| Master        | 150   | SCSI  | Y     | Y     |
|               | 153   | IDE   | Y     | Y     |
|               | 157   | MMC   | Y     | Y+    | WARNING: this version appears to currently be broken!
| Master 3.50   | 203   | SCSI  | N     |       | Rom not tested


* The roms above were downloaded from mdfs.net on 17 Feb 2021
+ The Master MMC ROM has some differences (see below)


# New builds

## SCSI2 
This is a build for an experimental SCSI board using a Zilog Z53C series controller. 

## IDE Fast

This is an experimental build to create a faster IDE FS - especially for use with the PiTubeDirect

- sector transfers are not repeated (this was added to overcome difficulties in earlier patching)
- the status byte is not checked before each byte transferred (this is unnecessary)
- tube transfer use the tube FIFO full flags rather than the 24us delay (this may cause problems on real ULAs)

In initial testing this provides a x10 speed increase. 

This is a pre-alpha experiment and should NOT be used on any drives containing precious data! 

So far this has only been tested on a DataCentre IDE adaptor with a Compact Flash card. 


# Tools required

[BeebAsm](https://github.com/stardot/beebasm)

[dfs](https://github.com/dominicbeesley/dfs-0.4)

[da65](https://cc65.github.io/doc/da65.html) - needed for comparisons

perl 5.0 - for extracting symbols



# TODO / Not attempted / No roms available to test against

- Master Compact
- Electron PRES 1.15
- Electron MMC 1.07
- BBC MMC 1.37
- Master has suspect WaitForData for MMC?!?!
- Master MMC series of suspect nops replacing dead code?
- Floppy NMI code might be simplified
- Electron floppy NMI code contains a large glob or raw disassembly


