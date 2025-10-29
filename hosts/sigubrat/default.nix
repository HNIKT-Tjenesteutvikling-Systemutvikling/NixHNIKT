{ pkgs
, lib
, ...
}:
{
  networking.hostName = "sigubrat";
  users.users.dev.initialHashedPassword = "$7$CU..../....xCwA2EkHz5ukX5QDlZHqH1$0mtiQIaAoZhsAzzqoVnGXl96.U9h8G/RQplqbUB.RxD";
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --pos 5120x0 --rotate normal --output DP-7 --primary --mode 2560x1440 --pos 2560x0 --rotate normal --output DP-9 --mode 2560x1440 --pos 0x0 --rotate normal
      '';
    };
  };

  # Modules loaded
  service.mysql.enable = true;
}
