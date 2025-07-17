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
    ./fish
    ./docker.nix
    ./fonts.nix
  ];
}
