{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware
    ./programs
    ./services
  ];
  # NixOS Network Configuration
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };
  system.autoUpgrade = {
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
  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
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
      dates = ["weekly"];
    };
  };
  # Timezone and locale
  time.timeZone = "Europe/Oslo";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
  ];
  users.users = {
    dev = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDEPjadku0NlF1Zkkn5lEQoUtQf7Ze4MiumMJu24y6LVFHwuygjIfZvNZYgcylMR5JzzDiCpz06cuO8pm0nGntquXADwZ6VyMdYqvepUVAMxesmSIr3p0tYhAtaPg0AvQ6CalSHe3tsL9KJPqqRAnqDB3PXSOI7hY3i5mR3EnwC7HzdEc9LlkR7NH3X2nLiY0b6Olhvgr9LhlENJ0dZxMMk36iLPDmL+dmnVITDkLFMkxS4TBNo5aA5AtNod9uMc+r96Y1Y8+6siHe4qNKdibrfp6xKaDnXIWstxaM076WTMINqzdK6/eXNnaTaIYnEkEU91jvS6tcvFwrEyhfWd+8wkJZ7JdCg4Y3dTwl2/3Ok3/jZvi79wrNpHWzlmAdj0EpGV9kLdgAD5nuEvI+zs8uJXC1CWiKj8cPo5wR5HK0pYFqXCvSGyhZRwSYwK4VgRSjJFz8SqX/5FlHLSK7Dbf3ULTmcPERMP84Q1B5h32Cwxn3G9iriPVRZ8yk24IJdQ62LBoAHjJHNjquFlpUXeXLr6mA1wXE32sCFOHV7PpsK9OOdpghQkDUZ2AgHLiL/czrozSy+y4eodBWQI0Abn9QptIYQfH9zppT4L2PZsdjCF7dclbKyKv9IJ2uWnMoZJoG0dO6hGt+xLGsfftCZH7eu3/NmX3WI1uGOuSacQv/YFQ== gako358@outlook.com"
      ];
      extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "video" "audio" ];
    };
  };
  console.useXkbConfig = true;
  programs.dconf.enable = true;

  # Enable hardware support
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth.enable = true;
    enableAllFirmware = true;
  };
  # Enable proprietary software
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
  ];
  system.stateVersion = "24.11";
}
