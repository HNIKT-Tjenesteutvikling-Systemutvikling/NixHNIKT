{pkgs, ...}: {
  home.packages = with pkgs; [
    rustdesk
    anydesk
  ];

  programs.git = {
    enable = true;
    userEmail = "joran@lillegaard.com";
    userName = "intervbs";
  };
}
