@echo off

set username="liuhonglin"
set password="lhl690"
set project="wc_hzz_api"

if exist %project% (
	echo ==============��Ŀ����==============
	cd %project%
	svn update
) else (
	echo ==============��Ŀ���==============
	svn checkout https://123.57.70.214/svn/sunsan2019/05_������Ǻӳ���/02_����/wc_hzz_api  --username %username% --password %password%
)
echo ==============��Ŀ����==============
call gradle build zip
echo ==============��Ŀ����==============
cd release
java -Dfile.encoding=utf-8 -jar web_server-1.0.jar --spring.profiles=application.yml
