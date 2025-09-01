{ pkgs
, lib
, ...
}:
{
  networking.hostName = "leif";
  users.users.dev.initialHashedPassword = "$7$CU..../....7emauu/nSIai9Z3k.5nme1$6FDaMoeVeQBls.bZ3FsswOVWoeB.ILPtcIAqZh24f54";
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
