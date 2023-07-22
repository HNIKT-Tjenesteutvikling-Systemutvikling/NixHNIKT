{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.programs.browser;
in {
  config = mkIf (cfg.application == "firefox") {
    programs.firefox = {
      enable = true;
    };

    programs.thunderbird = {
      enable = true;
      profiles."dev" = {
        isDefault = true;
      };
    };
  };
}
