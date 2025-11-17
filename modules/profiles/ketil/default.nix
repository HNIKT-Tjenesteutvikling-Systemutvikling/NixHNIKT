{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    settings.user = {
      Email = "ketilh@gmail.com";
      Name = "knotilla";
    };
  };

  # Home modules to load
  program = {
    browser = {
      chromium.enable = true;
      zen.enable = true;
    };
    dbeaver.enable = true;
    gimp.enable = true;
    intellij.enable = true;
    keepass.enable = true;
    libreoffice.enable = true;
    postman.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode.enable = true;
    wmware-horizon.enable = true;
  };
}
