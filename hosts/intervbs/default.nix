{ pkgs
, lib
, ...
}: {
  networking.hostName = "intervbs";
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # Optional use displayLink for USB-C docking station
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal
      '';
    };
  };

  # Modules loaded
  service.mysql.enable = true;
}
