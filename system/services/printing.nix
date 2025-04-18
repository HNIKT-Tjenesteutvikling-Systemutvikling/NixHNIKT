{ config, lib, ... }:
with lib;
let
  cfg = config.printing;
in
{
  options.printing = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable printing service";
    };
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
    services.printing = {
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
      browsedConf = ''
        BrowseDNSSDSubTypes _cups,_print
        BrowseLocalProtocols all
        BrowseRemoteProtocols all
        CreateIPPPrinterQueues All

        BrowseProtocols all
      '';
    };
  };
}
