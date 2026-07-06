{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.service.virt-manager;

  ovmf = pkgs.OVMFFull.fd;

  win11 = pkgs.writeShellApplication {
    name = "win11";
    runtimeInputs = with pkgs; [
      coreutils
      gawk
      qemu_kvm
      swtpm
    ];
    text = ''
      usage() {
        echo "Usage: win11 [/path/to/win11.iso]"
        echo
        echo "  First run: pass the Windows 11 installer ISO to create the VM."
        echo "  Download it from https://www.microsoft.com/software-download/windows11"
        echo "  Later runs: no argument needed, boots the installed disk."
        echo "  win11 --reset deletes the VM state to start over."
        echo
        echo "  State: ~/.local/share/vm/win11 (disk, firmware vars, TPM)."
        exit 1
      }

      dir="''${XDG_DATA_HOME:-$HOME/.local/share}/vm/win11"
      disk="$dir/win11.qcow2"
      vars="$dir/OVMF_VARS.fd"
      iso=""

      case "''${1:-}" in
        -h|--help) usage ;;
        --reset)
          read -r -p "Delete $dir and start over? [y/N] " ans
          [ "$ans" = "y" ] && rm -rf "$dir" && echo "Removed. Re-run with the ISO to reinstall."
          exit 0
          ;;
        *) iso="''${1:-}" ;;
      esac

      mkdir -p "$dir/tpm"

      if [ ! -f "$disk" ]; then
        if [ -z "$iso" ]; then
          echo "No VM yet - the first run needs the Windows 11 installer ISO." >&2
          usage
        fi
        [ -f "$iso" ] || { echo "No such file: $iso" >&2; exit 1; }
        echo ">> Creating 128G disk and firmware vars ..."
        qemu-img create -f qcow2 "$disk" 128G
        install -m644 ${ovmf}/FV/OVMF_VARS.fd "$vars"
      fi

      mem=$(( $(awk '/MemTotal/ {print $2}' /proc/meminfo) / 2048 ))
      cpus=$(( $(nproc) / 2 ))

      # Windows 11 requires TPM 2.0; qemu talks to this emulator socket.
      # --terminate makes swtpm exit when qemu disconnects.
      swtpm socket --tpm2 --daemon --terminate \
        --tpmstate dir="$dir/tpm" \
        --ctrl type=unixio,path="$dir/tpm/swtpm.sock"

      extra=()
      if [ -n "$iso" ]; then
        # shellcheck disable=SC2054 # commas belong to the qemu arguments
        extra+=( -drive if=none,id=wincd,media=cdrom,file="$iso"
                 -device ide-cd,drive=wincd,bus=ahci.1,bootindex=0 )
        echo ">> Booting installer. The disk shows up as NVMe - no drivers needed."
        echo ">> After install, run virtio-win-gt-x64.msi from the attached CD for guest tools."
      fi

      exec qemu-system-x86_64 \
        -enable-kvm -machine q35,smm=on -cpu host -m "$mem" -smp "$cpus" \
        -global driver=cfi.pflash01,property=secure,value=on \
        -drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf}/FV/OVMF_CODE.fd \
        -drive if=pflash,format=raw,unit=1,file="$vars" \
        -chardev socket,id=chrtpm,path="$dir/tpm/swtpm.sock" \
        -tpmdev emulator,id=tpm0,chardev=chrtpm \
        -device tpm-tis,tpmdev=tpm0 \
        -drive if=none,id=os,format=qcow2,file="$disk",discard=unmap \
        -device nvme,drive=os,serial=win11os \
        -device ahci,id=ahci \
        -drive if=none,id=drivers,media=cdrom,file=${pkgs.virtio-win.src} \
        -device ide-cd,drive=drivers,bus=ahci.0 \
        -nic user,model=e1000e \
        -audiodev pipewire,id=snd0 \
        -device intel-hda -device hda-duplex,audiodev=snd0 \
        -device qemu-xhci -device usb-tablet \
        -device virtio-vga,xres=2560,yres=1440 \
        -display gtk,full-screen=on \
        "''${extra[@]}"
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
    systemd.services.libvirtd.serviceConfig.LoadCredentialEncrypted = "";
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
        # Disk, firmware vars and TPM state for the win11 script.
        users.dev.directories = lib.optional cfg.win11.enable ".local/share/vm";
      };
    };
    services.spice-vdagentd.enable = true;
  };
}
