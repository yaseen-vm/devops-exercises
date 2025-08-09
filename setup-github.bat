@echo off
echo Setting up GitHub repository...

REM Check if GitHub CLI is installed
gh --version >nul 2>&1
if %errorlevel% neq 0 (
    echo GitHub CLI not found. Please install it from: https://cli.github.com/
    echo Or manually create repository at: https://github.com/new
    pause
    exit /b 1
)

REM Create repository on GitHub
echo Creating repository on GitHub...
gh repo create devops-exercises --public --description "Comprehensive DevOps exercises from basic to beginner level"

REM Add remote and push
echo Adding remote and pushing...
git remote add origin https://github.com/%USERNAME%/devops-exercises.git
git branch -M main
git push -u origin main

echo.
echo ✅ Repository created successfully!
echo 📍 View at: https://github.com/%USERNAME%/devops-exercises
pause