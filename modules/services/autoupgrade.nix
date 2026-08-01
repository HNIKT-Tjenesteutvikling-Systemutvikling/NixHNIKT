_: {
  flake.nixosModules.services-autoupgrade =
    {
      config,
      inputs,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.service.autoUpgrade;

      remoteHead = pkgs.writeShellScript "check-config-update" ''
        set -eu
        remote=$(${lib.getExe pkgs.gitMinimal} ls-remote \
          https://github.com/${cfg.repository}.git refs/heads/${cfg.branch} \
          | ${pkgs.coreutils}/bin/cut -f1)
        deployed=$(/run/current-system/sw/bin/nixos-version --configuration-revision 2>/dev/null || true)
        [ "$remote" != "$deployed" ]
      '';

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
          description = "Rebuild from the remote flake whenever it moves, discarding local state.";
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
          default = "Mon,Thu *-*-* 10:00:00";
          description = ''
            When to check for a new revision, in {manpage}`systemd.time(7)` format.
            The rebuild is skipped unless {option}`branch` moved since the last deploy.
          '';
        };
      };

      config = lib.mkIf cfg.enable {
        system = {
          configurationRevision = inputs.self.rev or "dirty";
          autoUpgrade = {
            enable = true;
            flake = "github:${cfg.repository}/${cfg.branch}";
            inherit (cfg) dates;
            upgrade = false;
            persistent = true;
            randomizedDelaySec = "45min";
          };
        };

        systemd.services.nixos-upgrade = {
          serviceConfig.ExecCondition = "${remoteHead}";
          preStart = lib.mkIf (cfg.localClone != null) "${syncLocalClone}";
        };
      };
    };
}
