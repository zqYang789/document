@echo off
set username="zhangjia"
set password="zj1598"
set project_name="nj_hzz_api"
set project_url="https://123.57.70.214/svn/sunsan2019/02_���������غӳ���ϵͳ/08_Դ����/nj_hzz_api"
set application_url="https://123.57.70.214/svn/sunsan2019/02_���������غӳ���ϵͳ/12_�汾����/application"
set start_java_url="https://123.57.70.214/svn/sunsan2019/02_���������غӳ���ϵͳ/12_�汾����/java"
if exist %project_name% (
	echo "==============��Ŀ����=============="
	cd %project_name%
	svn update
) else (
	echo "==============��Ŀ���=============="
	svn checkout %project_url%  --username %username% --password %password%
	cd %project_name%
)
echo "===========ɾ�������������ļ�============"
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
echo "==============��Ŀ����=============="
call gradle build zip
echo "==============��Ŀ����=============="
cd release
java -Dfile.encoding=utf-8 -jar web_server-1.0.jar --spring.profiles=application-prod.yml