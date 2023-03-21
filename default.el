(use-package emacs
  :init
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
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
  (evil-collection-eshell-setup evil-collection-magit-setup))

(use-package eshell
  :defer t
  :config
  (evil-collection-eshell-setup))

(use-package magit
  :ensure t
  :defer t
  :config
  (evil-collection-magit-setup))

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1))

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
