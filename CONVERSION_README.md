# MASM to NASM Conversion - Assembly Instructions

## Problem Identified

You were trying to assemble a **MASM (Microsoft Macro Assembler)** file using **NASM (Netwide Assembler)**. These are two completely different assemblers with incompatible syntax.

## Files in This Repository

1. **MASM_2035_Weaponized_Complete..asm** - Original MASM source code
2. **MASM_2035_Weaponized_Complete_NASM.asm** - Converted NASM source code (NEW)

## Key Differences Converted

### MASM Syntax → NASM Syntax

| Feature | MASM | NASM |
|---------|------|------|
| **Directives** | `.386`, `.model flat`, `.data`, `.code` | `[BITS 32]`, `section .data`, `section .text` |
| **API Declarations** | `ExitProcess PROTO :DWORD` | `extern _ExitProcess@4` |
| **Procedures** | `MyProc proc` ... `MyProc endp` | `MyProc:` ... `ret` |
| **Constants** | `MY_CONST EQU 100` | `%define MY_CONST 100` |
| **Data Allocation** | `buffer db 100 dup(0)` | `buffer times 100 db 0` |
| **Type Casting** | `word ptr [esi]` | `word [esi]` |
| **Labels** | Uses `:` and standalone labels | All labels must use `:` |

## How to Assemble the NASM Version

### Option 1: Using NASM (Windows)

```batch
REM Assemble to object file
nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

REM Link with MinGW
gcc -m32 output.obj -o output.exe -lkernel32 -luser32 -ladvapi32 -lwininet -lcrypt32
```

### Option 2: Using NASM (Linux/Wine)

```bash
# Assemble
nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

# Link with MinGW cross-compiler
i686-w64-mingw32-gcc output.obj -o output.exe \
  -lkernel32 -luser32 -ladvapi32 -lwininet -lcrypt32
```

## If You Want to Use MASM Instead

To assemble the **original MASM file**, you need to use Microsoft's assembler:

### Using MASM (ml.exe)

```batch
REM Assemble and link
ml /c /coff MASM_2035_Weaponized_Complete..asm
link /SUBSYSTEM:WINDOWS /OUT:output.exe MASM_2035_Weaponized_Complete..obj ^
  kernel32.lib user32.lib advapi32.lib wininet.lib crypt32.lib
```

### Using MASM with Visual Studio

1. Open "Developer Command Prompt for VS"
2. Navigate to the directory
3. Run: `ml /c /coff MASM_2035_Weaponized_Complete..asm`
4. Link the resulting .obj file

## Major Conversion Changes Made

### 1. **External Function Declarations**
- Added `extern` declarations for all Windows API functions
- Used stdcall decoration (e.g., `_ExitProcess@4` where `4` is bytes of parameters)

### 2. **Section Definitions**
- Converted `.data` → `section .data`
- Converted `.code` → `section .text`
- Added `section .bss` for uninitialized buffers

### 3. **Procedure Syntax**
- Converted `proc`/`endp` to label-based functions with `.local_label` syntax
- Replaced MASM local labels with NASM dot-prefixed labels

### 4. **Constants**
- Changed `EQU` to `%define` for all constants

### 5. **Data Declarations**
- Changed `db 100 dup(0)` to `times 100 db 0`
- Changed `dd MASM_2035_SIGNATURE` references to use proper addressing

### 6. **Memory References**
- Removed `ptr` keyword (NASM doesn't use it)
- Removed `offset` keyword (NASM uses direct label references)
- Changed `word ptr [esi]` to `word [esi]`
- Changed `dword ptr [edi]` to `dword [edi]`

### 7. **Function Calls**
- Updated all API calls to use stdcall decoration
- Example: `call MessageBoxA` → `call _MessageBoxA@16`

### 8. **Entry Point**
- Changed `start:` with `end start` to `global _start` with `_start:` label

## Required Libraries for Linking

The executable requires these Windows libraries:
- **kernel32.lib** - Core Windows functions
- **user32.lib** - UI functions (MessageBox, etc.)
- **advapi32.lib** - Registry and crypto functions
- **wininet.lib** - Internet/HTTP functions
- **crypt32.lib** - Cryptography functions

## Troubleshooting

### "command not found: nasm"
- Install NASM: https://www.nasm.us/pub/nasm/releasebuilds/
- Or use: `apt-get install nasm` (Linux) / `choco install nasm` (Windows)

### Linking errors
- Make sure you're using 32-bit libraries (`-m32` flag)
- Ensure all required Windows libraries are linked

### Undefined symbols
- Check that all `extern` declarations match your Windows SDK
- Some functions may need different decorations based on your linker

## Security Notice

⚠️ **WARNING**: This code contains implementations of security exploits and should only be used for:
- Authorized security testing
- Educational purposes in controlled environments
- Security research with proper authorization

Unauthorized use may violate computer security laws.

## Next Steps

1. Choose your assembler (NASM or MASM)
2. Install the required tools
3. Assemble the appropriate source file
4. Link with required libraries
5. Test in a safe, isolated environment

## Additional Resources

- NASM Documentation: https://www.nasm.us/doc/
- MASM Documentation: https://docs.microsoft.com/en-us/cpp/assembler/masm/
- Win32 API Reference: https://docs.microsoft.com/en-us/windows/win32/api/
