@echo off
REM get-latest.cmd - Update local repository to latest main branch
REM This script fetches the latest changes, resets to main, and cleans untracked files

echo Fetching latest from origin/main...
git fetch origin main

echo.
echo Resetting to origin/main (this will discard local changes)...
git reset --hard origin/main

echo.
echo Cleaning untracked files...
git clean -fd

echo.
echo Done! Your repository is now up to date with main.
