_: {
  flake.homeModules.programs-intellij =
    {
      osConfig,
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (osConfig.environment) desktop;
      cfg = config.program.intellij;

      devSDKs = with pkgs; {
        java25 = jdk25;
        scala = scala_3;
        inherit metals;
      };

      mkEntry = name: value: {
        inherit name;
        path = value;
      };

      entries = lib.mapAttrsToList mkEntry devSDKs;
      devSymlink = pkgs.linkFarm "local-dev" entries;

      # JSP support is unbundled since 2026.2 (IDEA-392988); bump with each IDE major (until-build 262.*).
      jspPlugin = pkgs.fetchzip {
        url = "https://plugins.jetbrains.com/files/13152/1152099/javaee-jsp-262.10315.69.zip";
        hash = "sha256-oQ+VX1eruLE/vfstNTp8NZnkxJSKq2L72uJBI4922CA=";
      };

      idea = pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.idea [ jspPlugin ];
    in
    {
      options.program.intellij.enable = lib.mkEnableOption "intellij";

      config = lib.mkIf (cfg.enable && desktop.enable && desktop.develop) {
        home = {
          packages = [ idea ];
          file.".local/dev".source = devSymlink;
          persistence."/persist/" = {
            directories = [
              ".cache/JetBrains"
              ".config/JetBrains"
              ".local/share/JetBrains"
              ".java"
            ];
          };
        };
      };
    };
}
