;; Package management: straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Vim emulation: evil
(straight-use-package 'evil)
(evil-mode 1)

;; Vim bindings for plugins: evil-collection
(straight-use-package 'evil-collection)
(evil-collection-init)

;; Comment stuff out: Evil commentary
(straight-use-package 'evil-commentary)
(evil-commentary-mode)

;; GitHub-flavored Markdown Org exporter: ox-gfm
(straight-use-package 'ox-gfm)

;; Syntax highlighted HTML exports for code blocks: htmlize
(straight-use-package 'htmlize)

;; Don't include default stylesheet in Org HTML export
(setq org-html-head-include-default-style nil)

;; Org-roam
(straight-use-package 'org-roam)
(setq org-roam-directory (file-truename "~/notes/"))
(setq org-roam-v2-ack t)
(org-roam-setup)

(straight-use-package 'websocket)

(straight-use-package
 '(org-roam-ui :host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out")))

;; Add "shell" to Babel's code execution languages.
(org-babel-do-load-languages 'org-babel-load-languages '((shell . t)))

;; Don't warn when evaluating code blocks.
(setq org-confirm-babel-evaluate nil)

;; Completions: Ivy
(straight-use-package 'ivy)
(ivy-mode 1)

(setq ivy-use-selectable-prompt t)

;; Completions: Ivy
(straight-use-package 'counsel)

;; Spell checking: Flyspell
(add-hook 'text-mode-hook 'flyspell-mode)

;; Git: magit
(straight-use-package 'magit)

;; Language server client: Eglot
(straight-use-package 'eglot)

;; Elixir: elixir-mode
(straight-use-package 'elixir-mode)

;; Format Elixir files on save
(add-hook 'elixir-mode-hook
	  (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))

;; Add elixir-ls to Eglot's server programs list
;;(add-to-list 'eglot-server-programs '(elixir-mode "~/.emacs.d/elixir-ls/release/language_server.sh"))

;; Copy and paste: xclip
(straight-use-package 'xclip)
(xclip-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-roam-mode-section-functions
   '(org-roam-backlinks-section org-roam-reflinks-section org-roam-unlinked-references-section))
 '(safe-local-variable-values
   '((eval add-hook 'after-save-hook
	   (lambda nil
	     (org-babel-tangle))
	   nil t)
     (eval add-hook 'after-save-hook
	   (lambda nil
	     (load "~/.emacs.d/hacks/ox-md-with-title.el")
	     (org-gfm-export-to-markdown))
	   nil t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Feed reader: elfeed
(straight-use-package 'elfeed)
