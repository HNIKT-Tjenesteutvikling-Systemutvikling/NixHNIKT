{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.filezilla;
in
{
  options.program.filezilla.enable = lib.mkEnableOption "filezilla";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      filezilla
    ];
  };
}
