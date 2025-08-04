{ pkgs
, lib
, ...
}:
{
  networking.hostName = "Turbonaepskrel";
  users.users.dev.initialHashedPassword = "$7$CU..../....lycRAipruqDlD6aJT6UGm1$/8KLktPSFYuIr7Xix3eu.ZcA9DT/ck3K/MV571lDPmB";
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
