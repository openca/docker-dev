#!/bin/bash

echo "Docker Image Push for ACM:C - v0.0.1"
echo "(c) Massimiliano Pala and CableLabs, Inc."
echo "All Rights Reserved"
echo

if [ "$1" = "" ] ; then
  echo "ERROR: Missing required parameter (image name)"
  echo
  echo "    USAGE: $0 [ dev | dev-pqc | gateway | gateway-pqc | mysql | redis ] [ y | n ]"
  echo
  echo "Where the first argument is the image name. Use 'y' as the second argument"
  echo "to force the pushing of the image to the official repository on CodeLab."
  echo
  exit 1
fi

export TAG_BASE_URL=code.cablelabs.com:4567/acm-project/acm-gateway
export TAG_IMAGE_LATEST=$TAG_BASE_URL/$1:latest

case "$1" in
  dev)
    ;;

  dev-pqc)
    ;;

  gateway)
    ;;

  gateway-pqc)
    ;;

  mysql)
    ;;

  redis)
    ;;

  *)
     echo "ERROR: please use one of the allowed names for the image:"
     echo "       (one of dev, dev-pqc, gateway, gateway-pqc, mysql, redis)"
     echo
     exit 0
    ;;

esac

echo "Please login into the CableLabs Code Repository:"
echo
# Logins and Pushes the image to the cablelabs repo, if requested
docker login code.cablelabs.com:4567 && \
  echo && echo "Pushing image to ${TAG_IMAGE_LATEST} ..." && \
    docker push ${TAB_IMAGE_LATEST}

echo
echo "All Done."
echo

exit 0
