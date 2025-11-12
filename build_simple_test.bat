@echo off
REM Simple test to create a minimal working 32-bit executable using GoLink

echo ==================================
echo Creating Simple Test Executable
echo ==================================
echo.

REM Create minimal 32-bit assembly test
echo Creating minimal test file...
(
echo [BITS 32]
echo extern _ExitProcess@4
echo extern _MessageBoxA@16
echo.
echo section .data
echo msg db 'NASM Assembly Works!',0
echo title db 'Success',0
echo.
echo section .text
echo global _start
echo.
echo _start:
echo     push 0
echo     push title
echo     push msg
echo     push 0
echo     call _MessageBoxA@16
echo     push 0
echo     call _ExitProcess@4
) > test_minimal.asm

echo [1/2] Assembling minimal test...
nasm -f win32 test_minimal.asm -o test_minimal.obj

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Assembly failed!
    pause
    exit /b 1
)

echo [2/2] Testing linker...
echo.
echo Attempting to link with GCC...
gcc -m32 test_minimal.obj -o test_minimal.exe -luser32 -lkernel32 2>link_error.txt

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ==================================
    echo TEST SUCCESSFUL!
    echo ==================================
    echo.
    echo Your MinGW CAN handle 32-bit code!
    echo The main assembly file may have other issues.
    echo.
    echo Test executable created: test_minimal.exe
    echo Run it to verify it works.
    echo.
    del test_minimal.obj
    del test_minimal.asm
    del link_error.txt 2>nul
    pause
    exit /b 0
) else (
    echo.
    echo ==================================
    echo LINKER TEST FAILED
    echo ==================================
    echo.
    echo Your MinGW cannot link 32-bit code.
    echo Error details saved to: link_error.txt
    echo.
    type link_error.txt
    echo.
    echo SOLUTIONS:
    echo.
    echo 1. Use Microsoft Visual Studio linker:
    echo    build_msvc.bat
    echo.
    echo 2. Download GoLink (lightweight linker):
    echo    http://www.godevtool.com/
    echo    Then use: golink /entry _start test_minimal.obj kernel32.dll user32.dll
    echo.
    echo 3. Install 32-bit MinGW separately
    echo.
    del test_minimal.obj
    pause
    exit /b 1
)
