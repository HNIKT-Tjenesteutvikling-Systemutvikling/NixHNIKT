{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian
    filezilla
  ];

  programs.git = {
    enable = true;
    userEmail = "jorgen.aspehaug.bjerkan@hnikt.no";
    userName = "jab600";
  };
}
