{lib, ...}:
with lib;
with builtins; {
  imports = [
    ./gnome.nix
    ./kde.nix
  ];

  options.desktop = {
    environment = mkOption {
      type = types.enum [
        "gnome"
        "none"
        "kde"
      ];
      default = "none";
      description = "The desktop environment to use";
    };
  };
}
