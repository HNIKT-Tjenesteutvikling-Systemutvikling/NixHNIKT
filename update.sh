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

spinner() {
    local pid=$1
    local update_message=$2
    local delay=0.75
    local spinstr='|/-\'
    printf " [ ]  $update_message...  "
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "\b\b\b[%c]" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
    done
    printf "\r\e[K [✓]  $update_message...  "
}

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
        echo "Nothing to update..."
        exit 0
    fi
fi

# Check disk space
disk_space=$(df /dev/nvme0n1p1 | awk 'NR==2 {print $5}' | sed 's/%//g')

# Run a garbage collection if disk space is less than 60%
if (( disk_space > 60 )); then
    (sudo nix-collect-garbage -d > /dev/null 2>&1) &
    spinner $! "Collecting garbage"
    echo ""
    clear
else
    (nix-collect-garbage --delete-older-than 28d > /dev/null 2>&1) &
    spinner $! "Deleting older generations"
    echo ""
    echo ""
    (home-manager expire-generations "-19 days" > /dev/null 2>&1) &
    spinner $! "Removing older home generations..."
    clear
fi

# Run the nixos-rebuild command
echo "Updating system for $flake..."
sudo -v
(sudo nixos-rebuild switch --flake .#$flake &>nixos-switch.log || (cat nixos-switch.log | grep --color error && echo "An error occurred during the rebuild. Do you want to continue? (yes/no)" && read continue && if [[ "$continue" == "no" ]]; then exit 1; fi)) &
spinner $! "System updating..."
echo ""

# Update home-manager
(home-manager switch --flake .#$home_name &>home-manager.log || (cat home-manager.log | grep --color error && echo "An error occurred during the home-manager update. Exiting." && exit 1)) &
spinner $! "Updating home"
echo ""

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
echo ""
echo ""
echo " ____                   "
echo "|  _ \  ___  _ __   ___ "
echo "| | | |/ _ \| '_ \ / _ \\"
echo "| |_| | (_) | | | |  __/"
echo "|____/ \___/|_| |_|\___|"
echo ""
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
