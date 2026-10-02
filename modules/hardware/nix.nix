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
        settings = {
          nix-path = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          auto-optimise-store = true;
        };
      };
    };
}
