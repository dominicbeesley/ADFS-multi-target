cd %0\..
H:\Apps\BeebAsm.exe -i bbcIDE.asm -o adfsIDE.rom -v > adfsIDE.lst
if ERRORLEVEL 1 pause
