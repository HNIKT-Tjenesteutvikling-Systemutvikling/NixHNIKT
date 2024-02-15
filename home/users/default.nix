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
        emacs.enable = true;
        citrix.enable = true;
        intellij.enable = true;
        vscode.enable = true;
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
