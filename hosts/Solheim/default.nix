{ pkgs
, lib
, ...
}:
{
  networking.hostName = "Solheim";
  users.users.dev.initialHashedPassword = "$7$CU..../....golmFbccEgPjPFWwyiKYU0$Uu/jQNf2DAS8RgsUmMsU5oB61Oib6OWjCVAKd385rf5";
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      '';
    };
  };

  # Modules loaded
  service.mysql.enable = true;
}
