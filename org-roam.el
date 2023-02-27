;; Org-roam
(use-package org-roam
  :init (setq org-roam-directory (file-truename "~/notes"))
  :config (org-roam-db-autosync-mode))
