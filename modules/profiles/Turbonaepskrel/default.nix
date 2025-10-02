{ osConfig, lib, ... }:
let
  inherit (osConfig.environment) desktop;
in

{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "magnus.thoralf.kristiansen@hnikt.no";
    userName = "Turbonaepskrel";
  };

  # Home modules to load
  program = {
    browser = {
      chromium.enable = true;
      zen.enable = true;
    };
    dbeaver.enable = true;
    discord.enable = true;
    gimp.enable = false;
    intellij.enable = true;
    keepass.enable = true;
    remmina.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode = {
      enable = true;
      theme = "onedark";
    };
    wmware-horizon.enable = false;
    libreoffice.enable = true;
    tilix.enable = true;
  };
  # Monitor settings for gnome
  home.file.".config/monitors.xml".text = lib.mkIf (desktop.windowManager == "gnome") ''
    <monitors version="2">
      <configuration>
        <layoutmode>physical</layoutmode>
        <logicalmonitor>
          <x>2560</x>
          <y>0</y>
          <scale>1</scale>
          <monitor>
            <monitorspec>
              <connector>DP-7</connector>
              <vendor>PHL</vendor>
              <product>PHL 499P9</product>
              <serial>AU02252003836</serial>
            </monitorspec>
            <mode>
              <width>2560</width>
              <height>1440</height>
              <rate>59.951</rate>
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
              <vendor>PHL</vendor>
              <product>PHL 499P9</product>
              <serial>AU02252003836</serial>
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
          <x>2560</x>
          <y>0</y>
          <scale>1</scale>
          <monitor>
            <monitorspec>
              <connector>DP-5</connector>
              <vendor>PHL</vendor>
              <product>PHL 499P9</product>
              <serial>AU02252003836</serial>
            </monitorspec>
            <mode>
              <width>2560</width>
              <height>1440</height>
              <rate>59.951</rate>
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
              <connector>DP-6</connector>
              <vendor>PHL</vendor>
              <product>PHL 499P9</product>
              <serial>AU02252003836</serial>
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
