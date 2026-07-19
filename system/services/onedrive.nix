{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.service.onedrive;
  onedrivePkg = config.services.onedrive.package;
in
{
  options.service.onedrive.enable = lib.mkEnableOption "onedrive";

  config = lib.mkIf cfg.enable {
    services.onedrive.enable = true;

    systemd.user.services."onedrive@" = {
      serviceConfig = {
        ExecStart = lib.mkForce ''
          ${onedrivePkg}/bin/onedrive --monitor --disable-notifications --confdir=%h/.config/%i
        '';
        RestartSec = lib.mkForce 60;
      };
    };

    environment.systemPackages = [
      (pkgs.writeShellScriptBin "onedrive-reauth" ''
        systemctl --user stop onedrive@onedrive
        ${onedrivePkg}/bin/onedrive --reauth
        exec systemctl --user start onedrive@onedrive
      '')
    ];
    environment.persistence."/persist" = {
      users.dev = {
        directories = [
          "OneDrive" # the actual synced files
          ".config/onedrive" # auth refresh token + items.sqlite3 sync database
        ];
      };
    };
  };
}
