{
  services.easyeffects = {
    enable = true;
    preset = "noise-cancellation";
  };

  xdg.configFile."easyeffects/input/noise-cancellation.json" = {
    text = builtins.toJSON {
      input = {
        blocklist = [ ];
        plugins_order = [ "rnnoise#0" ];
        "rnnoise#0" = {
          bypass = false;
          enable-vad = true;
          input-gain = 0.0;
          model-name = "";
          output-gain = 0.0;
          release = 20.0;
          vad-thres = 91.0;
          wet = 0.0;
        };
      };
    };
  };
}
