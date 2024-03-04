{
  pkgs,
  lib,
  ...
}: {
  desktop.environment = "gnome";
  networking.hostName = "intervbs";
  services.xserver = {
    videoDrivers = ["intel" "displaylink"]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal
      '';
    };
  };
}
