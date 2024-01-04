{
  pkgs,
  userSetup,
  ...
}: {
  imports =
    (
      if userSetup.intellijCli
      then [./../programs/intellij.nix]
      else [./../programs/develop.nix]
    )
    ++ (
      if userSetup.citrixConfig
      then [./../programs/citrix.nix]
      else []
    )
    ++ (
      if userSetup.emacsConfig
      then [./../programs/emacs.nix]
      else []
    );

  home.packages = with pkgs;
    if !userSetup.intellijCli
    then [jetbrains.idea-ultimate]
    else [];

  programs.git = {
    enable = true;
    userEmail = "${userSetup.gitEmail}";
    userName = "${userSetup.gitUsername}";
  };
}
