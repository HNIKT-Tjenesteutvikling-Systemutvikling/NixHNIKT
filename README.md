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

## Getting Started

### Prerequisites

- A NixOS installation (or installation media)
- Git
- Internet connection

### Setting Up User Configuration

Before installation, you need to set up your user profile:

1. Create a user configuration in `modules/profiles/yourusername/default.nix`
2. Follow the examples in existing user configurations (like `modules/profiles/neethan/default.nix`)

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
   ./scripts/install.sh
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

#### Via Installation Media (Direct)

You can also install directly from the GitHub repository:

```bash
nixos-install --flake github:HNIKT-Tjenesteutvikling-Systemutvikling/NixHNIKT#$(hostname)
```

## License

This project is licensed under the GNU General Public License v3.0 - see the LICENSE file for details.
