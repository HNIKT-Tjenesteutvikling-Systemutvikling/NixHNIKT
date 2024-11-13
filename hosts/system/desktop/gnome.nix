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
    environment = {
      systemPackages = with pkgs; [
        morewaita-icon-theme
        qogir-icon-theme
        gnome-extension-manager
      ];

      gnome.excludePackages = with pkgs; [
        # gnome-text-editor
        atomix # puzzle game
        cheese # webcam tool
        epiphany # web browser
        evince # document viewer
        gedit
        geary # email reader
        gnome-characters
        gnome-connections
        gnome-contacts
        gnome-font-viewer
        gnome-initial-setup
        gnome-maps
        gnome-music
        gnome-photos
        gnome-shell-extensions
        gnome-tour
        iagno # go game
        snapshot
        tali # poker game
        totem # video player
        hitori # sudoku game
        yelp # Help view
      ];
    };

    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };

    systemd.services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };
  };
}
