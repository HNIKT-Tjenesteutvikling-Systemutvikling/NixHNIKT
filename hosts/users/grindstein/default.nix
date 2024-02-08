{
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "grindstein";
  services.xserver = {
    displayManager = {
      sessionCommands = let
        xrandrCommand = ''
          ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --primary --mode 1920x1080 --pos 5120x666 --rotate normal --output DP-11 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-8 --mode 2560x1440 --pos 2560x135 --rotate normal
        '';
      in ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${xrandrCommand}
      '';
    };
  };
}

