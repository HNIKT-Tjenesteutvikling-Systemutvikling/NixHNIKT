{ lib, ... }:
{
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    useDHCP = lib.mkDefault true;
  };
}
