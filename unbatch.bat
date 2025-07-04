@echo off
:: Batch file to re-enable Task Manager and Registry Editor

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo This script must be run as Administrator!
    pause
    exit /b
)

echo.
echo ==============================
echo   Enabling TaskMgr & Regedit
echo ==============================
echo.

:: Enable Task Manager
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /t REG_DWORD /d 0 /f >nul 2>&1

:: Enable Registry Editor (regedit)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableRegistryTools /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo ✅ Task Manager and Registry Editor have been re-enabled.
echo Restart required for some changes to take effect.
echo.

pause