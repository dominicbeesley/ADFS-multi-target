# Hoglet's Master 157 ROMs

These files taken from https://github.com/hoglet67/ADFS.git : 82c7b3bebc43ed34d7e7975214bbf2ab0b6adb73

|FILE	| Port						|TURBO	|FLOPPY	|ADDRESS|
|SD	| User port					|  N	|  N   	| FE60  |
|SDT	| User port					|  Y 	|  N   	| FE60	|
|SD2	| Internal[^1] user port			|  N 	|  N    | FE80  |
|SD2T	| Internal[^1] user port			|  Y 	|  N    | FE80  |
|SD3	| Econet user port 				|  N	|  N    | FEA0	|
|SD3T	| Econet user port 				|  Y	|  N    | FEA0	|
|ORIG	| Original ADFS 150 SCSI + Floppy		|  -	|  Y    | FC40  |
|MM	| Memory mapped SPI port for BeebFPGA 		|  -    |  ?    | FEDC  |
|IDE	| IDE Patched ADFS e.g. for DataCentre / JGH?	|  -    |  Y    | FC40 	|
|IDE2	| IDE Test version[^2]				|  - 	|  Y    | FC40	|
|IDFS	| Internal[^1] VFS SCSI				|  0    |  N	| FE8x  |
|XDFS	| Second external SCSI provided by hacked Pi1MHz|  -	|  N    | FC44  |

[^1]: Master internal port for VFS boards
[^2]: Code shifted along by one byte, to try to validate referenced are still correct