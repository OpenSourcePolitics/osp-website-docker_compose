#!/bin/bash
container=$1

if [ -z "$container" ];then
	echo "You must pass a container name as a parameter"
	exit 1
else
	id=$(docker ps -aqf "name=$container")
fi

if [ -z "$id" ];then
	echo "You must pass a valid container name as a parameter"
	exit 1
fi

echo -n "You're about to replace all data, are you sure you want to continue? (yes/no)"

read choice


if [ "$choice" == "y" ] || [ "$choice" == "yes" ];then

	echo "dumping your old data to files/old-data.sql"
	docker exec ${container} sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > files/old-data.sql

        if [ -f files/dump.sql ]; then
		echo "Importing files/dump.sql"	
		docker exec ${container} sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < files/dump.sql
		echo "Success: databases has been imported from files folder!"
	else
	        echo "There is not dump.sql file in files folder, please check again"
		exit 1
	fi



else
	echo "Exiting..."
	exit 1
fi
exit 0
