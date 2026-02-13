#!/bin/bash
# brew: 1password-cli
command -v op >/dev/null && exit 0
curl -sSfo /tmp/op.deb "https://downloads.1password.com/linux/debian/$(dpkg --print-architecture)/stable/1password-cli-$(dpkg --print-architecture)-latest.deb"
sudo dpkg -i /tmp/op.deb
rm /tmp/op.deb
