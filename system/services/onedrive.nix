{ config
, lib
, ...
}:
let
  cfg = config.service.onedrive;
in
{
  options.service.onedrive.enable = lib.mkEnableOption "onedrive";

  config = lib.mkIf cfg.enable {
    services.onedrive.enable = true;
  };
}
