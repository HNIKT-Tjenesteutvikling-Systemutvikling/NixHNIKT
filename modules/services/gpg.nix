{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    seahorse
  ];

  programs = {
    gpg = {
      enable = true;
      homedir = "${config.home.homeDirectory}/.gnupg";
    };

    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
      settings = {
        PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-gnome3;
    };
  };
}
