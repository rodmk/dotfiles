#!/bin/bash
command -v uv >/dev/null && exit 0
curl -LsSf https://astral.sh/uv/install.sh | sh
