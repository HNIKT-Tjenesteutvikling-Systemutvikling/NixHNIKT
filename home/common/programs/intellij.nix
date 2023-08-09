{
  lib,
  pkgs,
  ...
}: let
  overrideWithGApps = pkg: pkg.overrideAttrs (oldAttrs: {nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.wrapGAppsHook];});
  devSDKs = with pkgs; {
    java19 = jdk19;
    node = nodejs;
    yarn = yarn;
  };
  intellij = pkgs.jetbrains.idea-ultimate;
  mkEntry = name: value: {
    inherit name;
    path = value;
  };
  entries = lib.mapAttrsToList mkEntry devSDKs;
  devSymlink = pkgs.linkFarm "local-dev" entries;
in {
  home.packages = [intellij];
  home.file.".local/dev".source = devSymlink;
}
