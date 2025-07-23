{
  services = {
    pulseaudio.enable = false;
    # Enable pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  environment.persistence."/persist" = {
    users.dev = {
      directories = [
        ".config/pulse"
      ];
    };
  };
}
