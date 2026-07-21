{
  config,
  lib,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.Turbonaepskrel = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = (lib.attrValues config.flake.nixosModules) ++ [
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      inputs.impermanence.nixosModules.impermanence

      ./_machine.nix

      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs; };
          backupFileExtension = ".hm-backup";
          users.dev.imports = (lib.attrValues config.flake.homeModules) ++ [
            inputs.nix-colors.homeManagerModules.default
            ./_home.nix
          ];
        };
      }
    ];
  };
}
