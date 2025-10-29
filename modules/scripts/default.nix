let
  scripts = { pkgs, ... }:
    let
      gen-ssh-key = pkgs.callPackage ./gen-ssh-key.nix { inherit pkgs; };
      get-all-repos = pkgs.callPackage ./get-all-repos.nix { inherit pkgs; };
    in
    {
      home.packages =
        [
          gen-ssh-key # generate ssh key and add it to the system
          get-all-repos # script to get all repositories
        ]
        ++ (pkgs.sxm.scripts or [ ]);
    };
in
[ scripts ]
