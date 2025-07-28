{ osConfig
, config
, lib
, pkgs
, ...
}:
let
  inherit (osConfig.environment) desktop;
  cfg = config.program.intellij;

  devSDKs = with pkgs; {
    java21 = jdk21;
    scala = dotty;
    inherit metals;
  };

  mkEntry = name: value: {
    inherit name;
    path = value;
  };

  entries = lib.mapAttrsToList mkEntry devSDKs;
  devSymlink = pkgs.linkFarm "local-dev" entries;
in
{
  options.program.intellij.enable = lib.mkEnableOption "intellij";

  config = lib.mkIf (cfg.enable && desktop.enable && desktop.develop) {
    home = {
      packages = [ pkgs.jetbrains.idea-ultimate ];
      file.".local/dev".source = devSymlink;
      persistence."/persist/${config.home.homeDirectory}" = {
        directories = [
          ".cache/JetBrains"
          ".config/JetBrains"
          ".local/share/JetBrains"
        ];
      };
    };
  };
}
