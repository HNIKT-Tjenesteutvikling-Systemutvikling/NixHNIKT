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

The repository follows the [dendritic pattern](https://github.com/mightyiam/dendritic):
every `.nix` file under `modules/` is a [flake-parts](https://flake.parts) module,
auto-imported by [`import-tree`](https://github.com/vic/import-tree). Modules are
organised by **feature**, not by layer — a single feature file declares whatever it
needs, exposing `flake.nixosModules.<name>` and/or `flake.homeModules.<name>`. Whether
a feature is applied through NixOS or home-manager is decided inside the expression, not
by its location. Each host aggregates all of them with `lib.attrValues`.

- `flake.nix`: Thin entrypoint — declares inputs and `import-tree ./modules`.
- `modules/`: Everything lives here.
  - `modules/programs/`: One file per program (e.g. `git.nix`, `fish.nix`, `vscode.nix`,
    `browser/`), regardless of whether it configures NixOS, home-manager, or both.
  - `modules/services/`: One file per service (NixOS and home-manager alike, e.g.
    `mysql.nix`, `openssh.nix`, `gpg.nix`, `mugge.nix`).
  - `modules/hardware/`: Hardware/boot NixOS modules (`boot.nix`, `disko.nix`,
    `graphics.nix`, …).
  - `modules/config/`: Cross-cutting NixOS config — the `environment.desktop` options
    (`desktop.nix`) and the shared `dev` user (`users.nix`).
  - `modules/scripts/`: Home-manager packaged scripts.
  - `modules/perSystem/`: `perSystem` outputs — formatter, devshell, checks, packages.
  - `modules/home.nix`, `modules/lib.nix`, `modules/options.nix`: home-manager base,
    `flake.lib`, and the `flake.homeModules` option declaration.
  - `modules/hosts/<host>/`: Per-host wiring.
    - `default.nix`: builds `flake.nixosConfigurations.<host>`, composing all
      `flake.nixosModules` and `flake.homeModules`.
    - `_machine.nix`: host-specific NixOS config (hostname, feature toggles).
    - `_home.nix`: host-specific home-manager profile.
    - `_disks.nix`: disko layout used by the installer.

Files prefixed with `_` are intentionally not auto-imported; they are referenced
explicitly (host includes, package derivations, helper data).

## Getting Started

### Prerequisites

- A NixOS installation (or installation media)
- Git
- Internet connection

### Setting Up User Configuration

Before installation, you need to set up a host:

1. Create a host directory under `modules/hosts/<hostname>/` containing a
   `default.nix` (wiring), `_machine.nix` (NixOS config), `_home.nix`
   (home-manager profile) and, for installable machines, a `_disks.nix`.
2. Follow the examples in existing hosts (like `modules/hosts/neethan/`).

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
