@echo off
REM Build script for 64-bit architecture (matches your MinGW installation)

echo ==================================
echo MASM 2035 NASM 64-bit Build
echo ==================================
echo.

REM Check for NASM
where nasm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: NASM not found!
    pause
    exit /b 1
)

echo [1/3] Assembling with NASM (64-bit format)...
nasm -f win64 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Assembly failed!
    echo.
    echo The code may need adjustments for 64-bit.
    echo Trying alternative approach...
    echo.
    goto :try_nostdlib
)

echo [2/3] Linking with MinGW (64-bit)...
gcc output.obj -o MASM_2035_Weaponized.exe -lkernel32 -luser32 -ladvapi32 -lwininet -lcrypt32 -s

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Linking failed!
    echo Trying alternative linking method...
    goto :try_nostdlib
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
echo.
pause
exit /b 0

:try_nostdlib
echo.
echo ==================================
echo Trying direct linking method...
echo ==================================
echo.

echo [1/2] Assembling as 32-bit with proper entry point...
nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Assembly failed!
    pause
    exit /b 1
)

echo [2/2] Linking with explicit architecture...
gcc -m32 -nostdlib -Wl,--subsystem,console -Wl,--entry,_start output.obj -o MASM_2035_Weaponized.exe -lkernel32 -luser32 -ladvapi32 -lwininet -lcrypt32 2>nul

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ==================================
    echo ARCHITECTURE MISMATCH DETECTED
    echo ==================================
    echo.
    echo Your MinGW is 64-bit only, but the code is 32-bit.
    echo.
    echo SOLUTIONS:
    echo.
    echo 1. Use Microsoft Visual Studio linker instead:
    echo    - Open "Developer Command Prompt for VS"
    echo    - Run: build_msvc.bat
    echo.
    echo 2. The code needs to be converted to 64-bit:
    echo    - This requires significant changes to calling conventions
    echo    - 64-bit Windows uses different register usage
    echo.
    echo 3. Install 32-bit capable tools:
    echo    - Requires finding 32-bit MinGW libraries
    echo    - More complex on 64-bit Windows
    echo.
    echo For now, try using Microsoft Visual Studio if you have it.
    echo.
    del output.obj
    pause
    exit /b 1
)

del output.obj
echo.
echo ==================================
echo BUILD SUCCESSFUL!
echo Output: MASM_2035_Weaponized.exe
echo ==================================
pause
exit /b 0
