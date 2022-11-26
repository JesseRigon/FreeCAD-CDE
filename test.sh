. ./.env

docker run -it --rm \
-v $SOURCE_FOLDER:/mnt/source \
-v $BUILD_FOLDER:/mnt/build \
-v $FILES_FOLDER:/mnt/files \
-e "DISPLAY" -e "QT_X11_NO_MITSHM=1" -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
registry.gitlab.com/daviddaish/freecad_docker_env:latest

xhost si:localuser:root

