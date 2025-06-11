#!/bin/bash
set -ue
set -o pipefail

code --list-extensions >vscode/extensions.txt

# check: against README.md
xargs -a vscode/extensions.txt -I{} bash -c "if grep -i -q {} README.md; then :; else echo "{}"; fi"
