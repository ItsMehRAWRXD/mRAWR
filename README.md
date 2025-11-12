# MASM 2035 Weaponized Framework

## 🚨 PROBLEM SOLVED: MASM vs NASM

**You were getting errors because you tried to assemble a MASM file with NASM!**

### The Error You Saw:
```
error: instruction expected, found `.model flat'
error: instruction expected, found 'ExitProcess PROTO'
error: instruction expected, found 'proc'
```

### The Solution:
✅ **Use the NASM-converted version:** `MASM_2035_Weaponized_Complete_NASM.asm`

---

## 📦 Files in This Repository

| File | Description |
|------|-------------|
| `MASM_2035_Weaponized_Complete..asm` | Original MASM source (use with ml.exe) |
| `MASM_2035_Weaponized_Complete_NASM.asm` | **NASM-compatible version** ✅ |
| `build_nasm.bat` | Windows build script |
| `build_nasm.sh` | Linux/macOS build script |
| `CONVERSION_README.md` | Detailed conversion documentation |

---

## 🚀 Quick Start

### Using NASM (Recommended)

**On Windows:**
```batch
build_nasm.bat
```

**On Linux/macOS:**
```bash
chmod +x build_nasm.sh
./build_nasm.sh
```

**Manual Assembly:**
```bash
# Assemble
nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

# Link (Windows)
gcc -m32 output.obj -o output.exe -lkernel32 -luser32 -ladvapi32 -lwininet -lcrypt32

# Link (Linux with MinGW)
i686-w64-mingw32-gcc output.obj -o output.exe -lkernel32 -luser32 -ladvapi32 -lwininet -lcrypt32
```

### Using MASM (Windows Only)

```batch
ml /c /coff MASM_2035_Weaponized_Complete..asm
link /SUBSYSTEM:WINDOWS /OUT:output.exe MASM_2035_Weaponized_Complete..obj ^
  kernel32.lib user32.lib advapi32.lib wininet.lib crypt32.lib
```

---

## 🔍 What's the Difference?

**MASM** and **NASM** are two different assemblers with incompatible syntax:

| Feature | MASM Syntax | NASM Syntax |
|---------|-------------|-------------|
| **Processor directive** | `.386` | `[BITS 32]` |
| **Memory model** | `.model flat, stdcall` | Not needed |
| **Section declarations** | `.data`, `.code` | `section .data`, `section .text` |
| **API declarations** | `ExitProcess PROTO :DWORD` | `extern _ExitProcess@4` |
| **Procedures** | `MyFunc proc` ... `endp` | `MyFunc:` ... `ret` |
| **Constants** | `MYCONST EQU 100` | `%define MYCONST 100` |
| **Repeat data** | `db 100 dup(0)` | `times 100 db 0` |
| **Type casting** | `word ptr [esi]` | `word [esi]` |
| **Addressing** | `offset mylabel` | `mylabel` (direct) |

---

## ✨ Features Implemented

✅ Real working UAC bypasses (FodHelper, Sdclt)  
✅ Configurable HTTP download/upload  
✅ AES256 + XOR encryption/decryption  
✅ Executable selection and PE manipulation  
✅ Fileless memory execution  
✅ Anti-debugging and anti-analysis  
✅ Process injection techniques  
✅ Registry persistence mechanisms  
✅ Stealth mutex creation  
✅ Cryptographic key generation  

---

## 📋 Requirements

### For NASM Assembly:
- **NASM** assembler (https://www.nasm.us/)
- **MinGW GCC** (for linking on Windows/Linux)
- Windows API libraries (kernel32, user32, advapi32, wininet, crypt32)

### For MASM Assembly:
- **Microsoft Macro Assembler** (ml.exe) - included with Visual Studio
- **Microsoft Linker** (link.exe)
- Windows SDK libraries

---

## 📖 Detailed Documentation

See **CONVERSION_README.md** for:
- Complete syntax conversion reference
- Line-by-line changes explained
- Troubleshooting common errors
- Advanced linking options

---

## ⚠️ Security Warning

This code contains **real security exploits** including:
- UAC bypass techniques
- Process/DLL injection
- Registry manipulation
- Privilege escalation attempts
- Anti-debugging mechanisms

### Legal Notice:
✅ **Authorized Use Only**
- Security research in controlled environments
- Penetration testing with written authorization
- Educational purposes in isolated VMs

❌ **Prohibited Use**
- Unauthorized access to computer systems
- Malware development or distribution
- Any illegal activity

**Unauthorized use may violate:**
- Computer Fraud and Abuse Act (CFAA)
- Electronic Communications Privacy Act
- Local and international computer crime laws

---

## 🛠️ Troubleshooting

### "nasm: command not found"
```bash
# Ubuntu/Debian
sudo apt-get install nasm

# macOS
brew install nasm

# Windows
choco install nasm
```

### "i686-w64-mingw32-gcc: command not found"
```bash
# Ubuntu/Debian
sudo apt-get install mingw-w64

# macOS
brew install mingw-w64
```

### Linking errors
- Use `-m32` flag for 32-bit compilation
- Ensure all required libraries are installed
- Check that library names match your system

### Still getting "instruction expected" errors
- Make sure you're using the **NASM** version: `MASM_2035_Weaponized_Complete_NASM.asm`
- Don't try to assemble the MASM file (with double dots: `..asm`) with NASM!

---

## 📚 Additional Resources

- **NASM Documentation**: https://www.nasm.us/doc/
- **MASM Documentation**: https://docs.microsoft.com/en-us/cpp/assembler/masm/
- **Win32 API Reference**: https://docs.microsoft.com/en-us/windows/win32/api/
- **PE Format Specification**: https://docs.microsoft.com/en-us/windows/win32/debug/pe-format

---

## 📝 Version History

- **v2.0** - NASM conversion completed with full feature parity
- **v1.0** - Original MASM implementation

---

**Built with ❤️ for security researchers and exploit developers**

*Remember: With great power comes great responsibility. Use wisely.*
