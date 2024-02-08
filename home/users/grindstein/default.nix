{pkgs, ...}: {
  home.packages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    userEmail = "torkil.grindstein@hnikt.no";
    userName = "grindstein";
  };
}
