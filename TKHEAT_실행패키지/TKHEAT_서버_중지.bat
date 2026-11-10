@echo off
chcp 65001 > nul
setlocal

set "BASE=%~dp0"
set "JAVA_HOME=%BASE%jre"
set "CATALINA_HOME=%BASE%tomcat"

echo 서버를 중지합니다...
call "%CATALINA_HOME%\bin\shutdown.bat"

pause
