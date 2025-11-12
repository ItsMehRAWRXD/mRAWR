# 🚀 START HERE - Quick Guide

## What Happened?

You got this error:
```
gcc: The term 'gcc' is not recognized
```

**This means:** You don't have a C compiler/linker installed on your Windows system.

---

## What You Need to Do (Choose One)

### 🥇 OPTION 1: Install MinGW (RECOMMENDED - 5 minutes)

**Step 1:** Open PowerShell **as Administrator** (Right-click → Run as Administrator)

**Step 2:** Install Chocolatey (package manager):
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

**Step 3:** Install build tools:
```powershell
choco install mingw nasm -y
```

**Step 4:** Close and reopen PowerShell (normal, not admin), then:
```batch
cd C:\Users\HiH8e\OneDrive\Desktop\mRAWR-main
build_auto.bat
```

**Done!** You'll have `MASM_2035_Weaponized.exe`

---

### 🥈 OPTION 2: Use Visual Studio (If You Have It)

**If you already have Visual Studio installed:**

1. Search for "**Developer Command Prompt for VS**" in Start Menu
2. Open it
3. Run:
```batch
cd C:\Users\HiH8e\OneDrive\Desktop\mRAWR-main
build_msvc.bat
```

---

### 🥉 OPTION 3: Manual Install (Advanced)

See detailed instructions in: **`INSTALL_TOOLS_WINDOWS.md`**

---

## Files You Have Now

✅ **MASM_2035_Weaponized_Complete_NASM.asm** - Fixed assembly code  
✅ **build_auto.bat** - Automatic build (use this!)  
✅ **build_nasm.bat** - Build with MinGW  
✅ **build_msvc.bat** - Build with Visual Studio  
✅ **INSTALL_TOOLS_WINDOWS.md** - Detailed installation guide  

---

## Quick Summary

| Your Situation | What to Run |
|----------------|-------------|
| No tools installed | Install with Chocolatey (Option 1) |
| Have Visual Studio | `build_msvc.bat` |
| Have MinGW/GCC | `build_nasm.bat` |
| Not sure | `build_auto.bat` (detects automatically) |

---

## Still Need Help?

Run this to see what tools you have:
```powershell
nasm -v
gcc --version
where link
```

Then tell me the output!

---

## After Building

You'll get: **`MASM_2035_Weaponized.exe`**

⚠️ **WARNING:** This contains real security exploits. Only use for authorized testing!

---

## TL;DR

**Fastest way to build right now:**

1. Open PowerShell as Admin
2. Run: `choco install mingw nasm -y` (installs tools)
3. Close and reopen normal PowerShell
4. Run: `build_auto.bat` (builds your program)

**That's it!** 🎉
