{pkgs, ...}: let
  git_commit = "b42228b2523d04206aa8b50e582c89f33c24713a";
in
  pkgs.writeShellScriptBin "fvm-install" ''
    git_commit="${git_commit}"
    fvm_folder="~/.fvm_flutter/bin"
    fvm_executable="$fvm_folder/fvm"

    if [[ ! -x "$fvm_executable" ]]; then
        tmp=$(mktemp)
        curl -fsSL https://raw.githubusercontent.com/leoafarias/fvm/$git_commit/scripts/install.sh | bash 2> $tmp
        if cat $tmp | grep "error: Failed to create symlink."; then
            echo "Could not create symlink but this is expected."
        else
            cat $tmp
        fi
        rm $tmp
    fi

    echo
    echo "Add $fvm_folder to your PATH to complete setup."
    echo "Or run $fvm_executable directly."
  ''
