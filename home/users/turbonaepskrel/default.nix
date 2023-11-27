{pkgs, ...}: {
  imports = [
    ../../programs/develop.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];

  programs.git = {
    enable = true;
    userEmail = "magnus.thoralf.kristiansen@hnikt.no";
    userName = "turbonaepskrel";
  };
}
