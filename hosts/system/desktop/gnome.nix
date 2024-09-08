{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with builtins; let
  cfg = config.desktop;
in {
  config = mkIf (cfg.environment == "gnome") {
    services.xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us";
      };
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-wlr
      ];
    };
    environment.gnome.excludePackages =
      (with pkgs; [
        gnome-photos
        gnome-tour
        gnome-music
        gnome-contacts
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ])
      ++ (with pkgs.gnome; [
        ]);

    # ensure gnome-settings-daemon udev rules are enabled
    services.udev.packages = with pkgs; [gnome-settings-daemon];
    # ensure telepathy is enable
    services.telepathy.enable = true;
  };
}
