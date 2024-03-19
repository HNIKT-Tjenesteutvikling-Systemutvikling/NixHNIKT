{pkgs, ...}: {
  home.packages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    userEmail = "jonas.nordhaug.myhre@hnikt.no";
    userName = "jonas-hnikt";
  };
}
