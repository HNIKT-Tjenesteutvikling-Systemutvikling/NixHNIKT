{
  pkgs,
  userSetup,
  lib,
  ...
}: {
  networking.hostName = userSetup.hostname;
  services.xserver = {
    displayManager = {
      sessionCommands = let
        xrandrCommand =
          if userSetup.xrandrConfig
          then "${lib.getBin pkgs.xorg.xrandr}/bin/xrandr ${userSetup.xrandrSettings}"
          else "";
      in ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        ${xrandrCommand}
      '';
    };
  };
}