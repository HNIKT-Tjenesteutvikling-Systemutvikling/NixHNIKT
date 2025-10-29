_:
let
  username = "dev";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

in
{
  programs = {
    home-manager.enable = true;
    gh.enable = true;
  };
  imports = builtins.concatMap import [
    ./programs
    ./scripts
    ./services
  ];
  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "25.05";
  };

  systemd.user.startServices = "sd-switch";
  news.display = "silent";
}
