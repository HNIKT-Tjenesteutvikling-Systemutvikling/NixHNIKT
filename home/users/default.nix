{
  home-manager,
  legacyPackages,
  inputs,
}: {
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
  "dev@sigubrat" = home-manager.lib.homeManagerConfiguration {
    pkgs = legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ../home.nix
      ./sigubrat

      # Optional modules
      {
        emacs.enable = false;
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
}
