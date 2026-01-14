{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.anydesk;
in
{
  options.program.anydesk.enable = lib.mkEnableOption "anydesk";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        anydesk
      ];

      persistence."/persist/" = {
        directories = [
          ".anydesk"
        ];
      };
    };
  };
}
