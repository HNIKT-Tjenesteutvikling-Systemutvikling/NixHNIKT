{
  fileSystems = {
    "/" = {
      device = "/dev/nvme0n1p3";
      fsType = "btrfs";
      options = [ "subvol=root" "noatime" "compress=zstd" "ssd" ];
    };

    "/home" = {
      device = "/dev/nvme0n1p3";
      fsType = "btrfs";
      options = [ "subvol=home" "noatime" "compress=zstd" "ssd" ];
    };

    "/nix" = {
      device = "/dev/nvme0n1p3";
      fsType = "btrfs";
      options = [ "subvol=nix" "noatime" "compress=zstd" "ssd" ];
    };

    "/var" = {
      device = "/dev/nvme0n1p3";
      fsType = "btrfs";
      options = [ "subvol=var" "noatime" "compress=zstd" "ssd" ];
    };

    "/tmp" = {
      device = "/dev/nvme0n1p3";
      fsType = "btrfs";
      options = [ "subvol=tmp" "noatime" "compress=zstd" "ssd" ];
    };

    "/boot/efi" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };
  };

  swapDevices = [
    { device = "/dev/nvme0n1p2"; }
  ];
}
