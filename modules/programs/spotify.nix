{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.spotify;
in
{
  options.program.spotify.enable = lib.mkEnableOption "spotify";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        spotify
      ];

      persistence."/persist/" = {
        directories = [
          ".cache/spotify-player"
        ];
      };
    };
  };
}
