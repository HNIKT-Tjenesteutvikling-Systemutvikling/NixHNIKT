{ config
, lib
, ...
}: {
  imports = [
    ./boot.nix
    ./disk.nix
    ./graphics.nix
    ./network.nix
  ];
  hardware = {
    bluetooth.enable = true;
    enableAllFirmware = true;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
