(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :commands
  (evil-collection-eshell-setup evil-collection-magit-setup))

(use-package eshell
  :defer t
  :config
  (evil-collection-eshell-setup))

(use-package magit
  :defer t
  :config
  (evil-collection-magit-setup))
