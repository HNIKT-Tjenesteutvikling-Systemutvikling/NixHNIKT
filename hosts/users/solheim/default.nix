{
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "solheim";
  services.xserver = {
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --mode 3440x1440 --pos 0x0 --rotate normal --output eDP-1 --primary --mode 1920x1080 --pos 3440x360 --rotate normal
      '';
    };
  };
}
