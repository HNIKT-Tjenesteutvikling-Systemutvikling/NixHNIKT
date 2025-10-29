{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.program.browser.brave;
in
{
  options.program.browser.brave = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Brave browser";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.brave = {
      enable = true;
      package = pkgs.brave.overrideAttrs (_: {
        commandLineArgs = [
          "--ozone-platform-hint=auto"
        ];
      });
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
        { id = "iaddfgegjgjelgkanamleadckkpnjpjc"; } # Auto Quality for YouTube
        { id = "annfbnbieaamhaimclajlajpijgkdblo"; } # Dark Theme
        { id = "jdocbkpgdakpekjlhemmfcncgdjeiika"; } # right click
        { id = "hlepfoohegkhhmjieoechaddaejaokhf"; } # Refined Github
        { id = "bggfcpfjbdkhfhfmkjpbhnkhnpjjeomc"; } # Material icons for github
        { id = "cbghhgpcnddeihccjmnadmkaejncjndb"; } # Vencord web
      ];
    };
  };
}
