> **Disclaimer:** _This is not a community framework or distribution._ It's a
> private configuration and an ongoing experiment to use for Java and Scala dev. There are no
> guarantees that it will work out of the box for anyone. It may also
> change drastically and without warning.

[![NixOS Unstable](https://img.shields.io/badge/NixOS-unstable-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)

# HNIKT NixOS Configuration

> **Note:** This is a specialized NixOS configuration for HNIKT development environments. It's designed to provide consistent development environments for Java/Scala development teams.

## Overview

This flake-based NixOS configuration provides a consistent, reproducible development environment for HNIKT teams. The configuration includes:

- Pre-configured development tools (IDEs, editors, build tools)
- Team-specific user configurations
- Module-based system configuration
- Automated update mechanism
- Language-specific templates for new projects

## Structure

- `flake.nix`: Main configuration file defining inputs and outputs
- `hosts/`: System configurations for each machine
- `modules/`: Shared NixOS and home-manager modules
- `system/`: Core system configurations (hardware, programs, services)
- `templates/`: Project templates for different languages
- `update.sh`: Script for updating the system
- `install.sh`: Script for initial system installation

## Getting Started

### Prerequisites

- A NixOS installation (or installation media)
- Git
- Internet connection

### Setting Up User Configuration

Before installation, you need to set up your user profile:

1. Create a user configuration in `modules/users/yourusername/default.nix`
2. Follow the examples in existing user configurations (like `modules/users/neethan/default.nix`)

### Installation Methods

#### On a Fresh System

1. Boot from NixOS installation media
2. Create and mount partitions to `/mnt`
3. Clone this repository:
   ```bash
   git clone https://github.com/HNIKT-Tjenesteutvikling-Systemutvikling/NixHNIKT.git
   cd NixHNIKT
   ```
4. Run the installation script:
   ```bash
   ./install.sh
   ```

#### On an Existing NixOS System

If you already have a NixOS system and want to switch to this configuration:

1. Clone this repository:

   ```bash
   git clone https://github.com/HNIKT-Tjenesteutvikling-Systemutvikling/NixHNIKT.git
   cd NixHNIKT
   ```

2. Enter a nix shell and switch to the configuration:

   ```bash
   nix-shell
   nixos-rebuild switch --flake .#$(hostname)
   ```

   Alternatively, use the install script:

   ```bash
   ./install.sh
   ```

#### Via Installation Media (Direct)

You can also install directly from the GitHub repository:

```bash
nixos-install --flake github:HNIKT-Tjenesteutvikling-Systemutvikling/NixHNIKT#$(hostname)
```

## Updating

The configuration includes an automatic update mechanism:

```bash
./update.sh
```

This script:

1. Pulls the latest changes from the remote repository
2. Handles any local modifications (offering to stash, commit, or discard)
3. Creates branches for changes when needed
4. Performs garbage collection to free disk space
5. Rebuilds the system with the latest configuration
6. Optionally restarts the system if needed

## Available Templates

Initialize new projects using the included templates:

```bash
nix flake init -t .#template-name
```

Available templates:

- `c`: C development environment
- `devshell`: Basic development shell
- `java`: Java development environment
- `nodejs`: Node.js development environment
- `python`: Python development environment
- `rust`: Rust development environment
- `wasm`: WebAssembly development environment

## License

This project is licensed under the GNU General Public License v3.0 - see the LICENSE file for details.
