;;; General

(use-package emacs
  :init
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (setq initial-scratch-message nil)
  (indent-tabs-mode nil)
  (set-face-attribute 'default nil :font "SF Mono-14"))

(use-package helpful
  :ensure t
  :init
  (require 'bind-key)
  :bind
  (("C-h f" . helpful-callable)  ; Replace describe-function
   ("C-h v" . helpful-variable)  ; Replace describe-variable
   ("C-h k" . helpful-key)       ; Replace describe-key
   ("C-h x" . helpful-command))) ; Replace describe-command

;;; Theme

(use-package emacs
  :init
  (load-theme 'modus-operandi-tinted)
  :custom
  modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))

(use-package auto-dark
  :ensure t
  :config
  (auto-dark-mode t)
  :custom
  (auto-dark-light-theme 'modus-operandi-tinted)
  (auto-dark-dark-theme 'modus-vivendi-tinted))

;;; Evil

(use-package evil-commentary
  :ensure t
  :after evil
  :config
  (evil-commentary-mode))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :commands
  (evil-collection-corfu-setup
   evil-collection-dired-setup
   evil-collection-eshell-setup
   evil-collection-magit-setup
   evil-collection-org-setup
   evil-collection-org-roam-setup
   evil-collection-vertico-setup))

(use-package corfu
  :defer t
  :config
  (evil-collection-corfu-setup))

(use-package dired
  :defer t
  :config
  (evil-collection-dired-setup))

(use-package eshell
  :defer t
  :config
  (evil-collection-eshell-setup))

(use-package org
  :defer t
  :config
  (evil-collection-org-setup))

(use-package org-roam
  :defer t
  :config
  (evil-collection-org-roam-setup))

(use-package magit
  :defer t
  :config
  (evil-collection-magit-setup))

(use-package vertico
  :defer t
  :config
  (evil-collection-vertico-setup))

;;; Magit

(use-package magit
  :ensure t
  :defer t)

;;; Vertico

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1))

(use-package savehist
  :init
  (savehist-mode 1))

(use-package marginalia
  :ensure t
  :after vertico
  :init
  (marginalia-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic)))

(use-package consult
  :ensure t
  :init
  (require 'bind-key)
  :bind
  (("C-x p b" . consult-project-buffer))) ; Replace project-switch-to-buffer

;;; Corfu

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  :custom
  (corfu-auto t))

;;; Eglot

(use-package eglot
  :ensure t
  :hook
  (elixir-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(elixir-mode "elixir-ls")))

;;; Org

(use-package org
  :custom
  (org-refile-targets (quote (("~/notes/tasks.org" :level . 1)))))

(use-package org
  :custom
  (org-agenda-files (directory-files-recursively "~/org/" "\\.org$")))

(use-package emacs
  :custom
  (org-babel-load-languages '((emacs-lisp . t)
			      (shell . t))))

(use-package org-auto-tangle
  :ensure t
  :hook
  (org-mode . org-auto-tangle-mode)
  :custom
  (org-auto-tangle-default t))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-directory (file-truename "~/notes"))
  :commands
  (org-roam-node-find)
  :config
  (org-roam-db-autosync-mode))

(use-package ox-gfm
  :ensure t
  :commands
  org-gfm-export-as-markdown
  org-gfm-convert-region-to-md
  org-gfm-export-to-markdown
  org-gfm-publish-to-gfm)

(use-package citeproc
  :ensure t
  :defer t)

(use-package org-glossary
  :ensure t)

;;; Eshell

(use-package exec-path-from-shell
  :ensure t
  :init
  (exec-path-from-shell-initialize))
