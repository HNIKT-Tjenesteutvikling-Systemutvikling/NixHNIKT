{
  pkgs,
  userSetup,
  ...
}: {
  imports =
    (
      if userSetup.android
      then [./../programs/android.nix]
      else []
    )
    ++ (
      if userSetup.vscode
      then [./../programs/vscode.nix]
      else []
    )
    ++ (
      if userSetup.intellij
      then [./../programs/intellij.nix]
      else []
    )
    ++ (
      if userSetup.citrixConfig
      then [./../programs/citrix.nix]
      else []
    )
    ++ (
      if userSetup.emacsConfig
      then [./../programs/emacs/default.nix]
      else []
    );

  home.packages = with pkgs;
    (
      if userSetup.rider
      then [jetbrains.rider]
      else []
    )
    ++ (
      if userSetup.android
      then [android-studio]
      else []
    );

  programs.git = {
    enable = true;
    userEmail = "${userSetup.gitEmail}";
    userName = "${userSetup.gitUsername}";
  };
}
