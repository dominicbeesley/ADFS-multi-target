cd %0\..
H:\Apps\BeebAsm.exe -i masMMC.asm -o adfsMMC.rom -v > adfsMMC.lst
if ERRORLEVEL 1 pause
