#!/usr/bin/env bash

set -ex

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
    echo "Use 1, 2, 3, 4 or 5"
    exit 1
fi

# Source your setup script
source ./scripts/setup.sh /dev/nvme0n1p

# Run the nixos-install command
nixos-install --flake .#$flake
