#!/bin/bash

DEB_BUILD=3

echo "Docker Build Script - v1.0.0"
echo "(c) Massimiliano Pala and OpenCA Labs"
echo "All Rights Reserved"
echo

if [ "$1" = "" ] ; then
  echo "ERROR: Missing required parameter (image name)"
  echo
  echo "    USAGE: $0 [ centos7 | ubuntu24 | ubuntu22-base | ubuntu22-libpki ] [ y | n ] [ no-cache ]"
  echo
  echo "Where the first argument is the image name. Use 'y' as the second argument"
  echo "to force the pushing of the image to the official repository on CodeLab."
  echo
  exit 1
fi

if [ "$2" = "yes" -o "$2" = "y" -o "$2" = "Y" ] ; then
  PUSH_IMAGE="yes"
else
  PUSH_IMAGE="no"
fi

if [ "$3" = "no-cache" -o "$2" = "no-cache" ] ; then
  NO_CACHE_OPT="--no-cache"
fi

# TODAY's DATE
TODAY=$(date +%Y%m%d)

# TAGS
export TAG_BASE_URL=openca.org

# Input Parameter Checks
case "$1" in

  centos7)
    export DOCKER_FILE="Docker/Dockerfile.$1"
    export OPTS="--build-arg DEV_BUILD=${DEV_BUILD} $NO_CACHE_OPT"
    export TAG_IMAGE_LATEST=$TAG_BASE_URL/centos:latest
    export TAG_IMAGE_VERSION=$TAG_BASE_URL/centos:7
    ;;
  
  ubuntu24)
    export DOCKER_FILE="Docker/Dockerfile.$1"
    export OPTS="--build-arg DEV_BUILD=${DEV_BUILD} $NO_CACHE_OPT"
    export TAG_IMAGE_LATEST=$TAG_BASE_URL/$1:latest
    export TAG_IMAGE_VERSION=$TAG_BASE_URL/$1:$(date +%Y%m%d)
    ;;

  ubuntu24-oqs)
    export DOCKER_FILE="Docker/Dockerfile.$1"
    export OPTS="--build-arg DEV_BUILD=${DEV_BUILD} $NO_CACHE_OPT"
    export TAG_IMAGE_LATEST=$TAG_BASE_URL/$1:latest
    export TAG_IMAGE_VERSION=$TAG_BASE_URL/$1:$(date +%Y%m%d)
    ;;

  ubuntu24-libpki)
    export DOCKER_FILE="Docker/Dockerfile.$1"
    export OPTS="--build-arg DEV_BUILD=${DEV_BUILD} $NO_CACHE_OPT"
    export TAG_IMAGE_LATEST=$TAG_BASE_URL/$1:latest
    export TAG_IMAGE_VERSION=$TAG_BASE_URL/$1:$(date +%Y%m%d)
    ;;

  ubuntu22-base)
    export DOCKER_FILE="Docker/Dockerfile.$1"
    export OPTS="--build-arg DEV_BUILD=${DEV_BUILD} $NO_CACHE_OPT"
    export TAG_IMAGE_LATEST=$TAG_BASE_URL/ubuntu:latest-base-oqs
    export TAG_IMAGE_VERSION=$TAG_BASE_URL/ubuntu:22.04-base-oqs
    ;;

  ubuntu22-libpki)
    export DOCKER_FILE="Docker/Dockerfile.$1"
    export OPTS="--build-arg DEV_BUILD=${DEV_BUILD} $NO_CACHE_OPT"
    export TAG_IMAGE_LATEST=$TAG_BASE_URL/ubuntu:latest-libpki-oqs
    export TAG_IMAGE_VERSION=$TAG_BASE_URL/ubuntu:22.04-libpki-oqs
    ;;

  *)
     echo "ERROR: please use one of the allowed names for the image:"
     echo "       (i.e., one of 'centos7', 'ubuntu22') "
     echo
     exit 0
     ;;

esac

echo "  - Using TAG_MAGE_LATEST: ${TAG_IMAGE_LATEST}"

# Some Info
echo "* Building Image from Dockerfile.$1 ..."
echo

# Build the image
docker build $NO_CACHE_OPT $OPTS -f "$DOCKER_FILE" -t "$TAG_IMAGE_LATEST" -t "$TAG_IMAGE_VERSION" .

# Checks the result and aborts on error
if [ $? -gt 0 ] ; then
  echo
  echo "ERROR: Cannot build image for [$DOCKER_FILE], aborting."
  echo
  exit 2
fi

# Pushes the image to the cablelabs repo, if requested
if [ "${PUSH_IMAGE}" = "yes" ] ; then
  docker login code.github.com:4567 && \
    docker push ${TAG_IMAGE_LATEST} && \
    docker push ${TAG_IMAGE_VERSION}
fi

echo
echo "All Done."
echo

exit 0
