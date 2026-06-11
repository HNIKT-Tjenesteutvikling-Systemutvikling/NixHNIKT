{
  config,
  lib,
  ...
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

      settings = {
        "*" = {
          ForwardAgent = false;
          AddKeysToAgent = "yes";
          Compression = true;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";
        };

        "github.com" = {
          HostName = "ssh.github.com";
          Port = 443;
          User = "git";
          IdentitiesOnly = true;
          IdentityFile = cfg.githubKeyFile;
          ControlMaster = "auto";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "10m";
        };

        "10.0.0.*" = {
          ForwardAgent = true;
        };
      };
    };
  };
}
