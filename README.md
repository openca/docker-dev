# docker-dev

Development Environments for OpenCA Software

## How to Use this Repository

When you need to develop against OpenCA software, you might need to
have a development environment built that is consistent and can be
deployed easily.

We have started this new repository that can be used to develop,
compile, and test the projects. This repo allows you to build Docker
images based on different base OS (e.g., Centos7)

### Build a new Image

To build a new image, you can use the bin/docker-gen-image.sh script
that accepts the image type (supported is 'centos7') use the foollowing
command:

  $ scripts/docker-gen-image.sh <type> [ y | n ] [no-cache]

where the type is 'centos7' (uses the Docker/Dockerfile.centos7) and
the second argument is for pushing (y/n) the image to the repo after
creation. The last argument 'no-cache' is used to generate the image
from scratch (no cache).

Enjoy OpenCA Software and Open Source!

Yours Truly,
Massimiliano Pala

