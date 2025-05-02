{ config
, lib
, pkgs
, ...
}:
let
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

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.jetbrains.idea-ultimate ];
    home.file.".local/dev".source = devSymlink;
  };
}
