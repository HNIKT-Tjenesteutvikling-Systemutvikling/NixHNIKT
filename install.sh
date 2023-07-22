#!/usr/bin/env bash

# Source your setup script
source ./scripts/setup.sh /dev/nvme0n1p

# Run the nixos-install command
nixos-install --flake github:HNIKT-Tjenesteutvikling-Systemutvikling/NixHNIKT#hnikt
