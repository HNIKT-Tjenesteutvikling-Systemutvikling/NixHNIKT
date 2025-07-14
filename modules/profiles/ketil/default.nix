{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "ketil@ketil.no";
    userName = "ketil";
  };

  # Home modules to load
  program = {
    dbeaver.enable = true;
    gimp.enable = true;
    intellij.enable = true;
    keepass.enable = true;
    libreoffice.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode.enable = true;
    wmware-horizon.enable = true;
  };
}
