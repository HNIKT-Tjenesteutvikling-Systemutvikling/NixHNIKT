#!/usr/bin/env bash

set -ex

git add -f userSetting.nix

# Extract the username from the userSetting.nix file
flake=$(grep 'hostname' userSetting.nix | cut -d '"' -f 2)
home_name="dev@$flake"

# Test system
clear
echo "Do you want to test the system or home-manager?"
echo "1. System, 2. Home-manager, 3. Both, 4. None"
read test

if [[ "$test" == "1" ]]; then
    nixos-rebuild build --flake .#$flake
    git reset userSetting.nix
    exit 0
elif [[ "$test" == "2" ]]; then
    home-manager build --flake .#$home_name
    git reset userSetting.nix
    exit 0
elif [[ "$test" == "3" ]]; then
    nixos-rebuild build --flake .#$flake
    home-manager build --flake .#$home_name
    git reset userSetting.nix
    exit 0
else
    continue
fi

echo "Updating system..."
echo "Run a garbage collection?"
echo "1. Yes, 2. No"
read gc

# Run a garbage collection
if [[ "$gc" == "1" ]]; then
    sudo nix-collect-garbage -d
    continue
else
    continue
fi

git pull
clear

# Run the nixos-rebuild command
echo "Updating system for $flake..."
sudo nixos-rebuild switch --flake .#$flake

# Clean up
clear

# Update home-manager
echo "System updated!, updating home-manager for $home_name..."
home-manager switch --flake .#$home_name

# Clean up
git reset userSetting.nix
