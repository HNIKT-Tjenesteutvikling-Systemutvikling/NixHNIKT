{ pkgs, ... }:
let
  mailClient = pkgs.thunderbird;
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-devedition-unwrapped {
      extraPolicies = {
        ExtensionSettings = { };
      };
    };
  };
  home.packages = [ mailClient ];
}
