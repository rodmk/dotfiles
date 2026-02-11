#!/bin/bash
# brew: MisterTea/et/et
command -v et >/dev/null && exit 0
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:jgmath2000/et
sudo apt-get update && sudo apt-get install -y et
