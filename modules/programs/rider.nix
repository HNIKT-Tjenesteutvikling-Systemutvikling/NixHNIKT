{ config
, lib
, pkgs
, ...
}:
with lib;
with builtins; let
  cfg = config.rider;

  devSDKs = with pkgs; {
    dotnet-sdk = dotnet-sdk;
    dotnet-runtime = dotnet-runtime;
  };

  mkEntry = name: value: {
    inherit name;
    path = value;
  };

  entries = lib.mapAttrsToList mkEntry devSDKs;
  devSymlink = pkgs.linkFarm "local-dotnet" entries;
in
{
  options.rider.enable = lib.mkEnableOption "rider";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.jetbrains.rider ];
    home.file.".local/dotnet".source = devSymlink;
  };
}
