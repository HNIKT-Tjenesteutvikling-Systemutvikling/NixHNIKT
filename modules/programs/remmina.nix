{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.remmina;
in
{
  options.program.remmina.enable = lib.mkEnableOption "remmina";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      remmina
    ];
  };
}
