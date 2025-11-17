{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    settings.user = {
      Email = "jan.olov.gustav.carlsson@hnikt.no";
      Name = "jca002";
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
    remmina.enable = true;
    slack.enable = true;
    spotify.enable = true;
    libreoffice.enable = true;
    vscode = {
      enable = true;
      theme = "light";
    };
    wmware-horizon.enable = true;
  };
}
