#!/usr/bin/env bash
#
# Reloads a Plasma 6 plasmoid and restarts the desktop shell.
#
# Usage:
#   ./reload-plasmoid.sh [PLASMOID_PATH]

set -euo pipefail

PLASMOID_PATH="${1:-/usr/share/plasma/plasmoids/dev.leios.theme-packages.plasmoids.digitalclock}"
QML_CACHE_DIR="${HOME}/.cache/plasmashell/qmlcache"

# Ensure the path exists
if [[ ! -e "$PLASMOID_PATH" ]]; then
    echo "Error: Plasmoid path does not exist: $PLASMOID_PATH" >&2
    exit 1
fi

# Ensure kpackagetool6 is available
if ! command -v kpackagetool6 >/dev/null 2>&1; then
    echo "Error: kpackagetool6 not found. Please install KDE development tools." >&2
    exit 1
fi

echo "Setting up Plasmoid: $PLASMOID_PATH"

# Determine if we need system-wide (global) installation with sudo,
# or user-space installation without root privileges.
if [[ "$PLASMOID_PATH" == /usr/share/* ]]; then
    echo "Using global upgrade (requires sudo)..."
    sudo kpackagetool6 --global --upgrade "$PLASMOID_PATH"
else
    echo "Using user-space upgrade..."
    kpackagetool6 --type Plasma/Applet --upgrade "$PLASMOID_PATH"
fi

# Clear Plasma 6 QML cache
if [[ -d "$QML_CACHE_DIR" ]]; then
    echo "Clearing QML cache: $QML_CACHE_DIR"
    rm -rf "$QML_CACHE_DIR"/*
fi

# Restart plasmashell cleanly
echo "Restarting plasmashell..."
killall plasmashell 2>/dev/null || true

if command -v kstart6 >/dev/null 2>&1; then
    kstart6 plasmashell
else
    # Fallback if kstart6 isn't in PATH for some reason
    plasmashell >/dev/null 2>&1 &
fi

echo "Done. The shell is reloading."