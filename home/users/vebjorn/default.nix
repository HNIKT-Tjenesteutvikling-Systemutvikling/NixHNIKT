{pkgs, ...}: {
  home.packages = with pkgs; [
    brave
  ];

  programs.git = {
    enable = true;
    userEmail = "vebjorn.hal@gmail.com";
    userName = "vebjorn";
  };
}
