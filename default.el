(use-package frame
  :init
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1))

(use-package faces
  :init
  (set-face-attribute 'default nil :family "SF Mono" :height 140)
  (set-face-attribute 'fixed-pitch nil :family "SF Mono" :height 140)
  (set-face-attribute 'variable-pitch nil :family "SF Pro" :height 170)
  :custom
  (face-font-family-alternatives
    '(("SF Mono" "Menlo" "monospace")
      ("SF Pro" "Helvetica" "Arial")))
  :hook
  (text-mode . variable-pitch-mode))

(use-package modus-themes
  :init
  (setq modus-themes-mixed-fonts t)
  (load-theme 'modus-operandi-tinted)
  :custom
  modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))

(use-package spacious-padding
  :init
  (spacious-padding-mode 1)
  :custom
  spacious-padding-subtle-mode-line t)

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :init
  (evil-commentary-mode 1))

(use-package files
  :custom
  backup-directory-alist `(("." . "~/.emacs.d/backups")))
