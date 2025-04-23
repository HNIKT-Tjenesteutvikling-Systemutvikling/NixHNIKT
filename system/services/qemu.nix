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
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    environment.systemPackages = with pkgs; [
      spice
      spice-vdagent
      spice-autorandr
      spice-gtk
      spice-protocol
      virt-viewer
      virtio-win
      win-spice
      win-virtio
    ];
    services.spice-vdagentd.enable = true;
  };
}
