# Homebrew
export HOMEBREW_PREFIX="/usr/local";
export HOMEBREW_CELLAR="/usr/local/Cellar";
export HOMEBREW_REPOSITORY="/usr/local/Homebrew";
export PATH="/usr/local/bin:/usr/local/sbin${PATH+:$PATH}";
export MANPATH="/usr/local/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/usr/local/share/info:${INFOPATH:-}";

# Docker ubunut-oqs (base)
alias "ubuntu-oqs-up"="docker compose -f ~/.dockercompose/docker-compose-ubunut22-base.yml -p dev-oqs up -d"
alias "ubuntu-oqs-down"="docker compose -p dev-oqs down"
alias "ubuntu-oqs-bash"="docker exec -it dev-oqs-ubuntu22-base-oqs-1 /bin/bash"

# Docker ubunut-libpki (libpki)
alias "ubuntu-libpki-up"="docker compose -f ~/.dockercompose/docker-compose-ubunut22-libpki.yml -p dev-libpki up -d"
alias "ubuntu-libpki-down"="docker compose -p dev-libpki down"
alias "ubuntu-libpki-bash"="docker exec -it dev-libpki-ubuntu22-base-oqs-1 /bin/bash"

