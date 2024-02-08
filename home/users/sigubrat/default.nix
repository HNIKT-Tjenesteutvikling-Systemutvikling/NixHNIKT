{pkgs, ...}: {
  home.packages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    userEmail = "sigurdjbratt@hotmail.no";
    userName = "sigubrat";
  };
}
