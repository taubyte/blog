@echo off
REM server.bat - Double-click to start development server
REM This script starts the Hugo development server

cd /d "%~dp0"
cd ..\..
echo.
echo ========================================
echo    Starting Hugo Blog Server
echo ========================================
echo.

REM Check if Hugo is available
where hugo >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    hugo server --bind=0.0.0.0 --port=1313
    goto :end
)

REM Check local binary
if exist "..\bin\hugo.exe" (
    ..\bin\hugo.exe server --bind=0.0.0.0 --port=1313
    goto :end
)

REM Try Git Bash
where bash >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    bash server.sh
    goto :end
)

echo ERROR: Hugo not found!
echo.
echo Please run scripts\windows\setup.bat first to install Hugo.
echo.
echo Press any key to close this window...
pause >nul
exit /b 1

:end
echo.
echo Server stopped. Press any key to close...
pause >nul

