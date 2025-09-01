#!/usr/bin/env bash

set -e

install_nixos() {
    echo "=================================="
    echo "NixOS Installation Script"
    echo "=================================="
    echo "Please select a machine to install:"
    echo "1) grindstein"
    echo "2) ievensen"
    echo "3) intervbs"
    echo "4) jca"
    echo "5) ketil"
    echo "6) leif"
    echo "7) neethan"
    echo "8) sigubrat"
    echo "9) Solheim"
    echo "10) Turbonaepskrel"
    echo "=================================="
    read -r -p "Enter your choice (1 to 8): " choice

    case $choice in
        1)
            machine="grindstein"
            ;;
        2)
            machine="ievensen"
            ;;
        3)
            machine="intervbs"
            ;;
        4)
            machine="jca"
            ;;
        5)
            machine="ketil"
            ;;
        6)
            machine="leif"
            ;;
        7)
            machine="neethan"
            ;;
        8)
            machine="sigubrat"
            ;;
        9)
            machine="Solheim"
            ;;
        10)
            machine="Turbonaepskrel"
            ;;
        *)
            echo "Invalid choice. Please select between 1 and 8."
            exit 1
            ;;
    esac

    echo "You selected: $machine"
    read -r -p "Continue with installation? (y/n): " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo "Installation aborted."
        exit 0
    fi

    flake_target=".#$machine"
    disko_path="./hosts/$machine/disks.nix"

    if [ ! -f "$disko_path" ]; then
        echo "Error: Disk configuration file not found at $disko_path"
        exit 1
    fi

    echo "Starting disk formatting with disko for $machine..."
    if nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode zap_create_mount "$disko_path"; then
        echo "Disk formatting completed successfully."
        echo "Installing NixOS on $machine..."
        if nixos-install --flake "$flake_target" --no-root-password; then
            echo "NixOS installation completed successfully on $machine."
        else
            echo "Error: NixOS installation failed."
            exit 1
        fi
    else
        echo "Error: Disk formatting failed. Aborting installation."
        exit 1
    fi
}

install_nixos
