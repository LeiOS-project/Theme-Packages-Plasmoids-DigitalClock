#!/usr/bin/env bash
#
# Installs the DigitalClock plasmoid to the system for development purposes.
#
# Usage:
#   ./scripts/dev-install.sh

set -euo pipefail

sudo mkdir -p /usr/share/plasma/plasmoids/dev.leios.theme-packages.plasmoids.digitalclock
sudo rsync -a --delete ./src/ /usr/share/plasma/plasmoids/dev.leios.theme-packages.plasmoids.digitalclock/
sudo chown -R root:root /usr/share/plasma/plasmoids/dev.leios.theme-packages.plasmoids.digitalclock

#systemctl --user restart plasma-plasmashell.service

systemctl --user stop plasma-plasmashell.service

rm -rf ~/.cache/plasma* ~/.cache/*.kcache ~/.cache/plasmashell/qmlcache/

systemctl --user start plasma-plasmashell.service
