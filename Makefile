# Makefile for OpenCA docker dev
# (c) 2021-2023 by Massimiliano Pala and OpenCA Labs
# All Rights Reserved

.PHONY: help all ubuntu ubuntu24/base ubuntu24/oqs ubuntu24/libpki dev


help:
	@echo
	@echo "    Usage: make [ ubuntu | ubuntu24/base | ubuntu24/oqs | ubuntu24/libpki ]"
	@echo
	@exit 1

all: ubuntu

ubuntu: ubuntu24/base ubuntu24/oqs

ubuntu/no-cache:: ubuntu24/base/no-cache ubuntu24/oqs/no-cache

ubuntu24/base/no-cache::
	@bin/docker-gen-image.sh ubuntu24
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu22-base.yml ~/.dockercompose/

ubuntu24/oqs::
	@bin/docker-gen-image.sh ubuntu24-oqs
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu24-oqs.yml ~/.dockercompose/

ubuntu24/base::
	@bin/docker-gen-image.sh ubuntu24
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu22-base.yml ~/.dockercompose/

ubuntu24/libpki::
	@bin/docker-gen-image.sh ubuntu24-libpki
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu24-libpki.yml ~/.dockercompose/

dev:
	@bin/dev.sh docker-image

