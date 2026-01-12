#!/bin/bash
set -ue
set -o pipefail

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# ruff
curl -LsSf https://astral.sh/ruff/install.sh | sh
