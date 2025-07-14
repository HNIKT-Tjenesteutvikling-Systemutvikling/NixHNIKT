{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.keepass;
in
{
  options.program.keepass.enable = lib.mkEnableOption "keepass";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        keepass
      ];
      persistence."/persist/${config.home.homeDirectory}" = {
        directories = [
          ".keepass"
        ];
      };
    };
  };
}
