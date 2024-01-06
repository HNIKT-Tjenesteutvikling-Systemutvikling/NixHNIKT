#!/usr/bin/env bash

# Check if profile exists
if [ -d ~/.local/state/nix/profiles ]; then
    echo "Profile exists"
else
    echo "Profile does not exist"
    mkdir -p ~/.local/state/nix/profiles
fi

git add -f userSetting.nix

# Extract the username from the userSetting.nix file
flake=$(grep 'hostname' userSetting.nix | cut -d '"' -f 2)
home_name="dev@$flake"

# Install Home-manager
nix run github:nix-community/home-manager#home-manager -- switch --flake .#$home_name;

git reset userSetting.nix

echo "Home-manager installed"
