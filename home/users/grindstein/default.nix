{pkgs, ...}: {
  home.packages = with pkgs; [
    teamviewer
  ];

  programs.git = {
    enable = true;
    userEmail = "torkil.grindstein@hnikt.no";
    userName = "grindstein";
  };
}
