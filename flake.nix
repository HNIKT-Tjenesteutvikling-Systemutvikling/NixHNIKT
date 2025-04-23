{
  description = "HNIKT Flake";

  outputs = inputs@{ self, nixpkgs, flake-parts, home-manager, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      imports = [
        ./hosts
        ./pkgs
      ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        {
          devShells.default = pkgs.mkShell {
            name = "HNIKT-dev-shell";
            inputsFrom = [ ];
            nativeBuildInputs = with pkgs; [
              nixpkgs-fmt
            ];
          };
        };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
}
