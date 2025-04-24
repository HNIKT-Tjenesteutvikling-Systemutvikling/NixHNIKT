{
  system = {
    autoUpgrade = {
      enable = true;
      flake = "github:HNIKT-Tjenesteutvikling-Systemutvikling/NixHNIKT";
      allowReboot = true;
      persistent = true;
      rebootWindow = {
        lower = "22:00";
        upper = "00:00";
      };
      dates = "weekly";
      flags = [
        "--update-input"
        "nixpkgs"
        "--commit-lock-file"
        "--no-write-lock-file"
      ];
      randomizedDelaySec = "1min";
    };
    stateVersion = "24.11";
  };
}
