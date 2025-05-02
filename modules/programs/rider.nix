{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.rider;

  devSDKs = with pkgs; {
    inherit dotnet-sdk dotnet-runtime;
  };

  mkEntry = name: value: {
    inherit name;
    path = value;
  };

  entries = lib.mapAttrsToList mkEntry devSDKs;
  devSymlink = pkgs.linkFarm "local-dotnet" entries;
in
{
  options.program.rider.enable = lib.mkEnableOption "rider";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.jetbrains.rider ];
    home.file.".local/dotnet".source = devSymlink;
  };
}
