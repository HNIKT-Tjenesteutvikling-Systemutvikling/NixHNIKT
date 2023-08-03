{
  description = "HNIKT Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Utilities for building our flake
    flake-utils.url = "github:numtide/flake-utils";

    # Extra flakes for modules, packages, etc
    hardware.url = "github:nixos/nixos-hardware"; # Convenience modules for hardware-specific quirks
    nur.url = "github:nix-community/NUR"; # User contributed pkgs and modules
    nix-colors.url = "github:misterio77/nix-colors"; # Color schemes for usage with home-manager
    impermanence.url = "github:riscadoa/impermanence"; # Utilities for opt-in persistance
    agenix.url = "github:ryantm/agenix"; # Secrets management

    # Neovim built with flake support
    neovim-flake.url = "github:gako358/neovim";
  };

  outputs = {
    nixpkgs,
    hardware,
    flake-utils,
    home-manager,
    neovim-flake,
    nur,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs systems;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in rec {
    overlays = {
      default = import ./overlay {inherit inputs;};
    };
    templates = import ./templates;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    devShells = forAllSystems (system: {
      default = legacyPackages.${system}.callPackage ./shell.nix {};
    });

    legacyPackages = forAllSystems (system:
      import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues overlays;
        config.allowUnfree = true;
      });

    nixosConfigurations = {
      # System Config
      hnikt = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./host/hnikt
          nixosModules
          {
            # Set desktop environment
            desktop.gnome.enable = true;
            # Services enabled
            services.battery.enable = false;
          }
          {nixpkgs.overlays = builtins.attrValues overlays;}
          ({
            config,
            pkgs,
            ...
          }: {
            environment.systemPackages = [
              neovim-flake.defaultPackage.x86_64-linux
            ];
          })
        ];
      };
      grindstein = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./host/grindstein
          nixosModules
          {
            # Set desktop environment
            desktop.gnome.enable = true;
            # Services enabled
            services.battery.enable = false;
            # Programs to enable
            programs.citrix.enable = true;
            programs.dbeaver.enable = true;
            programs.discord.enable = false;
            programs.intellij.enable = true;
            programs.mysql-workbench.enable = true;
            programs.slack.enable = true;
            programs.teams.enable = true;
            programs.virt-manager.enable = true;
            programs.wine.enable = false; # Wine for Windows apps
            programs.wps.enable = false; # WPS Office
          }
          {nixpkgs.overlays = builtins.attrValues overlays;}
          ({
            config,
            pkgs,
            ...
          }: {
            environment.systemPackages = [
              neovim-flake.defaultPackage.x86_64-linux
            ];
          })
        ];
      };
      sigubrat = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./host/sigubrat
          nixosModules
          {
            # Set desktop environment
            desktop.gnome.enable = true;
            # Services enabled
            services.battery.enable = false;
            # Programs to enable
            programs.citrix.enable = true;
            programs.dbeaver.enable = true;
            programs.discord.enable = false;
            programs.intellij.enable = true;
            programs.mysql-workbench.enable = false;
            programs.slack.enable = true;
            programs.teams.enable = true;
            programs.virt-manager.enable = true;
          }
          {nixpkgs.overlays = builtins.attrValues overlays;}
          ({
            config,
            pkgs,
            ...
          }: {
            environment.systemPackages = [
              neovim-flake.defaultPackage.x86_64-linux
            ];
          })
        ];
      };
      turbonaepskrel = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./host/turbonaepskrel
          nixosModules
          {
            # Set desktop environment
            desktop.gnome.enable = true;
            # Services enabled
            services.battery.enable = false;
            # Programs to enable
            programs.citrix.enable = true;
            programs.dbeaver.enable = true;
            programs.discord.enable = false;
            programs.intellij.enable = true;
            programs.mysql-workbench.enable = false;
            programs.slack.enable = true;
            programs.teams.enable = true;
            programs.virt-manager.enable = true;
          }
          {nixpkgs.overlays = builtins.attrValues overlays;}
          ({
            config,
            pkgs,
            ...
          }: {
            environment.systemPackages = [
              neovim-flake.defaultPackage.x86_64-linux
            ];
          })
        ];
      };
    };
    homeConfigurations = {
      "dev@hnikt" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/hnikt
          homeManagerModules
          {
            # Development tools
            programs = {
              browser.application = "firefox";
              develop.vscode.enable = false;
              terminal = {
                # Gnome has default terminal
                kitty.enable = false;
                alacritty.enable = false;
                gnome-terminal.enable = false;
              };
            };
          }
        ];
      };
      "dev@grindstein" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/grindstein
          homeManagerModules
          {
            # Development tools
            programs = {
              browser.application = "firefox";
              develop.vscode.enable = false;
              terminal = {
                # Gnome has default terminal
                kitty.enable = false;
                alacritty.enable = false;
                gnome-terminal.enable = false;
              };
            };
          }
        ];
      };
      "dev@sigubrat" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/sigubrat
          homeManagerModules
          {
            # Development tools
            programs = {
              browser.application = "firefox";
              develop.vscode.enable = true;
              terminal = {
                # Gnome has default terminal
                kitty.enable = false;
                alacritty.enable = false;
                gnome-terminal.enable = false;
              };
            };
          }
        ];
      };
      "dev@turbonaepskrel" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/turbonaepskrel
          homeManagerModules
          {
            # Development tools
            programs = {
              browser.application = "firefox";
              develop.vscode.enable = true;
              terminal = {
                # Gnome has default terminal
                kitty.enable = false;
                alacritty.enable = false;
                gnome-terminal.enable = false;
              };
            };
          }
        ];
      };
    };
  };
}
