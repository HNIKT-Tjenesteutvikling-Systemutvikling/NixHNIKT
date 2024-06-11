{
  nixpkgs,
  inputs,
}: {
  grindstein = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./grindstein

      {
        virt-manager.enable = true;
      }
    ];
  };
  intervbs = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./intervbs
    ];
  };
  ievensen = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./ievensen
    ];
  };
  jca = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./jca
    ];
  };
  jergen = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./jergen
    ];
  };
  jonas = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./jonas
    ];
  };
  jonvidars = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./jonvidars
    ];
  };
  neethan = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./neethan
    ];
  };
  sigubrat = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./sigubrat
    ];
  };
  Solheim = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./Solheim
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
  vebjorn = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ../configuration.nix
      ./vebjorn
    ];
  };
}
