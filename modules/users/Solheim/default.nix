{ pkgs, ... }: {
  home.packages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    userEmail = "jan-magnus.solheim@hnikt.no";
    userName = "5olheim";
  };
}
