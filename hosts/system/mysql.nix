{pkgs, ...}: {
  services.mysql = {
    enable = true;
    package = pkgs.mysql80;
  };
  networking.firewall.allowedTCPPorts = [3306];
}
