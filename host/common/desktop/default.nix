{lib, ...}:
with lib;
with builtins; {
  imports = [
    ./gnome.nix
    ./xserver.nix
  ];
  options.desktop = {
    environment = mkOption {
      type = types.enum [
        "gnome"
        "bspwm"
        "none"
        "dwm"
        "kde"
        "wsl"
      ];
      default = "none";
      description = "Desktop environment to use.";
    };
  };
}
