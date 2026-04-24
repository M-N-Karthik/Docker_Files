source .env.network
source .env.volume

if [ "$(docker network ls -q -f name=${NETWORK_NAME})" ]; then
    echo " Docker network already exists: ${NETWORK_NAME}"
else 
    docker network create ${NETWORK_NAME}
fi

if [ "$(docker volume ls -q -f name=${VOLUME_NAME})" ]; then
    echo " Docker volume already exists: ${VOLUME_NAME}"
else
    docker volume create ${VOLUME_NAME}
fi