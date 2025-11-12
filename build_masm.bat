@echo off
REM Build script for MASM 2035 Weaponized Framework
REM Requires Microsoft Macro Assembler (ml.exe) from Visual Studio or Windows SDK

echo Building MASM 2035 Weaponized Framework...

REM Check if ml.exe is available
where ml.exe >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: ml.exe not found!
    echo Please install Visual Studio or Windows SDK with MASM support
    echo Or use MASM32 SDK from http://www.masm32.com/
    pause
    exit /b 1
)

REM Assemble the source file
ml.exe /c /coff /Cp MASM_2035_Weaponized_Complete..asm
if %ERRORLEVEL% NEQ 0 (
    echo Assembly failed!
    pause
    exit /b 1
)

REM Link the object file
link.exe /subsystem:console /entry:start MASM_2035_Weaponized_Complete..obj kernel32.lib user32.lib wininet.lib advapi32.lib
if %ERRORLEVEL% NEQ 0 (
    echo Linking failed!
    pause
    exit /b 1
)

echo Build successful!
echo Output: MASM_2035_Weaponized_Complete..exe
pause
