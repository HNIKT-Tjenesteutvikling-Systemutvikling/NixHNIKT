{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libnfc
    ccid
    #acsccid
    pcsclite
    pcsc-tools
  ];

  services.pcscd.enable = true;
}
