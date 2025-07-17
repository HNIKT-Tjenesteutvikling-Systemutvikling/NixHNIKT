{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.dropbox;
in
{
  options.program.dropbox.enable = lib.mkEnableOption "dropbox";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        dropbox
      ];

      persistence."/persist/${config.home.homeDirectory}" = {
        directories = [
          ".dropbox"
        ];
      };
    };
  };
}
