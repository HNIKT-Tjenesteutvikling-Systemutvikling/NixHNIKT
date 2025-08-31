{ pkgs
, lib
, ...
}:
{
  networking.hostName = "leif";
  users.users.dev.initialHashedPassword = "$7$CU..../....LHBYw6TQguCtttLZrDM.J1$C9d/wSXL4C9kE1NOvMl2Z90rO1a9V368sFI3lUTljW6";
  services.xserver = {
    videoDrivers = [ "nvidia" ]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      '';
    };
  };

  # Modules loaded
  environment.desktop = {
    windowManager = "gnome";
    graphics = "nvidia";
  };
  service.mysql.enable = true;
}
