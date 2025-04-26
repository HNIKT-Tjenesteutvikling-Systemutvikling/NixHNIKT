{ config
, pkgs
, lib
, ...
}: {
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./disk.nix
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
      permittedInsecurePackages = [
        "python-2.7.18.6"
      ];
    };
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  users = {
    defaultUserShell = pkgs.fish;
    # mutableUsers = false;
    users.root.initialHashedPassword = "$7$CU..../....xM/ghsj5uVLcgAidGzKgs1$JJX8YwDoTnFXMJNaWX/n5m9jPVKeTisZVYlefd5jlL0";
  };
}
