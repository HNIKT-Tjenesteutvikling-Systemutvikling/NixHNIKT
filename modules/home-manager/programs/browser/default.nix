{lib, ...}:
with lib;
with builtins; {
  imports = [
    ./brave.nix
    ./chromium.nix
    ./firefox.nix
  ];
  options.programs.browser = {
    application = mkOption {
      type = types.enum [
        "brave"
        "chromium"
        "firefox"
      ];
      default = "none";
      description = "Select browser";
    };
  };
}
