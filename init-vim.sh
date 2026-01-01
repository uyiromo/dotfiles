#!/bin/bash
set -ue
set -o pipefail

if command -v apt >/dev/null 2>&1; then
    sudo apt install -y vim
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y vim
elif [ "Darwin" = "$(uname -s)" ]; then
    brew install vim
else
    echo "Neither apt-get nor dnf found. Exiting."
    exit 1
fi

if [[ -e "${HOME}/.vimrc" ]]; then
    mv "${HOME}/.vimrc" "${HOME}/.vimrc.bak-$(date +%s)"
fi
ln -s "$(realpath .vim)" "${HOME}/.vim"

if [[ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"
fi

#if [[ ! -d "${HOME}/.vim/pack/github/start/copilot.vim" ]]; then
#    git clone https://github.com/github/copilot.vim.git "${HOME}/.vim/pack/github/start/copilot.vim"
#fi

vim +PluginInstall +qall
