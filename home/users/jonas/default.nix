{ pkgs, ... }: {
  home.packages = with pkgs; [
    inkscape
    alacritty
  ];

  programs.git = {
    enable = true;
    userEmail = "jonas.nordhaug.myhre@hnikt.no";
    userName = "jonas-hnikt";
  };
}
