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
    # graphics = {
    #   enable = true;
    #   enable32Bit = true;
    # };
    opengl = {
      enable = true;
    };
    nvidia = lib.mkIf (desktop.graphics == "nvidia") {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
