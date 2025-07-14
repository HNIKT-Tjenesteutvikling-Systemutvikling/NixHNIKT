let
  more =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        acpi # battery info
        arandr # screen layout manager
        btop # alternative to htop & ytop
        cacert # ca certificates
        dconf2nix # dconf (gnome) files to nix converter
        drawio # diagram design
        gh-copilot # github copilot cli
        glow # terminal markdown viewer
        headsetcontrol # logitech headset control
        hyperfine # command-line benchmarking tool
        killall # kill processes by name
        kooha # Screen to gif recorder
        lazygit # terminal git ui
        libsecret # secret management
        logitech-udev-rules # logitech udev rules
        nettools # network tools
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
