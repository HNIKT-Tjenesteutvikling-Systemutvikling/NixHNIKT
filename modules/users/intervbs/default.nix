{
  programs.git = {
    enable = true;
    userEmail = "joran@lillegaard.com";
    userName = "intervbs";
  };

  # Fix git not working in vscode terminal
  # Copies the ssh config instead of symlinking it
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
  };
}
