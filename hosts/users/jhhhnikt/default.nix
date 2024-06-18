{
  inputs,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    inputs.neovim-flake.defaultPackage.${pkgs.system}
  ];
  desktop.environment = "gnome";
  networking.hostName = "jhhhnikt";
  services.xserver = {
    videoDrivers = ["intel" "displaylink"]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${pkgs.xorg.xrandr}/bin/xrandr --output DP-10 --mode 2560x1440 --pos 4480x0 --rotate normal --output DP-7 --mode 2560x1440 --pos 1920x0 --rotate normal --output eDP-1 --primary --mode 1920x1080 --pos 0x360 --rotate normal
      '';
    };
  };
}
