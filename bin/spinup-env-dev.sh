#!/bin/bash

echo
echo "Docker Spinup Script for DEV Environments - v1.0.0"
echo "(c) Massimiliano Pala and OpenCA Labs"
echo "All Rights Reserved"
echo

# Version to use
DOCKER_BASE_IMAGE=openca.org/dev
DOCKER_IMAGE_VERSION=latest
PULL_IMAGES=no

# Second argument to pull the images
if [ "x$1" = "xy" -o "x$1" = "xyes" ] ; then
  PULL_IMAGES=no
fi

# Some info
echo "   NOTE: USING DOCKER TAG (VERSION): $DOCKER_IMAGE_VERSION"
echo

# All Images that need to be mounted
IMG_CENTOS7_DEV=$DOCKER_BASE_IMAGE/centos7:$DOCKER_IMAGE_VERSION
NAME_CONTAINER_CENTOS7_DEV=centos7-dev

# Network Name
NAME_NETWORK=dev-network

# pull down images
if [ "$PULL_IMAGES" = "yes" ] ; then
  docker pull $IMG_CENTOS7_DEV
fi

# Shutdown Running Instances
docker container rm -f $NAME_CONTAINER_CENTOS7_DEV || true
docker network rm $NAME_NETWORK || true

# create user-defined bridge network if it doesn't exist yet
docker network create --driver bridge $NAME_NETWORK || true

# start dev container
echo docker run --network $NAME_NETWORK --name $NAME_CONTAINER_CENTOS7_DEV \
   --mount type=bind,src="$(pwd)",target=/workspace -p 127.0.0.1:80:8000 \
   -d $IMG_CENTOS7_DEV

docker run --network $NAME_NETWORK --name $NAME_CONTAINER_CENTOS7_DEV \
  --mount type=bind,src="$(pwd)",target=/workspace -p 127.0.0.1:80:8000 \
  -d $IMG_CENTOS7_DEV

# Aliases to access the Bash on each container
echo
echo "Aliases for bashrc:"
echo "docker-centos7-bash"="docker exec -it centos7-dev /bin/bash"
echo

exit 0
