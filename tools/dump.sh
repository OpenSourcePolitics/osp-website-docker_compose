#!/bin/bash
container=$1
if [ -z "$container" ];then
	echo "you must pass a container name as a parameter"
	exit 1
else
	id=$(docker ps -aqf "name=$container")
fi

if [ -z "$id" ];then
	echo "you must pass a valid container name as a parameter"
	exit 1
fi


docker exec $container sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > files/dump.sql
echo "Data has been dumped in files/dump.sql successfully"
exit 0
