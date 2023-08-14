#!/usr/bin/env bash

# Check if profile exists
if [ -d ~/.local/state/nix/profiles ]; then
    echo "Profile exists"
else
    echo "Profile does not exist"
    mkdir -p ~/.local/state/nix/profiles
fi

# Get flake input from the user
clear
echo "Please enter the flake:"
echo "1. grindstein, 2. jca, 3. solheim, 4. sigubrat, 5. turbonaepskrel"

read flake
# Set the flake
if [[ "$flake" == "1" ]]
then
    flake="grindstein"
elif [[ "$flake" == "2" ]]
then
    flake="jca"
elif [[ "$flake" == "3" ]]
then
    flake="solheim"
elif [[ "$flake" == "4" ]]
then
    flake="sigubrat"
elif [[ "$flake" == "5" ]]
then
    flake="turbonaepskrel"
else
    echo "Invalid input!"
    echo "Use 1, 2, 3 or 4 or 5"
    exit 1
fi
home_name="dev@$flake"

# Install Home-manager
nix run github:nix-community/home-manager#home-manager -- switch --flake .#$home_name;
