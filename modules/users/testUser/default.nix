{ pkgs
, ...
}: {
  home.packages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    userEmail = "testUser.gmail.com";
    userName = "testUser";
  };
}
