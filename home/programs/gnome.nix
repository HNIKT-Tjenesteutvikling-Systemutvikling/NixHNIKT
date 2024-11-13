{
  lib,
  pkgs,
  ...
}: let
  wallpaper = "/home/merrinx/Sources/archive/images/wallpapers/dark_moon.jpg";
in
  with lib.hm.gvariant; {
    home.packages = with pkgs; [
      gnomeExtensions.caffeine
      gnomeExtensions.clipboard-history
      gnomeExtensions.dash-to-panel
      gnomeExtensions.just-perfection
      gnomeExtensions.tray-icons-reloaded
      gnomeExtensions.user-themes
      gnome-tweaks
      dconf-editor
      flat-remix-gnome
      ranger
    ];
    dconf.settings = {
      "org/gnome/desktop/search-providers" = {
        disabled = ["org.gnome.Boxes.desktop"];
        enabled = ["org.gnome.Weather.desktop"];
        sort-order = [
          "org.gnome.Contacts.desktop"
          "org.gnome.Documents.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Calendar.desktop"
          "org.gnome.Calculator.desktop"
          "org.gnome.Settings.desktop"
          "org.gnome.clocks.desktop"
          "org.gnome.design.IconLibrary.desktop"
          "org.gnome.seahorse.Application.desktop"
          "org.gnome.Weather.desktop"
          "org.gnome.Boxes.desktop"
        ];
      };

      "org/gnome/desktop/wm/preferences" = {
        mouse-button-modifier = "<Super>";
        num-workspaces = 5;
        resize-with-right-button = true;
        focus-mode = "sloppy";
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = false;
        edge-tiling = true;
        num-workspaces = 5;
        workspaces-only-on-primary = true;
      };

      "org/gnome/settings-daemon/plugins/power" = {
        idle-dim = false;
        power-button-action = "interactive";
        sleep-inactive-ac-type = "nothing";
        sleep-inactive-battery-type = "nothing";
      };

      "org/gnome/shell" = {
        enabled-extensions = [
          "caffeine@patapon.info"
          "clipboard-history@alexsaveau.dev"
          "dash-to-panel@jderose9.github.com"
          "just-perfection-desktop@just-perfection"
          "trayIconsReloaded@selfmade.pl"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };

      "org/gnome/shell/extensions/caffeine" = {
        enable-fullscreen = true;
        restore-state = true;
        show-indicator = true;
        show-notification = false;
      };

      "org/gnome/shell/extensions/clipboard-history" = {
        "display-mode" = 3;
        "next-entry" = ["<Shift><Alt>j"];
        "prev-entry" = ["<Shift><Alt>k"];
        "toggle-menu" = ["<Shift><Alt>v"];
      };

      "org/gnome/shell/extensions/dash-to-panel" = {
        appicon-margin = 0;
        appicon-padding = 3;
        available-monitors = [0];
        dot-position = "BOTTOM";
        hotkeys-overlay-combo = "TEMPORARILY";
        leftbox-padding = -1;
        panel-anchors = "{\"0\":\"MIDDLE\"}";
        panel-lengths = "{\"0\":100}";
        panel-positions = "{\"0\":\"BOTTOM\"}";
        panel-sizes = "{\"0\":48}";
        status-icon-padding = -1;
        tray-padding = -1;
        window-preview-title-position = "TOP";
      };

      "org/gnome/shell/extensions/just-perfection" = {
        "accessibility-menu" = true;
        "activities-button" = true;
        "activities-button-icon-monochrome" = false;
        "activities-button-label" = true;
        "animation" = 0;
        "app-menu" = false;
        "app-menu-icon" = true;
        "app-menu-label" = true;
        "background-menu" = true;
        "clock-menu" = true;
        "controls-manager-spacing-size" = 0;
        "dash" = true;
        "dash-icon-size" = 0;
        "dash-separator" = true;
        "double-super-to-appgrid" = true;
        "gesture" = true;
        "hot-corner" = false;
        "keyboard-layout" = true;
        "notification-banner-position" = 2;
        "osd" = false;
        "panel" = true;
        "panel-arrow" = true;
        "panel-button-padding-size" = 4;
        "panel-corner-size" = 0;
        "panel-in-overview" = true;
        "panel-indicator-padding-size" = 0;
        "panel-notification-icon" = true;
        "panel-size" = 0;
        "power-icon" = true;
        "quick-settings" = true;
        "ripple-box" = true;
        "screen-sharing-indicator" = true;
        "search" = true;
        "show-apps-button" = true;
        "startup-status" = 0;
        "theme" = false;
        "window-demands-attention-focus" = false;
        "window-menu-take-screenshot-button" = true;
        "window-picker-icon" = true;
        "window-preview-caption" = true;
        "window-preview-close-button" = true;
        "workspace" = false;
        "workspace-background-corner-size" = 0;
        "workspace-peek" = false;
        "workspace-popup" = true;
        "workspace-switcher-size" = 0;
        "workspace-wrap-around" = false;
        "workspaces-in-app-grid" = true;
      };

      "org/gnome/shell/extensions/user-theme".name = "Flat-Remix-Blue-Light";
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/shell/app-switcher" = {
        current-workspace-only = false;
      };

      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };

      "org/gnome/TextEditor" = {
        keybindings = "vim";
      };
    };
  }
