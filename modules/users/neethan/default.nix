{
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

  # Fix git not working in vscode terminal
  # Copies the ssh config instead of symlinking it
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
  };
}
