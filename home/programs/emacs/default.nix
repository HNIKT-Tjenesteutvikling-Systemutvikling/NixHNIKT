{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with builtins; let
  cfg = config.emacs;

  emacsCopilotSrc = builtins.fetchGit {
    url = "https://github.com/zerolfx/copilot.el.git";
    rev = "421703f5dd5218ec2a3aa23ddf09d5f13e5014c2";
  };
in {
  options.emacs.enable = mkEnableOption "emacs";

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      extraPackages = epkgs:
        with epkgs; [
          # Core packages
          general # Provides a more convenient way to define keybindings
          which-key # Displays available keybindings in popup

          all-the-icons # A package for inserting developer icons
          all-the-icons-dired # Shows icons for each file in dired mode
          all-the-icons-ivy-rich # More friendly display transformer for ivy
          blamer # Show git blame information in the fringe
          company # Modular text completion framework
          company-box # A company front-end with icons
          company-quickhelp # Documentation popup for Company
          counsel # Various completion functions using Ivy
          counsel-projectile # Ivy integration for Projectile
          dashboard # A startup screen extracted from Spacemacs
          dired-single # Reuse the dired buffer
          direnv # Environment switcher for Emacs
          dmenu # A dynamic menu for X
          docker # Docker integration
          dockerfile-mode # Major mode for editing Dockerfiles
          editorconfig # EditorConfig Emacs Plugin
          elfeed # An extensible web feed reader
          eldoc # Show function arglist or variable docstring in echo area
          erc # An IRC client for Emacs
          flycheck # On-the-fly syntax checking
          forge # Work with Git forges from the comfort of Magit
          ghub # Minuscule client library for the Github API
          git-gutter # Show git diff in the fringe
          git-gutter-fringe # Fringe version of git-gutter.el
          highlight-thing # Highlight the current line, the current symbol, and more
          ivy # A generic completion mechanism
          ivy-posframe # Display ivy in a posframe
          ivy-prescient # Better sorting and filtering for ivy
          ivy-rich # More friendly display transformer for ivy
          ligature # Ligature support for Emacs
          magit # A Git porcelain inside Emacs
          nerd-icons # Nerd icons for Emacs
          org # For keeping notes, maintaining TODO lists, and project planning
          org-drill # A spaced repetition system for Emacs
          org-modern # A modern org-mode distribution
          org-pomodoro # Pomodoro technique implementation
          org-present # A simple org-mode presentation tool
          org-roam # A note-taking tool based on the principles of networked thought
          org-roam-ui # A graphical user interface for org-roam
          pdf-tools # Emacs support library for PDF files
          projectile # Project Interaction Library for Emacs
          rainbow-delimiters # Highlight delimiters such as parentheses, brackets or braces according to their depth
          rainbow-mode # Colorize color names in buffers
          simple-httpd # A simple HTTP server
          vterm # Fully-featured terminal emulator
          multi-vterm # Multiple vterm buffers
          web-mode # Major mode for editing web templates
          whitespace-cleanup-mode # Intelligently call whitespace-cleanup on save

          # Theme
          doom-modeline # A minimal and modern mode-line
          doom-themes # An opinionated pack of modern color-themes

          # Programming language packages.
          blacken # Black formatter for Python
          eglot-java # Java support for eglot
          nix-mode # Nix integration
          python-mode # Major mode for editing Python files
          rustic # Rust development environment
          sbt-mode # Major mode for editing SBT files
          scala-mode # Major mode for editing Scala files
        ];
      extraConfig = builtins.readFile ./init.el;
    };

    home.packages = with pkgs; [
    ];

    home.file."./.emacs.d/emacsCopilot".source = emacsCopilotSrc;
    services.emacs.enable = true;
  };
}
