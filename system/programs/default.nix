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

    nodejs_20 # Github Copilot requires
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
