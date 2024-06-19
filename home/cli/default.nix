let
  scripts = {
    config,
    lib,
    pkgs,
    ...
  }: let
    gen-ssh-key = pkgs.callPackage ./gen-ssh-key.nix {inherit pkgs;};
    fvm-install = pkgs.callPackage ./fvm-install.nix {inherit pkgs;};
  in {
    home.packages =
      [
        gen-ssh-key # generate ssh key and add it to the system
        fvm-install # Script to download and install Flutter Version Manager in user home.
      ]
      ++ (pkgs.sxm.scripts or []);
  };
in [scripts]
