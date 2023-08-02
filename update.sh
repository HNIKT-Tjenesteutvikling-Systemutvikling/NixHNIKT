#!/usr/bin/env bash

set -ex

echo "Updating system..."
git pull
clear
echo "set flake..."
echo "1. hnikt, 2. grindstein, 3. sigubrat, 4. turbonaepskrel"
read flake


# Run the nixos-rebuild command
sudo nixos-rebuild switch --flake .#$flake

# Clean up
echo "System updated!, updating home-manager..."
home_name="dev@$flake"

# Update home-manager
home-manager switch --flake .#$home_name
