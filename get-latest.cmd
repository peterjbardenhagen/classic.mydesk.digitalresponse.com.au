@echo off
REM get-latest.cmd - Update local deployment to the latest authoritative MyDesk source
REM
REM classic.mydesk.digitalresponse.com.au is NOT the source of truth for the app.
REM The real, complete application (SalesEngine3a, SalesEngineTL, routing, etc.)
REM lives in techlight.digitalresponse.com.au-ASP-Classic on branch "main".
REM This script repoints origin there and syncs the working copy to it.

echo Repointing origin to the authoritative repository...
git remote set-url origin https://github.com/peterjbardenhagen/techlight.digitalresponse.com.au-ASP-Classic.git

echo.
echo Fetching latest from origin/main...
git fetch origin main

echo.
echo Resetting to origin/main (this will discard local changes)...
git reset --hard origin/main

echo.
echo Cleaning untracked files...
git clean -fd

echo.
echo Done! Your repository is now up to date with techlight.digitalresponse.com.au-ASP-Classic main.
