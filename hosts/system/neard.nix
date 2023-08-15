{pkgs, ...}: {
  environment.systemPackages = [pkgs.neard];
  services.dbus.packages = [pkgs.neard];
  systemd.packages = [pkgs.neard];
}
