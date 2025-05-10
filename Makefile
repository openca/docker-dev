# Makefile for OpenCA docker dev
# (c) 2021-2023 by Massimiliano Pala and OpenCA Labs
# All Rights Reserved

# Includes the details for the docker image
-include .env

# NOW auxiliary variable
NOW := $(shell date +%Y%m%d)

# Repository information
REPO_OWNER := openca
REPO_NAME := docker-dev


.PHONY: help all ubuntu ubuntu24/base ubuntu24/oqs ubuntu24/libpki dev

help:
	@echo
	@echo "    Usage: make [ all | base-dev | crypto-dev | libpki-dev ]"
	@echo
	@exit 1

all: ubuntu

base-dev:: ubuntu24/base

ubuntu24/base:: ubuntu24/base/build # ubuntu24/docker/push

ubuntu24/base/build::
	@bin/docker-gen-image.sh ubuntu24
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu24.yml ~/.dockercompose/

ubuntu24/docker/push: TAG=openca.org/ubuntu24:latest
ubuntu24/docker/push: docker-push

crypto-dev:: ubuntu24/crypto

ubuntu24/crypto:: ubuntu24/crypto/build ubuntu24/crypto/push

ubuntu24/crypto/build::
	@bin/docker-gen-image.sh ubuntu24-crypto
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu24-crypto.yml ~/.dockercompose/

ubuntu24/crypto/push: TAG=openca.org/ubuntu24-crypto:latest
ubuntu24/crypto/push: docker-push

libpki-dev:: ubuntu24/libpki

ubuntu24/libpki:: ubuntu24/libpki/build ubuntu24/libpki/push

ubuntu24/libpki/build::
	@bin/docker-gen-image.sh ubuntu24-libpki
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu24-libpki.yml ~/.dockercompose/

ubuntu24/libpki/push: TAG=openca.org/ubuntu24-libpki:latest
ubuntu24/libpki/push: docker-push

docker-push:
	@echo "Pushing the Docker image to GitHub repository (TAG=$(TAG))..."
	@docker image tag "$(TAG)" "ghcr.io/$(REPO_OWNER)/$(REPO_NAME):latest"
	@docker image tag "$(TAG)" "ghcr.io/$(REPO_OWNER)/$(REPO_NAME):$(NOW)"
	@echo $(CR_PAT) | docker login ghcr.io -u $(CR_USR) --password-stdin && \
		docker push "ghcr.io/$(REPO_OWNER)/$(REPO_NAME):latest" && \
		docker push "ghcr.io/$(REPO_OWNER)/$(REPO_NAME):$(NOW)"
	@echo "Docker image pushed successfully."
	@echo ""

run-base:
	@IMAGE=openca.org/ubuntu24:latest bin/docker-dev.sh

run-crypto:
	@IMAGE=openca.org/ubuntu24-crypto:latest bin/dev.sh 

run-libpki:
	@IMAGE=openca.org/ubuntu24-libpki:latest bin/dev.sh
