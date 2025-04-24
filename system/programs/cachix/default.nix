{ pkgs
, lib
, ...
}:
{
  imports = [
    ./hnikt.nix
    ./nix-community.nix
    ./iog.nix
  ];
  nix.settings.substituters = lib.mkAfter [ "https://cache.nixos.org/" ];

  environment.systemPackages = [ pkgs.cachix ];
}
