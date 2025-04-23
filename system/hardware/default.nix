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
    ./network.nix
  ];
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableAllFirmware = true;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.root.initialHashedPassword = "$6$pbE4rcxk1KsvypJn$ZJlFtw85hgSWzdJnAuZr935zmm6Qc974ehL13/8WGPKnxX4epK5FiP2BBM/q89Gii9Xk0hxVvVKOkdkZuR2xE0";
  };
}
