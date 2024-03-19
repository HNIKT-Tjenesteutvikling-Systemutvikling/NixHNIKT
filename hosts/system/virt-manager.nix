{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with builtins; let
  cfg = config.virt-manager;
in {
  options.virt-manager.enable = lib.mkEnableOption "virt-manager";

  config = lib.mkIf cfg.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [pkgs.OVMFFull.fd];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    # Packages for virtualisation
    environment.systemPackages = with pkgs; [
      spice
      spice-gtk
      spice-protocol
      virt-viewer
      virtio-win
      win-spice
    ];
    services.spice-vdagentd.enable = true;
  };
}
