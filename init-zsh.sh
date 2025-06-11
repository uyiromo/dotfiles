#!/bin/bash
set -ue
set -o pipefail

if command -v apt >/dev/null 2>&1; then
    sudo apt install -y vim
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y vim
else
    echo "Neither apt-get nor dnf found. Exiting."
    exit 1
fi

# zinit
git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.zinit"

ln -sb "$(realpath .zshrc)" "${HOME}/.zshrc"

# shellcheck disable=SC2046
chsh -s $(which zsh)
