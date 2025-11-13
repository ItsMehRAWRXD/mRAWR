@echo off
echo ====================================================
echo MASM 2035 Weaponized Framework - MinGW Build Script
echo ====================================================

REM Check if NASM is installed
where nasm >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: NASM not found! Please install NASM first.
    echo Download from: https://www.nasm.us/
    pause
    exit /b 1
)

REM Check if MinGW is available
where gcc >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: MinGW GCC not found! Please install MinGW-w64.
    pause
    exit /b 1
)

echo Building MASM 2035 Weaponized...

REM Assemble the ASM file to object
echo [1/3] Assembling with NASM...
nasm -f win32 "MASM_2035_Weaponized_Complete..asm" -o masm_2035_temp.o
if %errorlevel% neq 0 (
    echo ERROR: Assembly failed!
    pause
    exit /b 1
)

REM Link with MinGW
echo [2/3] Linking with MinGW...
gcc -m32 -o masm_2035_weaponized.exe masm_2035_temp.o -lkernel32 -luser32 -ladvapi32 -lshell32 -lwininet -lcrypt32 -lole32
if %errorlevel% neq 0 (
    echo ERROR: Linking failed!
    del masm_2035_temp.o 2>nul
    pause
    exit /b 1
)

REM Clean up temporary files
echo [3/3] Cleaning up...
del masm_2035_temp.o 2>nul

echo.
echo ====================================================
echo SUCCESS! Built: masm_2035_weaponized.exe
echo ====================================================
echo.
echo WARNING: This contains real exploits - use responsibly!
echo For authorized security testing only.
echo.
pause