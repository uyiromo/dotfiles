#!/bin/bash
set -ue
set -o pipefail

# create .ssh
dotssh="${HOME}/.ssh"
mkdir -p "${dotssh}"
chmod 700 "${dotssh}"

# ln
if [[ -e "${dotssh}/config" ]]; then
    mv "${dotssh}/config" "${dotssh}/config.bak-$(date +%s)"
fi
ln -s "$(realpath .ssh/config)" "${dotssh}/config"
chmod 600 "${dotssh}/config"

# setup github.com public key
curl -fsS https://github.com/uyiromo.keys >>"${dotssh}/authorized_keys"
