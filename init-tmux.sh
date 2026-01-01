#!/bin/bash
set -ue
set -o pipefail

if command -v apt >/dev/null 2>&1; then
    sudo apt install -y tmux
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y tmux
elif [ "Darwin" = "$(uname -s)" ]; then
    brew install tmux
else
    echo "Neither apt-get nor dnf found. Exiting."
    exit 1
fi

if [[ -e "${HOME}/.tmux.conf" ]]; then
    mv "${HOME}/.tmux.conf" "${HOME}/.tmux.conf.bak-$(date +%s)"
fi
ln -sf "$(realpath .tmux.conf)" "${HOME}/.tmux.conf"
