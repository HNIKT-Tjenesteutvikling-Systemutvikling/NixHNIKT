{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.mysql;
in
{
  options.mysql.enable = lib.mkEnableOption "mysql";
  config = lib.mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mysql80;
    };
    networking.firewall.allowedTCPPorts = [ 3306 ];
  };
}
