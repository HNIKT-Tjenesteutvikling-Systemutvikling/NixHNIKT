_: {
  flake.homeModules.programs-browser-chromium =
    { config, lib, ... }:
    let
      cfg = config.program.browser.chromium;
      ext = import ./_extensions.nix;
    in
    {
      options.program.browser.chromium = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable Chromium browser";
        };
      };

      config = lib.mkIf cfg.enable {
        programs.chromium = {
          enable = true;
          extensions = builtins.attrValues ext;
          commandLineArgs = [ "--ozone-platform-hint=auto" ];
        };

        home.persistence."/persist/" = {
          directories = [
            ".config/chromium"
          ];
        };
      };
    };
}
