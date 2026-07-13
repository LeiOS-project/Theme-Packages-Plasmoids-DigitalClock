#!/bin/bash

set -e

# Build
dpkg-buildpackage -us -uc


mkdir -p ./build/
mv ../leios.theme.plasmoids.digitalclock_* ./build/