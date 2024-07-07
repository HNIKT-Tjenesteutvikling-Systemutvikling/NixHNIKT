#!/usr/bin/env bash

set -e

clear
echo ""
echo ""
echo ""
echo " _   _ _       ____   _____   _    _           _       _"
echo "| \\ | (_)     / __ \\ / ____| | |  | |         | |     | |"
echo "|  \\| |___  _| |  | | (___   | |  | |_ __   __| | __ _| |_ ___"
echo "| . \` | \\ \\/ / |  | |\\___ \\  | |  | | '_ \\ / _\` |/ _\` | __/ _ \\"
echo "| |\\  | |>  <| |__| |____) | | |__| | |_) | (_| | (_| | ||  __/"
echo "|_| \\_|_/_/\\_\\\\____/|_____/   \\____/| .__/ \\__,_|\\__,_|\\__\\___|"
echo "                                    | |"
echo "                                    |_|"
echo ""
echo ""

# Fetch the latest changes from the remote repository
git fetch -a
echo ""

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

check_and_pull() {
    if ! git diff --quiet HEAD origin/master; then
        echo "Changes detected in the remote repository, pulling changes."
        git pull >/dev/null 2>&1
    else
        echo "No changes detected in the remote repository, exiting."
        echo "Building local..."
    fi
}

merge_master_into_branch() {
    git fetch origin >/dev/null 2>&1
    git merge origin/master >/dev/null 2>&1

    # Check if there are any merge conflicts
    if git diff --name-only --diff-filter=U | grep . >/dev/null; then
        echo "Merge conflicts detected. Please resolve them manually."
        exit 1
    fi
}

handle_unstaged_changes() {
    echo "Unstaged changes detected."
    echo "Do you want to add these changes? (yes/no)"
    read add_changes

    # If on master, we checkout
    if [ "$(git rev-parse --abbrev-ref HEAD)" == "master" ]; then
        echo "Creating a new branch for the changes..."
        if git rev-parse --verify $branch_name >/dev/null 2>&1; then
            branch_name="${branch_name}_new"
        fi
        git checkout -b $branch_name
    fi

    if [ "$add_changes" == "yes" ]; then
        git add . || true
        changes_made=true
        echo "Upstream changes will be merged into the branch $current_branch..."
        merge_master_into_branch
    else
        echo "Do you want to 1) discard these changes or 2) stash these changes? (1/2)"
        read action

        if [ "$action" == "1" ]; then
            echo "Discarding changes..."
            git reset --hard HEAD && git clean -fd
            if [ "$(git rev-parse --abbrev-ref HEAD)" != "master" ]; then
                git checkout master
            fi
            check_and_pull
        elif [ "$action" == "2" ]; then
            echo "Stashing changes..."
            git stash
            if [ "$(git rev-parse --abbrev-ref HEAD)" != "master" ]; then
                git checkout master
            fi
            check_and_pull
        else
            echo "Invalid option. Please manually handle the unstaged changes."
            exit 1
        fi
    fi
}

changes_made=false
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" != "master" ]; then
    echo "You are not on the master branch. You are on $current_branch."
    echo "Do you want to stay on this branch and add changes? (yes/no)"
    read stay_on_branch
    if [ "$stay_on_branch" == "yes" ]; then
        if ! git diff --quiet; then
            handle_unstaged_changes
        else
            echo "No unstaged changes detected."
            git checkout master
            check_and_pull
        fi
    else
        if ! git diff --quiet; then
            handle_unstaged_changes
        else
            git checkout master
            check_and_pull
        fi
    fi
else
    if ! git diff --quiet; then
        echo "Unstaged changes on master, branching out to $branch_name..."
        handle_unstaged_changes
    else
        echo "No unstaged changes detected."
        check_and_pull
    fi
fi

# Check disk space
disk_space=$(df /dev/nvme0n1p1 | awk 'NR==2 {print $5}' | sed 's/%//g')

# Run a garbage collection if disk space is less than 60%
if ((disk_space > 60)); then
    (sudo nix-collect-garbage -d >/dev/null 2>&1) &
    spinner $! "Collecting garbage"
    echo ""
else
    (nix-collect-garbage --delete-older-than 28d >/dev/null 2>&1) &
    spinner $! "Deleting older generations"
    echo ""
    echo ""
    (home-manager expire-generations "-19 days" >/dev/null 2>&1) &
    spinner $! "Removing older home generations..."
fi

# Run the nixos-rebuild command
echo ""
echo "Updating system for $flake..."
echo ""
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
echo ""
echo ""
if $changes_made; then
    echo "Pushed changes to git, please create pull request to get changes on master from $branch_name..."
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
