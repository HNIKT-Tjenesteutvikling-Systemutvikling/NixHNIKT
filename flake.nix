{
  description = "HNIKT Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";
    nur.url = "github:nix-community/NUR";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
              dropbox.enable = true;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
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
              dropbox.enable = false;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
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
              dropbox.enable = false;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
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
              dropbox.enable = false;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
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
              dropbox.enable = false;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
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
              dropbox.enable = false;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
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
              dropbox.enable = false;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
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
              dropbox.enable = false;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
                backupFileExtension = ".hm-backup";
                users.dev = { ... }: {
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
