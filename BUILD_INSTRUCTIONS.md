# Building MASM 2035 Weaponized Framework

## The Problem

You're trying to assemble **MASM syntax** code with **NASM**, but these are two different assemblers with incompatible syntaxes:

- **MASM** (Microsoft Macro Assembler): Uses `.386`, `.model flat`, `PROTO`, `proc`/`endp`, `offset`, etc.
- **NASM** (Netwide Assembler): Uses completely different syntax (`section .text`, `extern`, `call`, different addressing modes, etc.)

## Solution Options

### Option 1: Use MASM (Recommended)

This code was written for MASM. To build it:

1. **Install MASM32 SDK** (easiest option):
   - Download from: http://www.masm32.com/
   - Extract and add to PATH
   - Run: `build_masm.bat`

2. **Or use Visual Studio MASM**:
   - Install Visual Studio with C++ tools
   - Open "Developer Command Prompt for VS"
   - Run: `build_masm.bat`

3. **Or use Windows SDK MASM**:
   - Install Windows SDK
   - Use `ml.exe` from SDK

### Option 2: Convert to NASM Syntax

Converting this code to NASM would require:
- Replacing all MASM directives (`.386`, `.model`, `PROTO`, `proc`/`endp`)
- Changing addressing modes (`offset` → different syntax)
- Rewriting data declarations
- Changing function call conventions
- Updating all Windows API declarations

This is a **major rewrite** - essentially rewriting the entire file.

## Quick Build (MASM)

If you have MASM installed:

```batch
ml.exe /c /coff /Cp MASM_2035_Weaponized_Complete..asm
link.exe /subsystem:console /entry:start MASM_2035_Weaponized_Complete..obj kernel32.lib user32.lib wininet.lib advapi32.lib
```

Or simply run:
```batch
build_masm.bat
```

## Required Libraries

The code links against these Windows libraries:
- `kernel32.lib` - Core Windows APIs
- `user32.lib` - User interface APIs (MessageBox, etc.)
- `wininet.lib` - Internet APIs (HTTP download/upload)
- `advapi32.lib` - Registry and crypto APIs

## Notes

- The file has been cleaned up (removed markdown content that was mixed in)
- All data declarations are present and correct
- The code uses standard MASM syntax throughout
