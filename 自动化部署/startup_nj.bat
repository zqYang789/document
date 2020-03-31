@echo off
set username="xxx"
set password="yyy"
set project_name="zzz"
set project_url="mmm"
set application_url="ppp"
set start_java_url="qqq"
if exist %project_name% (
	echo "==============项目更新=============="
	cd %project_name%
	svn update
) else (
	echo "==============项目检出=============="
	svn checkout %project_url%  --username %username% --password %password%
	cd %project_name%
)
echo "===========删除并更新配置文件============"
cd service/src/main/resources
del application-prod.yml
svn checkout %application_url%  --username %username% --password %password%
cd application
move ./application-prod.yml ../
cd ../
rd /s /q application
cd ../../../../
cd web_server/src/main/java/cn/hzz
svn checkout %start_java_url%  --username %username% --password %password%
del WebServerAppWithSwagger.java
cd java
move ./WebServerAppWithSwagger.java ../
cd ../ 
rd /s /q java 
cd ../../../../../../
echo "==============项目构建=============="
call gradle build zip
echo "==============项目运行=============="
cd release
java -Dfile.encoding=utf-8 -jar web_server-1.0.jar --spring.profiles=application-prod.yml