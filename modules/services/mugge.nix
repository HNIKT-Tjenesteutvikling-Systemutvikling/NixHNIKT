{
  pkgs,
  inputs,
  ...
}:
let
  muggePkgs = inputs.mugge.packages.${pkgs.stdenv.hostPlatform.system};
in
{

  imports = [ inputs.mugge.homeManagerModules.default ];

  services.mugge-chat.enable = true;
  home.packages = [
    muggePkgs.mugge-azure
  ];
}
