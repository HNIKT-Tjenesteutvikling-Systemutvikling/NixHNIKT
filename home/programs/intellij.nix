{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with builtins; let
  cfg = config.intellij;

  overrideWithGApps = pkg: pkg.overrideAttrs (oldAttrs: {nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.wrapGAppsHook];});
  devSDKs = with pkgs; {
    java21 = jdk21;
    scala = dotty;
    metals = metals;
    node = nodejs;
    yarn = yarn;
  };
  extraPath = lib.makeBinPath (builtins.attrValues devSDKs);
  idea-with-copilot = pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.idea-ultimate [
    "github-copilot"
  ];
  mkEntry = name: value: {
    inherit name;
    path = value;
  };
  entries = lib.mapAttrsToList mkEntry devSDKs;
  devSymlink = pkgs.linkFarm "local-dev" entries;
in {
  options.intellij.enable = lib.mkEnableOption "intellij";

  config = lib.mkIf cfg.enable {
    home.packages = [idea-with-copilot];
    home.file.".local/dev".source = devSymlink;
  };
}
