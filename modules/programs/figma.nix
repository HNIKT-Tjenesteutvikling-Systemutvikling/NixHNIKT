{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.figma;
in
{
  options.program.figma.enable = lib.mkEnableOption "figma";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      figma-linux
    ];
  };
}
