#!/bin/bash
set -ue
set -o pipefail

# zinit
git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.zinit"

ln -sb "$(realpath .zshrc)" "${HOME}/.zshrc"

# shellcheck disable=SC2046
chsh -s $(which zsh)
