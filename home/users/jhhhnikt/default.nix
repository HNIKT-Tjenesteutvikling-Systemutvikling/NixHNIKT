{pkgs, lib, ...}: {
  home.packages = with pkgs; [
    android-studio
    bitwarden-desktop
    clamav
    figma-linux
    filezilla
    google-chrome
    totem
    gitg
    microsoft-edge
    vmware-horizon-client
    yaru-theme
    corefonts # Microsoft free fonts
    dejavu_fonts
  ];

  programs.git = {
    enable = true;
    userEmail = "jan.henrik.hasselberg@hnikt.no";
    userName = "jhhhnikt";
    signing = {
      key = "530B240AB1AD2F7C";
      signByDefault = true;
    };
  };

  # Allow devcontainers to speak with gpg agent.
  services.gpg-agent.enableExtraSocket = true;

  # Fix git push not working in vscode terminal due to permissions.
  # Copies the ssh config instead of symlinking it.
  # https://github.com/nix-community/home-manager/issues/322#issuecomment-1856128020
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
  };

  # Override defaults in home/themes/default.nix
  # Reference: https://github.com/nix-community/home-manager/blob/master/modules/misc/gtk.nix
  gtk = {
    enable = true;
    iconTheme = {
      name = lib.mkForce "Yaru";
      package = lib.mkForce pkgs.yaru-theme;
    };
    theme = {
      name = lib.mkForce "Yaru";
      package = lib.mkForce pkgs.yaru-theme;
    };
    cursorTheme = {
      name = "Yaru";
      size = 16;
      package = pkgs.yaru-theme;
    };
  };

  # QT theme.
  # Reference: https://github.com/nix-community/home-manager/blob/master/modules/misc/qt.nix
  qt = {
    enable = true;
    platformTheme = { name = "adwaita"; };
    style = { 
      name = "adwaita";
      package = pkgs.adwaita-qt; 
    };
  };

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };

    # Override defaults in home/programs/gnome.nix.
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
    };

    # Override defaults in home/programs/gnome.nix
    "org/gnome/shell/extensions/user-theme" = { 
      name = lib.mkForce "Yaru";
    };

    # Hint: Use "gsettings get org.gnome.shell favorite-apps" to find *.desktop name after added manually.
    "org/gnome/shell" = {
      # Favoritt-panelet.
      favorite-apps = lib.mkForce [
        #"firefox-beta.desktop"
        #"firefontelx.desktop"
        #"thunderbird.desktop"
        "org.gnome.Nautilus.desktop"
        #"spotify.desktop"
        "dbeaver.desktop"
        "code.desktop"
        "android-studio.desktop"
        #"discord.desktop"
        #"gimp.desktop"
        "virt-manager.desktop"
        "google-chrome.desktop"
        "microsoft-edge.desktop"
        "chrome-cinhimbnkkaeohfgghhklpknlkffjgod-Default.desktop" # Google Chrome YouTube Music app.
        #"slack.desktop"
        "bitwarden.desktop"
        "org.gnome.Console.desktop"
        "chrome-cifhbcnohmdccbgoicgdjpfamggdegmo-Profile_1.desktop" # Google Chrome Teams app.
      ];
    };

    # Keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      email = ["<Super>e"];
      www = ["<Super>w"];
      screensaver = ["<Super>L"];
      custom-keybindings = [
      ];
    };
    # Windows
    "org/gnome/desktop/wm/keybindings" = {
      # Activate the window menu
      activate-window-menu = [];
      # Move window
      begin-move = [];
      # Resize window
      begin-resize = ["<Super>r"];
      # Close window
      close = ["<Super>q"];
      # Switch windows of an app directly
      cycle-group = [];
      cycle-group-backward = [];
      # Switch system controls directly
      cycle-panels = [];
      cycle-panels-backward = [];
      # Switch windows directly
      cycle-windows = [];
      cycle-windows-backward = [];
      # Maximize window
      maximize = ["<Super>Up"];
      # Minimize window
      minimize = ["<Super>c"];
      # Move window to workspace 1
      move-to-workspace-1 = ["<Shift><Super>exclam"];
      # Move window to workspace 2
      move-to-workspace-2 = ["<Shift><Super>at"];
      # Move window to workspace 3
      move-to-workspace-3 = ["<Shift><Super>numbersign"];
      # Move window to workspace 4
      move-to-workspace-4 = ["<Shift><Super>dollar"];
      # Switch to workspace 1
      switch-to-workspace-1 = ["<Super>1"];
      # Switch to workspace 2
      switch-to-workspace-2 = ["<Super>2"];
      # Switch to workspace 3
      switch-to-workspace-3 = ["<Super>3"];
      # Switch to workspace 4
      switch-to-workspace-4 = ["<Super>4"];
      # Switch to workspace on the left
      switch-to-workspace-left = ["Page_Up"];
      # Switch to workspace on the right
      switch-to-workspace-right = ["Page_Down"];
      # Switch windows
      switch-windows = ["<Super>Tab"];
      switch-windows-backward = ["<Shift><Super>Tab"];
      # Toggle fullscreen mode
      toggle-fullscreen = [];
      # Toggle maximization state
      toggle-maximized = ["<Super>f"];
      # Restore window
      unmaximize = ["<Super>Down"];
    };
    "org/gnome/shell/keybindings" = {
      # Focus the active notification
      focus-active-notification = [];
      # Open the application menu
      open-application-menu = [];
      # Switch to application 1
      switch-to-application-1 = [];
      # Switch to application 2
      switch-to-application-2 = [];
      # Switch to application 3
      switch-to-application-3 = [];
      # Switch to application 4
      switch-to-application-4 = [];
      # Switch to application 5
      switch-to-application-5 = [];
      # Switch to application 6
      switch-to-application-6 = [];
      # Switch to application 7
      switch-to-application-7 = [];
      # Switch to application 8
      switch-to-application-8 = [];
      # Switch to application 9
      switch-to-application-9 = [];
      # Show all applications
      toggle-application-view = [];
      # Show the notification list
      toggle-message-tray = ["<Super>n"];
      # Show the overview
      toggle-overview = [];
    };
  };
}
