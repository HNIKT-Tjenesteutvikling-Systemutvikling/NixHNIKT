{ config
, inputs
, lib
, ...
}: {
  imports = [
    ./hardware
    ./programs
    ./services
  ];
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
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    # Weekly garbage collection
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };

    # Enable optimisation
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };
  # Timezone and locale
  time.timeZone = "Europe/Oslo";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
  ];
  console.useXkbConfig = true;

  # Enable proprietary software
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
    permittedInsecurePackages = [
      "python-2.7.18.6"
    ];
  };
}
