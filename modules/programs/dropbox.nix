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

    systemd.user.services.dropbox = {
      Unit = {
        Description = "Dropbox service";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.dropbox}/bin/dropbox";
        Restart = "on-failure";
      };
    };
  };
}
