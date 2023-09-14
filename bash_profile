# Docker ubuntu-oqs (base)
alias "ubuntu-oqs-up"="docker compose -f ~/.dockercompose/docker-compose-ubuntu22-base.yml -p dev up -d"
alias "ubuntu-oqs-down"="docker compose -p dev down"
alias "ubuntu-oqs-bash"="docker exec -it dev-ubuntu22-base-oqs-1 /bin/bash"

# Docker ubuntu-libpki (libpki)
alias "ubuntu-libpki-up"="docker compose -f ~/.dockercompose/docker-compose-ubuntu22-libpki.yml -p dev up -d"
alias "ubuntu-libpki-down"="docker compose -p dev down"
alias "ubuntu-libpki-bash"="docker exec -it dev-ubuntu22-libpki-oqs-1 /bin/bash"

