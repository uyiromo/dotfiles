#!/bin/bash
set -ue
set -o pipefail

ln -sb "$(realpath .tmux.conf)" "${HOME}/.tmux.conf"
