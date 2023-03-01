;; Hide the top menu bar
(menu-bar-mode -1)

;; Save minibuffer history
(savehist-mode 1)

;; Disable the startup message
(put 'inhibit-startup-echo-area-message 'saved-value t)

(setq
 ;; Disable the startup screen
 inhibit-startup-screen t
 ;; Disable the startup message
 inhibit-startup-echo-area-message (user-login-name)
 ;; Store all backup files in =~/.emacs.d/backups/
 backup-directory-alist '(("." . "~/.emacs.d/backups")))
