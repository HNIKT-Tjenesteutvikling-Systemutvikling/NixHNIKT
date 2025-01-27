{ pkgs, ... }: {
  home.packages = with pkgs; [
    jetbrains.rider
  ];

  programs.git = {
    enable = true;
    userEmail = "jon-vidar.schneider@hnikt.no";
    userName = "jonvidars";
  };
}
