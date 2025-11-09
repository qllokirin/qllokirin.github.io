@echo off
REM 获取当前时间，格式化为 YYYY-MM-DD HH:MM:SS
for /f "tokens=1-6 delims=:. " %%a in ("%date% %time%") do (
    set yyyy=%%c
    set mm=%%a
    set dd=%%b
    set hh=%%d
    set mi=%%e
    set ss=%%f
)

set commit_time=%mm%-%dd% %hh%:%mi%:%ss%

REM 拼接 commit message
set commit_msg=:sparkles: Site updated: %commit_time%


echo %commit_msg%
REM Git 操作
git add .
git commit -m "%commit_msg%"
git push
pause