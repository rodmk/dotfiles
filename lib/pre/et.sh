#!/bin/bash
# brew: MisterTea/et/et
# apt: et
[ "$(uname)" = "Darwin" ] && exit 0
command -v et >/dev/null && exit 0
command -v add-apt-repository >/dev/null || { sudo apt-get update && sudo apt-get install -y software-properties-common; }
sudo add-apt-repository -y --no-update ppa:jgmath2000/et
