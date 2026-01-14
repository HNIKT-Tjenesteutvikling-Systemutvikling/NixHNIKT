{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.postman;
in
{
  options.program.postman.enable = lib.mkEnableOption "postman";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        postman
      ];
      persistence."/persist/" = {
        directories = [
          ".config/postman"
        ];
      };
    };
  };
}
