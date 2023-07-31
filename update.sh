#!/usr/bin/env bash

set -ex

echo "Updating system..."
git pull

# Run the nixos-rebuild command
sudo nixos-rebuild switch --flake .#hnikt

# Clean up
echo "System updated!, updating home-manager..."

# Update home-manager
home-manager switch --flake .#"dev@hnikt"
