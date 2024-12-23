{pkgs, ...}: {
  home.packages = with pkgs; [
    figma-linux
  ];

  programs.git = {
    enable = true;
    userEmail = "sigurdjbratt@hotmail.no";
    userName = "sigubrat";
  };

  # Fix git not working in vscode terminal
  # Copies the ssh config instead of symlinking it
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
  };

  dconf.settings = {
    # Keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      email = ["<Super>e"];
      www = ["<Super>w"];
      screensaver = ["<Super>L"];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "thunderbird.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Calendar.desktop"
        "spotify.desktop"
        "vmware-view.desktop"
        "Slack.desktop"
        "gimp.desktop"
        "Discord.desktop"
        "dbeaver.desktop"
        "selfservice.desktop"
        "chromium-browser.desktop"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<super>return";
      command = "alacritty";
      name = "open-terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<shift><super>r";
      command = "alacritty -e ranger";
      name = "Ranger";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<shift><super>b";
      command = "alacritty -e btm";
      name = "Btop";
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
