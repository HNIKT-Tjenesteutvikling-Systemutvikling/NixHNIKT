{
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "turbonaepskrel";
  services.xserver = {
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      '';
    };
  };
}
