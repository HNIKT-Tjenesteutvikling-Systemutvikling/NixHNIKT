{ config
, pkgs
, lib
, ...
}:
{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./disko.nix
    ./graphics.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./system.nix
  ];
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableAllFirmware = true;
  };
  nixpkgs = {
    # Enable proprietary software
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
      # permittedInsecurePackages = [
      #   "python-2.7.18.6"
      # ];
    };
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  powerManagement.powertop.enable = true;

  services = {
    hardware.bolt.enable = false; # Thunderbolt, a userspace daemon to enable security levels for Thunderbolt 3 on GNU/Linux.
    thermald.enable = false;
    power-profiles-daemon.enable = lib.mkIf
      (
        config.environment.desktop.windowManager == "gnome"
      )
      false; # Disable GNOMEs power management
    system76-scheduler.settings.cfsProfiles.enable = false; # Better scheduling for CPU cycles - thanks System76!!!
    tlp = {
      enable = true; # Enable TLP (better than gnomes internal power manager)
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 1;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 1;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 81;
      };
    };
  };

  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.root.initialHashedPassword = "$7$CU..../....jz9t1QKqQ.jT18.JftZ7E1$yLl5PDBaJCHdzx5YdI5IVAhmy7T6vUB063yjt/vpQn2";
  };
}
