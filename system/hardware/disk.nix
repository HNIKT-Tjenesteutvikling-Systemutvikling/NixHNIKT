{
  fileSystems = {
    "/" = {
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=root" "noatime" "compress=zstd" "ssd" ];
    };

    "/home" = {
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=home" "noatime" "compress=zstd" "ssd" ];
    };

    "/nix" = {
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=nix" "noatime" "compress=zstd" "ssd" ];
    };

    "/var" = {
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=var" "noatime" "compress=zstd" "ssd" ];
    };

    "/tmp" = {
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=tmp" "noatime" "compress=zstd" "ssd" ];
    };

    "/boot/efi" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };
  };

  swapDevices = [
    { device = "/dev/mapper/cryptswap"; }
  ];
}
