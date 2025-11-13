#!/bin/bash

echo "===================================================="
echo "MASM 2035 Weaponized Framework - Linux Build Script"
echo "===================================================="

# Check if NASM is installed
if ! command -v nasm &> /dev/null; then
    echo "ERROR: NASM not found! Installing..."
    sudo apt update && sudo apt install -y nasm
    if [ $? -ne 0 ]; then
        echo "Failed to install NASM. Please install manually."
        exit 1
    fi
fi

# Check if GCC is available
if ! command -v gcc &> /dev/null; then
    echo "ERROR: GCC not found! Please install gcc."
    exit 1
fi

echo "Building MASM 2035 Weaponized..."

# Assemble the ASM file to object
echo "[1/3] Assembling with NASM..."
nasm -f elf32 "MASM_2035_Weaponized_Complete..asm" -o masm_2035_temp.o
if [ $? -ne 0 ]; then
    echo "ERROR: Assembly failed!"
    exit 1
fi

# Link with GCC
echo "[2/3] Linking with GCC..."
gcc -m32 -o masm_2035_weaponized masm_2035_temp.o
if [ $? -ne 0 ]; then
    echo "ERROR: Linking failed!"
    rm -f masm_2035_temp.o
    exit 1
fi

# Clean up temporary files
echo "[3/3] Cleaning up..."
rm -f masm_2035_temp.o

echo
echo "===================================================="
echo "SUCCESS! Built: masm_2035_weaponized"
echo "===================================================="
echo
echo "WARNING: This contains real exploits - use responsibly!"
echo "For authorized security testing only."
echo

# Make executable
chmod +x masm_2035_weaponized
echo "Binary is now executable."