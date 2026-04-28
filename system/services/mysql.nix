{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.service.mysql;
in
{
  options.service.mysql.enable = lib.mkEnableOption "mysql";
  config = lib.mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mysql84;
      settings = {
        mysqld = {
          # MySQL 8.4 deprecates non-unique/partial keys as foreign keys.
          # Disable the restriction so legacy schemas keep working.
          restrict_fk_on_non_standard_key = "OFF";
        };
      };
    };
    networking.firewall.allowedTCPPorts = [ 3306 ];

    environment = {
      persistence."/persist" = {
        directories = [
          "/var/lib/mysql"
        ];
        users.dev = {
          directories = [
            {
              directory = ".mysql";
              mode = "0700";
            }
          ];
        };
      };
    };
  };
}
