{ config
, ...
}:
{
  config = {
    disko.devices.disk = {
      main = {
        type = "disk";
        device = config.system.disks.mainDevice;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
                mountOptions = [ "defaults" "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted_root";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-L" "NIXOS" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [ "noatime" "compress=zstd" "ssd" "space_cache=v2" ];
                    };
                    "/nix" = {
                      mountpoint = "/persist";
                      mountOptions = [ "noatime" "noacl" "compress=zstd" "ssd" "space_cache=v2" ];
                    };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "32G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
