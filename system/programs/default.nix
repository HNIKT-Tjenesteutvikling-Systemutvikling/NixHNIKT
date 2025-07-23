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

  programs = {
    # Allow non-root users to specify the allow_other or allow_root mount options
    fuse.userAllowOther = true;
    # Nano is enabled by default, but not anymore...
    nano.enable = false;
  };
}
