@echo off
:: Batch file to disable UAC (User Account Control)

echo.
echo ==============================
echo  Disabling User Account Control
echo ==============================
echo.

:: Check if user is admin
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo This script must be run as Administrator!
    pause
    exit /b
)

:: Disable UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo UAC has been disabled.
echo Your computer will now restart to apply changes.
echo.

timeout /t 5 >nul
shutdown /r /t 0