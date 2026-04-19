{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.paf;
  paf = pkgs.callPackage ../../pkgs/paf { };
in
{
  options.program.paf.enable = lib.mkEnableOption "Personal Ancestal File";

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        paf
      ];

      persistence."/persist/" = {
        directories = [
          ".wine-paf"
        ];
      };
    };
  };
}
