{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.obsidian;
in
{
  options.program.obsidian.enable = lib.mkEnableOption "obsidian";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
