{ config
, lib
, ...
}:
let
  cfg = config.onedrive;
in
{
  options.onedrive.enable = lib.mkEnableOption "onedrive";

  config = lib.mkIf cfg.enable {
    services.onedrive.enable = true;
  };
}
