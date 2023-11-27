{pkgs, ...}: {
  imports = [
    ../../programs/develop.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];

  programs.git = {
    enable = true;
    userEmail = "torkil.grindstein@hnikt.no";
    userName = "grindstein";
  };
}
