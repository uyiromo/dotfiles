#!/bin/bash
set -ue
set -o pipefail

xargs -a vscode/extensions.txt -I{} code --install-extension {}
