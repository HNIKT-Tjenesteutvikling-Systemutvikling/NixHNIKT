{
  home-manager,
  legacyPackages,
  inputs,
}: {
  "dev@grindstein" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./grindstein

      {
        emacs.enable = true;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
      }
    ];
  };
  "dev@ievensen" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./ievensen

      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = false;
        vscode.enable = true;
      }
    ];
  };
  "dev@intervbs" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./intervbs

      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
      }
    ];
  };
  "dev@jca" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./jca

      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
      }
    ];
  };
  "dev@jergen" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./jergen

      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = false;
        vscode.enable = true;
      }
    ];
  };
  "dev@jonas" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./jonas

      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = false;
        vscode.enable = true;
      }
    ];
  };
  "dev@jonvidars" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./jonvidars

      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = false;
        vscode.enable = true;
      }
    ];
  };
  "dev@neethan" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./neethan

      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = false;
        vscode.enable = true;
      }
    ];
  };
  "dev@sigubrat" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./sigubrat

      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
      }
    ];
  };
  "dev@Solheim" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./Solheim

      # Optional modules
      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
      }
    ];
  };
  "dev@testUser" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./testUser

      # Optional modules
      {
        emacs.enable = false;
        citrix.enable = false;
        intellij.enable = false;
        vscode.enable = false;
      }
    ];
  };
  "dev@Turbonaepskrel" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./Turbonaepskrel

      # Optional modules
      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
      }
    ];
  };
  "dev@vebjorn" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./vebjorn

      # Optional modules
      {
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
      }
    ];
  };
}
