{ osConfig, lib, ... }:
let
  inherit (osConfig.environment) desktop;
in

{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "sigurdjbratt@hotmail.no";
    userName = "sigubrat";
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
    remmina.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode = {
      enable = true;
      theme = "cyberpunk";
    };
    wmware-horizon.enable = true;
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
      <connector>DP-11</connector>
      <vendor>HWP</vendor>
      <product>HP Z27n</product>
      <serial>CNK5440603</serial>
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
      <monitor>
      <monitorspec>
      <connector>DP-9</connector>
      <vendor>HWP</vendor>
      <product>HP Z27n</product>
      <serial>CNK5440603</serial>
      </monitorspec>
      <mode>
      <width>2560</width>
      <height>1440</height>
      <rate>59.951</rate>
      </mode>
      </monitor>
      </logicalmonitor>
    <logicalmonitor>
    <x>2560</x>
    <y>0</y>
    <scale>1</scale>
    <monitor>
    <monitorspec>
    <connector>DP-8</connector>
    <vendor>HWP</vendor>
    <product>HP Z27n</product>
    <serial>CNK6481RQ6</serial>
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
    <y>360</y>
    <scale>1</scale>
    <primary>yes</primary>
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
    <x>2560</x>
    <y>0</y>
    <scale>1</scale>
    <monitor>
    <monitorspec>
    <connector>DP-6</connector>
    <vendor>HWP</vendor>
    <product>HP Z27n</product>
    <serial>CNK6481RQ6</serial>
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
    <y>360</y>
    <scale>1</scale>
    <primary>yes</primary>
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
    </configuration>
    <configuration>
    <layoutmode>physical</layoutmode>
    <logicalmonitor>
    <x>5120</x>
    <y>360</y>
    <scale>1</scale>
    <primary>yes</primary>
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
    <monitor>
    <monitorspec>
    <connector>DP-9</connector>
    <vendor>HWP</vendor>
    <product>HP Z27n</product>
    <serial>CNK5440603</serial>
    </monitorspec>
    <mode>
    <width>2560</width>
    <height>1440</height>
    <rate>59.951</rate>
    </mode>
    </monitor>
    </logicalmonitor>
    <logicalmonitor>
    <x>2560</x>
    <y>0</y>
    <scale>1</scale>
    <monitor>
    <monitorspec>
    <connector>DP-6</connector>
    <vendor>HWP</vendor>
    <product>HP Z27n</product>
    <serial>CNK6481RQ6</serial>
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
