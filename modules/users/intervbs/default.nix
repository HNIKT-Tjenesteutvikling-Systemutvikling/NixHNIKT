{ pkgs, ... }: {
  home.packages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    userEmail = "joran@lillegaard.com";
    userName = "intervbs";
  };
}
