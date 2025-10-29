@echo off
REM setup.bat - Double-click to install Hugo
REM This script sets up Hugo for the blog

cd /d "%~dp0"
echo.
echo ========================================
echo    Hugo Blog Setup
echo ========================================
echo.

REM Check if Git Bash is available
where bash >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Running setup script...
    bash setup.sh
) else (
    echo Git Bash not found. Please install Git for Windows.
    echo Download from: https://git-scm.com/downloads
    echo.
    echo Alternatively, you can manually install Hugo:
    echo 1. Download from: https://github.com/gohugoio/hugo/releases
    echo 2. Extract hugo.exe to ..\bin\ folder
    echo.
)

echo.
echo Press any key to close this window...
pause >nul

