#!/usr/bin/env bash
#
# Reloads a Plasma 6 plasmoid and restarts the desktop shell.
#
# Usage:
#   ./reload-plasmoid.sh

set -euo pipefail

systemctl --user restart plasma-plasmashell.service
