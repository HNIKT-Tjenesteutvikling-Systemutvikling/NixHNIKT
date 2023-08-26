{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraConfig = ''
      (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                               ("melpa" . "https://melpa.org/packages/")))
      (setq package-check-signature nil)
      (setq package-enable-at-startup nil)
      (package-initialize)
    '';
  };
}
