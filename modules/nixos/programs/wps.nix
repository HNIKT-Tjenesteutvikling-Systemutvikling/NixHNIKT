{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.programs.wps;
in {
  options.programs.wps.enable = lib.mkEnableOption "WPS Office (Kingsoft Office)";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wpsoffice
    ];
  };
}
