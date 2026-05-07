{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "Mon *-*-* 11:00:00";
      extraArgs = "--keep-since 4d --keep 3";
    };
    flake = "/home/dev/Sources/nixhnikt";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
