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

# Phony targets
.PHONY: help all ubuntu ubuntu24/base ubuntu24/oqs ubuntu24/libpki dev

help:
	@echo
	@echo "    Usage: make [ all | devenv-base | devenv-crypto | devenv-libpki | scripts ]"
	@echo
	@exit 1

all: ubuntu

devenv-base:: ubuntu24/base

ubuntu24/base:: ubuntu24/base/build ubuntu24/base/push

ubuntu24/base/build::
	@bin/build-openca-devenv ubuntu24 n $(NOCACHE)
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu24.yml ~/.dockercompose/

ubuntu24/base/push: SRC_TAG=openca.org/ubuntu24:latest
ubuntu24/base/push: 
ubuntu24/base/push:

devenv-crypto:: ubuntu24/crypto

ubuntu24/crypto:: ubuntu24/crypto/build ubuntu24/crypto/push

ubuntu24/crypto/build::
	@bin/build-openca-devenv ubuntu24-crypto n $(NOCACHE)
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu24-crypto.yml ~/.dockercompose/

ubuntu24/crypto/push: SRC_TAG=openca.org/ubuntu24:latest
ubuntu24/crypto/push: DST_TAG_BASE=ghcr.io/$(REPO_OWNER)/devenv-crypto
ubuntu24/crypto/push: docker-push

devenv-libpki:: ubuntu24/libpki

ubuntu24/libpki:: ubuntu24/libpki/build ubuntu24/libpki/push

ubuntu24/libpki/build::
	@bin/build-openca-devenv ubuntu24-libpki n $(NOCACHE)
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu24-libpki.yml ~/.dockercompose/

ubuntu24/libpki/push: SRC_TAG=ghcr.io/openca/devenv-crypto:latest
ubuntu24/libpki/push: DST_TAG_BASE=ghcr.io/$(REPO_OWNER)/devenv-libpki
ubuntu24/libpki/push: docker-push

docker-push:
	@echo "Pushing the Docker image to GitHub repository (TAG=$(TAG))..."
	@if [ "x$(DST_TAG_BASE)" != "x" ] ; then \
		docker image tag "$(SRC_TAG)" "$(DST_TAG_BASE):latest" ; \
		docker image tag "$(SRC_TAG)" "$(DST_TAG_BASE):$(NOW)" ; \
	 fi
	@echo $(CR_PAT) | docker login ghcr.io -u $(CR_USR) --password-stdin && \
		docker push "$(DST_TAG_BASE):$(NOW)" && \
		docker push "$(DST_TAG_BASE):latest"
	@echo "Docker image pushed successfully."
	@echo ""

scripts:
	@target_dir=~/bin; \
	 if ! [ -d "$$target_dir" ]; then \
	 	target_dir=~/.bin ; \
	 	if ! [ -d "$$target_dir" ]; then \
	 		echo "Creating target directory: $$target_dir"; \
	 		mkdir -p "$$target_dir" ; \
	 	fi; \
	 fi ; \
	 echo && echo "Copying scripts to the local directory ($$target_dir)..." ; \
	 cp -r bin/openca-devenv "$$target_dir"/
	@echo ""
	@echo "Please make sure to add the target directory to your PATH variable."
	@echo ""
