{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "jan.olov.gustav.carlsson@hnikt.no";
    userName = "jca002";
  };

  # Home modules to load
  program = {
    dbeaver.enable = true;
    gimp.enable = true;
    intellij.enable = true;
    keepass.enable = true;
    remmina.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode = {
      enable = true;
      theme = "light";
    };
    wmware-horizon.enable = true;
    libreoffice.enable = true;
  };
}
