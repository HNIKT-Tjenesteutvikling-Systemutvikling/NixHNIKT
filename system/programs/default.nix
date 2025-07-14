{ inputs
, pkgs
, lib
, ...
}:
with lib;
{
  # Core pakages for system
  environment.systemPackages = with pkgs; [
    wget
    git

    inputs.neovim-flake.defaultPackage.${pkgs.system}
  ];

  imports = [
    ./cachix
    ./docker.nix
    ./fish.nix
    ./fonts.nix
  ];
}
