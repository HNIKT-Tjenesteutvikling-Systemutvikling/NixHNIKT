_: {
  flake.homeModules.programs-dropbox =
    {
      config,
      lib,
      pkgs,
      ...
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
            # Dropbox checks for AppIndicator support at startup and refuses to
            # show a tray icon without it. libappindicator-gtk3 provides the
            # shared library Dropbox dlopen's to register itself as an app indicator.
            libappindicator-gtk3
            gnomeExtensions.appindicator
          ];
          persistence."/persist/" = {
            directories = [
              ".dropbox" # auth token + local sync index
              "Dropbox" # the actual synced files
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
    };
}
