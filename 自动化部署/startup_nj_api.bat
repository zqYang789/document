@echo off
echo "==============��������=============="
:: svn�˺�
set username="xxx"  		
::svn����
set password="yyy"	
::��Ŀ����		
set project_name="zzz" 	
::��Ŀsvn��ַ	
set project_url="mmm"	
::�����ļ�svn��ַ	
set application_url="ppp"	
::������svn��ַ
set start_java_url="qqq"	


::�ж��Ƿ������Ŀ
::������ڣ�������ĿĿ¼�����´���
::��������ڣ������Ŀ
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
::ɾ��applocation-prod.yml�ļ�������svn�м�������ļ�������svn�е������ļ�
cd service/src/main/resources
del application-prod.yml
svn checkout %application_url%  --username %username% --password %password%
cd application
move ./application-prod.yml ../
cd ../
rd /s /q application
cd ../../../../
::ɾ��������WebServerAppWithSwagger������svn�е�java�ļ�
cd web_server/src/main/java/cn/hzz
svn checkout %start_java_url%  --username %username% --password %password%
del WebServerAppWithSwagger.java
cd java
move ./WebServerAppWithSwagger.java ../
cd ../ 
rd /s /q java 
cd ../../../../../../
::��Ŀ���
echo "==============��Ŀ����=============="
call gradle build zip
::��Ŀ����
echo "==============��Ŀ����=============="
cd release
java -Dfile.encoding=utf-8 -jar web_server-1.0.jar --spring.profiles=application-prod.yml