username="zhangjia"
password="zj1598"
project_name="nj_hzz_api"
project_url="https://123.57.70.214/svn/sunsan2019/02_���������غӳ���ϵͳ/08_Դ����/nj_hzz_api"
application_url="https://123.57.70.214/svn/sunsan2019/02_���������غӳ���ϵͳ/12_�汾����/application"
start_java_url="https://123.57.70.214/svn/sunsan2019/02_���������غӳ���ϵͳ/12_�汾����/java"
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