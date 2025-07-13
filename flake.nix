{
  description = "HNIKT Flake";

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      imports = [
        ./hosts
        ./pkgs
      ];
      perSystem =
        { pkgs, system, ... }:
        let
          pre-commit-lib = inputs.pre-commit-hooks-nix.lib.${system};
        in
        {
          devShells.default = pkgs.mkShell {
            name = "HNIKT-dev-shell";
            inputsFrom = [ ];
            nativeBuildInputs = with pkgs; [
              nixpkgs-fmt
            ];
          };

          formatter = pkgs.nixpkgs-fmt;
          checks = {
            pre-commit-check = pre-commit-lib.run {
              src = ./.;
              hooks = {
                statix.enable = true;
                deadnix.enable = true;
                nil.enable = true;
                nixpkgs-fmt.enable = true;
                shellcheck.enable = true;
                beautysh.enable = true;
              };
            };
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
    # mugge.url = "github:HNIKT-Tjenesteutvikling-Systemutvikling/mugge";
    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-flake.url = "github:gako358/neovim";
  };
}
