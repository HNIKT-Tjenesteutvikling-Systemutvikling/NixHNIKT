{ osConfig, lib, ... }:
{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "joran@lillegaard.com";
    userName = "intervbs";
  };

  # Gnome dconf overrides
  dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".binding =
    "<Ctrl-Alt>t";

  # Home modules to load
  program = {
    dbeaver.enable = true;
    discord.enable = true;
    gimp.enable = true;
    intellij.enable = true;
    keepass.enable = true;
    remmina.enable = true;
    slack.enable = true;
    spotify.enable = false;
    vscode.enable = true;
    wmware-horizon.enable = true;
    libreoffice.enable = true;

    # Gnome dconf custom options
    dconf = lib.mkIf (osConfig.environment.desktop.windowManager == "gnome") {
      pictureUri = "file:///home/dev/Pictures/002.jpg";
      pictureUriDark = "file:///home/dev/Pictures/002.jpg";
    };
  };
}
