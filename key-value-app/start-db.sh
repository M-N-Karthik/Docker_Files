source .env.db
CONTAINER_IMAGE=mongodb/mongodb-community-server
CONTAINER_TAG=7.0-ubuntu2204
ROOT_USER="root-user"
ROOT_PASSWORD="root-password"

KEY_VALUE_DB_NAME="key-value-db"
KEY_VALUE_DB_USER="key-value-user"
KEY_VALUE_DB_PASSWORD="key-value-password"

LOCAL_HOST_PORT=27017
LOCAL_CONTAINER_PORT=27017
source .env.network

source .env.volume
VOLUME_PATH="/data/db"

source setup.sh

if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
    echo " Docker container is already running: ${CONTAINER_NAME}"
    echo " Docker container will removed when stopped"
    echo " To stop the container: docker stop ${CONTAINER_NAME}"
    exit 1
fi

docker run --rm -d --name ${CONTAINER_NAME} \
    -e MONGO_INITDB_ROOT_USERNAME=${ROOT_USER} \
    -e MONGO_INITDB_ROOT_PASSWORD=${ROOT_PASSWORD} \
    -e KEY_VALUE_DB=${KEY_VALUE_DB_NAME} \
    -e KEY_VALUE_USER=${KEY_VALUE_DB_USER} \
    -e KEY_VALUE_PASSWORD=${KEY_VALUE_DB_PASSWORD} \
    -p ${LOCAL_HOST_PORT}:${LOCAL_CONTAINER_PORT} \
    -v ${VOLUME_NAME}:${VOLUME_PATH} \
    -v ./db-config/mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js:ro \
    --network ${NETWORK_NAME} \
    ${CONTAINER_IMAGE}:${CONTAINER_TAG}