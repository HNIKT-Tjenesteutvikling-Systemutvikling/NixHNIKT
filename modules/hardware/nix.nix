_: {
  flake.nixosModules.hardware-nix =
    {
      inputs,
      config,
      lib,
      ...
    }:
    {
      nix = {
        registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
        nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
        settings = {
          experimental-features = "nix-command flakes";
          auto-optimise-store = true;
        };
      };
    };
}
