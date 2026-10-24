@echo off
setlocal enabledelayedexpansion
title Ultimate Windows Max Path Stress Tester & Diagnostic Tool

:: =========================================================================
:: FEATURE 1: Administrative Check & Long-Path Registry Status Detection
:: =========================================================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [NOTICE] Running as standard user. (Tip: Run as Admin to test system policies)
) else (
    echo [NOTICE] Running with Administrator privileges.
)

for /f "tokens=3" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled 2^>nul') do set "longPathStatus=%%A"
if "%longPathStatus%"=="0x1" (
    set "regStatusText=ENABLED (Supports up to 32,767 chars)"
) else (
    set "regStatusText=DISABLED / DEFAULT (Hard stop near 260 chars)"
)

:: =========================================================================
:: FEATURE 2: Professional UI Header & Configuration Setup
:: =========================================================================
cls
echo ===================================================================
echo               ULTIMATE MAX FILE PATH STRESS TESTER v2.0
echo ===================================================================
echo  - Long Paths Registry Status : !regStatusText!
echo.
set /p "folderName=Enter subfolder name pattern [Default: x]: "
if "!folderName!"=="" set "folderName=x"

set "baseDir=PathStressTest_%RANDOM%_%RANDOM%"
echo.
echo [*] Initializing isolated testing workspace: !baseDir!
mkdir "%baseDir%"
cd "%baseDir%"

:: =========================================================================
:: FEATURE 3: High-Precision Performance Tracking (Start Timer)
:: =========================================================================
for /f "tokens=1-4 delims=:., " %%a in ("%time%") do (
    set /a "startSec=(((%%a*60)+10^^%%b)*60+10^^%%c)*100+10^^%%d"
)

set "depth=0"
set "logFile=..\PathTest_Report_%RANDOM%.txt"

echo [INFO] Stress test running... Writing execution log to disk.
echo [INFO] Press Ctrl+C at any time to abort safely.
echo.

(
    echo WINDOWS PATH STRESS TEST REPORT
    echo Generated on: %DATE% %TIME%
    echo -------------------------------------------------------------------
) > "%logFile%"

:: =========================================================================
:: FEATURE 4: Advanced Loop with Live Telemetry & Error Catching
:: =========================================================================
:loop
mkdir "%folderName%" >nul 2>&1
if errorlevel 1 goto :limit_reached

cd "%folderName%" >nul 2>&1
if errorlevel 1 goto :limit_reached

set /a depth+=1

:: Print real-time rolling feedback to screen
echo [+] Depth: !depth! nested folders created successfully.

goto :loop

:limit_reached
:: =========================================================================
:: FEATURE 5: High-Precision Performance Tracking (End Timer & Math)
:: =========================================================================
for /f "tokens=1-4 delims=:., " %%a in ("%time%") do (
    set /a "endSec=(((%%a*60)+10^^%%b)*60+10^^%%c)*100+10^^%%d"
)
set /a "elapsedMS=endSec-startSec"
if !elapsedMS! lss 0 set /a elapsedMS+=8640000
set /a "elapsedSec=elapsedMS/100"

echo.
echo ===================================================================
echo [!] PATH CREATION CEILING REACHED OR BLOCKED!
echo ===================================================================

:: =========================================================================
:: FEATURE 6: Accurate Character Length Calculation Engine
:: =========================================================================
for /f "delims=" %%i in ('cd') do set "finalPath=%%i"

set "len=0"
if defined finalPath (
    for %%A in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
        if "!finalPath:~%%A,1!" NEQ "" (
            set /a "len+=%%A"
            set "finalPath=!finalPath:~%%A!"
        )
    )
)

:: Re-capture clean path for reporting
for /f "delims=" %%i in ('cd') do set "finalPath=%%i"

echo [*] Maximum Safe Depth       : !depth! folders
echo [*] Final Absolute Path Length : !len! characters
echo [*] Time Elapsed             : !elapsedSec! seconds
echo.

:: =========================================================================
:: FEATURE 7: Automatic Session Logging
:: =========================================================================
(
    echo Stop Reason: Limit reached or path block triggered.
    echo Maximum Depth Reached: !depth! folders
    echo Final Path Length: !len! characters
    echo Time Taken: !elapsedSec! seconds
    echo Final Path String:
    echo !finalPath!
) >> "%logFile%"

echo [INFO] Detailed diagnostic report saved to: %logFile%
echo ===================================================================
echo.

:: =========================================================================
:: FEATURE 8: Safe Workspace Egress (Reverting to parent directory)
:: =========================================================================
cd /d "%~dp0"

:: =========================================================================
:: FEATURE 9: Interactive Multi-Mode Cleanup Protocol
:: =========================================================================
echo CHOOSE CLEANUP ACTION:
echo [1] Automatically wipe and delete all test folders now (Using robocopy trick)
echo [2] Leave folders intact (Manual inspection or testing deletion tools)
echo.
set /p "choice=Select option (1 or 2): "

if "%choice%"=="1" (
    echo.
    echo [*] Preparing high-speed purge via robocopy mirror technique...
    
    :: Create an empty dummy directory for purging deep trees safely
    mkdir "%TEMP\EmptyPurgeDir_%RANDOM%" >nul 2>&1
    
    :: Use robocopy MIR (mirror) tool to clear deep directory blocks instantly
    robocopy "%TEMP\EmptyPurgeDir_%RANDOM%" "%~dp0%baseDir%" /MIR >nul 2>&1
    
    :: Remove root artifacts
    rd /s /q "%TEMP\EmptyPurgeDir_%RANDOM%" >nul 2>&1
    rd /s /q "%~dp0%baseDir%" >nul 2>&1
    
    echo [+] Test folders successfully and completely destroyed!
) else (
    echo.
    echo [!] Folders preserved. To delete manually later via command line, run:
    echo     rd /s /q "%~dp0%baseDir%"
)

echo.
echo ===================================================================
echo                 TEST COMPLETE - THANK YOU
echo ===================================================================
pause
exit
