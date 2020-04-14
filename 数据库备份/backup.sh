database_backup_url="xxx"
ip="aaa"
username="yyy"
password="zzz"
back_time=$(date +%Y%m%d%H)
backup_database="aaa"
sql_name=${backup_database}${back_time}".sql"
if  [ ! -d $database_backup_url ];then
	echo "==============创建备份目录=============="
	mkdir $database_backup_url
fi
echo "===========数据库导出============"
mysqldump --single-transaction -h$ip -u$username -p$password --default-character-set=utf8 $backup_databse >$database_backup_url/$sql_name


# 1、:set ff 查看文件类型是dos还是linux
# 2、:set ff=unix 修改文件类型为linux
# 3、:set fileencoding=utf-8 编码为utf-8
