#!/bin/bash

mysql(){
    echo "Create new mysql docker instance"
    docker run --name mysql-docker \
    > -p 3306:3306 \
    > -v ~/Desktop/mysql-db-test:/var/lib/mysql \
    > -d mysql
}

mongo(){
    echo "Create new mongoDB docker instance"
    docker run --name mongo-docker -v ~/Desktop/docker-db-test:/data/db -p 27017:27017 -d mongo
}

redis(){
    echo "Create new redis docker instance"
    docker run --name redis-docker -p 6379:6379 -d redis
}

createNew() {
    read -p "enter your current container ID, if want to start a new container, hit enter:" CONTAINER_ID

    if [[ -z $CONTAINER_ID ]]; then
        echo "no container is setup, choose witch container you want to start:"
        docker_instances="mysql mongo redis quit"
        select instance in $docker_instances; do
            case $instance in
                mysql)
                    mysql
                    break ;;
                mongo)
                    mongo
                    break ;;
                redis)
                    redis
                    break ;;
                quit)
                    exit ;;
                *)
                    clear
                    echo "please choose 1-3" ;;
            esac
        done
    else
        echo "CONTAINER ID $CONTAINER_ID is setup"
        CONTAINER_NAME=$(docker inspect --format='{{.Config.Image}}' $CONTAINER_ID)

        docker stop $CONTAINER_ID
        echo $CONTAINER_ID now is stop

        docker rm $CONTAINER_ID
        echo $CONTAINER_ID now is deleted

        case $CONTAINER_NAME in
            mysql)
                mysql ;;
            mongo)
                mongo ;;
            redis)
                redis ;;
        esac
    fi
}

stop() {
    read  -p "Enter your current container ID:" CONTAINER_ID
	CONTAINER_STATUS=$(docker inspect --format='{{.State.Status}}' $CONTAINER_ID)
	CONTAINER_NAME=$(docker inspect --format='{{.Config.Image}}' $CONTAINER_ID)

	if [[ $CONTAINER_STATUS == running ]]; then
		docker stop $CONTAINER_ID
		echo "$CONTAINER_NAME container is now stop"
		docker ps
	elif [[ $CONTAINER_STATUS == exited ]]; then
		echo "$CONTAINER_NAME is already been stop"
		docker ps
	else
		exit
	fi
}

restart() {
	read -p "Enter your current container ID:" CONTAINER_ID
	CONTAINER_STATUS=$(docker inspect --format='{{.State.Status}}' $CONTAINER_ID)
	CONTAINER_NAME=$(docker inspect --format='{{.Config.Image}}' $CONTAINER_ID)

	if [[ $CONTAINER_STATUS == running ]]; then
		docker stop $CONTAINER_ID
		docker restart $CONTAINER_ID
		echo "$CONTAINER_NAME container is now restart it"
		docker ps
	elif [[ $CONTAINER_STATUS == exited ]]; then
		docker restart $CONTAINER_ID
		echo "$CONTAINER_NAME container is now restart it"
		docker ps
	else
		exit
	fi
}

delete() {
	read -p "Enter your current container ID:" CONTAINER_ID
	CONTAINER_STATUS=$(docker inspect --format='{{.State.Status}}' $CONTAINER_ID)
	CONTAINER_NAME=$(docker inspect --format='{{.Config.Image}}' $CONTAINER_ID)

	if [[ $CONTAINER_STATUS == running ]]; then
		docker stop $CONTAINER_ID
		docker rm $CONTAINER_ID
		echo "$CONTAINER_NAME container is now deleted"
		docker ps
	elif [[ $CONTAINER_STATUS == exited ]]; then
		docker rm $CONTAINER_ID
		echo "$CONTAINER_NAME container is now deleted"
		docker ps
	else
		exit
	fi
}

echo "What action do you want to process?:"
ACTION_LIST="Create-new-docker-container Stop-docker-container Restart-docker-container Delete-docker-container"
select ACTION in $ACTION_LIST; do
	case $ACTION in
		Create-new-docker-container)
			createNew
			break ;;
		Stop-docker-container)
			stop
			break ;;
		Restart-docker-container)
			restart
			break ;;
		Delete-docker-container)
			delete
			break ;;
	esac
done

