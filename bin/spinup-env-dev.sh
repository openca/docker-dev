#!/bin/bash

echo
echo "Docker Spinup Script for ACM:C - v2.0.0"
echo "(c) Massimiliano Pala and CableLabs, Inc."
echo "All Rights Reserved"
echo

# Version to use
DOCKER_BASE_IMAGE=openca.org/dev
DOCKER_IMAGE_VERSION=latest
PULL_IMAGES=no

# Second argument to pull the images
if [ "x$1" = "xy" -o "x$1" = "xyes" ] ; then
  PULL_IMAGES=yes
fi

# Some info
echo "   NOTE: USING DOCKER TAG (VERSION): $DOCKER_IMAGE_VERSION"
echo

# set script ENVs
# IMG_MYSQL=code.cablelabs.com:4567/acm-project/acm-gateway/mysql:latest
# IMG_REDIS=code.cablelabs.com:4567/acm-project/acm-gateway/redis:latest
# IMG_DEV=code.cablelabs.com:4567/acm-project/acm-gateway/dev:$ACM_DOCKER_VERSION

# All Images that need to be mounted
IMG_CENTOS7_DEV=$DOCKER_BASE_IMAGE/centos7:$DOCKER_IMAGE_VERSION
NAME_CONTAINER_CENTOS7_DEV=centos7-dev

# Network Name
NAME_NETWORK=dev-network

# pull down images
if [ "$PULL_IMAGES" = "yes" ] ; then
  # docker pull $IMG_MYSQL
  # docker pull $IMG_REDIS
  docker pull $IMG_CENTOS7_DEV 2>/dev/null >/dev/null
fi

# Shutdown Running Instances
docker container rm -f $NAME_CONTAINER_CENTOS7_DEV 2>/dev/null >/dev/null || true
docker network rm $NAME_NETWORK 2>/dev/null >/dev/null || true

# create user-defined bridge network if it doesn't exist yet
docker network create --driver bridge $NAME_NETWORK 2>/dev/null >/dev/null || true

# start dev container
docker run --network $NAME_NETWORK --name $NAME_CONTAINER_CENTOS7_DEV \
  --mount type=bind,src="$(pwd)",target=/workspace -p 127.0.0.1:80:8000 \
  -d $IMG_CENTOS7_DEV tail -f /dev/null 2>/dev/null

# Aliases to access the Bash on each container
echo
echo "Aliases for bashrc:"
echo "docker-centos7-bash"="docker exec -it centos7-dev /bin/bash"
echo

exit 0
