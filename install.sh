#!/usr/bin/env bash

set -ex

# Stage the new userSetting.nix file
git add -f userSetting.nix

# Extract the username from the userSetting.nix file
username=$(grep 'hostname' userSetting.nix | cut -d '"' -f 2)

# Source your setup script
source ./scripts/setup.sh

# Run the nixos-install command
nixos-install --flake .#$username
