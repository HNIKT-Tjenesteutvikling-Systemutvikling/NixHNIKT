{
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "solheim";
  services.xserver = {
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      '';
    };
  };
}
