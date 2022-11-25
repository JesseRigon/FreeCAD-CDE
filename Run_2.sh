#!/usr/bin/env sh

. ./.env

#export DOCKER_BUILDKIT=1
#export COMPOSE_DOCKER_CLI_BUILD=1

xhost +local:
mkdir -p "${BUILD_FOLDER}"
mkdir -p "${FILES_FOLDER}"

docker-compose down
docker-compose up --build --remove-orphans
