{
  programs.git = {
    enable = true;
    userEmail = "sigurdjbratt@hotmail.no";
    userName = "sigubrat";
  };

  # Fix git not working in vscode terminal
  # Copies the ssh config instead of symlinking it
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
  };
}
