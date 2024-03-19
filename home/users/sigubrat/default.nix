{pkgs, ...}: {
  home.packages = with pkgs; [
    figma-linux
  ];

  programs.git = {
    enable = true;
    userEmail = "sigurdjbratt@hotmail.no";
    userName = "sigubrat";
  };
}
