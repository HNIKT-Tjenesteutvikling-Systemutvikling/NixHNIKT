{lib, ...}:
with lib;
with builtins; {
  imports = [
  ];
  options.desktop = {
    environment = mkOption {
      type = types.enum [
        "gnome"
        "bspwm"
        "none"
        "kde"
        "dwm"
      ];
      default = "none";
      description = "Desktop environment to use.";
    };
  };
}
