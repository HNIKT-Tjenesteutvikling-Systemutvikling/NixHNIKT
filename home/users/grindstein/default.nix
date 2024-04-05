{pkgs, ...}: {
  home.packages = with pkgs; [
    rustdesk
  ];

  programs.git = {
    enable = true;
    userEmail = "torkil.grindstein@hnikt.no";
    userName = "grindstein";
  };
}
