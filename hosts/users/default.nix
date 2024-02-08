{
  nixpkgs,
  inputs,
}: {
  grindstein = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./grindstein
    ];
  };
  intervbs = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./intervbs
    ];
  };
  sigubrat = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./sigubrat
    ];
  };
  testUser = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./testUser
    ];
  };
  Turbonaepskrel = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./Turbonaepskrel
    ];
  };
}
