{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with builtins; let
  cfg = config.desktop;
in {
  config = mkIf (cfg.environment == "gnome" || cfg.environment == "dwm" || cfg.environment == "bspwm") {
    services.xserver = {
      enable = true;
      libinput.enable = true;
      layout = "us";
      xkbVariant = "";
      excludePackages = with pkgs; [
        xterm
      ];
      videoDrivers = ["intel"];
    };
  };
}