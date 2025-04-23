{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.gimp;
in
{
  options.program.gimp.enable = lib.mkEnableOption "gimp";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
