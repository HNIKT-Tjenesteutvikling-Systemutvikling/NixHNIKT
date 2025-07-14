{ config
, lib
, ...
}:
let
  sshConfigSourcePath = config.home.homeDirectory + "/.ssh/config_source";
  sourceFileExists = builtins.pathExists sshConfigSourcePath;
in
{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "leif@leif.no";
    userName = "leif";
  };

  # Fix git not working in vscode terminal
  # Copies the ssh config instead of symlinking it
  home.file.".ssh/config" = lib.mkIf sourceFileExists {
    target = ".ssh/config_source";
    onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
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
