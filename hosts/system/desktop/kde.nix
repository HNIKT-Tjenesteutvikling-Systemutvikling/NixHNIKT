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
  config = mkIf (cfg.environment == "kde") {
    services.xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us";
      };
      displayManager = {
        sddm.enable = true;
        defaultSession = "plasmawayland";
      };
      desktopManager.plasma5.enable = true;
    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
    };
    environment = {
      # Add Kde packages to exclude
      plasma5.excludePackages = with pkgs.libsForQt5; [
      ];
    };
  };
}
