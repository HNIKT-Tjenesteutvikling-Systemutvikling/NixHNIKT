{ osConfig, lib, ... }:
let
  inherit (osConfig.environment) desktop;
in
{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "eggenfellner@protonmail.com";
    userName = "leifeggenfellner";
  };

  # Home modules to load
  program = {
    browser = {
      chromium.enable = true;
      zen.enable = true;
    };
    dbeaver.enable = true;
    discord.enable = true;
    gimp.enable = true;
    keepass.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode.enable = true;
  };
  # Monitor settings for gnome
  home.file.".config/monitors.xml".text = lib.mkIf (desktop.windowManager == "gnome") ''
        <monitors version="2">
      <configuration>
        <layoutmode>physical</layoutmode>
        <logicalmonitor>
          <x>0</x>
          <y>0</y>
          <scale>1</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>DP-1</connector>
              <vendor>HPN</vendor>
              <product>HP E45c G5</product>
              <serial>CNC50212K0</serial>
            </monitorspec>
            <mode>
              <width>5120</width>
              <height>1440</height>
              <rate>165.001</rate>
            </mode>
          </monitor>
        </logicalmonitor>
        <logicalmonitor>
          <x>1646</x>
          <y>1440</y>
          <scale>1</scale>
          <monitor>
            <monitorspec>
              <connector>eDP-1</connector>
              <vendor>LGD</vendor>
              <product>0x0791</product>
              <serial>0x00000000</serial>
            </monitorspec>
            <mode>
              <width>1920</width>
              <height>1200</height>
              <rate>60.001</rate>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
    </monitors>
  '';
}
