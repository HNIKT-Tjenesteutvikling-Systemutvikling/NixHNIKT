_: {
  flake.nixosModules.services-autoupgrade =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.service.autoUpgrade;

      syncLocalClone = pkgs.writeShellScript "sync-config-clone" ''
        set -eu
        if [ ! -d ${cfg.localClone}/.git ]; then
          exit 0
        fi
        git() {
          ${pkgs.util-linux}/bin/runuser -u dev -- \
            ${pkgs.coreutils}/bin/env HOME=/home/dev \
            ${lib.getExe pkgs.gitMinimal} -C ${cfg.localClone} "$@"
        }
        git fetch https://github.com/${cfg.repository}.git ${cfg.branch}
        git update-ref refs/remotes/origin/${cfg.branch} FETCH_HEAD
        git checkout -f -B ${cfg.branch} FETCH_HEAD
      '';
    in
    {
      options.service.autoUpgrade = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Rebuild the system weekly from the remote flake, discarding local state.";
        };

        repository = lib.mkOption {
          type = lib.types.str;
          default = "HNIKT-Tjenesteutvikling-Systemutvikling/NixHNIKT";
          description = "GitHub owner/repo holding the configuration.";
        };

        branch = lib.mkOption {
          type = lib.types.str;
          default = "master";
          description = "Branch to deploy from.";
        };

        localClone = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = "/home/dev/Sources/nixhnikt";
          description = ''
            Checkout to force onto the deployed revision before rebuilding, so that a
            later manual rebuild does not roll the machine back. Local changes on
            {option}`branch` are discarded. Set to `null` to leave the checkout alone.
          '';
        };

        dates = lib.mkOption {
          type = lib.types.str;
          default = "Mon *-*-* 10:00:00";
          description = "When the upgrade runs, in {manpage}`systemd.time(7)` format.";
        };
      };

      config = lib.mkIf cfg.enable {
        system.autoUpgrade = {
          enable = true;
          flake = "github:${cfg.repository}/${cfg.branch}";
          inherit (cfg) dates;
          upgrade = false;
          persistent = true;
          randomizedDelaySec = "45min";
        };

        systemd.services.nixos-upgrade.preStart = lib.mkIf (cfg.localClone != null) "${syncLocalClone}";
      };
    };
}
