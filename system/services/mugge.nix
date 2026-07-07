{
  pkgs,
  inputs,
  ...
}:
let
  muggePkgs = inputs.mugge.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  environment.systemPackages = [
    muggePkgs.mugge-azure
  ];

  programs.fish.shellAliases = {
    mugge = "mugge-azure";
  };
}
