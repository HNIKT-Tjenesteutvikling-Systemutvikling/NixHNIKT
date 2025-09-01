{
  imports = [ ../../default.nix ];

  programs.git = {
    enable = true;
    userEmail = "neethan.puvanendran@hnikt.no";
    userName = "neethan";
    signing = {
      key = "6080BAC662730473";
      signByDefault = true;
    };
  };

  # Allow devcontainers to speak with gpg agent.
  services.gpg-agent.enableExtraSocket = true;

  # Home modules to load
  program = {
    browser = {
      chromium.enable = true;
      firefox.enable = true;
      zen.enable = true;
    };
    gimp.enable = true;
    keepass.enable = true;
    remmina.enable = true;
    slack.enable = true;
    spotify.enable = true;
    vscode = {
      enable = true;
      theme = "stardew";
    };
  };
}
