# Installing Build Tools for Windows

You got the error: `gcc: The term 'gcc' is not recognized`

This means you need to install a C compiler/linker. Here are your options:

---

## Option 1: Install MinGW-w64 (Recommended)

### Method A: Using Chocolatey (Easiest)

1. **Install Chocolatey** (if not already installed):
   - Open PowerShell as Administrator
   - Run:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

2. **Install MinGW and NASM**:
   ```powershell
   choco install mingw nasm -y
   ```

3. **Restart PowerShell** and try again:
   ```batch
   build_nasm.bat
   ```

### Method B: Manual Installation

1. **Download MinGW-w64**:
   - Go to: https://www.mingw-w64.org/downloads/
   - Download: "MingW-W64-builds" 
   - Or direct link: https://github.com/niXman/mingw-builds-binaries/releases
   - Get: `i686-*-win32-*` (32-bit version)

2. **Install**:
   - Extract to `C:\mingw32\`
   - Add to PATH: `C:\mingw32\bin`

3. **Download NASM**:
   - Go to: https://www.nasm.us/pub/nasm/releasebuilds/
   - Download latest Windows version (e.g., `nasm-2.16.01-win64.zip`)
   - Extract to `C:\nasm\`
   - Add to PATH: `C:\nasm`

4. **Add to System PATH**:
   - Press `Win + X` → System → Advanced System Settings
   - Environment Variables → System Variables → Path → Edit
   - Add: `C:\mingw32\bin` and `C:\nasm`
   - Click OK on all dialogs
   - **Restart PowerShell**

---

## Option 2: Use Microsoft Visual Studio Tools

If you have Visual Studio installed, you can use Microsoft's linker.

### Step 1: Find Visual Studio Developer Command Prompt

- Search for "Developer Command Prompt for VS" in Start Menu
- Or search for "x86 Native Tools Command Prompt"

### Step 2: Navigate and Build

```batch
cd C:\Users\HiH8e\OneDrive\Desktop\mRAWR-main
nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj
link /SUBSYSTEM:CONSOLE /OUT:output.exe output.obj kernel32.lib user32.lib advapi32.lib wininet.lib crypt32.lib
```

---

## Option 3: Use GoLink (Lightweight Alternative)

1. **Download GoLink**:
   - Go to: http://www.godevtool.com/
   - Download `GoLink.exe`

2. **Download NASM**:
   - Get from: https://www.nasm.us/

3. **Build**:
   ```batch
   nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj
   golink /entry _start output.obj kernel32.dll user32.dll advapi32.dll wininet.dll crypt32.dll
   ```

---

## Option 4: Use Online Build Service (No Installation)

### WSL (Windows Subsystem for Linux)

1. **Enable WSL**:
   ```powershell
   wsl --install
   ```

2. **Install Ubuntu from Microsoft Store**

3. **In WSL terminal**:
   ```bash
   sudo apt update
   sudo apt install nasm mingw-w64 -y
   cd /mnt/c/Users/HiH8e/OneDrive/Desktop/mRAWR-main
   nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj
   i686-w64-mingw32-gcc output.obj -o output.exe -lkernel32 -luser32 -ladvapi32 -lwininet -lcrypt32
   ```

---

## Quick Test: What Do You Have?

Run these commands in PowerShell to check what's available:

```powershell
# Check for NASM
nasm -v

# Check for GCC/MinGW
gcc --version

# Check for Microsoft linker
where link

# Check for Visual Studio
where cl
```

---

## Recommended: Quick Chocolatey Install

**This is the fastest method:**

1. Open PowerShell as Administrator
2. Install Chocolatey (one command)
3. Run: `choco install mingw nasm -y`
4. Wait 2-3 minutes
5. Restart PowerShell
6. Run: `build_nasm.bat`

---

## Already Have NASM But No GCC?

If you already ran NASM successfully and have `output.obj`, you can use Microsoft's linker:

```batch
# Find and use Visual Studio linker
"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\*\bin\Hostx64\x86\link.exe" /SUBSYSTEM:CONSOLE /OUT:output.exe output.obj kernel32.lib user32.lib advapi32.lib wininet.lib crypt32.lib
```

Or search for `link.exe` on your system.

---

## Need Help?

Tell me which option you prefer and I'll give you detailed steps!
