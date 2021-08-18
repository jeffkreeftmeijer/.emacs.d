;; Hide the top menu bar
(menu-bar-mode -1)

;; Save minibuffer history
(savehist-mode 1)

(setq
 ;; Disable the startup screen
 inhibit-startup-screen t
 ;; Disable the startup message
 inhibit-startup-echo-area-message t
 ;; Store all backup files in =~/.emacs.d/backups/
 backup-directory-alist '(("." . "~/.emacs.d/backups")))
