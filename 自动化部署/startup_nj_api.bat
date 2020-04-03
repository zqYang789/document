@echo off
echo "==============变量申明=============="
:: svn账号
set username="xxx"  		
::svn密码
set password="yyy"	
::项目名称		
set project_name="zzz" 	
::项目svn地址	
set project_url="mmm"	
::配置文件svn地址	
set application_url="ppp"	
::启动类svn地址
set start_java_url="qqq"	


::判断是否存在项目
::如果存在，进入项目目录，更新代码
::如果不存在，检出项目
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
::删除applocation-prod.yml文件，并从svn中检出配置文件，采用svn中的配置文件
cd service/src/main/resources
del application-prod.yml
svn checkout %application_url%  --username %username% --password %password%
cd application
move ./application-prod.yml ../
cd ../
rd /s /q application
cd ../../../../
::删除启动类WebServerAppWithSwagger，采用svn中的java文件
cd web_server/src/main/java/cn/hzz
svn checkout %start_java_url%  --username %username% --password %password%
del WebServerAppWithSwagger.java
cd java
move ./WebServerAppWithSwagger.java ../
cd ../ 
rd /s /q java 
cd ../../../../../../
::项目打包
echo "==============项目构建=============="
call gradle build zip
::项目运行
echo "==============项目运行=============="
cd release
java -Dfile.encoding=utf-8 -jar web_server-1.0.jar --spring.profiles=application-prod.yml