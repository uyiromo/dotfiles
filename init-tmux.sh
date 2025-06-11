#!/bin/bash
set -ue
set -o pipefail

if command -v apt >/dev/null 2>&1; then
    sudo apt install -y tmux
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y tmux
else
    echo "Neither apt-get nor dnf found. Exiting."
    exit 1
fi

sudo apt-get install -y tmux
ln -sb "$(realpath .tmux.conf)" "${HOME}/.tmux.conf"
