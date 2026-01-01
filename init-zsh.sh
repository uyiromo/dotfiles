#!/bin/bash
set -ue
set -o pipefail

if command -v apt >/dev/null 2>&1; then
    sudo apt install -y zsh
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y zsh
elif [ "Darwin" = "$(uname -s)" ]; then
    brew install zsh
else
    echo "Neither apt-get nor dnf found. Exiting."
    exit 1
fi

# zinit
if [[ -d "${HOME}/.zinit" ]]; then
    mv "${HOME}/.zinit" "${HOME}/.zinit.bak-$(date +%s)"
fi
git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.zinit"

if [[ -e "${HOME}/.zshrc" ]]; then
    mv "${HOME}/.zshrc" "${HOME}/.zshrc.bak-$(date +%s)"
fi
ln -s "$(realpath .zshrc)" "${HOME}/.zshrc"

# shellcheck disable=SC2046
chsh -s /bin/zsh
