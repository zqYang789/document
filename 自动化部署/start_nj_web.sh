username="zqyang"
password="y2901"
project_name="nj_hzz_web"
project_url="https://123.57.70.214/svn/sunsan2019/02_���������غӳ���ϵͳ/08_Դ����/nj_hzz_web"
http_url="https://123.57.70.214/svn/sunsan2019/02_���������غӳ���ϵͳ/12_�汾����/http"
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
echo "===========���==========="
npm install --unsafe-perm=true --allow-root
npm run build
echo "===========ѹ��==========="
zip -r dist.zip dist/

# 1��:set ff �鿴�ļ�������dos����linux
# 2��:set ff=unix �޸��ļ�����Ϊlinux
# 3��:set fileencoding=utf-8 ����Ϊutf-8