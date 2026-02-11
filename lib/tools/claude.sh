#!/bin/bash
command -v claude >/dev/null && exit 0
curl -fsSL https://claude.ai/install.sh | bash
