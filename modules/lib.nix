{ inputs, ... }:
{
  flake.lib = inputs.nixpkgs.lib // inputs.home-manager.lib;
}
