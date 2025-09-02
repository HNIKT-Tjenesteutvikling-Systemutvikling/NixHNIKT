{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "jan-magnus.solheim@hnikt.no";
    userName = "5olheim";
  };

  # Home modules to load
  program = {
    browser = {
      chromium.enable = true;
      firefox.enable = true;
    };
    dbeaver.enable = true;
    gimp.enable = true;
    intellij.enable = true;
    keepass.enable = true;
    libreoffice.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode = {
      enable = true;
    };
  };
}
