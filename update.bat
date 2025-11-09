@echo off
set commit_msg=:sparkles: Site updated: %date%
git add .
git commit -m "%commit_msg%"
git push
pause