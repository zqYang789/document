username="zqyang"
password="y2901"
project_name="nj_hzz_web"
project_url="https://123.57.70.214/svn/sunsan2019/02_德州宁津县河长制系统/08_源代码/nj_hzz_web"
http_url="https://123.57.70.214/svn/sunsan2019/02_德州宁津县河长制系统/12_版本发布/http"
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
cd config
rm -rf http.js
echo "===========检出http.js==========="
svn checkout $http_url  --username $username --password $password
cd http
mv ./http.js ../
cd ../
rm -rf http
cd ../
echo "===========打包==========="
npm install --unsafe-perm=true --allow-root
npm run build
echo "===========压缩==========="
zip -r dist.zip dist/

# 1、:set ff 查看文件类型是dos还是linux
# 2、:set ff=unix 修改文件类型为linux
# 3、:set fileencoding=utf-8 编码为utf-8