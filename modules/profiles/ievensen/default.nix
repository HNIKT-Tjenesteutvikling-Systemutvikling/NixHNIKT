{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "idar.evensen@gmail.com";
    userName = "ievensen";
  };

  # Home modules to load
  program = {
    discord.enable = true;
    gimp.enable = true;
    keepass.enable = true;
    remmina.enable = true;
    vmware-horizon.enable = true;
    slack.enable = true;
    spotify.enable = true;
    tmux.enable = true;
    vscode.enable = true;
  };
}
