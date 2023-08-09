{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.programs.intellij;
  devSDKs = with pkgs; {
    java19 = jdk19;
    node = nodejs;
    yarn = yarn;
  };
  mkEntry = name: value: {
    inherit name;
    path = value;
  };
  entries = lib.mapAttrsToList mkEntry devSDKs;
  devSymLink = pkgs.linkFarm "local-dev" entries;
in {
  options.programs.intellij.enable = lib.mkEnableOption "intellij";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.idea-ultimate
      devSymLink
    ];
  };
}
