@echo off

set commit_msg=:sparkles: Site updated: %date%

echo %commit_msg%

git add .
git commit -m "%commit_msg%"
git push
pause