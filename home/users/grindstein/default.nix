{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustdesk
    anydesk
  ];

  programs.git = {
    enable = true;
    userEmail = "torkil.grindstein@hnikt.no";
    userName = "grindstein";
  };
}
