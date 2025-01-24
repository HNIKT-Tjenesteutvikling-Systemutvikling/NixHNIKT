{
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "jonvidars";
  services.xserver = {
    videoDrivers = ["modesetting"]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      '';
    };
  };
}
