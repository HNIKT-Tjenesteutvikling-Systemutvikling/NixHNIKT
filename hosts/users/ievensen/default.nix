{
  inputs,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    inputs.neovim-flake.defaultPackage.${pkgs.system}
  ];

  desktop.environment = "gnome";
  environment.systemPackages = [ pkgs.k3s ];
  networking.hostName = "ievensen";
  networking.firewall.allowedTCPPorts = [
    6443 # k3s default API server port
  ];
  networking.firewall.allowedUDPPorts = [
    8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];
  services = {
    k3s.enable = true;
    k3s.role = "server";
    k3s.extraFlags = toString [
      "--write-kubeconfig-mode 644"
      "--node-name k3s-idev-master-01"
    ];
    xserver = {
      videoDrivers = ["intel"]; # Optional use displayLink for USB-C docking station
      displayManager = {
        sessionCommands = ''
          ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        '';
      };
    };
  };
}
