_: {
  flake.nixosModules.hardware-network =
    { lib, ... }:
    {
      networking = {
        networkmanager.enable = true;
        firewall.enable = false;
        useDHCP = lib.mkDefault true;
      };
    };
}
