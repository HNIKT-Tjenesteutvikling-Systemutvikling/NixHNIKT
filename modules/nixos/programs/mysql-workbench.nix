{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.programs.mysql-workbench;
in {
  options.programs.mysql-workbench.enable = lib.mkEnableOption "Mysql-Workbench";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mysql-workbench
    ];
  };
}
