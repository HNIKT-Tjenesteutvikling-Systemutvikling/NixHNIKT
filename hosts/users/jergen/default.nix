{
  pkgs,
  lib,
  ...
}: {
  desktop.environment = "gnome";
  networking.hostName = "jergen";
  services.xserver = {
    videoDrivers = ["intel"]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      '';
    };
  };
}
