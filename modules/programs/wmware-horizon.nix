{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.wmware-horizon;
in
{
  options.program.wmware-horizon.enable = lib.mkEnableOption "wmware-horizon-client";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vmware-horizon-client
    ];
  };
}
