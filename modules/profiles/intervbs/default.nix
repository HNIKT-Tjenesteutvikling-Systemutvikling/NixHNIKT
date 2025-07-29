{ osConfig, lib, ... }:
let
  inherit (osConfig.environment) desktop;
in
{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "joran@lillegaard.com";
    userName = "intervbs";
  };

  # Gnome dconf overrides
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".binding = "<Ctrl-Alt>t";
    "org/gnome/desktop/interface".show-battery-percentage = true;

    "org/gnome/shell".favorite-apps = [
      "org.gnome.Nautilus.desktop"
      "org.gnome.Console.desktop"
      "thunderbird.desktop"
      "zen.desktop"
      "firefox-devedition.desktop"
      "chromium-browser.desktop"
      "discord.desktop"
      "slack.desktop"
      "dbeaver.desktop"
      "idea-ultimate.desktop"
      "code.desktop"
    ];
  };

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
    dconf = lib.mkIf (desktop.windowManager == "gnome") {
      pictureUri = "file:///home/dev/Pictures/backgrounds/mario.jpg";
      pictureUriDark = "file:///home/dev/Pictures/backgrounds/mario.jpg";
    };
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
          <monitor>
            <monitorspec>
              <connector>DP-5</connector>
              <vendor>DEL</vendor>
              <product>DELL U2717D</product>
              <serial>J0XYN8AI261S</serial>
            </monitorspec>
            <mode>
              <width>2560</width>
              <height>1440</height>
              <rate>59.951</rate>
            </mode>
          </monitor>
        </logicalmonitor>
        <logicalmonitor>
          <x>5120</x>
          <y>623</y>
          <scale>1</scale>
          <monitor>
            <monitorspec>
              <connector>eDP-1</connector>
              <vendor>LGD</vendor>
              <product>0x06fa</product>
              <serial>0x00000000</serial>
            </monitorspec>
            <mode>
              <width>1920</width>
              <height>1200</height>
              <rate>60.001</rate>
            </mode>
          </monitor>
        </logicalmonitor>
        <logicalmonitor>
          <x>2560</x>
          <y>0</y>
          <scale>1</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>DP-9</connector>
              <vendor>DEL</vendor>
              <product>DELL U2717D</product>
              <serial>J0XYN8AI327S</serial>
            </monitorspec>
            <mode>
              <width>2560</width>
              <height>1440</height>
              <rate>59.951</rate>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
      <configuration>
        <layoutmode>physical</layoutmode>
        <logicalmonitor>
          <x>2843</x>
          <y>1440</y>
          <scale>1</scale>
          <monitor>
            <monitorspec>
              <connector>eDP-1</connector>
              <vendor>LGD</vendor>
              <product>0x06fa</product>
              <serial>0x00000000</serial>
            </monitorspec>
            <mode>
              <width>1920</width>
              <height>1200</height>
              <rate>60.001</rate>
            </mode>
          </monitor>
        </logicalmonitor>
        <logicalmonitor>
          <x>0</x>
          <y>0</y>
          <scale>1</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>DP-8</connector>
              <vendor>SAM</vendor>
              <product>C32JG5x</product>
              <serial>H4ZNA01013</serial>
            </monitorspec>
            <mode>
              <width>2560</width>
              <height>1440</height>
              <rate>143.998</rate>
            </mode>
          </monitor>
        </logicalmonitor>
        <logicalmonitor>
          <x>2560</x>
          <y>0</y>
          <scale>1</scale>
          <monitor>
            <monitorspec>
              <connector>DP-9</connector>
              <vendor>AOC</vendor>
              <product>Q3279WG5B</product>
              <serial>0x0000e1fb</serial>
            </monitorspec>
            <mode>
              <width>2560</width>
              <height>1440</height>
              <rate>59.951</rate>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
    </monitors>
  '';
}
