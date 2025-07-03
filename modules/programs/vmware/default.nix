{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.vmware-horizon;
in
{
  options.program.vmware-horizon = {
    enable = lib.mkEnableOption "VMware/Omnissa Horizon Client";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.omnissa-horizon-client or (pkgs.callPackage ./omnissa-horizon-client.nix { });
      defaultText = lib.literalExpression ''
        pkgs.omnissa-horizon-client or (pkgs.callPackage ./omnissa-horizon-client.nix { })
      '';
      description = ''
        The Horizon client package to use. Defaults to Omnissa Horizon Client.
        You can override this if you have a custom package or overlay.
      '';
    };

    legacyCompatibility = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to create legacy vmware-view symlinks for compatibility
        with scripts expecting the old binary names.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      [ cfg.package ]
      ++ lib.optionals cfg.legacyCompatibility [
        (pkgs.runCommand "vmware-horizon-compat" { } ''
          mkdir -p $out/bin
          ln -s ${cfg.package}/bin/horizon-client $out/bin/vmware-view
          ln -s ${cfg.package}/bin/omnissa-usbarbitrator $out/bin/vmware-usbarbitrator
        '')
      ];
  };
}
