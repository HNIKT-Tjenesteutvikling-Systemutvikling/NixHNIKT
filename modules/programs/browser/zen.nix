_: {
  flake.homeModules.programs-browser-zen =
    {
      osConfig,
      config,
      inputs,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.program.browser.zen;

      # Upstream still sets the pre-rename passthru flags, so wrapFirefox drops
      # ffmpeg from the library path and media playback fails.
      # Drop once https://github.com/youwen5/zen-browser-flake/pull/20 lands.
      zen-unwrapped =
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".zen-browser-unwrapped.overrideAttrs
          (prev: {
            passthru = prev.passthru // {
              withGSSAPI = true;
              withFFmpeg = true;
            };
          });

      zen = pkgs.wrapFirefox zen-unwrapped { pname = "zen-browser"; };
    in
    {

      options.program.browser.zen = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable Browser Zen";
        };
      };

      config = lib.mkIf cfg.enable {
        home = lib.mkIf osConfig.environment.desktop.enable {
          packages = [ zen ];
          persistence."/persist/" = {
            directories = [
              ".zen"
            ];
          };
        };
      };
    };
}
