{ inputs
, pkgs
, lib
, ...
}:
with lib; {
  # Core pakages for system
  environment.systemPackages = with pkgs; [
    wget
    git

    nodejs-18_x # Github Copilot requires nodejs 16
    inputs.neovim-flake.defaultPackage.${pkgs.system}
  ];

  imports = [
    ./cachix
    ./desktop.nix
    ./docker.nix
    ./fish.nix
    ./fonts.nix
  ];
}
