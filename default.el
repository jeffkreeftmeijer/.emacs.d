;;; -*- lexical-binding: t -*-

(require 'bind-key)

(use-package frame
  :init
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1))

(use-package faces
  :init
  (defun jk/set-face-font (face family)
    (set-face-attribute
     face nil
     :family family :weight 'regular :width 'expanded :height 150))

  (jk/set-face-font 'default "Iosevka")
  (jk/set-face-font 'fixed-pitch "Iosevka")
  (jk/set-face-font 'variable-pitch "Iosevka Aile")
  :custom
  (face-font-family-alternatives
    '(("Iosevka" "SF Mono" "Menlo" "monospace")
      ("Iosevka Aile" "SF Pro" "Helvetica" "Arial")))
  :hook
  (org-mode . variable-pitch-mode)
  (markdown-mode . variable-pitch-mode))

(use-package auto-dark
  :ensure t
  :config
  (auto-dark-mode 1)
  :custom
  (auto-dark-light-theme 'modus-operandi-tinted)
  (auto-dark-dark-theme 'modus-vivendi-tinted))

(defun jk/dark ()
  "Switch to macOS' dark appearance."
  (interactive)
  (do-applescript
   "tell application \"System Events\"
  tell appearance preferences
    set dark mode to true
  end tell
end tell"))

(defun jk/light ()
  "Switch to macOS' light appearance."
  (interactive)
  (do-applescript
   "tell application \"System Events\"
  tell appearance preferences
    set dark mode to false
  end tell
end tell"))

(use-package emacs
  :config
  (require-theme 'modus-themes)
  (setq
   modus-themes-mixed-fonts t
   modus-themes-italic-constructs t
   modus-themes-bold-constructs t)
  (load-theme 'modus-operandi-tinted)
  :custom
  modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))

(use-package spacious-padding
  :ensure t
  :init
  (spacious-padding-mode 1)
  :custom
  spacious-padding-subtle-mode-line t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package evil-commentary
  :ensure t
  :after evil
  :init
  (evil-commentary-mode 1))

(use-package emacs
  :init
  (setq-default cursor-type 'bar))

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

(use-package consult
  :ensure t
  :bind
  ("C-x b" . consult-buffer)
  ("C-x p b" . consult-project-buffer)
  ("M-g g" . consult-goto-line)
  ("M-g M-g" . consult-goto-line)
  ("C-x p g" . consult-grep))

(use-package orderless
  :ensure t
  :custom
  completion-styles '(orderless basic))

(use-package embark
  :ensure t
  :bind
  ("C-." . embark-act))

(use-package savehist
  :init
  (savehist-mode 1))

(use-package completion-preview
  :init
  (global-completion-preview-mode 1))

(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode 1)
  :custom
  (treesit-auto-install 'prompt))

(use-package beancount
  :ensure t
  :mode ("\\.beancount\\'" . beancount-mode))

(use-package dockerfile-mode
  :ensure t)

(use-package elixir-mode
  :ensure t)

(use-package git-modes
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package nix-mode
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package typescript-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package direnv
  :ensure t
  :init
  (direnv-mode 1))

(defun jk/maybe-format-buffer ()
  (when (bound-and-true-p eglot-managed-p)
    (eglot-format-buffer)))

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode) "rust-analyzer"))
  (add-to-list 'eglot-server-programs '((elixir-ts-mode elixir-mode) "elixir-ls"))
  (add-to-list 'eglot-server-programs '((nix-mode) "nixd"))
  :hook
  (rust-mode . eglot-ensure)
  (rust-ts-mode . eglot-ensure)
  (after-save . jk/maybe-format-buffer))

(use-package magit
  :ensure t)

(use-package eat
  :ensure t
  :init
  (eat-eshell-mode 1)
  :custom
  eshell-visual-commands nil)

(use-package eshell-atuin
  :after em-hist
  :init
  (eshell-atuin-mode)
  (keymap-set eshell-hist-mode-map "<up>" 'eshell-atuin-history)
  (keymap-unset eshell-hist-mode-map "<down>")
  (vertico-multiform-mode 1)
  (setq vertico-multiform-commands
        '((eshell-atuin-history
  	 reverse
  	 (vertico-sort-function . identity))))
  :custom
  eshell-atuin-search-options nil)

(use-package dirvish
  :ensure t
  :init
  (dirvish-override-dired-mode))

(use-package org-gode
  :hook (org-mode . org-node-enable))

(use-package org-roam
  :ensure t
  :custom
  org-roam-directory (file-truename "~/notes"))

(use-package ox-org
  :custom
  org-export-with-smart-quotes t
  org-export-with-entities nil
  org-export-headline-levels 5
  org-export-with-toc nil
  org-export-section-numbers nil
  org-html-doctype "html5"
  org-html-html5-fancy t
  org-html-container-element "section"
  org-html-divs '((preamble  "header" "preamble")
  		(content   "main" "content")
  		(postamble "footer" "postamble")))

(use-package notmuch
  :ensure t)

(use-package files
  :custom
  backup-directory-alist `(("." . "~/.emacs.d/backups")))

(use-package which-key
  :ensure t
  :init
  (which-key-mode 1))

(use-package project-x
  :after project
  :init
  (project-x-mode 1)
  (setq project-find-functions '(project-x-try-local project-try-vc)))

(use-package pixel-scroll
  :init
  (pixel-scroll-precision-mode 1))
