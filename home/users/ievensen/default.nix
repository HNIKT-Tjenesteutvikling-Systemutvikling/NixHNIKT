{ pkgs, ... }: {
  home.packages = with pkgs; [
    rclone
    obsidian
    filezilla
    logitech-udev-rules
  ];

  programs.git = {
    enable = true;
    userEmail = "idar.evensen@gmail.com";
    userName = "ievensen";
  };
}
