#!/usr/bin/env bash

set -ex

echo "Updating system..."
# Comment lines 20 and 21 in .gitignore
echo "Commenting lines 20 and 21 in .gitignore"
sed -i '21,22s/^/#/' .gitignore

# Stage the specified folder
echo "Staging the specified folder"
git add modules/nixos/programs/certs

git pull

# Run the nixos-rebuild command
sudo nixos-rebuild switch --flake .#hnikt

# Clean up
echo "Cleaning up"
sed -i '21,22s/^#//' .gitignore
git reset modules/nixos/programs/certs

echo "System updated!, please enter the hostname:"
read user

# Update home-manager
home-manager switch --flake .#"dev@hnikt"

# Commit and push
git add .
git commit -m "System update carried out on $(date)"
git push
