@echo off
REM Build with Windows GUI subsystem (no console window)

echo Building GUI version without console...
echo.

.\nasm.exe -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

echo Linking as pure Windows GUI application...
.\golink.exe /entry _start output.obj kernel32.dll user32.dll advapi32.dll wininet.dll crypt32.dll

if exist output.exe (
    echo.
    echo SUCCESS! Created: output.exe
    echo This version will show MessageBoxes without a console window.
    echo.
) else (
    echo ERROR: Build failed!
)

pause
