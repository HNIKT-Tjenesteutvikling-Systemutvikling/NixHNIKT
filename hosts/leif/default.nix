{ pkgs
, lib
, ...
}:
{
  networking.hostName = "leif";
  users.users.dev.initialHashedPassword = "$7$CU..../....LemQQdYSZoWpNCYXFw/Iw1$RDXNztdFaE6qGnUMWsgW7cpMeBhofT/esvhJeC1QQD6";
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
