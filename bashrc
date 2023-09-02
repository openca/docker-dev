# Docker DEV environments
alias "ubuntu-oqs-up"="docker compose -f ~/Devel/OpenCA/Github/docker-dev/Docker/docker-compose-ubuntu22-base.yml -p dev up -d"
alias "ubuntu-oqs-down"="docker compose -p dev down"
alias "ubuntu-oqs-bash"="docker exec -it dev-ubuntu22-base-oqs-1 /bin/bash"

# Docker DEV environments
alias "ubuntu-libpki-oqs-up"="docker compose -f ~/Devel/OpenCA/Github/docker-dev/Docker/docker-compose-ubuntu22-libpki.yml -p dev up -d"
alias "ubuntu-libpki-oqs-down"="docker compose -p dev down"
alias "ubuntu-libpki-oqs-bash"="docker exec -it dev-ubuntu22-libpki-oqs-1 /bin/bash"

