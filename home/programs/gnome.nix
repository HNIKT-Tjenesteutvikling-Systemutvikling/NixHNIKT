{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    gnomeExtensions.battery-indicator-upower
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-panel
    gnomeExtensions.just-perfection
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.space-bar
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnomeExtensions.pop-shell
    flat-remix-gnome
  ];
  dconf.settings = {
    "org/gnome/tweaks".show-extensions-notice = false;
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "dash-to-panel@jderose9.github.com"
        "just-perfection-desktop@just-perfection"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "sound-output-device-chooser@kgshank.net"
        "space-bar@luchrioh"
        "tiling-assistant@leleat-on-github"
        "trayIconsReloaded@selfmade.pl"
        "Vitals@CoreCoding.com"
      ];
      favorite-apps = [
        "firefox-beta.desktop"
        "firefontelx.desktop"
        "thunderbird.desktop"
        "org.gnome.Nautilus.desktop"
        "spotify.desktop"
        "dbeaver.desktop"
        "code.desktop"
        "discord.desktop"
        "gimp.desktop"
        "microsoft-edge.desktop"
        "slack.desktop"
      ];
    };

    "org/gnome/shell/extensions/just-perfection" = {
      theme = true;
      activities-button = false;
      app-menu = true;
      animation = lib.hm.gvariant.mkUint32 3;
      clock-menu-position = lib.hm.gvariant.mkUint32 1;
      clock-menu-position-offset = lib.hm.gvariant.mkUint32 7;
    };

    "org/gnome/shell/extensions/caffeine" = {
      enable-fullscreen = true;
      restore-state = true;
      show-indicator = true;
      show-notification = false;
    };

    "org/gnome/shell/extension/dash-to-panel" = {
      # Possibly need to set this manually
      panel-position = ''{"0":"Bottom","1":"Bottom"}'';
      panel-sizes = ''{"0":55,"1":55}'';
      panel-element-positions-monitors-sync = true;
      appicon-margin = lib.hm.gvariant.mkUint32 0;
      appicon-padding = lib.hm.gvariant.mkUint32 3;
      dot-position = "TOP";
      dot-style-focused = "SOLID";
      dot-style-unfocused = "DOTS";
      animate-appicon-hover = true;
      animate-appicon-hover-animation-travel = "{'SIMPLE': 0.14999999999999999, 'RIPPLE': 0.40000000000000002, 'PLANK': 0.0}";
      isolate-monitors = true;
    };

    # Custom
    "org/gnome/shell/extensions/user-theme".name = "Flat-Remix-Blue-Light";
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/wm/preferences" = {
      workspace-names = ["Main"];
      "titlebar-font" = lib.hm.gvariant.mkString "Roboto Bold 11";
    };
  };
}
