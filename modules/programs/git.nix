{ pkgs
, config
, lib
, ...
}:
let
  gitConfig = {
    core = {
      editor = "code";
      pager = "diff-so-fancy | less --tabs=4 -RFX";
    };
    init.defaultBranch = "main";
    merge = {
      conflictStyle = "diff3";
      tool = "vim_mergetool";
    };
    mergetool."vim_mergetool" = {
      cmd = "nvim -f -c \"MergetoolStart\" \"$MERGED\" \"$BASE\" \"$LOCAL\" \"$REMOTE\"";
      prompt = false;
    };
    pull.rebase = false;
    push.autoSetupRemote = true;
    url = {
      "https://github.com/".insteadOf = "gh:";
      "ssh://git@github.com".pushInsteadOf = "gh:";
    };
  };

  sshConfigSourcePath = config.home.homeDirectory + "/.ssh/config_source";
  sourceFileExists = builtins.pathExists sshConfigSourcePath;
in
{
  home = {
    packages = with pkgs.gitAndTools; [
      diff-so-fancy # git diff with colors
      git-crypt # git files encryption
      hub # github command-line client
      tig # diff and commit view
    ];

    # Fix git not working in vscode terminal
    # Copies the ssh config instead of symlinking it
    file.".ssh/config" = lib.mkIf sourceFileExists {
      target = ".ssh/config_source";
      onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
    };
  };

  programs.git = {
    enable = true;
    aliases = {
      amend = "commit -a --amend";
      fix = "commit -a --fixup HEAD";
      base = "rebase -i --autosquash";
      br = "branch";
      co = "checkout";
      s = "status";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      p = "pull";
      pp = "push";
      f = "fetch";
      ppf = "push --force-with-lease";
    };
    extraConfig = gitConfig;
    ignores = [
      "*.bloop"
      "*.bsp"
      "*.metals"
      "*.metals.sbt"
      "*metals.sbt"
      "*.direnv"
      "*.envrc" # there is lorri, nix-direnv & simple direnv; let people decide
      "*hie.yaml" # ghcide files
      "*.mill-version" # used by metals
      "*.jvmopts" # should be local to every project
    ];
  } // (pkgs.sxm.git or { });
}
