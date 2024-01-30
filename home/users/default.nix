{
  pkgs,
  inputs,
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
      then [./../programs/emacs/default.nix]
      else []
    )
    ++ (
      if userSetup.android
      then [./../programs/android.nix]
      else []
    );

  home.packages = with pkgs;
    (
      if !userSetup.intellijCli
      then [jetbrains.idea-ultimate]
      else []
    )
    ++ (
      if userSetup.rider
      then [jetbrains.rider]
      else []
    )
    ++ (
      if userSetup.android
      then [android-studio]
      else []
    )
    ++ (
      if userSetup.nvim
      then [inputs.neovimFlake.defaultPackage.${pkgs.system}]
      else []
    );

  programs.git = {
    enable = true;
    userEmail = "${userSetup.gitEmail}";
    userName = "${userSetup.gitUsername}";
  };
}
