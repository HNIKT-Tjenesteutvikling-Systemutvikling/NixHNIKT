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

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.root.initialHashedPassword = "$7$CU..../....jz9t1QKqQ.jT18.JftZ7E1$yLl5PDBaJCHdzx5YdI5IVAhmy7T6vUB063yjt/vpQn2";
  };
}
