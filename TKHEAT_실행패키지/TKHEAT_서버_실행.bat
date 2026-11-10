@echo off
chcp 65001 > nul
setlocal

set "BASE=%~dp0"
set "JAVA_HOME=%BASE%jre"
set "CATALINA_HOME=%BASE%tomcat"

echo ================================================
echo  TKHEAT MES 서버를 시작합니다.
echo  (이 창을 닫으면 서버가 종료됩니다)
echo ================================================
echo.
echo  잠시 후 아래 주소로 접속하세요:
echo    http://localhost:9082/tkheat
echo    (다른 PC에서는 http://이_PC의_IP:9082/tkheat)
echo.
echo  필수 조건: D 드라이브에 "태경출력파일" 폴더가 있어야 합니다.
echo  (이 패키지에 포함된 태경출력파일 폴더를 D:\ 에 그대로 복사해주세요)
echo.

call "%CATALINA_HOME%\bin\catalina.bat" run

pause
