{pkgs, ...}: {
  services.xserver = {
    enable = true;
    libinput.enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-contacts
      simple-scan
      epiphany # web browser
      geary # email reader
      evince # document viewer
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  # Systray Icons
  environment.systemPackages = with pkgs; [
    gnomeExtensions.vitals
    gnomeExtensions.tiling-assistant
    gnomeExtensions.user-themes
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnome.gnome-tweaks
    gnome.dconf-editor
    gnome.gnome-notes
    evince
  ];
  # ensure gnome-settings-daemon udev rules are enabled
  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];
  # ensure telepathy is enable
  services.telepathy.enable = true;
}
