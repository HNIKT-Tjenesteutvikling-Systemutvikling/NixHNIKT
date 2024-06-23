#!/usr/bin/env bash

set -e

# Fetch the latest changes from the remote repository
git fetch

# Extract the username from the userSetting.nix file
flake=$(hostname)
home_name="dev@$flake"

# Get the current generation
current=$(nixos-rebuild list-generations | grep current | awk '{print $1}')
if [ -z "$current" ]; then
    echo "Failed to get current generation"
    exit 1
fi
branch_name="${current}_$flake"

# Check if there are any changes in the local repository
changes_made=false
if ! git diff --quiet; then
    git checkout -b $branch_name
    git add . || true
    changes_made=true
else
    echo "No unstaged changes detected."
    # Fetch the latest changes from the remote repository
    git fetch
    # Check if there are any changes between the local and remote repository
    if ! git diff --quiet HEAD origin/master; then
        echo "Changes detected in the remote repository, pulling changes."
        git pull > /dev/null 2>&1
    else
        echo "No changes detected in the remote repository, exiting."
        exit 0
    fi
fi

# Check disk space
disk_space=$(df /dev/nvme0n1p1 | awk 'NR==2 {print $5}' | sed 's/%//g')

# Run a garbage collection if disk space is less than 60%
echo "Checking disk space..."
if (( disk_space > 60 )); then
    echo "Disk space is $disk_space% "
    echo "which is more than 60%, running garbage collection,"
    echo "to free up boot..."
    # sudo nix-collect-garbage -d
else
    echo "Disk space is $disk_space% "
    echo "Enough disk space available, skipping garbage collection..."
    echo "Deleting older generations..."
    # nix-collect-garbage --delete-older-than 28d
    # home-manager expire-generations "-19 days"
fi

# Run the nixos-rebuild command
echo "Updating system for $flake..."
nixos-rebuild build --flake .#jca &>nixos-switch.log || (cat nixos-switch.log | grep --color error && echo "An error occurred during the rebuild. Do you want to continue? (yes/no)" && read continue && if [[ "$continue" == "no" ]]; then exit 1; fi)
# sudo nixos-rebuild switch --flake .#$flake &>nixos-switch.log || (cat nixos-switch.log | grep --color error && echo "An error occurred during the rebuild. Do you want to continue? (yes/no)" && read continue && if [[ "$continue" == "no" ]]; then exit 1; fi)

# Update home-manager
echo "System updated!, updating home-manager for $home_name..."
home-manager build --flake .#"dev@jca" &>home-manager.log || (cat home-manager.log | grep --color error && echo "An error occurred during the home-manager update. Exiting." && exit 1)
# home-manager switch --flake .#$home_name &>home-manager.log || (cat home-manager.log | grep --color error && echo "An error occurred during the home-manager update. Exiting." && exit 1)

# Check if there were any errors during the execution of the script
if ! grep -q "error" nixos-switch.log && ! grep -q "error" home-manager.log; then
    rm nixos-switch.log home-manager.log
fi

# If there were changes in the local repository, commit and push them
if $changes_made; then
    git commit -m "$flake Updated system and home-manager for generation $current"
    git push origin $branch_name
    git checkout master
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
