{pkgs, ...}: let
  git_commit = "b42228b2523d04206aa8b50e582c89f33c24713a";
in
  pkgs.writeShellScriptBin "fvm-install" ''
    if ! command -v fvm &> /dev/null; then
      curl -fsSL https://raw.githubusercontent.com/leoafarias/fvm/${git_commit}/scripts/install.sh | bash
    else
      echo fvm already installed.
    fi
  ''
