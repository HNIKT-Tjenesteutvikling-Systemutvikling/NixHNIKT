_: {
  flake.nixosModules.services-openssh = {
    services = {
      openssh = {
        enable = true;
        # Forbid root login through SSH.
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
        };
      };
    };
  };
}
