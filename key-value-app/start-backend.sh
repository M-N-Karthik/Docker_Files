source .env.db

LOCAL_HOST_PORT=3000
LOCAL_CONTAINER_PORT=3000
source .env.network

CONTAINER_NAME_BACKEND=key-value-backend
IMAGE_NAME_BACKEND=key-value-backend-image

if [ "$(docker ps -q -f name=${CONTAINER_NAME_BACKEND})" ]; then
    echo " Docker container is already running: ${CONTAINER_NAME_BACKEND}"
    echo " Docker container will removed when stopped"
    echo " To stop the container: docker stop ${CONTAINER_NAME_BACKEND}"
    exit 1
fi

docker build -t ${IMAGE_NAME_BACKEND} ./backend

docker run --rm -d --name ${CONTAINER_NAME_BACKEND} \
    -e KEY_VALUE_DB=${KEY_VALUE_DB_NAME} \
    -e KEY_VALUE_USER=${KEY_VALUE_DB_USER} \
    -e KEY_VALUE_PASSWORD=${KEY_VALUE_DB_PASSWORD} \
    -e MONGO_DBHOST=${CONTAINER_NAME} \
    -e PORT=${LOCAL_CONTAINER_PORT} \
    -p ${LOCAL_HOST_PORT}:${LOCAL_CONTAINER_PORT} \
    -v ./backend/src:/app/src \
    --network ${NETWORK_NAME} \
    ${IMAGE_NAME_BACKEND}