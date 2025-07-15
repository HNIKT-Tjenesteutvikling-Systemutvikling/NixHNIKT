{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.libreoffice;
in
{
  options.program.libreoffice.enable = lib.mkEnableOption "libreoffice";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        libreoffice
      ];

      persistence."/persist/${config.home.homeDirectory}" = {
        directories = [
          ".config/libreoffice"
        ];
      };
    };
  };
}
