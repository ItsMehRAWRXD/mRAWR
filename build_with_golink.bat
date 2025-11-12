@echo off
REM Build script using GoLink linker

echo ==================================
echo MASM 2035 Build with GoLink
echo ==================================
echo.

REM Check for NASM
where nasm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: NASM not found!
    echo Please install NASM first: choco install nasm
    pause
    exit /b 1
)

REM Check for GoLink
if not exist "GoLink.exe" (
    echo ERROR: GoLink.exe not found in current directory!
    echo.
    echo Please download GoLink:
    echo   1. Go to: http://www.godevtool.com/
    echo   2. Download GoLink.Zip
    echo   3. Extract GoLink.exe to this folder
    echo.
    echo Current folder: %CD%
    echo.
    echo See DOWNLOAD_GOLINK.md for detailed instructions.
    echo.
    pause
    exit /b 1
)

echo [+] NASM found
echo [+] GoLink found
echo.

echo [1/3] Assembling with NASM...
nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Assembly failed!
    pause
    exit /b 1
)

echo [2/3] Linking with GoLink...
GoLink.exe /console /entry _start output.obj kernel32.dll user32.dll advapi32.dll wininet.dll crypt32.dll

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Linking failed!
    echo.
    echo GoLink may need different parameters.
    echo Trying alternative linking method...
    echo.
    GoLink.exe /mix /ni /entry _start output.obj kernel32.dll user32.dll advapi32.dll wininet.dll crypt32.dll
    
    if %ERRORLEVEL% NEQ 0 (
        echo ERROR: Alternative linking also failed!
        echo.
        echo Please check:
        echo   1. GoLink.exe is valid and not corrupted
        echo   2. Assembly code assembled correctly
        echo   3. All DLL names are correct
        echo.
        pause
        exit /b 1
    )
)

echo [3/3] Cleaning up and renaming...
if exist "output.exe" (
    move /Y output.exe MASM_2035_Weaponized.exe >nul
)
del output.obj

echo.
echo ==================================
echo BUILD SUCCESSFUL!
echo ==================================
echo.

if exist "MASM_2035_Weaponized.exe" (
    echo Output: MASM_2035_Weaponized.exe
) else if exist "output.exe" (
    echo Output: output.exe
) else (
    echo WARNING: Output file not found!
)

echo.
echo WARNING: This executable contains security exploits.
echo          Only run in authorized, isolated environments.
echo.
pause
