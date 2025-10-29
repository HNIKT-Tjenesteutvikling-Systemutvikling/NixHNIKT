{ config
, lib
, ...
}:
let
  cfg = config.program.ssh;
in

{
  options.program.ssh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable ssh configuration";
    };
    githubKeyFile = lib.mkOption {
      type = lib.types.str;
      default = "~/.ssh/id_rsa";
      description = "SSH key file to use";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        forwardAgent = false;
        addKeysToAgent = "yes";
        compression = true;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };

      matchBlocks = {
        "github.com" = {
          hostname = "ssh.github.com";
          port = 443;
          user = "git";
          identitiesOnly = true;
          identityFile = cfg.githubKeyFile;
        };

        "10.0.0.*" = {
          forwardAgent = true;
        };
      };
    };
  };
}
