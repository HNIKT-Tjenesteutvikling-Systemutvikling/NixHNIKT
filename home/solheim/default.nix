{pkgs, ...}: {
  imports = [
    ../common
    ./desktop
    ./services
    ./git.nix
  ];

  # Set desktop environment
  desktop.environment = "gnome";

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "dev";
    homeDirectory = "/home/dev";
  };

  home.packages = with pkgs; [];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
