{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.service.virt-manager;

  # pkgs.virtio-win ships the drivers unpacked; the Windows installer
  # needs them on a CD, so repack them into an ISO.
  virtioIso = pkgs.runCommand "virtio-win.iso" { nativeBuildInputs = [ pkgs.xorriso ]; } ''
    xorriso -as mkisofs -o $out -r -J -joliet-long -V virtio-win ${pkgs.virtio-win}
  '';

  win11 = pkgs.writeShellApplication {
    name = "win11";
    runtimeInputs = with pkgs; [
      libvirt
      virt-manager
      virt-viewer
    ];
    text = ''
      export LIBVIRT_DEFAULT_URI=qemu:///system
      vm=win11

      if ! virsh dominfo "$vm" &>/dev/null; then
        iso="''${1:-}"
        if [ ! -f "$iso" ]; then
          echo "VM does not exist yet. Pass the Windows 11 installer ISO:" >&2
          echo "  win11 ~/Downloads/Win11_x64.iso" >&2
          echo "Download it from https://www.microsoft.com/software-download/windows11" >&2
          exit 1
        fi

        vcpus=$(( $(nproc) / 2 ))
        [ "$vcpus" -lt 4 ] && vcpus=4

        virsh net-start default &>/dev/null || true
        virsh net-autostart default &>/dev/null || true

        echo "Creating VM '$vm' ($vcpus vCPUs, 16 GiB RAM, 120 GiB disk) ..."
        echo
        echo "NOTE: when the installer asks where to install Windows, click"
        printf '%s\n' "'Load driver' and browse to viostor\w11\amd64 on the virtio-win CD."
        echo "After installation, run virtio-win-guest-tools.exe from the same"
        echo "CD to get dynamic/full-screen resolution and clipboard sharing."
        echo

        exec virt-install \
          --name "$vm" \
          --memory 16384 \
          --vcpus "$vcpus" \
          --cpu host-passthrough \
          --os-variant win11 \
          --boot uefi,firmware.feature0.name=secure-boot,firmware.feature0.enabled=yes,firmware.feature1.name=enrolled-keys,firmware.feature1.enabled=yes \
          --tpm model=tpm-crb,backend.type=emulator,backend.version=2.0 \
          --disk size=120,bus=virtio,format=qcow2,discard=unmap \
          --disk ${virtioIso},device=cdrom \
          --cdrom "$iso" \
          --network network=default,model=virtio \
          --graphics spice \
          --video virtio \
          --channel spicevmc \
          --sound ich9 \
          --controller usb,model=qemu-xhci \
          --redirdev usb,type=spicevmc
      fi

      if [ "$(virsh domstate "$vm")" != "running" ]; then
        virsh start "$vm"
      fi
      exec virt-viewer --attach "$vm" "$@"
    '';
  };
in
{
  options.service.virt-manager = {
    enable = lib.mkEnableOption "virt-manager";
    win11.enable = lib.mkEnableOption "win11 VM launcher";
  };

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
      systemPackages =
        with pkgs;
        [
          spice
          spice-vdagent
          spice-autorandr
          spice-gtk
          spice-protocol
          virt-viewer
          virtio-win
          win-spice
        ]
        ++ lib.optional cfg.win11.enable win11;
      persistence."/persist" = {
        directories = [
          "/var/lib/libvirt"
          "/var/cache/libvirt"
        ];
      };
    };
    services.spice-vdagentd.enable = true;
  };
}
