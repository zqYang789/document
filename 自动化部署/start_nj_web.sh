username="xxx"
password="yyy"
project_name="zzz"
project_url="mmm"
http_url="qqq"
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
cd config
rm -rf http.js
echo "===========���http.js==========="
svn checkout $http_url  --username $username --password $password
cd http
mv ./http.js ../
cd ../
rm -rf http
cd ../
echo "===========��װ����==========="
npm install --unsafe-perm=true --allow-root
echo "===========���==========="
npm run build
echo "===========ѹ��==========="
zip -r dist.zip dist/

# 1��:set ff �鿴�ļ�������dos����linux
# 2��:set ff=unix �޸��ļ�����Ϊlinux
# 3��:set fileencoding=utf-8 ����Ϊutf-8