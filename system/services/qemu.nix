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
      pool_dir=/var/lib/libvirt/images

      # Unredirected connectivity check: lets libvirt/polkit errors and
      # prompts reach the terminal instead of hanging silently.
      echo "Connecting to $LIBVIRT_DEFAULT_URI ..."
      virsh uri >/dev/null

      if ! virsh list --all --name | grep -qxF "$vm"; then
        iso="''${1:-}"
        if [ ! -f "$iso" ]; then
          echo "VM does not exist yet. Pass the Windows 11 installer ISO:" >&2
          echo "  win11 ~/Downloads/Win11_x64.iso" >&2
          echo "Download it from https://www.microsoft.com/software-download/windows11" >&2
          exit 1
        fi
        shift

        vcpus=$(( $(nproc) / 2 ))
        [ "$vcpus" -lt 4 ] && vcpus=4

        if ! virsh pool-info default >/dev/null 2>&1; then
          echo "Defining default storage pool at $pool_dir ..."
          virsh pool-define-as default dir --target "$pool_dir" >/dev/null
          virsh pool-build default >/dev/null 2>&1 || true
          virsh pool-start default >/dev/null
          virsh pool-autostart default >/dev/null
        fi

        # qemu runs as its own user and cannot read files under \$HOME
        # (mode 700), so import the installer ISO into the pool.
        if ! virsh vol-info --pool default win11-installer.iso >/dev/null 2>&1; then
          echo "Importing installer ISO into the libvirt pool (may take a minute) ..."
          virsh vol-create-as default win11-installer.iso "$(stat -c %s "$iso")" --format raw >/dev/null
          virsh vol-upload --pool default win11-installer.iso "$iso"
        fi
        iso="$pool_dir/win11-installer.iso"

        virsh net-start default >/dev/null 2>&1 || true
        virsh net-autostart default >/dev/null 2>&1 || true

        echo "Creating VM '$vm' ($vcpus vCPUs, 16 GiB RAM, 120 GiB disk) ..."
        echo
        echo "NOTE: when the installer asks where to install Windows, click"
        printf '%s\n' "'Load driver' and browse to viostor\w11\amd64 on the virtio-win CD."
        echo "After installation, run virtio-win-guest-tools.exe from the same"
        echo "CD to get dynamic/full-screen resolution and clipboard sharing."
        echo

        virt-install \
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
          --redirdev usb,type=spicevmc \
          --noautoconsole
      fi

      if [ "$(virsh domstate "$vm")" != "running" ]; then
        virsh start "$vm" >/dev/null
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
          # Domain/network/pool definitions and autostart flags
          "/etc/libvirt"
          "/var/lib/libvirt"
          "/var/cache/libvirt"
        ];
      };
    };
    services.spice-vdagentd.enable = true;
  };
}
