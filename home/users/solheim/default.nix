{pkgs, ...}: {
  imports = [
    ../../programs/develop.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];

  programs.git = {
    enable = true;
    userEmail = "jan-magnus.solheim@hnikt.no";
    userName = "5olheim";
  };
}
