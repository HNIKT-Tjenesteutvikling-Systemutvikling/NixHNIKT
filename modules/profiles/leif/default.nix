{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "leif@leif.no";
    userName = "leif";
  };

  # Home modules to load
  program = {
    dbeaver.enable = true;
    discord.enable = true;
    gimp.enable = true;
    keepass.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode.enable = true;
  };
}
