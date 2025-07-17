{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.service.mysql;
in
{
  options.service.mysql.enable = lib.mkEnableOption "mysql";
  config = lib.mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mysql80;
    };
    networking.firewall.allowedTCPPorts = [ 3306 ];

    environment.persistence."/persist".users.dev = {
      directories = [
        "/var/lib/mysql"
        ".mysql"
      ];
    };
  };
}
