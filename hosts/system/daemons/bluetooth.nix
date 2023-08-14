{
  services = {
    blueman.enable = true;
  };

  systemd.services = {
    usb-power-management = {
      description = "Enable USB power management";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
      };
      unitConfig.RequireMountsFor = ["/sys"];
      script = ''
        echo -1 > /sys/module/usbcore/parameters/autosuspend
      '';
    };
  };
}
