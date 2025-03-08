{ modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [
      "kvm-intel"
      "virtio"
      "bluetooth"
      "btusb"
    ];
    extraModulePackages = [ ];
  };
}
