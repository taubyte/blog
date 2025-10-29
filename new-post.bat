@echo off
REM new-post.bat - Double-click to create a new post
REM This script prompts for post name and creates a new post

cd /d "%~dp0"
echo.
echo ========================================
echo    Create New Blog Post
echo ========================================
echo.

set /p POST_NAME="Enter post name (e.g., my-awesome-post): "

if "%POST_NAME%"=="" (
    echo ERROR: Post name cannot be empty!
    echo.
    pause
    exit /b 1
)

REM Check if Hugo is available
where hugo >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    hugo new content "posts\%POST_NAME%.md"
    goto :success
)

REM Check local binary
if exist "..\bin\hugo.exe" (
    ..\bin\hugo.exe new content "posts\%POST_NAME%.md"
    goto :success
)

REM Try Git Bash
where bash >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    bash new-post.sh %POST_NAME%
    goto :end
)

echo ERROR: Hugo not found!
echo Please run setup.bat first to install Hugo.
pause
exit /b 1

:success
echo.
echo SUCCESS: Post created at content\posts\%POST_NAME%.md
echo Edit the file and set draft = false when ready to publish.
echo.

:end
pause

