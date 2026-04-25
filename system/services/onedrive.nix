{
  config,
  lib,
  ...
}:
let
  cfg = config.service.onedrive;
in
{
  options.service.onedrive.enable = lib.mkEnableOption "onedrive";

  config = lib.mkIf cfg.enable {
    services.onedrive.enable = true;
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
