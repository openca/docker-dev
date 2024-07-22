# Makefile for OpenCA docker dev
# (c) 2021-2023 by Massimiliano Pala and OpenCA Labs
# All Rights Reserved

all:
	@echo
	@echo "    Usage: make [ ubuntu | ubuntu24 | ubuntu22/base | ubuntu22/libpki ]"
	@echo
	@exit 1

ubuntu: ubuntu22/base ubuntu22/libpki

ubuntu24::
	@bin/docker-gen-image.sh ubuntu24
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu24.yml ~/.dockercompose/

ubuntu24/oqs::
	@bin/docker-gen-image.sh ubuntu24-oqs
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu24-oqs.yml ~/.dockercompose/

ubuntu22/base::
	@bin/docker-gen-image.sh ubuntu22-base
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu22-base.yml ~/.dockercompose/

ubuntu22/libpki::
	@bin/docker-gen-image.sh ubuntu22-libpki
	@mkdir -p ~/.dockercompose && \
	 cp Docker/docker-compose-ubuntu22-libpki.yml ~/.dockercompose/

