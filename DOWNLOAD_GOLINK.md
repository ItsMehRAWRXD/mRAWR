# 📥 Download GoLink - Lightweight Linker Solution

## What is GoLink?

GoLink is a tiny (~100KB), fast Windows linker that can handle 32-bit assembly code. Perfect for your situation!

---

## 🚀 QUICK STEPS (5 minutes)

### Step 1: Download GoLink

**Option A: Direct Download**
1. Go to: http://www.godevtool.com/
2. Click on "**GoLink**" in the menu
3. Download `GoLink.Zip` (latest version)
4. Extract `GoLink.exe` 
5. Copy `GoLink.exe` to: `C:\Users\HiH8e\OneDrive\Desktop\mRAWR-main\`

**Option B: Alternative Mirror**
- If the main site is down, search "GoLink.exe download"
- Version 0.30+ works fine

### Step 2: Build Your Code

Once GoLink.exe is in your folder, run:

```powershell
cd C:\Users\HiH8e\OneDrive\Desktop\mRAWR-main
.\build_with_golink.bat
```

---

## 📋 Manual Build (If Script Doesn't Work)

```powershell
cd C:\Users\HiH8e\OneDrive\Desktop\mRAWR-main

# Assemble
nasm -f win32 MASM_2035_Weaponized_Complete_NASM.asm -o output.obj

# Link with GoLink
.\GoLink.exe /console /entry _start output.obj kernel32.dll user32.dll advapi32.dll wininet.dll crypt32.dll
```

This creates `output.exe` - your final executable!

---

## ✅ What You'll Get

After running GoLink, you'll have:
- **output.exe** or **MASM_2035_Weaponized.exe**
- Fully functional 32-bit executable
- Works on all Windows systems

---

## 🔧 GoLink Advantages

✅ Tiny size (~100KB)  
✅ No installation needed  
✅ Handles 32-bit code perfectly  
✅ Fast linking  
✅ No dependencies  

---

## 🆘 If GoLink Website is Down

Try these alternatives:

1. **JWASM** (includes linker): http://www.japheth.de/JWasm.html
2. **Pelles C** (includes POLINK): http://www.smorgasbordet.com/pellesc/
3. **Digital Mars** (includes linker): https://digitalmars.com/

---

## 📞 Next Steps

1. Download GoLink.exe
2. Put it in your mRAWR-main folder
3. Run: `.\build_with_golink.bat`
4. Get your executable!

**Once you've downloaded GoLink.exe, just tell me and I'll walk you through building!**
