@echo off

set username="liuhonglin"
set password="lhl690"
set project="wc_hzz_api"

if exist %project% (
	echo ==============项目更新==============
	cd %project%
	svn update
) else (
	echo ==============项目检出==============
	svn checkout https://123.57.70.214/svn/sunsan2019/05_德州武城河长制/02_代码/wc_hzz_api  --username %username% --password %password%
)
echo ==============项目构建==============
call gradle build zip
echo ==============项目运行==============
cd release
java -Dfile.encoding=utf-8 -jar web_server-1.0.jar --spring.profiles=application.yml
