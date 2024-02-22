{
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "vebjorn";
  services.xserver = {
    displayManager = {
      sessionCommands = let
        xrandrCommand = ''
          ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1200 --pos 5120x542 --rotate normal --output DP-7 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-8 --primary --mode 2560x1440 --pos 2560x0 --rotate normal
        '';
      in ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${xrandrCommand}
      '';
    };
  };
}
