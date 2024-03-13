# ADFS-multi-target
 Acorn ADFS built for BBC/ELK/MAS SCSI/SCSI2/IDE/MMC

 This is an attempt to make a single-source ADFS. It is by no means finished and any suggestions / pull requests
 will be welcome.

 The existing versions of ADFS listed below should be produced byte-perfectly and the Makefile has a target for producing comparison disassemblies to compare against original roms (included in the orgroms folder):


## ROMS from MDFS.net

The following ROMS were taken from MDFS.net on the dates noted. The 157 (MMC) ROM on MDFS.net seems to have 
further optimisations that are not covered as there appear to be bugs present. The current 157 is taken from
Hoglet's repo.

The original binaries for these ROMs are in /src/orgroms

| Machine       | ROM #         | HD    | Builds| Cmp   | Notes
|---------------|---------------|-------|-------|-------|---------
| Electron      | 100[^1]       | SCSI  | Y     | Y     |
|               | 103[^1]       | IDE   | Y     | Y     |
| BBC B/+       | 130[^1]       | SCSI  | Y     | Y     |
|               | 133[^2]       | IDE   | Y     | Y     |
| Master        | 150[^1]       | SCSI  | Y     | Y     |
|               | 153[^1]       | IDE   | Y     | Y     |
| Master 3.50   | 203[^1]       | SCSI  | N     |       | Rom not tested

[^1] The roms above were downloaded from mdfs.net on 17 Feb 2021
[^2] The roms above were downloaded from mdfs.net on 8  Mar 2024

## ROMS from Hoglet's 157 repo

These roms were taken from Hoglet's "[ADFS](https://github.com/hoglet67/ADFS)" repo on [82c7b3b](https://github.com/hoglet67/ADFS/commit/82c7b3bebc43ed34d7e7975214bbf2ab0b6adb73). 

These ROM represent the original Master 150 ADFS ROM and a set of ROMs containing modifications for different
IDE, MMC, Internal VFS port devices 

|File   | Port                                          |Turbo  |Floppy |Address|Builds | Cmp
|-------|-----------------------------------------------|-------|-------|-------|-------|--------
|SD     | User port                                     |  N    |  N    | FE60  |   Y   |  Y
|SDT    | User port                                     |  Y    |  N    | FE60  |   Y   |  Y
|SD2    | Internal[^1] user port                        |  N    |  N    | FE80  |   Y   |  Y
|SD2T   | Internal[^1] user port                        |  Y    |  N    | FE80  |   Y   |  Y
|SD3    | Econet user port                              |  N    |  N    | FEA0  |   Y   |  Y
|SD3T   | Econet user port                              |  Y    |  N    | FEA0  |   Y   |  Y
|ORIG   | Original ADFS 150 SCSI + Floppy               |  -    |  Y    | FC40  |   Y   |  Y
|MM     | Memory mapped SPI port for BeebFPGA           |  -    |  ?    | FEDC  |   N   |  
|IDE    | IDE Patched ADFS e.g. for DataCentre / JGH?   |  -    |  Y    | FC40  |   Y   |  N[^3]
|IDE2   | IDE Test version[^2]                          |  -    |  Y    | FC40  |   N   |  
|IDFS   | Internal[^1] VFS SCSI                         |  0    |  N    | FE8x  |   N   |  
|XDFS   | Second external at VFS address                |  -    |  N    | FC44  |   Y   |  Y

[^1]: Master internal port for VFS boards
[^2]: Code shifted along by one byte, to try to validate referenced are still correct
[^3]: The code in Hoglet's repo appears to be behind MDFS.net - testing and rationalisation required

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


