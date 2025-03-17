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

    neovim-flake.url = "github:gako358/neovim";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in
    {
      inherit lib;
      overlays = {
        default = import ./overlay { inherit inputs outputs; };
      };
      templates = import ./templates;
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs:
        import ./shell.nix {
          inherit pkgs;
          buildInputs = [
          ];
        });

      nixosConfigurations = {
        grindstein = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./system
            ./hosts/grindstein
            {
              virt-manager.enable = true;
              k3s-service.enable = false;
              mysql.enable = true;
              onedrive.enable = true;
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
                  nixpkgs.config.allowUnfree = true;
                  imports = [ ./modules ./modules/users/grindstein ];
                  tmux.enable = true;
                  intellij.enable = true;
                  rider.enable = false;
                  vscode.enable = true;
                };
              };
            }
          ];
        };
        ievensen = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./system
            ./hosts/ievensen
            {
              virt-manager.enable = false;
              k3s-service.enable = true;
              mysql.enable = false;
              onedrive.enable = false;
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
                  nixpkgs.config.allowUnfree = true;
                  imports = [ ./modules ./modules/users/ievensen ];
                  tmux.enable = true;
                  intellij.enable = false;
                  rider.enable = false;
                  vscode.enable = true;
                };
              };
            }
          ];
        };
        intervbs = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./system
            ./hosts/intervbs
            {
              virt-manager.enable = false;
              k3s-service.enable = false;
              mysql.enable = true;
              onedrive.enable = false;
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
                  nixpkgs.config.allowUnfree = true;
                  imports = [ ./modules ./modules/users/intervbs ];
                  tmux.enable = false;
                  intellij.enable = true;
                  rider.enable = false;
                  vscode.enable = true;
                };
              };
            }
          ];
        };
        jca = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./system
            ./hosts/jca
            {
              virt-manager.enable = false;
              k3s-service.enable = false;
              mysql.enable = true;
              onedrive.enable = false;
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
                  nixpkgs.config.allowUnfree = true;
                  imports = [ ./modules ./modules/users/jca ];
                  tmux.enable = false;
                  intellij.enable = true;
                  rider.enable = false;
                  vscode.enable = true;
                };
              };
            }
          ];
        };
        neethan = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./system
            ./hosts/neethan
            {
              virt-manager.enable = false;
              k3s-service.enable = false;
              mysql.enable = false;
              onedrive.enable = false;
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
                  nixpkgs.config.allowUnfree = true;
                  imports = [ ./modules ./modules/users/neethan ];
                  tmux.enable = false;
                  intellij.enable = false;
                  rider.enable = false;
                  vscode.enable = true;
                };
              };
            }
          ];
        };
        sigubrat = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./system
            ./hosts/sigubrat
            {
              virt-manager.enable = false;
              k3s-service.enable = false;
              mysql.enable = true;
              onedrive.enable = false;
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
                  nixpkgs.config.allowUnfree = true;
                  imports = [ ./modules ./modules/users/sigubrat ];
                  tmux.enable = false;
                  intellij.enable = true;
                  rider.enable = false;
                  vscode.enable = true;
                };
              };
            }
          ];
        };
        Solheim = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./system
            ./hosts/Solheim
            {
              virt-manager.enable = false;
              k3s-service.enable = false;
              mysql.enable = true;
              onedrive.enable = false;
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
                  nixpkgs.config.allowUnfree = true;
                  imports = [ ./modules ./modules/users/Solheim ];
                  tmux.enable = false;
                  intellij.enable = true;
                  rider.enable = false;
                  vscode.enable = true;
                };
              };
            }
          ];
        };
        Turbonaepskrel = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./system
            ./hosts/Turbonaepskrel
            {
              virt-manager.enable = false;
              k3s-service.enable = false;
              mysql.enable = true;
              onedrive.enable = false;
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
                  nixpkgs.config.allowUnfree = true;
                  imports = [ ./modules ./modules/users/Turbonaepskrel ];
                  tmux.enable = false;
                  intellij.enable = true;
                  rider.enable = false;
                  vscode.enable = true;
                };
              };
            }
          ];
        };
      };
    };
}
