#!/usr/bin/env bash

set -ex

# Ask for the hostname
echo "Please enter the hostname:"
read hostname

# Source your setup script
source ./scripts/setup.sh

# Run the nixos-install command
nixos-install --flake .#$hostname