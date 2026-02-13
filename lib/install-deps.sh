#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Bootstrap make if missing (needed for the Makefile)
if ! command -v make >/dev/null 2>&1; then
    echo "Installing make..."
    if [ "$(uname)" = "Darwin" ]; then
        xcode-select --install 2>/dev/null || true
    else
        sudo apt-get install -y make 2>/dev/null || { sudo apt-get update && sudo apt-get install -y make; }
    fi
fi

make -C "$SCRIPT_DIR" install
