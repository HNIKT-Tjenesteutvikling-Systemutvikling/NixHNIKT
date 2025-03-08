{ pkgs, ... }: {
  home.packages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    userEmail = "magnus.thoralf.kristiansen@hnikt.no";
    userName = "Turbonaepskrel";
  };
}
