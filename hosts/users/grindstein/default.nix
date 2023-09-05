{
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "grindstein";
  services.xserver = {
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --pos 4480x858 --rotate normal --output DP-10 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-11 --mode 1920x1200 --pos 2560x240 --rotate normal
      '';
    };
  };
}
