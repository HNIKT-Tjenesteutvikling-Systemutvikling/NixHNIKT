{ config, ... }:
let
  ext = import ./extensions.nix;
in
{
  programs.chromium = {
    enable = true;
    extensions = builtins.attrValues ext;
    commandLineArgs = [ "--ozone-platform-hint=auto" ];
  };

  home.persistence."/persist/${config.home.homeDirectory}" = {
    directories = [
      ".config/chromium"
      ".config/BraveSoftware"
    ];
  };
}
