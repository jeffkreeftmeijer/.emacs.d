(use-package org
  :custom
  (org-cycle-separator-lines -1)
  (org-agenda-files (directory-files-recursively "~/notes/" "\\.org$"))
  (org-babel-load-languages '((emacs-lisp . t)
                              (shell . t))))

(use-package org-gtd
  :init
  (setq org-gtd-update-ack "2.1.0"))

(use-package org-auto-tangle
  :hook
  (org-mode . org-auto-tangle-mode)
  :custom
  (org-auto-tangle-default t))
