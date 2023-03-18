(use-package emacs
  :init
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1))

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
