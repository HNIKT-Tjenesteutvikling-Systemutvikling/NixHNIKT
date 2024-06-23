#!/usr/bin/env bash

set -e

# Fetch the latest changes from the remote repository
git fetch

# Check if there are any changes between the local and remote repository
if git diff --quiet HEAD origin/master && git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    exit 0
fi

# If there are changes, pull the latest changes from the remote repository
git pull > /dev/null 2>&1

# Extract the username from the userSetting.nix file
flake=$(hostname)
home_name="dev@$flake"

# Check disk space
disk_space=$(df /dev/nvme0n1p1 | awk 'NR==2 {print $5}' | sed 's/%//g')

# Run a garbage collection if disk space is less than 60%
echo "Checking disk space..."
if (( disk_space > 60 )); then
    echo "Disk space is $disk_space% "
    echo "which is more than 60%, running garbage collection,"
    echo "to free up boot..."
    sudo nix-collect-garbage -d
else
    echo "Enough disk space available, skipping garbage collection..."
    echo "Deleting older generations..."
    nix-collect-garbage --delete-older-than 28d
    home-manager expire-generations "-19 days"
fi

# Run the nixos-rebuild command
echo "Updating system for $flake..."
sudo nixos-rebuild switch --flake .#$flake &>nixos-switch.log || (cat nixos-switch.log | grep --color error && echo "An error occurred during the rebuild. Do you want to continue? (yes/no)" && read continue && if [[ "$continue" == "no" ]]; then exit 1; fi)

# Update home-manager
echo "System updated!, updating home-manager for $home_name..."
home-manager switch --flake .#$home_name &>home-manager.log || (cat home-manager.log | grep --color error && echo "An error occurred during the home-manager update. Exiting." && exit 1)

# Check if there were any errors during the execution of the script
if ! grep -q "error" nixos-switch.log && ! grep -q "error" home-manager.log; then
    rm nixos-switch.log home-manager.log
fi

echo ""
echo "Some updates may require a restart"
echo "Do you want to restart now?"
echo "1. Yes, 2. No"
read restart

if [[ "$restart" == "1" ]]; then
    reboot
else
    exit 0
fi
