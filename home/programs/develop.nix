{
  lib,
  pkgs,
  ...
}: let
  devSDKs = with pkgs; {
    java21 = jdk21;
    scala = dotty;
    node = nodejs;
    yarn = yarn;
  };
  mkEntry = name: value: {
    inherit name;
    path = value;
  };
  entries = lib.mapAttrsToList mkEntry devSDKs;
  devSymlink = pkgs.linkFarm "local-dev" entries;
in {
  home.file.".local/dev".source = devSymlink;
}
