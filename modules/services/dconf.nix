{ osConfig
, config
, pkgs
, lib
, ...
}:
let
  inherit (osConfig.environment) desktop;
  cfg = config.program.dconf;

  autostartPrograms = [
    pkgs.discord
    pkgs.slack
  ];
in
{
  options.program.dconf = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Gnome configuration";
    };
    cursorSize = lib.mkOption {
      type = lib.types.int;
      default = 24;
      description = "Set cursor size";
    };
    pictureUri = lib.mkOption {
      type = lib.types.str;
      default = "file:///home/dev/Sources/nixhnikt/images/wallpaper.jpg";
      description = "URI of the GNOME desktop background image.";
    };
    pictureOptions = lib.mkOption {
      type = lib.types.str;
      default = "fill";
      description = "Option of the GNOME desktop background image.";
    };
    pictureUriDark = lib.mkOption {
      type = lib.types.str;
      default = "file:///home/dev/Sources/nixhnikt/images/wallpaper.jpg";
      description = "URI of the GNOME desktop background image (dark mode).";
    };
    primaryColor = lib.mkOption {
      type = lib.types.str;
      default = "#B9B5AE";
      description = "Primary color of the GNOME desktop background.";
    };
    colorScheme = lib.mkOption {
      type = lib.types.enum [
        "prefer-dark"
        "default"
      ];
      default = "prefer-dark";
      description = "GNOME interface color scheme";
    };
    enableHotCorners = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable GNOME hot corners";
    };
    screensaverPictureUri = lib.mkOption {
      type = lib.types.str;
      default = "file:///home/dev/Sources/nixhnikt/images/wallpaper.jpg";
      description = "URI of the GNOME screensaver background.";
    };
    screensaverPrimaryColor = lib.mkOption {
      type = lib.types.str;
      default = "#B9B5AE";
      description = "Primary color of the GNOME screensaver background.";
    };
    screensaverSecondaryColor = lib.mkOption {
      type = lib.types.str;
      default = "#000000";
      description = "Secondary color of the GNOME screensaver background.";
    };
    traySize = lib.mkOption {
      type = lib.types.int;
      default = 15;
      description = "Set the tray icon size.";
    };
    leftBoxSize = lib.mkOption {
      type = lib.types.int;
      default = 17;
      description = "Set the left box icon size.";
    };
    panelSizes = lib.mkOption {
      type = lib.types.str;
      default = "{\"0\":46}";
      description = "Panel size of the GNOME desktop";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf osConfig.service.virt-manager.enable {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
      };
    })
    (lib.mkIf (cfg.enable && desktop.windowManager == "gnome") {

      gtk.cursorTheme.size = lib.mkForce config.program.dconf.cursorSize;

      dconf.settings = {
        "org/gnome/TextEditor" = {
          keybindings = "vim";
        };
        "org/gnome/desktop/background" = {
          picture-uri = config.program.dconf.pictureUri;
          picture-options = config.program.dconf.pictureOptions;
          picture-uri-dark = config.program.dconf.pictureUriDark;
          primary-color = config.program.dconf.primaryColor;
        };
        "org/gnome/desktop/interface" = {
          color-scheme = config.program.dconf.colorScheme;
          enable-hot-corners = config.program.dconf.enableHotCorners;
        };
        "org/gnome/desktop/input-sources" = {
          sources = [
            (lib.hm.gvariant.mkTuple [
              "xkb"
              "no"
            ])
            (lib.hm.gvariant.mkTuple [
              "xkb"
              "us"
            ])
          ];
        };
        "org/gnome/desktop/screensaver" = {
          picture-uri = config.program.dconf.screensaverPictureUri;
          primary-color = config.program.dconf.screensaverPrimaryColor;
          secondary-color = config.program.dconf.screensaverSecondaryColor;
        };
        "org/gnome/desktop/session" = {
          idle-delay = lib.hm.gvariant.mkUint32 0;
        };
        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Alt>q" ];
          move-to-workspace-1 = [ "<Shift><Super>1" ];
          move-to-workspace-2 = [ "<Shift><Super>2" ];
          move-to-workspace-3 = [ "<Shift><Super>3" ];
          move-to-workspace-4 = [ "<Shift><Super>4" ];
          move-to-workspace-5 = [ "<Shift><Super>5" ];
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          switch-to-workspace-left = [ ];
          switch-to-workspace-right = [ ];
          toggle-fullscreen = [ "<Super>g" ];
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = ":minimize,maximize,close";
          focus-mode = "click";
          mouse-button-modifier = "<Super>";
          num-workspaces = 5;
          resize-with-right-button = true;
          workspace-names = [ "Main" ];
        };
        "org/gnome/mutter" = {
          center-new-windows = true;
          dynamic-workspaces = false;
          edge-tiling = true;
          num-workspaces = 5;
          workspaces-only-on-primary = true;
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = lib.mkDefault "<Super>Return";
          command = lib.mkDefault "kgx";
          name = lib.mkDefault "console";
        };
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            caffeine.extensionUuid
            clipboard-indicator.extensionUuid
            dash-to-panel.extensionUuid
            just-perfection.extensionUuid
            space-bar.extensionUuid
            tray-icons-reloaded.extensionUuid
            user-themes.extensionUuid
          ];
          favorite-apps = lib.mkDefault [
            "org.gnome.Console.desktop"
            "discord.desktop"
            "gimp.desktop"
            "org.gnome.Nautilus.desktop"
            "thunderbird.desktop"
            "firefox-devedition.desktop"
            "chromium-browser.desktop"
            "idea-ultimate.desktop"
            "dbeaver.desktop"
            "slack.desktop"
            "code.desktop"
            "spotify.desktop"
            "zen.desktop"
          ];
        };
        "org/gnome/shell/app-switcher" = {
          current-workspace-only = false;
        };
        "org/gnome/shell/extensions/caffeine" = {
          enable-fullscreen = true;
          restore-state = true;
          show-indicator = true;
          show-notification = false;
          user-enabled = true;
        };
        "org/gnome/shell/extensions/clipboard-indicator" = {
          next-entry = [ ];
        };
        "org/gnome/shell/extensions/dash-to-panel" = {
          window-preview-fixed-x = true;
          window-preview-fixed-y = true;
          preview-custom-opacity = 73;
          window-preview-size = 127;
          appicon-padding = 5;
          appicon-margin = 3;
          show-tooltip = false;
          show-showdesktop-hover = true;
          dot-style-unfocused = "DOTS";
          dot-style-focused = "DOTS";
          trans-use-custom-opacity = true;
          trans-panel-opacity = "0.55";
          tray-size = config.program.dconf.traySize;
          leftbox-size = config.program.dconf.leftBoxSize;
          panel-element-positions = ''{"AUS-0x0000bec6":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"centered"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'';
          panel-sizes = config.program.dconf.panelSizes;
          panel-positions = "{\"0\":\"BOTTOM\"}";
          showdesktop-button-width = "5";
          show-apps-icon-file = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
        };
        "org/gnome/shell/extensions/just-perfection" = {
          accessibility-menu = true;
          app-menu = true;
          app-menu-icon = true;
          background-menu = true;
          clock-menu = false;
          controls-manager-spacing-size = 22;
          dash = true;
          dash-icon-size = 0;
          double-super-to-appgrid = true;
          gesture = true;
          hot-corner = false;
          notification-banner-position = 2;
          osd = false;
          panel = true;
          panel-arrow = true;
          panel-corner-size = 1;
          panel-in-overview = true;
          panel-notification-icon = true;
          panel-size = 36;
          power-icon = true;
          ripple-box = false;
          search = false;
          show-apps-button = true;
          startup-status = 0;
          support-notifier-type = 0;
          theme = true;
          window-demands-attention-focus = true;
          window-picker-icon = false;
          window-preview-caption = true;
          window-preview-close-button = true;
          workspace = true;
          workspace-background-corner-size = 15;
          workspace-popup = false;
          workspaces-in-app-grid = true;
        };
        "org/gnome/shell/extensions/user-theme" = {
          name = "palenight";
        };
        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [ ];
          switch-to-application-2 = [ ];
          switch-to-application-3 = [ ];
          switch-to-application-4 = [ ];
          switch-to-application-5 = [ ];
        };
        "system/locale" = {
          region = "en_US.UTF-8";
        };
        "org/gtk/gtk4/settings/file-chooser" = {
          show-hidden = true;
        };
        "org/gnome/nautilus/icon-view" = {
          default-zoom-level = "small-plus";
        };
      };

      home = {
        file = builtins.listToAttrs (
          map
            (pkg: {
              name = ".config/autostart/" + pkg.pname + ".desktop";
              value =
                if pkg ? desktopItem then
                  {
                    inherit (pkg.desktopItem) text;
                  }
                else
                  {
                    source = pkg + "/share/applications/" + pkg.pname + ".desktop";
                  };
            })
            autostartPrograms
        );

        packages = with pkgs; [
          gnomeExtensions.caffeine
          gnomeExtensions.clipboard-indicator
          gnomeExtensions.dash-to-panel
          gnomeExtensions.just-perfection
          gnomeExtensions.space-bar
          gnomeExtensions.sound-output-device-chooser
          gnomeExtensions.tray-icons-reloaded
          gnomeExtensions.user-themes
          palenight-theme
        ];
      };
    })
  ];
}
