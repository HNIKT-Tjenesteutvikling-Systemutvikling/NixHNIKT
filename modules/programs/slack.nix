{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.slack;
in
{
  options.program.slack.enable = lib.mkEnableOption "slack";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      slack
    ];
  };
}
