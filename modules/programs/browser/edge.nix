{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.program.browser.edge;
in
{
  options.program.browser.edge = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable edge browser";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.microsoft-edge
    ];
  };
}
