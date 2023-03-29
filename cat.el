(defun emacs-config/section (name)
  (concat
   ";;; " name
   "\n\n"
   (with-temp-buffer
     (insert-file-contents (concat (downcase name) ".el"))
     (buffer-string))
   "\n"))

(defun emacs-config/cat-config-files ()
  "Concatenate all configuration into default.el"
  (org-babel-tangle-file "emacs-general.org")
  (org-babel-tangle-file "emacs-theme.org")
  (org-babel-tangle-file "emacs-evil.org")
  (org-babel-tangle-file "emacs-magit.org")
  (org-babel-tangle-file "emacs-vertico.org")
  (org-babel-tangle-file "emacs-corfu.org")
  (org-babel-tangle-file "emacs-eglot.org")
  (org-babel-tangle-file "emacs-org-mode.org")
  (org-babel-tangle-file "emacs-eshell.org")

  (write-region
   (replace-regexp-in-string "\n\\'"
			     ""
			     (concat
			      (emacs-config/section "General")
			      (emacs-config/section "Theme")
			      (emacs-config/section "Evil")
			      (emacs-config/section "Magit")
			      (emacs-config/section "Vertico")
			      (emacs-config/section "Corfu")
			      (emacs-config/section "Eglot")
			      (emacs-config/section "Org")
			      (emacs-config/section "Eshell")))
   nil
   "default.el"))

(emacs-config/cat-config-files)
