{ pkgs
, lib
, ...
}:
{
  networking.hostName = "grindstein";
  users.users.dev.initialHashedPassword = "$7$CU..../....87RQd./xXvTs9PuD3lrZZ/$QgXAA42.i1XsVed2ifjaQunvDo7vdpBmfgg7FDBSp11";
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --primary --mode 1920x1080 --pos 5120x666 --rotate normal --output DP-11 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-8 --mode 2560x1440 --pos 2560x135 --rotate normal
      '';
    };
  };

  # Modules loaded
  service = {
    mysql.enable = true;
    onedrive.enable = true;
    printing.enable = true;
    virt-manager.enable = true;
  };
}
