(menu-bar-mode -1) ; Disable the menu bar
(tool-bar-mode -1) ; Disable the toolbar
(scroll-bar-mode -1) ; Disable the scroll bar
(tab-bar-mode -1) ; Disable the tab bar
(setq-default indent-tabs-mode nil) ; Use spaces instead of tabs
(global-display-line-numbers-mode t) ;; Show line numbers
(setq
 make-backup-files nil ; Disable backup files
 auto-save-default nil ; Disable auto save
 display-line-numbers-type 'relative
 gc-cons-threshold 100000000 ;; 100mb
 read-process-output-max (* 1024 1024)) ;; 1mb

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq ring-bell-function 'ignore)
(defalias 'yes-or-no-p 'y-or-n-p)

(use-package async
  :ensure t
  :init (dired-async-mode 1))

;; Direnv Configuration
(require 'direnv)
(direnv-mode 1)

(use-package dmenu
  :ensure t
  :bind
  ("s-SPC" . 'dmenu))

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(use-package company
  :demand t
  :config
  (setq
   company-backends '(company-capf company-files company-dabbrev)
   company-idle-delay 0.1)
  :init
  :hook (after-init . global-company-mode))

(use-package company-box
  :demand t
  :config
  (setq
   company-box-icons-alist 'company-box-icons-all-the-icons
   company-box-backends-colors nil
   company-box-show-single-candidate t
   company-box-max-candidates 50
   company-box-doc-delay 0.1
   company-box-enable-icon t
   company-box-scrollbar t)
  :hook (company-mode . company-box-mode))

(use-package company-quickhelp
  :demand t
  :config
  (setq company-quickhelp-delay 0.1)
  :after company
  :init
  :hook (company-mode . company-quickhelp-mode))

(let
    (
     (copilot-dir "~/.emacs.d/emacsCopilot")
     (copilot-file "~/.emacs.d/emacsCopilot/copilot.el"))
  ;; Check if the copilot.el file exists
  (when
      (file-exists-p copilot-file)
    ;; Add the directory to the load-path
    (add-to-list 'load-path copilot-dir)
    ;; Try to load the copilot module and catch any errors
    (condition-case err
        (progn
          (require 'copilot)
          (add-hook 'prog-mode-hook 'copilot-mode)
          (define-key copilot-completion-map
                      (kbd "C-p") 'copilot-accept-completion)
          (define-key copilot-mode-map
                      (kbd "<C-S-n>") 'copilot-next-completion
                      (define-key copilot-mode-map
                                  (kbd "<C-S-p>") 'copilot-previous-completion)))
      ;; If there's an error, print a message (you can also log or take other actions)
      (error
       (message "Failed to load copilot: %s" err)))))

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-startup-banner 'logo
        dashboard-banner-logo-title "Welcome back Master"
        dashboard-set-file-icons t
        dashboard-center-content t
        dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 5)
                          (agenda . 5))
        initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  :init
  :hook (after-init . dashboard-setup-startup-hook))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35
        doom-modeline-bar-width 3
        doom-modeline-buffer-file-name-style 'truncate-with-project
        doom-modeline-buffer-encoding nil
        doom-modeline-buffer-modification-icon nil
        doom-modeline-buffer-state-icon nil
        doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-minor-modes nil
        doom-modeline-persp-name nil
        doom-modeline-eglot t
        doom-modeline-github nil
        doom-modeline-github-interval (* 30 60)))

(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package nerd-icons
  :ensure t
  :config
  (setq nerd-icons-font-family "Iosevka Nerd Font"))

(add-hook 'after-make-frame-functions
          (lambda (f)
            (with-selected-frame f
              (set-frame-font "Iosevka Nerd Font 11" nil t)
              (set-face-attribute 'mode-line nil :font "Iosevka Nerd Font 12" :height 100)
              (set-face-attribute 'company-tooltip nil :font "Iosevka Nerd Font 11" :height 100))))

(use-package flycheck
  :config
  (global-flycheck-mode)) ; Enable flycheck

(use-package highlight-thing
  :config
  (global-highlight-thing-mode)
  :custom
  (highlight-thing-delay-seconds 0.5)
  (highlight-thing-case-sensitive-p t)
  (highlight-thing-ignore-list '("False" "True" "None")))

(use-package ivy
  :init
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) "))

(use-package editorconfig
  :ensure t
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-annot-activate-created-annotations t)
  :hook
  (pdf-view-mode . (lambda ()
                     (when (bound-and-true-p display-line-numbers-mode)
                       (display-line-numbers-mode -1)))))

(use-package rainbow-mode
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package whitespace)
(use-package whitespace-cleanup-mode)

(use-package eglot
  :ensure t
  :config
  (setq eglot-autoshutdown t))

(use-package eglot-java
  :hook (java-mode . eglot-java-mode)
  :mode ("\\.java\\'" . java-mode))

(use-package nix-mode
  :hook (nix-mode . eglot-ensure)
  :mode "\\.nix\\'")

(use-package blacken)
(use-package python-mode
  :hook (python-mode . eglot-ensure))

(use-package rustic
  :after eglot
  :hook (rustic-mode . eglot-ensure)
  :mode "\\.rs\\'")

(use-package sbt-mode
  :config
  (setq sbt:program-options '("-Dsbt.supershell=false"))
  :mode "\\.s\\(cala\\|bt\\)$")

(use-package scala-mode
  :hook (scala-mode . eglot-ensure)
  :mode "\\.scala\\'")

(setq major-mode-remap-alist
      '((bash-mode . bash-ts-mode)
        (css-mode . css-ts-mode)
        (json-mode . js-ts-mode)
        (js2-mode . js-ts-mode)
        (typescript-mode . typescript-ts-mode)))

(setq treesit-font-lock-level 4)

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :custom
  (git-gutter:update-interval 0.05))

(use-package git-gutter-fringe
  :after git-gutter
  :config
  (fringe-mode '(8 . 8))
  (define-fringe-bitmap 'git-gutter-fr:added
    [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
    nil nil 'center)
  (define-fringe-bitmap 'git-gutter-fr:modified
    [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
    nil nil 'center)
  (define-fringe-bitmap 'git-gutter-fr:deleted
    [0 0 0 0 0 0 0 0 0 0 0 0 0 128 192 224 240 248]
    nil nil 'center))

(use-package blamer
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70))

(use-package forge
  :after magit)

(defun split-window-right-and-move-there-dammit ()
  (interactive)
  (split-window-right)
  (windmove-right))

(defun split-window-left-and-move-there-dammit ()
  (interactive)
  (split-window-left)
  (windmove-left))

(defun split-window-below-and-move-there-dammit ()
  (interactive)
  (split-window-below)
  (windmove-down))

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
        (transpose-lines arg))
      (forward-line -1)))))

(defun move-text-down (arg)
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  (interactive "*p")
  (move-text-internal (- arg)))

(defun move-right-and-open-todo ()
  (interactive)
  (split-window-right)
  (windmove-right)
  (find-file "~/Documents/org/todo.org"))

(global-set-key (kbd "C-S-l") 'split-window-right-and-move-there-dammit)
(global-set-key (kbd "C-S-h") 'split-window-left-and-move-there-dammit)
(global-set-key (kbd "C-S-j") 'split-window-below-and-move-there-dammit)
(global-set-key (kbd "C-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-S-<down>") 'shrink-window)
(global-set-key (kbd "C-S-<up>") 'enlarge-window)
(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-j") 'windmove-down)
(global-set-key (kbd "C-k") 'windmove-up)
(global-set-key (kbd "C-l") 'windmove-right)
(global-set-key (kbd "S-<up>") 'move-text-up)
(global-set-key (kbd "S-<down>") 'move-text-down)
(global-set-key (kbd "C-<tab>") 'previous-buffer)
(global-set-key (kbd "C-S-i") 'move-right-and-open-todo)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package org
  :init
  (setq org-directory (or org-directory "~/Documents/org/")
        org-id-locations-file (expand-file-name ".orgids" org-directory)
        org-agenda-files (list org-directory)
        org-agenda-deadline-faces '((1.001 . error)
                                    (1.0 . org-warning)
                                    (0.5 . org-upcoming-deadline)
                                    (0.0 . org-upcoming-distant-deadline))
        org-agenda-window-setup 'current-window
        org-agenda-skip-unavailable-files t
        org-agenda-span 10
        org-agenda-start-on-weekday nil
        org-agenda-start-day "-3d"
        org-agenda-inhibit-startup t
        org-indirect-buffer-display 'current-window
        org-eldoc-breadcrumb-separator " → "
        org-enforce-todo-dependencies t
        org-entities-user '(("flat"  "\\flat" nil "" "" "266D" "♭")
                            ("sharp" "\\sharp" nil "" "" "266F" "♯"))
        org-ellipsis " "
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-confirm-babel-evaluate nil
        org-export-with-smart-quotes t
        org-src-window-setup 'current-window
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        org-fontify-whole-heading-line t
        org-hide-leading-stars t
        org-image-actual-width nil
        org-imenu-depth 6
        org-priority-faces '((?A . error)
                             (?B . warning)
                             (?C . success))
        org-startup-indented t
        org-tags-column 0
        org-use-sub-superscripts '{}
        org-startup-folded nil))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-roam
  :init
  (setq org-roam-v2-ack t
        org-roam-directory "~/Documents/Notes"
        org-roam-db-location "~/Documents/Notes/org-roam.db"
        org-roam-completion-everywhere t))

(use-package org-roam-ui
  :init
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package org-present
  :hook ((org-present-mode . (lambda ()
                               (org-present-big)
                               (org-display-inline-images)
                               (org-present-hide-cursor)
                               (org-present-read-only)))
         (org-present-mode-quit . (lambda ()
                                    (org-present-small)
                                    (org-remove-inline-images)
                                    (org-present-show-cursor)
                                    (org-present-read-write))))
  )

(use-package org-pomodoro
  :init
  (setq org-pomodoro-length 25
        org-pomodoro-short-break-length 5
        org-pomodoro-long-break-length 15
        org-pomodoro-manual-break t))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :config
  (setq projectile-enable-caching t
        projectile-completion-system 'ivy
        projectile-indexing-method 'alien
        projectile-sort-order 'recently-active
        projectile-project-search-path '("~/Projects/" ("~/Projects/workspace/" . 1))))

(use-package counsel-projectile
  :after projectile
  :config
  (counsel-projectile-mode))

(use-package vterm
  :ensure t)

(use-package multi-vterm
  :ensure t
  :bind (("C-S-t" . multi-vterm-project)
         ("C-S-b" . multi-vterm-dedicated-toggle))
  :config
  (setq multi-vterm-dedicated-window-height 37))

(use-package web-mode
  :ensure t
  :mode (("\\.phtml\\'" . web-mode)
         ("\\.tpl\\.php\\'" . web-mode)
         ("\\.[agj]sp\\'" . web-mode)
         ("\\.as[cp]x\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.liquid\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode)
         ("\\.html?\\'" . web-mode))
  :config
  (setq web-mode-enable-auto-closing t
        web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-part-padding 2
        web-mode-script-padding 2
        web-mode-style-padding 2
        web-mode-code-indent-offset 2))

(use-package yaml-mode
  :ensure t
  :mode (("\\.\\(yml\\|yaml\\)\\'" . yaml-mode)))
