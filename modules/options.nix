{ lib, ... }:
let
  moduleType = lib.mkOptionType {
    name = "module";
    description = "NixOS / home-manager module";
    check = x: lib.isAttrs x || lib.isFunction x || builtins.isPath x;
    merge = lib.mergeOneOption;
  };
in
{
  options.flake.homeModules = lib.mkOption {
    type = lib.types.lazyAttrsOf moduleType;
    default = { };
    description = "Home-manager modules exposed by the flake, aggregated per host.";
  };
}
