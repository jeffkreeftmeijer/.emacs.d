;; Org-roam
(use-package org-roam
  :init
  (setq org-roam-directory (file-truename "~/notes"))
  :config
  (org-roam-db-autosync-mode)
  :custom
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :target (file+head "${slug}.org" "#+title: ${title}\n#+date: %<%Y-%m-%d>")
      :unnarrowed t))))
