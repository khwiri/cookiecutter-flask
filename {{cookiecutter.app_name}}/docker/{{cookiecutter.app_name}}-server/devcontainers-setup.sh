#!/usr/bin/env bash
set -e

if [[ -n $DEV_CONTAINERS ]]; then
    printf "\\e[32mstarting devcontainer setup\\n\\e[0m"
else
    printf "\\e[32mskipping devcontainer setup\\n\\e[0m"
    exit;
fi

install_nvm()
(
    cd ~
    curl --output nvm-install.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh
    echo "c1e672cd63737cd3e166ad43dffcb630a3bea07484705eae303c4b6c3e42252a  nvm-install.sh" | sha256sum --check
    chmod +x nvm-install.sh && ./nvm-install.sh
)

printf "\\e[32minstalling additional packages\\n\\e[0m"
apt install --yes vim

printf "\\e[32minstalling node version manager\\n\\e[0m"
install_nvm

if [[ -n $DEV_NODE_VERSION ]]; then
    printf "\\e[32minstalling node %s and project dependencies\\n\\e[0m" "$DEV_NODE_VERSION"
    cp /devcontainer-setup-staging/package*.json .
    bash --login -c "nvm install ${DEV_NODE_VERSION} && npm install"
else
    printf "\\e[32mskipping node install\\n\\e[0m"
fi
