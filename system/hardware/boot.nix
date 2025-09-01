{ modulesPath
, ...
}:
let
  cleanup = ''
    mkdir -p /btrfs_tmp
    echo "[cleanup] Created /btrfs_tmp"
    mount -o subvolid=5 /dev/mapper/crypted_root /btrfs_tmp
    mkdir -p /btrfs_tmp/persist/snapshots/root

    if [[ -e /btrfs_tmp/root ]]; then
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%d_%H:%M:%S")
        echo "[cleanup] Found /btrfs_tmp/root, moving to /btrfs_tmp/persist/snapshots/root/$timestamp"
        mv /btrfs_tmp/root "/btrfs_tmp/persist/snapshots/root/$timestamp"
    else
        echo "[cleanup] /btrfs_tmp/root does not exist, skipping move"
    fi

    delete_subvolume_recursively() {
        local subvol="$1"
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$subvol" | cut -f 9- -d ' '); do
            echo "[cleanup] Recursively deleting subvolume /btrfs_tmp/$i"
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        echo "[cleanup] Deleting subvolume $subvol"
        btrfs subvolume delete "$subvol"
    }

    find /btrfs_tmp/persist/snapshots/root -maxdepth 1 -mtime +30 -type d | while read snapshot; do
        echo "[cleanup] Deleting old snapshot $snapshot"
        delete_subvolume_recursively "$snapshot"
    done

    echo "[cleanup] Creating new subvolume /btrfs_tmp/root"
    btrfs subvolume create /btrfs_tmp/root

    echo "[cleanup] Unmounted /btrfs_tmp"
    umount /btrfs_tmp
  '';
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    consoleLogLevel = 3;
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
      verbose = false;
      systemd = {
        enable = true;
        services.wipe_root = {
          wantedBy = [ "initrd.target" ];
          after = [ "systemd-cryptsetup@crypted_root.service" ];
          before = [ "sysroot.mount" ];
          unitConfig.DefaultDependencies = "no";
          serviceConfig.Type = "oneshot";
          script = cleanup;
        };
      };
    };
    kernelParams = [
      # "quiet"
      # "splash"
      # "boot.shell_on_fail"
      # "udev.log_priority=3"
      # "rd.systemd.show_status=auto"
    ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      systemd-boot.enable = true;
    };
    # plymouth = {
    #   enable = true;
    # };
    kernelModules = [
      "kvm-intel"
      "virtio"
      "bluetooth"
      "btusb"
    ];
    extraModulePackages = [ ];
  };
}
