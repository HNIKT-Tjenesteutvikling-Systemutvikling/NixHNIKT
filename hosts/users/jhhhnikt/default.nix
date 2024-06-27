{
  inputs,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    inputs.neovim-flake.defaultPackage.${pkgs.system}
  ];
  desktop.environment = "gnome";
  networking.hostName = "jhhhnikt";
  networking.extraHosts = ''
    # Local ipv4 dev.
    127.0.0.1 app.localhost
    127.0.0.1 keycloak.localhost
    # Local ipv6 dev.
    ::1 app.localhost
    ::1 keycloak.localhost
  '';
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # https://nixos.org/manual/nixos/stable/#sec-x11--graphics-cards-intel
    displayManager = {
      # Optional command xrandr, e.g. ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x360 --rotate normal --output DP-9 --mode 2560x1440 --pos 1920x0 --rotate normal --output DP-14 --mode 2560x1440 --pos 4480x0 --rotate normal
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      '';
    };
  };
}
