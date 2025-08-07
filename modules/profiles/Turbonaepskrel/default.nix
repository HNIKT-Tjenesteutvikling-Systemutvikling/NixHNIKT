{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "magnus.thoralf.kristiansen@hnikt.no";
    userName = "Turbonaepskrel";
  };

  # Home modules to load
  program = {
    dbeaver.enable = true;
    discord.enable = true;
    gimp.enable = false;
    intellij.enable = true;
    keepass.enable = true;
    remmina.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode.enable = true;
    wmware-horizon.enable = false;
    libreoffice.enable = true;
    tilix.enable = true;
  };
}
