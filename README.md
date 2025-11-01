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

where the type is 'ubuntu24' (uses the Docker/Dockerfile.ubuntu24.yml) and
the second argument is for pushing (y/n) the image to the repo after
creation. The last argument 'no-cache' is used to generate the image
from scratch (no cache).

### Use makefile Targets to Build the Image

You can also use the Makefile to build the image. The Makefile is
located in the root of the repository. You can use the following
commands to build the image:

```bash
$ make [ all | base-dev | crypto-dev | libpki-dev | scripts ]
```

The `all` target will build all the images, while the other targets
will build the specific images. The `base-dev` target will build the
base development image, the `crypto-dev` target will build the
cryptographic development image, and the `libpki-dev` target will
build the libpki development image. The `scripts` target will copy the
scripts to the local directory.

Internally, the Makefile uses the `docker-gen-image.sh` script to build the
images.

# The docker-dev.sh Script

To simplify the management of multiple DEV containers running at the same time,
we added the dev.sh script (you can find it in the bin/ directory). This script
accepts one argument for the name of the container and uses a variable for the
image to use for the container. The current directory is bound to the work
directory in the image /workdir.

You can copy the script to your bin directory or use it directly from the
repository (e.g., ~/bin/docker-dev.sh or ~/.bin/docker-dev.sh)

Example:

```sh
$ openca-devenv [-k] [project-name]
```

This starts a new image named 'project-name' inside the 'devnet' network. The default
name used for the container when 'project-name' is not given is taken from the name
of the current directory. When the -k option is used, the script will kill the container
if it is already running.

When trying to start a container with the same name, the script will generate an error
and will not start the container. When killing a container that has not been started, the script
will generate an error and will not kill any container.

## Contributing

We welcome contributions to this project. If you have suggestions or improvements, please feel free to open an issue or submit a pull request.

Please make sure to follow the [Code of Conduct](docs/CODE_OF_CONDUCT.md) when contributing to this project.

More information on how to contribute can be found in the
[CONTRIBUTING.md](docs/CONTRIBUTING.md) file.

## Code of Conduct

We are committed to providing a friendly, safe, and welcoming
environment for all, regardless of their background or identity.

Please read our [Code of Conduct](docs/CODE_OF_CONDUCT.md) to understand our expectations for participants and the consequences for unacceptable behavior.

## Authors and Contributors

The OpenCA Software project is maintained by a team of developers and contributors. We would like to thank all the contributors for their hard work and dedication.

The following people have contributed to this project:
- Massimiliano Pala, OpenCA Labs Founder and Director

Enjoy OpenCA Software and Open Source!