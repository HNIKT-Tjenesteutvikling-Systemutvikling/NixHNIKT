{ osConfig, lib, ... }:
let
  inherit (osConfig.environment) desktop;
in
{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "jan-magnus.solheim@hnikt.no";
    userName = "5olheim";
  };

  # Home modules to load
  program = {
    browser = {
      chromium.enable = true;
      firefox.enable = true;
    };
    dbeaver.enable = true;
    gimp.enable = true;
    intellij.enable = true;
    keepass.enable = true;
    libreoffice.enable = true;
    slack.enable = true;
    spotify.enable = true;
    wmware-horizon.enable = true;
    vscode = {
      enable = true;
    };
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/color" = {
      "night-light-enabled" = true;
      "night-light-temperature" = lib.gvariant.mkUint32 3700;
      "night-light-schedule-from" = 6.0;
      "night-light-schedule-to" = 5.0;
    };
  };

  # Monitor settings for gnome
  home.file.".config/monitors.xml".text = lib.mkIf (desktop.windowManager == "gnome") ''
    <monitors version="2">
      <configuration>
        <layoutmode>physical</layoutmode>
        <logicalmonitor>
          <x>2560</x>
          <y>360</y>
          <scale>1</scale>
          <monitor>
            <monitorspec>
              <connector>eDP-1</connector>
              <vendor>AUO</vendor>
              <product>0x229e</product>
              <serial>0x00000000</serial>
            </monitorspec>
            <mode>
              <width>1920</width>
              <height>1080</height>
              <rate>60.049</rate>
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
              <connector>DP-2</connector>
              <vendor>SAM</vendor>
              <product>LS49A950U</product>
              <serial>H4ZT100025</serial>
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
