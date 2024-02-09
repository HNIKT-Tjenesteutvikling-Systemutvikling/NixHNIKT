{pkgs, ...}: {
  home.packages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    userEmail = "vebjorn.hal@gmail.com";
    userName = "vebjorn";
  };
}
