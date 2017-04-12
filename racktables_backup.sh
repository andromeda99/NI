#!/bin/bash
#====== Script to backup Racktables database ==========
echo "===== Racktables database backup started ===="
#"Please mention destination backup folder in area51 & name of the database in db"
area51=/Mysql_backup/ 
db=racktables
cd /var/lib/mysql
echo "Current Dir:- $PWD"
x=`date | awk '{print $2$3"-"$6}'`
f=`date | awk '{print $2}'`
d=`date | awk '{print $6}'`
if [ -d "/Mysql_backup/$f/" ]; then
	echo "Destination folder $area51$f/ exists..."
	echo "Dumping MySQL DB "\"racktables"\" to $area51"
	mysqldump -uroot -psupp0rt $db > /Mysql_backup/$db$x.sql
	y=`echo $?`
	echo "Exit status is $y..sql dumped to $area51"
	echo "MySQL dump file:- racktables$x.sql"
else
	echo "Destination folder $area51$f does not exist. Creating..."
	sleep 1;
	mkdir -p $area51$f
	echo "$area51$f Created..." 
	mysqldump -uroot -psupp0rt $db > $area51$db$x.sql
	y=`echo $?`
	echo "Exit status is $y..sql dumped to $area51"
fi
cd $area51$f
echo "Archiving $area51$db$x.sql into $area51$f "
tar zcfP  $db$x.sql.tar $area51$db$x.sql
y=`echo $?`
echo "Exit status is $y...Archive complete..."
echo "Current Dir:- $PWD"
echo "Archived file:- $db$x.sql.tar"
echo "Uploading $db$x.sql.tar to Amazon S3..."
aws s3 cp $db$x.sql.tar s3://myracktable/db/$d/$f/
y=`echo $?`
echo "Exit status is $y...upload to s3 complete"
if [ $y == 0 ]; then
echo "Removing backup file $area51$db$x.sql to free space since its already archived"
rm -rf $area51$db$x.sql
echo "Backup file removed"
echo "Removing archive $area51$f/$db$x.sql.tar since its already backup up on S3" 
rm -rf $db$x.sql.tar
rm -rf $area51$f
echo "Archived removed"
else
echo "upload failed"
fi
#====== Script to backup Racktables websfiles ==========
#"Please mention destination backup folder in area51 & name of the files in f1 & f2"
area51=/web_backup/
f1=index.php
f2=racktables.config
cd $area51
echo "===== Archiving & Uploading Racktables webfiles data to Amazon S3 ====="
echo "Current Dir:- $PWD"
echo "Archiving $f1"
tar cfzP index.php$x.tar /var/www/html/$f1
echo "File1 Archived:- $f1$x.tar"
echo "Archiving $f2"
tar cfzP racktables.config$x.tar /var/www/html/$f2
echo "File2 Archived:- $f2$x.tar"
echo "Uploading both archives to Amazon S3"
aws s3 cp $f1$x.tar s3://myracktable/web-files/$d/$f/
aws s3 cp $f2$x.tar s3://myracktable/web-config/$d/$f/
echo "Upload to Amazon S3 complete"
y=`echo $y`
if [ $y == 0 ]; then
echo "Removing $area51$f1$x.tar & $area51$f2$x.tar to clear space in $area51."
rm -rf $area51$f1$x.tar $area51$f2$x.tar
echo "Successfully removed files from $area51"
else
echo "upload failed"
fi

