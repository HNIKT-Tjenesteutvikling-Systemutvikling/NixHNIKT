{ config
, lib
, ...
}:
let
  inherit (config.environment) desktop;
in
{
  boot.initrd.kernelModules = lib.mkIf (desktop.graphics == "nvidia") [ "nvidia" ];
  hardware = {
    graphics = {
      enable = true;
      # enable32Bit = true;
    };
    nvidia = lib.mkIf (desktop.graphics == "nvidia") {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        offload.enable = false; # disable on-demand
        sync.enable = true;     # NVIDIA drives the session

        # Set these to YOUR bus IDs (see commands below)
        intelBusId  = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
