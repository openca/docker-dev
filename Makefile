# Makefile for OpenCA docker dev
# (c) 2021-2023 by Massimiliano Pala and OpenCA Labs
# All Rights Reserved

all: ubuntu22/base ubuntu22/libpki

ubuntu22:
ubuntu22/base:
	@bin/docker-gen-image.sh ubuntu22-base

ubuntu22/libpki:
	@bin/docker-gen-image.sh ubuntu22-libpki

