#!/bin/sh

DEV_OS_IMAGE=openca.org/ubuntu24-crypto:latest

# Accept one argument
PROJECT_NAME=$1

# Default Value
if [ "x$PROJECT_NAME" = "x" ] ; then
	PROJECT_NAME=unspecified-dev
fi

# Check the dev network is available
if [ "$(docker network ls | grep devnet)" = "" ] ; then
  # Create the dev network
  docker network create devnet
fi

# Runs the container
docker container run -d --rm --tty \
  -v "$PWD:/workspace" --network devnet \
  --name "$PROJECT_NAME" "$DEV_OS_IMAGE"

exit 0

