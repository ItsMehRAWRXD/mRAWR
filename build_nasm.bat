@echo off
REM Build script for NASM version of the weaponized assembly code (Windows)

echo ==================================
echo MASM 2035 NASM Build Script
echo ==================================
echo.

REM Check if NASM is installed
where nasm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: NASM is not installed!
    echo Please install NASM from: https://www.nasm.us/
    echo Or use: choco install nasm
    exit /b 1
)

REM Check if MinGW GCC is available
where gcc >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: MinGW GCC is not installed!
    echo Please install MinGW from: https://www.mingw-w64.org/
    echo Or use: choco install mingw
    exit /b 1
)

echo [1/3] Assembling with NASM...
nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Assembly failed!
    exit /b 1
)

echo [2/3] Linking with MinGW...
gcc -m32 output.obj -o MASM_2035_Weaponized.exe ^
    -lkernel32 ^
    -luser32 ^
    -ladvapi32 ^
    -lwininet ^
    -lcrypt32 ^
    -s

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Linking failed!
    exit /b 1
)

echo [3/3] Cleaning up...
del output.obj

echo.
echo ==================================
echo BUILD SUCCESSFUL!
echo Output: MASM_2035_Weaponized.exe
echo ==================================
echo.
echo WARNING: This executable contains security exploits.
echo          Only run in authorized, isolated environments.

pause
