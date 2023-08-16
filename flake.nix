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
      grindstein = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/configuration.nix
          ./hosts/users/grindstein
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
      jca = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/configuration.nix
          ./hosts/users/jca
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
          ./hosts/configuration.nix
          ./hosts/users/sigubrat
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
      solheim = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/configuration.nix
          ./hosts/users/solheim
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
          ./hosts/configuration.nix
          ./hosts/users/turbonaepskrel
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
      "dev@grindstein" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/home.nix
          ./home/users/grindstein
        ];
      };
      "dev@jca" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/home.nix
          ./home/users/jca
        ];
      };
      "dev@solheim" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/home.nix
          ./home/users/solheim
        ];
      };
      "dev@sigubrat" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/home.nix
          ./home/users/sigubrat
        ];
      };
      "dev@turbonaepskrel" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/home.nix
          ./home/users/turbonaepskrel
        ];
      };
    };
  };
}
