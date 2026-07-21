_: {
  flake.homeModules.scripts =
    { pkgs, ... }:
    let
      gen-ssh-key = pkgs.callPackage ./_gen-ssh-key.nix { inherit pkgs; };
      get-all-repos = pkgs.callPackage ./_get-all-repos.nix { inherit pkgs; };
      qr-code-gen = pkgs.callPackage ./_qr-code-gen.nix { inherit pkgs; };
    in
    {
      home.packages = [
        gen-ssh-key # generate ssh key and add it to the system
        get-all-repos # script to get all repositories
        qr-code-gen # script to generate QR codes
      ]
      ++ (pkgs.sxm.scripts or [ ]);
    };
}
