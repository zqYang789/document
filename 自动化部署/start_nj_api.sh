username="xxx"
password="yyy"
project_name="zzz"
project_url="mmm"
application_url="ttt"
start_java_url="qqq"
if  [ -d $project_name ];then
	echo "==============update=============="
	cd $project_name
	svn update
else
	echo "==============checkout=============="
	svn checkout $project_url --username $username --password $password
	cd $project_name
fi
echo "===========�����ļ��޸�============"
cd service/src/main/resources
rm -rf application-prod.yml
echo "===========���application==========="
svn checkout $application_url  --username $username --password $password
cd application
mv ./application-prod.yml ../
cd ../
rm -rf application
cd ../../../../
cd web_server/src/main/java/cn/hzz
echo "===========���WebServerAppWithSwagger==========="
svn checkout $start_java_url  --username $username --password $password
rm -rf WebServerAppWithSwagger.java
cd java
mv ./WebServerAppWithSwagger.java ../
cd ../ 
rm -rf java 
cd ../../../../../../
echo "==============��Ŀ����=============="
gradle build zip

# 1��:set ff �鿴�ļ�������dos����linux
# 2��:set ff=unix �޸��ļ�����Ϊlinux
# 3��:set fileencoding=utf-8 ����Ϊutf-8