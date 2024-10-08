{
  pkgs,
  lib,
  ...
}:
with lib; {
  # Core pakages for system
  environment.systemPackages = with pkgs; [
    wget
    curl
    git

    nodejs-18_x # Github Copilot requires nodejs 16
    alejandra # Nix formatting tool
  ];

  imports = [
    ./daemons
    ./desktop
    ./docker.nix
    ./fonts.nix
    ./nfc.nix
    ./mysql.nix
    ./zsh.nix
    ./qemu.nix
  ];
}
