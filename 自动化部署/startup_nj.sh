username="zhangjia"
password="zj1598"
project_name="nj_hzz_api"
project_url="https://123.57.70.214/svn/sunsan2019/02_德州宁津县河长制系统/08_源代码/nj_hzz_api"
application_url="https://123.57.70.214/svn/sunsan2019/02_德州宁津县河长制系统/12_版本发布/application"
start_java_url="https://123.57.70.214/svn/sunsan2019/02_德州宁津县河长制系统/12_版本发布/java"
if  [ -d $project_name ];then
	echo "==============update=============="
	cd $project_name
	svn update
else
	echo "==============checkout=============="
	svn checkout $project_url --username $username --password $password
	cd $project_name
fi
echo "===========配置文件修改============"
cd service/src/main/resources
rm -rf application-prod.yml
echo "===========检出application==========="
svn checkout $application_url  --username $username --password $password
cd application
mv ./application-prod.yml ../
cd ../
rm -rf application
cd ../../../../
cd web_server/src/main/java/cn/hzz
echo "===========检出WebServerAppWithSwagger==========="
svn checkout $start_java_url  --username $username --password $password
rm -rf WebServerAppWithSwagger.java
cd java
mv ./WebServerAppWithSwagger.java ../
cd ../ 
rm -rf java 
cd ../../../../../../
echo "==============项目构建=============="
gradle build zip

# 1、:set ff 查看文件类型是dos还是linux
# 2、:set ff=unix 修改文件类型为linux
# 3、:set fileencoding=utf-8 编码为utf-8