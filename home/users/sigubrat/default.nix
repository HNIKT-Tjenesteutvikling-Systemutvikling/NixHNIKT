{
  imports = [
    ../../programs/intellij.nix
  ];

  programs.git = {
    enable = true;
    userEmail = "Sigurdjbratt@hotmail.no";
    userName = "Sigubrat";
  };
}
