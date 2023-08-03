#!/usr/bin/env bash

set -ex

echo "Updating system..."
echo "Run a garbage collection?"
echo "1. Yes, 2. No"
read gc

# Run a garbage collection
if [[ "$gc" == "1" ]]
then
    sudo nix-collect-garbage -d
    continue
else
    continue
fi

git pull
clear
echo "set flake..."
echo "1. hnikt, 2. grindstein, 3. sigubrat, 4. turbonaepskrel"
echo "Enter the number of the flake you want to use: "

read flake

# Set the flake
if [[ "$flake" == "1" ]]
then
    flake="hnikt"
elif [[ "$flake" == "2" ]]
then
    flake="grindstein"
elif [[ "$flake" == "3" ]]
then
    flake="sigubrat"
elif [[ "$flake" == "4" ]]
then
    flake="turbonaepskrel"
else
    echo "Invalid input!"
    echo "Use 1, 2, 3 or 4"
    exit 1
fi

# Check if the user wants to test the flake
clear
echo "For testing flake choose <<test>>"
read test
if [[ "$test" == "test" ]]
then
    echo "Testing flake..."
    sudo nixos-rebuild build --flake .#$flake
    exit 0
else
    continue
fi

# Run the nixos-rebuild command
clear
echo "Updating system..."
sudo nixos-rebuild switch --flake .#$flake

# Clean up
clear
echo "System updated!, updating home-manager..."
home_name="dev@$flake"

# Update home-manager
home-manager switch --flake .#$home_name
