{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.dbeaver;
in
{
  options.program.dbeaver.enable = lib.mkEnableOption "dbeaver";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dbeaver-bin
    ];
  };
}
