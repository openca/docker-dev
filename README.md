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

where the type is 'ubuntu22-base' (uses the Docker/Dockerfile.ubuntu22-base.yml) and
the second argument is for pushing (y/n) the image to the repo after
creation. The last argument 'no-cache' is used to generate the image
from scratch (no cache).

# The dev.sh Script

To simplify the management of multiple DEV containers running at the same time,
we added the dev.sh script (you can find it in the bin/ directory). This script
accepts one argument for the name of the container and uses a variable for the
image to use for the container. The current directory is bound to the work
directory in the image /workdir.

Example:

```sh
$ ./dev.sh my_project
```

This starts a new image named my_project-dev. The default is to connect all
dev containers in the same docker network (devnet). Adjust the script's
variables to use different settings.

Enjoy OpenCA Software and Open Source!

Yours Truly,
Massimiliano Pala

