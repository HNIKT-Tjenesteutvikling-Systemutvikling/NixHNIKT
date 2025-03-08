{ pkgs, ... }: {
  home.packages = with pkgs; [
    rclone
    obsidian
    filezilla
  ];

  programs.git = {
    enable = true;
    userEmail = "idar.evensen@gmail.com";
    userName = "ievensen";
  };
}
