let
  more = { pkgs, ... }: {
    home.packages = with pkgs; [
      acpi # battery info
      any-nix-shell # fish support for nix shell
      arandr # screen layout manager
      btop # alternative to htop & ytop
      cacert # ca certificates
      dconf2nix # dconf (gnome) files to nix converter
      dive # explore docker layers
      drawio # diagram design
      duf # disk usage/free utility
      eza # a better `ls`
      fd # "find" for files
      github-copilot-cli # github copilot cli
      glow # terminal markdown viewer
      headsetcontrol # logitech headset control
      hyperfine # command-line benchmarking tool
      jump # fast directory navigation
      killall # kill processes by name
      lazygit # terminal git ui
      libsecret # secret management
      logitech-udev-rules # logitech udev rules
      ncdu # disk space info (a better du)
      nettools # network tools
      nitch # minimal system information fetch
      nix-index # locate packages containing certain nixpkgs
      nix-output-monitor # nom: monitor nix commands
      ouch # painless compression and decompression for your terminal
      paprefs # pulseaudio preferences
      prettyping # a nicer ping
      rage # encryption tool for secrets management
      rclone # cloud storage
      ripgrep # fast grep
      tldr # summary of a man page
      tree # display files in a tree view
      unzip # unzip files
      wgetpaste # paste to pastebin
      xarchiver # archive manager
      xclip # command-line interface to X selections
      xdotool # command-line X11 automation tool
      xmind # mind mapping tool
      zip # zip files
    ];
  };
in
[
  ./browser/chromium.nix
  #./browser/edge.nix
  ./browser/firefox.nix
  ./browser/zen.nix
  ./anydesk.nix
  ./bat.nix
  ./broot.nix
  ./dbeaver.nix
  ./direnv.nix
  ./discord.nix
  ./dropbox.nix
  ./figma.nix
  ./filezilla.nix
  ./fish.nix
  ./fzf.nix
  ./gimp.nix
  ./git.nix
  ./intellij.nix
  ./jq.nix
  ./keepass.nix
  ./libreoffice.nix
  ./obsidian.nix
  ./remmina.nix
  ./rider.nix
  ./slack.nix
  ./spotify.nix
  ./starship.nix
  ./tmux.nix
  ./vscode.nix
  ./wmware-horizon.nix
  more
]
