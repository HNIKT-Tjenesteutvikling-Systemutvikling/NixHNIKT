{ osConfig
, config
, inputs
, pkgs
, lib
, ...
}:
let
  cfg = config.program.browser.zen;

  # Create a wrapper script for zen-browser with Wayland enabled
  zenWithWayland = pkgs.symlinkJoin {
    name = "zen-browser-wayland";
    paths = [ inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/zen \
        --set MOZ_ENABLE_WAYLAND 1
    '';
  };
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
      packages = [ zenWithWayland ];
      persistence."/persist/" = {
        directories = [
          ".zen"
        ];
      };
    };
  };
}
