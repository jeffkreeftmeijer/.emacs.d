(use-package emacs
  :init
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (setq initial-scratch-message nil)
  (set-face-attribute 'default nil :font "SF Mono-15"))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :commands
  (evil-collection-dired-setup
   evil-collection-eshell-setup
   evil-collection-magit-setup
   evil-collection-org-setup
   evil-collection-org-roam-setup
   evil-collection-vertico-setup))

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

(use-package magit
  :ensure t
  :defer t)

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

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  :custom
  (corfu-auto t))

(use-package emacs
  :custom
  (org-babel-load-languages '((emacs-lisp . t)
			      (shell . t))))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-directory (file-truename "~/notes"))
  :commands
  (org-roam-node-find)
  :config
  (org-roam-db-autosync-mode))

(use-package citeproc
  :ensure t
  :defer t)

(use-package elixir-mode
  :ensure t
  :mode ("mix\\.lock" . elixir-mode)
  :mode ("\\.exs\\'" . elixir-mode)
  :mode ("\\.ex\\'" . elixir-mode)
  :mode ("\\.elixir\\'" . elixir-mode))

(use-package eglot
  :ensure t
  :hook
  (elixir-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(elixir-mode "elixir-ls")))
