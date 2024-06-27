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
        tmux.enable = false;
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
        tmux.enable = true;
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
        tmux.enable = false;
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
        tmux.enable = false;
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
      }
    ];
  };
  "dev@borgej" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./borgej

      {
        tmux.enable = false;
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
      }
    ];
  };
  "dev@nora" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./nora

      {
        tmux.enable = false;
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = false;
        vscode.enable = true;
      }
    ];
  };
  "dev@jhhhnikt" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./jhhhnikt

      {
        tmux.enable = true;
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
        tmux.enable = false;
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
        tmux.enable = false;
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
        tmux.enable = false;
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
        tmux.enable = false;
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
        tmux.enable = false;
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

      {
        tmux.enable = false;
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

      {
        tmux.enable = false;
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

      {
        tmux.enable = false;
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

      {
        tmux.enable = true;
        emacs.enable = false;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
      }
    ];
  };
}
