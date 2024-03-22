{pkgs, ...}: {
  home.packages = with pkgs; [
    brave
    asciiquarium-transparent
  ];

  programs.git = {
    enable = true;
    userEmail = "vebjorn.hal@gmail.com";
    userName = "vebjorn";
  };
}
