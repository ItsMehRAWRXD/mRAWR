@echo off
REM Automatic build script - detects available tools and uses them

echo ==================================
echo MASM 2035 Auto Build Script
echo Detecting available tools...
echo ==================================
echo.

REM Check for NASM
where nasm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [X] NASM not found!
    echo.
    echo Please install NASM first:
    echo   Option 1: choco install nasm
    echo   Option 2: Download from https://www.nasm.us/
    echo.
    goto :show_install_help
)
echo [+] NASM found

REM Check for MinGW GCC
where gcc >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [+] MinGW GCC found
    echo.
    echo Using: MinGW GCC
    goto :build_with_mingw
)
echo [-] MinGW GCC not found

REM Check for Microsoft linker
where link >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [+] Microsoft linker found
    echo.
    echo Using: Microsoft Visual C++ linker
    goto :build_with_msvc
)
echo [-] Microsoft linker not found

REM Nothing found
echo.
echo [X] No suitable linker found!
echo.
goto :show_install_help

:build_with_mingw
echo.
echo ==================================
echo Building with MinGW...
echo ==================================
call build_nasm.bat
goto :end

:build_with_msvc
echo.
echo ==================================
echo Building with Microsoft linker...
echo ==================================
call build_msvc.bat
goto :end

:show_install_help
echo ==================================
echo INSTALLATION REQUIRED
echo ==================================
echo.
echo You need to install build tools. Choose one:
echo.
echo OPTION 1: MinGW (Recommended - Easy)
echo -----------------------------------------
echo   1. Open PowerShell as Administrator
echo   2. Install Chocolatey (if needed):
echo      Set-ExecutionPolicy Bypass -Scope Process -Force;
echo      [System.Net.ServicePointManager]::SecurityProtocol = 3072;
echo      iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
echo   3. Install tools:
echo      choco install mingw nasm -y
echo   4. Restart this script
echo.
echo OPTION 2: Visual Studio
echo -----------------------------------------
echo   1. Install Visual Studio Community (free)
echo   2. Include "Desktop development with C++"
echo   3. Run this script from "Developer Command Prompt"
echo.
echo OPTION 3: Manual MinGW Install
echo -----------------------------------------
echo   1. Download from: https://www.mingw-w64.org/downloads/
echo   2. Extract to C:\mingw32\
echo   3. Add C:\mingw32\bin to System PATH
echo   4. Restart PowerShell
echo.
echo For detailed instructions, see: INSTALL_TOOLS_WINDOWS.md
echo.
pause
exit /b 1

:end
echo.
echo Done!
pause
