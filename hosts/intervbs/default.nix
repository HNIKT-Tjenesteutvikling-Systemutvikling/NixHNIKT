{ pkgs
, lib
, ...
}:
{
  networking.hostName = "intervbs";
  users.users.dev.initialHashedPassword = "$7$CU..../..../9Xx8NRHkSAWJioosG3LS1$luAa3BlGiM28xWgJOH2XEXmQYuP58qvpjtsEU21im07";
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${pkgs.xorg.xrandr}/bin/xrandr --output DP-8 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-9 --mode 2560x1440 --pos 2560x0 --rotate normal --output eDP-1 --mode 1920x1200 --pos 2848x1440 --rotate normal
      '';
    };
  };

  # Modules loaded
  service.mysql.enable = true;
}
