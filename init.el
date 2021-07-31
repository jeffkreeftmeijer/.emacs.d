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

;; Org-roam
(straight-use-package 'org-roam)
(setq org-roam-directory (file-truename "~/notes/"))
(setq org-roam-v2-ack t)
(org-roam-setup)

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

;; Elixir: elixir-mode
(straight-use-package 'elixir-mode)

;; Format Elixir files on save
(add-hook 'elixir-mode-hook
	  (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
