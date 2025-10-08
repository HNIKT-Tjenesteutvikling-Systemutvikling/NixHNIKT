{ pkgs
, lib
, ...
}:
{
  networking.hostName = "jca";
  users.users.dev.initialHashedPassword = "$7$CU..../....9/NzsqdoxnlEMlRaSIKMT0$ZdYt3gG0QywoziL7h6U5pbUaz4znzisu6OSV2Arnlo0";
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      '';
    };
  };

  # Modules loaded
  service = {
    mysql.enable = true;
    printing.enable = true;
  };
}
