{ pkgs, ... }: {
  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };
}
