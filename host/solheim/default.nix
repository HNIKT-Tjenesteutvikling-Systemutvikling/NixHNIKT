{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../common
    ./services
    ./network.nix
    ./user.nix
  ];

  # Set desktop environment
  desktop.environment = "gnome";

  # Set audio server
  sys.audio.server = "pulse";

  # Remove if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;

  # NixOS release to be compatible with for staeful data such as databases.
  system.stateVersion = "23.05";
}