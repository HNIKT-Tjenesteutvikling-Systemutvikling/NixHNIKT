{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "torkil.grindstein@hnikt.no";
    userName = "grindstein";
  };

  # Home modules to load
  program = {
    anydesk.enable = true;
    dbeaver.enable = true;
    dropbox.enable = true;
    gimp.enable = true;
    intellij.enable = true;
    keepass.enable = true;
    libreoffice.enable = true;
    remmina.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode.enable = true;
    vmware-horizon.enable = true;
  };
}
