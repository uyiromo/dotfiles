#!/bin/bash
set -ue
set -o pipefail

ln -sb "$(realpath .vim)" "${HOME}/.vim"

if [[ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"
fi

if [[ ! -d "${HOME}/.vim/pack/github/start/copilot.vim" ]]; then
    git clone https://github.com/github/copilot.vim.git "${HOME}/.vim/pack/github/start/copilot.vim"
fi

vim +PluginInstall +qall
