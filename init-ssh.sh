#!/bin/bash
set -ue
set -o pipefail

# create .ssh
dotssh="${HOME}/.ssh"
mkdir -p "${dotssh}"
chmod 700 "${dotssh}"

# ln
ln -sb "$(realpath .ssh/config)" "${dotssh}/config"
chmod 600 "${dotssh}/config"

# setup github.com public key
curl -fsS https://github.com/uyiromo.keys >>"${dotssh}/authorized_keys"
