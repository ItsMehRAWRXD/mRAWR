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

REM Check for GoLink (best for 32-bit)
if exist "GoLink.exe" (
    echo [+] GoLink found
    echo.
    echo Using: GoLink (recommended for 32-bit)
    goto :build_with_golink
)
echo [-] GoLink not found

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

:build_with_golink
echo.
echo ==================================
echo Building with GoLink...
echo ==================================
call build_with_golink.bat
goto :end

:build_with_mingw
echo.
echo ==================================
echo Building with MinGW...
echo ==================================
echo.
echo Detecting MinGW architecture...
gcc -dumpmachine | findstr /C:"x86_64" >nul
if %ERRORLEVEL% EQU 0 (
    echo Detected: 64-bit MinGW
    echo.
    echo WARNING: Your MinGW is 64-bit only and cannot link 32-bit code.
    echo.
    echo RECOMMENDED: Download GoLink (tiny, free linker)
    echo   1. Get from: http://www.godevtool.com/
    echo   2. Put GoLink.exe in this folder
    echo   3. Run build_auto.bat again
    echo.
    echo See: DOWNLOAD_GOLINK.md for instructions
    echo.
    pause
    goto :show_install_help
) else (
    echo Detected: 32-bit MinGW  
    echo Using 32-bit build script...
    call build_nasm.bat
)
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
echo OPTION 1: GoLink (Recommended - Easiest!)
echo -----------------------------------------
echo   1. Download from: http://www.godevtool.com/
echo   2. Extract GoLink.exe to this folder
echo   3. Run this script again
echo   See: DOWNLOAD_GOLINK.md for details
echo.
echo OPTION 2: MinGW with 32-bit support
echo -----------------------------------------
echo   1. Open PowerShell as Administrator
echo   2. Install Chocolatey (if needed):
echo      Set-ExecutionPolicy Bypass -Scope Process -Force;
echo      [System.Net.ServicePointManager]::SecurityProtocol = 3072;
echo      iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
echo   3. Install tools:
echo      choco install mingw nasm -y
echo   4. Restart this script
echo   NOTE: May still have 32-bit issues
echo.
echo OPTION 3: Visual Studio
echo -----------------------------------------
echo   1. Install Visual Studio Community (free)
echo   2. Include "Desktop development with C++"
echo   3. Run this script from "Developer Command Prompt"
echo.
echo OPTION 4: Manual MinGW Install
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
