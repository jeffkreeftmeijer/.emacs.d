;;; Evil

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
