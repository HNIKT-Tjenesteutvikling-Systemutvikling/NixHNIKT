{
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "Turbonaepskrel";
  services.xserver = {
    displayManager = {
      sessionCommands = let
        xrandrCommand = ''
          ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal
        '';
      in ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        #${xrandrCommand}
      '';
    };
  };
}

