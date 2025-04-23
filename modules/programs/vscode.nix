{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.vscode;
in
{
  options.program.vscode.enable = lib.mkEnableOption "vscode";

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
}
