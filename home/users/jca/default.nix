{pkgs, ...}: {
  imports = [
    ../../programs/develop.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];

  programs.git = {
    enable = true;
    userEmail = "jan.olov.gustav.carlsson@hnikt.no";
    userName = "jca002";
  };
}
