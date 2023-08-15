{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.neard
    pkgs.libnfc
  ];
  services.dbus.packages = [pkgs.neard];
  systemd.packages = [pkgs.neard];
}
