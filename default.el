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

(use-package vertico
  :init
  (vertico-mode 1))

(use-package marginalia
  :init
  (marginalia-mode 1))

(use-package consult
  :bind
  ("C-x b" . consult-buffer)
  ("C-x p b" . consult-project-buffer)
  ("M-g g" . consult-goto-line)
  ("M-g M-g" . consult-goto-line))

(use-package orderless
  :custom
  completion-styles '(orderless basic))

(use-package embark
  :bind
  ("C-." . embark-act))

(use-package savehist
  :init
  (savehist-mode 1))

(use-package treesit-auto
  :config
  (global-treesit-auto-mode 1)
  :custom
  (treesit-auto-install 'prompt))

(use-package direnv
  :init
  (direnv-mode 1))

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode) "rust-analyzer"))
  :hook
  (rust-mode . eglot-ensure)
  (rust-ts-mode . eglot-ensure))

(use-package files
  :custom
  backup-directory-alist `(("." . "~/.emacs.d/backups")))
