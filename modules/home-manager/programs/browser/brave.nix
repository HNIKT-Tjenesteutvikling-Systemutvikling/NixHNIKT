{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.programs.browser;
in {
  config = mkIf (cfg.application == "brave") {
    programs.brave = {
      enable = true;
    };
  };
}
