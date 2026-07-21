_: {
  flake.nixosModules.programs-cachix-base =
    {
      pkgs,
      lib,
      ...
    }:
    {
      nix.settings.substituters = lib.mkAfter [ "https://cache.nixos.org/" ];

      environment.systemPackages = [ pkgs.cachix ];
    };
}
