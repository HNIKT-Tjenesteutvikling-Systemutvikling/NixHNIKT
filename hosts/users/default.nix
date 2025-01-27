{ nixpkgs
, inputs
,
}: {
  grindstein = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./grindstein

      {
        virt-manager.enable = true;
        mysql.enable = true;
      }
    ];
  };
  intervbs = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./intervbs
      {
        virt-manager.enable = false;
        mysql.enable = true;
      }
    ];
  };
  ievensen = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./ievensen
      {
        virt-manager.enable = false;
        mysql.enable = false;
      }
    ];
  };
  jca = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./jca
      {
        virt-manager.enable = false;
        mysql.enable = true;
      }
    ];
  };
  jergen = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./jergen
      {
        virt-manager.enable = false;
        mysql.enable = false;
      }
    ];
  };
  jonas = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./jonas
      {
        virt-manager.enable = false;
        mysql.enable = false;
      }
    ];
  };
  jonvidars = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./jonvidars
      {
        virt-manager.enable = false;
        mysql.enable = false;
      }
    ];
  };
  neethan = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./neethan
      {
        virt-manager.enable = false;
        mysql.enable = false;
      }
    ];
  };
  sigubrat = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./sigubrat
      {
        virt-manager.enable = false;
        mysql.enable = true;
      }
    ];
  };
  Solheim = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./Solheim
      {
        virt-manager.enable = false;
        mysql.enable = true;
      }
    ];
  };
  testUser = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./testUser
      {
        virt-manager.enable = false;
        mysql.enable = true;
      }
    ];
  };
  Turbonaepskrel = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./Turbonaepskrel
      {
        virt-manager.enable = false;
        mysql.enable = true;
      }
    ];
  };
  vebjorn = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ./vebjorn
      {
        virt-manager.enable = false;
        mysql.enable = false;
      }
    ];
  };
}
