#!/bin/bash
# Build script for NASM version of the weaponized assembly code

echo "=================================="
echo "MASM 2035 NASM Build Script"
echo "=================================="
echo ""

# Check if NASM is installed
if ! command -v nasm &> /dev/null; then
    echo "ERROR: NASM is not installed!"
    echo "Please install NASM:"
    echo "  - Ubuntu/Debian: sudo apt-get install nasm"
    echo "  - macOS: brew install nasm"
    echo "  - Windows: choco install nasm"
    exit 1
fi

# Check if MinGW cross-compiler is available
if ! command -v i686-w64-mingw32-gcc &> /dev/null; then
    echo "ERROR: MinGW cross-compiler (i686-w64-mingw32-gcc) is not installed!"
    echo "Please install MinGW:"
    echo "  - Ubuntu/Debian: sudo apt-get install mingw-w64"
    echo "  - macOS: brew install mingw-w64"
    exit 1
fi

echo "[1/3] Assembling with NASM..."
nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

if [ $? -ne 0 ]; then
    echo "ERROR: Assembly failed!"
    exit 1
fi

echo "[2/3] Linking with MinGW..."
i686-w64-mingw32-gcc output.obj -o MASM_2035_Weaponized.exe \
    -m32 \
    -lkernel32 \
    -luser32 \
    -ladvapi32 \
    -lwininet \
    -lcrypt32 \
    -s

if [ $? -ne 0 ]; then
    echo "ERROR: Linking failed!"
    exit 1
fi

echo "[3/3] Cleaning up..."
rm -f output.obj

echo ""
echo "=================================="
echo "BUILD SUCCESSFUL!"
echo "Output: MASM_2035_Weaponized.exe"
echo "=================================="
echo ""
echo "⚠️  WARNING: This executable contains security exploits."
echo "    Only run in authorized, isolated environments."
