{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.program.discord;
in
{
  options.program.discord.enable = lib.mkEnableOption "discord";

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        pkgs.discord
      ];
    };

    xdg.configFile = {
      "discord/settings.json" = {
        text = ''
          {
            "SKIP_HOST_UPDATE": true
          }
        '';
      };
    };
  };
}
