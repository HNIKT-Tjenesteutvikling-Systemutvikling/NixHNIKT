{ pkgs
, lib
, ...
}:
{
  networking.hostName = "neethan";
  users.users.dev.initialHashedPassword = "$7$CU..../....LHBYw6TQguCtttLZrDM.J1$C9d/wSXL4C9kE1NOvMl2Z90rO1a9V368sFI3lUTljW6";
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --pos 5120x0 --rotate normal --output DP-7 --primary --mode 2560x1440 --pos 2560x0 --rotate normal --output DP-9 --mode 2560x1440 --pos 0x0 --rotate normal
      '';
    };
  };
}
