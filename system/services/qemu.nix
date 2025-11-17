{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.service.virt-manager;
in
{
  options.service.virt-manager.enable = lib.mkEnableOption "virt-manager";

  config = lib.mkIf cfg.enable {
    programs = {
      virt-manager.enable = true;
    };
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
    };
    environment = {
      systemPackages = with pkgs; [
        spice
        spice-vdagent
        spice-autorandr
        spice-gtk
        spice-protocol
        virt-viewer
        virtio-win
        win-spice
        virtio-win
      ];
      persistence."/persist" = {
        directories = [
          "/var/lib/libvirt/images"
        ];
      };
    };
    services.spice-vdagentd.enable = true;
  };
}
