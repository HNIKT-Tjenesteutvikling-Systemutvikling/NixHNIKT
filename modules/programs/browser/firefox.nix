{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.program.browser.firefox;

  mailClient = pkgs.thunderbird;
in
{
  options.program.browser.firefox = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable firefox browser";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-devedition-unwrapped {
        extraPolicies = {
          ExtensionSettings = { };
        };
      };
    };
    home = {
      packages = [ mailClient ];
      persistence."/persist/" = {
        directories = [
          ".config/mozilla"
          ".mozilla"
          ".thunderbird"
        ];
      };
    };
  };
}
