@echo off
REM Windows Utility Menu - simplified & cleaned (by Prabhat)
REM No auto-elevation. No restore-point. Detects OneDrive Desktop for battery report.

title Windows Utility Menu - Prabhat
cls

:: ----- Helper: choose Desktop (OneDrive if present) -----
set "OD_DESKTOP=%USERPROFILE%\OneDrive\Desktop"
set "LOCAL_DESKTOP=%USERPROFILE%\Desktop"
if exist "%OD_DESKTOP%" (
    set "DESKTOP=%OD_DESKTOP%"
) else (
    set "DESKTOP=%LOCAL_DESKTOP%"
)

:menu
cls
echo ===========================================================
echo              Windows Utility Menu  -  by Prabhat
echo ===========================================================
echo.
echo  1) Check for updates (winget)
echo  2) Update all packages (winget upgrade --all)
echo  3) Flush DNS cache (ipconfig /flushdns)
echo  4) Generate battery report (saved to Desktop)
echo  5) Reboot to BIOS (Requires Admin Permission)
echo  6) Exit
echo.
choice /c 123456 /n /m "Enter your choice (1-6): "

if errorlevel 6 goto exit
if errorlevel 5 goto BIOS
if errorlevel 4 goto battery
if errorlevel 3 goto flushdns
if errorlevel 2 goto update
if errorlevel 1 goto check

:check
echo.
echo [*] Checking for available updates (winget)...
winget upgrade
echo.
pause
goto menu

:update
echo.
echo [*] Updating all packages (winget upgrade --all)...
winget upgrade --all
echo.
pause
goto menu

:flushdns
echo.
echo [*] Flushing DNS resolver cache...
ipconfig /flushdns
if %errorlevel% equ 0 (
    echo DNS cache flushed successfully.
) else (
    echo Warning: failed to flush DNS cache. This may require administrative privileges.
)
echo.
pause
goto menu

:battery
echo.
echo [*] Generating battery report...
:: get timestamp using PowerShell (format: yyyyMMdd_HHmmss)
for /f "delims=" %%T in ('powershell -NoProfile -Command "(Get-Date).ToString('yyyyMMdd_HHmmss')"') do set TS=%%T

:: ensure target folder exists (in rare cases OneDrive path might be unavailable)
if not exist "%DESKTOP%" (
    echo Desktop folder not found at "%DESKTOP%". Attempting fallback to %LOCAL_DESKTOP%...
    set "DESKTOP=%LOCAL_DESKTOP%"
    if not exist "%DESKTOP%" (
        echo Error: No Desktop folder found. Cannot save battery report.
        pause
        goto menu
    )
)

set "OUT=%DESKTOP%\battery-report-%TS%.html"
powercfg /batteryreport /output "%OUT%" >nul 2>&1
if %errorlevel% equ 0 (
    echo Battery report created: "%OUT%"
    rem Try to open the report; if it fails, just show the path
    start "" "%OUT%" 2>nul || echo (Unable to launch file viewer; open "%OUT%" manually)
) else (
    echo Error: Failed to create battery report.
    echo - If you get "Access denied", try running this script with administrative privileges.
    echo - If "powercfg" is not found, ensure you're on Windows and system PATH is intact.
)
echo.
pause
goto menu

:BIOS
echo.
echo [*] Rebooting into BIOS (Wait 03 Seconds)...
shutdown /r /fw /t 3
echo.
pause
goto menu

:exit
echo.
echo Exiting...
timeout /t 1 >nul
exit /b
