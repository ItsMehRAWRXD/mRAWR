@echo off
REM Build script using Microsoft Visual C++ linker (alternative to MinGW)
REM This script attempts to find and use Microsoft's linker

echo ==================================
echo MASM 2035 NASM Build Script
echo Using Microsoft Visual C++ Linker
echo ==================================
echo.

REM Check if NASM is installed
where nasm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: NASM is not installed!
    echo.
    echo Please install NASM:
    echo   1. Download from: https://www.nasm.us/
    echo   2. Or run: choco install nasm
    echo.
    pause
    exit /b 1
)

echo [1/3] Assembling with NASM...
nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Assembly failed!
    pause
    exit /b 1
)

echo [2/3] Looking for Microsoft linker...

REM Try to find link.exe in common Visual Studio locations
set "LINKER="

REM VS 2022
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\" (
    for /f "delims=" %%i in ('dir /b /ad "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\"') do (
        if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\%%i\bin\Hostx64\x86\link.exe" (
            set "LINKER=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\%%i\bin\Hostx64\x86\link.exe"
            goto :found_linker
        )
    )
)

REM VS 2019
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\" (
    for /f "delims=" %%i in ('dir /b /ad "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\"') do (
        if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\%%i\bin\Hostx64\x86\link.exe" (
            set "LINKER=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\%%i\bin\Hostx64\x86\link.exe"
            goto :found_linker
        )
    )
)

REM VS 2017
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\" (
    for /f "delims=" %%i in ('dir /b /ad "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\"') do (
        if exist "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\%%i\bin\Hostx64\x86\link.exe" (
            set "LINKER=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\%%i\bin\Hostx64\x86\link.exe"
            goto :found_linker
        )
    )
)

REM Try Windows SDK
for /f "tokens=*" %%i in ('where link.exe 2^>nul') do (
    set "LINKER=%%i"
    goto :found_linker
)

REM Not found
echo ERROR: Microsoft linker (link.exe) not found!
echo.
echo You have two options:
echo   1. Install Visual Studio or Windows SDK
echo   2. Install MinGW: choco install mingw
echo.
echo Then use one of these build scripts:
echo   - build_nasm.bat (for MinGW)
echo   - build_msvc.bat (for Visual Studio)
echo.
pause
exit /b 1

:found_linker
echo Found linker: %LINKER%
echo.

echo [3/3] Linking with Microsoft linker...
"%LINKER%" /SUBSYSTEM:CONSOLE /OUT:MASM_2035_Weaponized.exe output.obj kernel32.lib user32.lib advapi32.lib wininet.lib crypt32.lib

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Linking failed!
    echo.
    echo You may need to run this from a Visual Studio Developer Command Prompt.
    echo Or install the Windows SDK.
    echo.
    pause
    exit /b 1
)

echo.
echo [4/4] Cleaning up...
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
