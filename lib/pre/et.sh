#!/bin/bash
# brew: MisterTea/et/et
# apt: et
[ "$(uname)" = "Darwin" ] && exit 0
command -v et >/dev/null && exit 0
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y --no-update ppa:jgmath2000/et
