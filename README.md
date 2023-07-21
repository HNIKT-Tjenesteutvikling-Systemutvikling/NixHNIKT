[![NixOS Unstable](https://img.shields.io/badge/NixOS-unstable-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)

> **Disclaimer:** _This is not a community framework or distribution._ It's a
> private configuration and an ongoing experiment to use for Java and Scala dev. There are no
> guarantees that it will work out of the box for anyone. It may also
> change drastically and without warning.

# HNIKT NixOS Configuration

HNIKT NixOS Configuration is a personalized, sophisticated system configuration for NixOS that is tailored towards Java and Scala development. It is based on the flake system, a new mechanism introduced in Nix to manage Nix projects in a more reproducible way.

It is worth noting that HNIKT is not a community framework or distribution. Instead, it's a personal, ongoing experiment and its main aim is to create a system setup that enhances productivity for Java and Scala developers.

The configuration features a plethora of tools and utilities that are often used in Java and Scala development, including (but not limited to):

- Various IDEs and text editors optimized for Java and Scala development.
- A variety of build tools such as SBT, Gradle, and Maven.
- Databases and other services often used in Java and Scala projects.
- Debugging and profiling tools to help optimize your code.
- A rich set of command-line utilities that can be used for a variety of tasks.

Moreover, the configuration is designed to be modular, allowing the setup to be tailored to specific needs. Each module contains a particular set of tools and services that can be enabled or disabled according to the requirement. Furthermore, there are also templates for setting up development environments for several other programming languages.

It is important to note that while this configuration has been made available to the public, it remains a personal experiment, meaning it may not suit everyone's needs or work out of the box for everyone. Also, it may undergo drastic changes without prior notice. Therefore, if you wish to use this setup, please be prepared to spend some time customizing it to your needs.

Remember, while NixOS provides a high level of flexibility and power, it also requires a good understanding of how the system works. Therefore, ensure to familiarize yourself with the NixOS manual and seek help from the community if you run into any problems.

# Setting Github config

```
home/default.nix
```

On line 24 and 25, the username and user email need to be set, for Github config.

# How To Install

There are two main ways to deploy these dotfiles on a system:

### On an existing NixOS system

If you have setup a NixOS system with a configuration.nix file its possible to switch over to this nix config with
the following commands:

```shell
nix-shell
nixos-rebuild switch --flake .#
```

`Note: This assumes your computer name matches one of the configurations in the flake.`

### Installation via Media

Alternatively, you can install these configurations via the install media from the nix-install repo as follows:

- Boot off the install media.
- Create the partition schedule and mount it to /mnt
- Run `nixos-install --flake github:HNIKT-Tjenesteutvikling-Systemutvikling/NixHNIKT#hnikt`

# Updating

After switching to this configuration, you can update your system using the following command:

```shell
nixos-rebuild switch --upgrade --flake .#
```

## Understanding the Structure

The flake configuration is organized as follows:

- `flake.nix`: This is the main configuration file for the project. It contains the flake specification, along with inputs (dependencies) for the project.

- `flake.lock`: This file, typically generated by Nix, specifies exact versions of your flake's dependencies.

- `home`: Home-manager configuration, acessible via `home-manager --flake`

  - Each directory here is a "feature" each hm configuration can toggle, thus
    customizing my setup for each machine (be it a server, desktop, laptop,
    anything really).

- `host`: This directory contains configurations for different hosts. Each host has its own directory which includes a default.nix file and any other specific configurations.

- `modules/`: This directory contains common NixOS configurations that can be shared across multiple machines.

- `overlays/`: This directory contains Nixpkgs overlays. Overlays allow custom modifications of Nixpkgs.

- `pkgs/`: This directory contains custom packages.

- `templates`: A couple project templates for different languages. Accessible
  via `nix init`.
  - `C` - C develop environment
  - `devshell` - Basic develop shell, to be bootstapped to anything
  - `latex` - Latex develop environment
  - `python` - Python develop environment
  - `rust` - Rust develop environment
  - `wasm` - wasm develop environment
  - `java` - Java develop environment

Please consult the respective directories and files for more information.

# License

This project is licensed under the GNU General Public License v3.0 - see the LICENSE file for details.

The GPL-3.0 License is a free, copyleft license for software and other kinds of works. This license ensures that you have the freedom to distribute copies of free software (and charge for them if you wish), that you receive source code or can get it if you want it, that you can change the software or use pieces of it in new free programs, and that you know you can do these things.

Please remember to respect the terms and conditions of this license when using this project, including the requirements of compatibility, attribution and disclosing source.

For more details about this license, please visit GNU General Public License v3.0.
