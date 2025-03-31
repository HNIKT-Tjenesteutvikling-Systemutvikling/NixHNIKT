let
  more = { pkgs, ... }: {
    home.packages = with pkgs; [
      anydesk # remote desktop
      acpi # battery info
      arandr # screen layout manager
      asciiquarium # aquarium in your terminal
      btop # alternative to htop & ytop
      cacert # ca certificates
      cmatrix # matrix in your terminal
      dbeaver-bin # database manager
      dconf2nix # dconf (gnome) files to nix converter
      dive # explore docker layers
      drawio # diagram design
      duf # disk usage/free utility
      dropbox # cloud storage
      eza # a better `ls`
      figma-linux # design tool
      filezilla # ftp client
      fd # "find" for files
      geany # text editor
      gimp # gnu image manipulation program
      github-copilot-cli # github copilot cli
      glow # terminal markdown viewer
      headsetcontrol # logitech headset control
      hyperfine # command-line benchmarking tool
      killall # kill processes by name
      keepass # password manager
      lazygit # terminal git ui
      libsecret # secret management
      libreoffice # office suite
      logitech-udev-rules # logitech udev rules
      ncdu # disk space info (a better du)
      ncspot # ncurses spotify client
      nettools # network tools
      nitch # minimal system information fetch
      nix-index # locate packages containing certain nixpkgs
      nix-output-monitor # nom: monitor nix commands
      nyancat # the famous rainbow cat!
      obsidian # note taking app
      ouch # painless compression and decompression for your terminal
      paprefs # pulseaudio preferences
      prettyping # a nicer ping
      rage # encryption tool for secrets management
      slack # team communication
      spotify # music streaming
      rclone # cloud storage
      ripgrep # fast grep
      tldr # summary of a man page
      tree # display files in a tree view
      unzip # unzip files
      wgetpaste # paste to pastebin
      vmware-horizon-client # vmware horizon client
      xarchiver # archive manager
      xclip # command-line interface to X selections
      xdotool # command-line X11 automation tool
      xmind # mind mapping tool
      zip # zip files
    ];
    programs = {
      bat.enable = true;

      broot = {
        enable = true;
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      fzf = {
        enable = true;
        defaultCommand = "fd --type file --follow"; # FZF_DEFAULT_COMMAND
        defaultOptions = [ "--height 20%" ]; # FZF_DEFAULT_OPTS
        fileWidgetCommand = "fd --type file --follow"; # FZF_CTRL_T_COMMAND
      };

      gpg.enable = true;
      jq.enable = true;

      ssh.enable = true;
    };
  };
in
[
  ./browser/chromium.nix
  ./browser/discord.nix
  ./browser/edge.nix
  ./browser/firefox.nix
  ./browser/teams.nix
  ./git.nix
  ./intellij.nix
  ./tmux.nix
  ./rider.nix
  ./vscode.nix
  more
]
