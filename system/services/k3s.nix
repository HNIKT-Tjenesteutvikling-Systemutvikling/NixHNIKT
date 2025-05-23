{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.service.k3s-service;
in
{
  options.service.k3s-service = {
    enable = lib.mkEnableOption "Kubernetes k3s service";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.k3s ];

    networking.firewall = {
      allowedTCPPorts = [
        6443 # k3s default API server port
      ];
      allowedUDPPorts = [
        8472 # k3s, flannel: required if using multi-node for inter-node networking
      ];
    };

    boot.kernel.sysctl = {
      "net.ipv6.conf.all.disable_ipv6" = "1";
      "net.ipv6.conf.default.disable_ipv6" = "1";
    };

    services.k3s = {
      enable = true;
      role = "server";
      extraFlags = toString [
        "--write-kubeconfig-mode 644"
        "--node-name k3s-master-01"
      ];
    };
  };
}
