{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.tilix;
in
{
  options.program.tilix.enable = lib.mkEnableOption "tilix";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        tilix
      ];
    };
  };
}
