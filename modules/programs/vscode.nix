{ config
, lib
, pkgs
, ...
}:
with lib;
with builtins; let
  cfg = config.vscode;
in
{
  options.vscode.enable = lib.mkEnableOption "vscode";

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
}
