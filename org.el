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

;;; Org-roam

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
