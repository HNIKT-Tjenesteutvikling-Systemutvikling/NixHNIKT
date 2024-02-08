{
  nixpkgs,
  inputs,
}: {
  testUser = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./testUser
    ];
  };
  sigubrat = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./sigubrat
    ];
  };
  intervbs = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./intervbs
    ];
  };
}

