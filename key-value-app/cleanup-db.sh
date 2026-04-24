#!/bin/bash
source .env.db
source .env.network
source .env.volume

if [ "$(docker ps -q -f name=^${CONTAINER_NAME}$)" ]; then
    echo "Stopping container: ${CONTAINER_NAME}"
    docker stop ${CONTAINER_NAME}
else
    echo "Container not running: ${CONTAINER_NAME}"
fi

if [ "$(docker ps -aq -f name=^${CONTAINER_NAME}$)" ]; then
    echo "Removing container: ${CONTAINER_NAME}"
    docker rm ${CONTAINER_NAME}
else
    echo "Container does not exist: ${CONTAINER_NAME}"
fi

if [ "$(docker volume ls -q -f name=^${VOLUME_NAME}$)" ]; then
    echo "Removing volume: ${VOLUME_NAME}"
    docker volume rm ${VOLUME_NAME}
else
    echo "Volume does not exist: ${VOLUME_NAME}"
fi

if [ "$(docker network ls -q -f name=^${NETWORK_NAME}$)" ]; then
    echo "Removing network: ${NETWORK_NAME}"
    docker network rm ${NETWORK_NAME}
else
    echo "Network does not exist: ${NETWORK_NAME}"
fi
