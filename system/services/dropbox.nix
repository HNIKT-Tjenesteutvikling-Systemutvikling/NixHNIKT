{ config, lib, pkgs, ... }:
let
  cfg = config.service.dropbox;

in
{
  options.service.dropbox.enable = lib.mkEnableOption "dropbox";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dropbox-cli
    ];

    networking.firewall = {
      allowedTCPPorts = [ 17500 ];
      allowedUDPPorts = [ 17500 ];
    };

    systemd.user.services.dropbox = {
      description = "Dropbox";
      wantedBy = [ "graphical-session.target" ];
      environment = {
        QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
        QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
      };
      serviceConfig = {
        ExecStart = "${lib.getBin pkgs.dropbox}/bin/dropbox";
        ExecReload = "${lib.getBin pkgs.coreutils}/bin/kill -HUP $MAINPID";
        KillMode = "control-group";
        Restart = "on-failure";
        PrivateTmp = true;
        ProtectSystem = "full";
        Nice = 10;
      };
    };
  };
}
