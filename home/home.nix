{pkgs, ...}: let
  username = "dev";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    acpi                 # battery info
    arandr               # screen layout manager
    btop                 # alternative to htop & ytop
    cacert               # ca certificates
    dbeaver              # database manager
    dconf2nix            # dconf (gnome) files to nix converter
    docker-compose       # docker manager
    dive                 # explore docker layers
    drawio               # diagram design
    duf                  # disk usage/free utility
    exa                  # a better `ls`
    fd                   # "find" for files
    geany                # text editor
    gimp                 # gnu image manipulation program
    glow                 # terminal markdown viewer
    hyperfine            # command-line benchmarking tool
    killall              # kill processes by name
    keepass              # password manager
    lazygit              # terminal git ui
    libsecret            # secret management
    ncdu                 # disk space info (a better du)
    ncspot               # ncurses spotify client
    nitch                # minimal system information fetch
    nix-index            # locate packages containing certain nixpkgs
    nix-output-monitor   # nom: monitor nix commands
    nyancat              # the famous rainbow cat!
    ouch                 # painless compression and decompression for your terminal
    paprefs              # pulseaudio preferences
    prettyping           # a nicer ping
    rage                 # encryption tool for secrets management
    spotify              # music streaming
    ripgrep              # fast grep
    tldr                 # summary of a man page
    tree                 # display files in a tree view
    unzip                # unzip files
    virt-manager         # virtual machine manager
    wgetpaste            # paste to pastebin
    xarchiver            # archive manager
    xclip                # command-line interface to X selections
    xdotool              # command-line X11 automation tool
    zip                  # zip files
  ];

in {
  programs.home-manager.enable = true;
  imports = builtins.concatMap import [
    ./cli
    ./programs
    ./services
    ./themes
  ];

  xdg = {
    inherit configHome;
    enable = true;
  };

  # Default services
  services.pasystray.enable = true;   # pulseaudio system tray

  home = {
    inherit username homeDirectory;
    stateVersion = "23.11";

    packages = defaultPkgs;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";
}