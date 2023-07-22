{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.programs.browser;
in {
  config = mkIf (cfg.application == "chromium") {
    programs.chromium = {
      enable = true;
    };
  };
}
