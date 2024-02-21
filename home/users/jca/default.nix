{pkgs, ...}: {
  home.packages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    userEmail = "jan.olov.gustav.carlsson@hnikt.no";
    userName = "jca002";
  };
}
