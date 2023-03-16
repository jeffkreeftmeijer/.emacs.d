(defun linguist--loaded-message (mode)
  (message (concat "Linguist: Loaded " mode ".")))

(use-package dockerfile-mode
  :config (linguist--loaded-message "dockerfile-mode")
  :mode ("\\.dockerfile\\'" . dockerfile-mode)
  :mode ("[/\\]\\(?:Containerfile\\|Dockerfile\\)\\(?:\\.[^/\\]*\\)?\\'" . dockerfile-mode))

(use-package elixir-mode
  :config (linguist--loaded-message "elixir-mode")
  :mode ("mix\\.lock" . elixir-mode)
  :mode ("\\.exs\\'" . elixir-mode)
  :mode ("\\.ex\\'" . elixir-mode)
  :mode ("\\.elixir\\'" . elixir-mode))

(use-package git-modes
  :config (linguist--loaded-message "gitconfig-mode")
  :mode ("/etc/gitconfig\\'" . gitconfig-mode)
  :mode ("/\\.gitmodules\\'" . gitconfig-mode)
  :mode ("/git/config\\'" . gitconfig-mode)
  :mode ("/modules/.*/config\\'" . gitconfig-mode)
  :mode ("/\\.git/config\\'" . gitconfig-mode)
  :mode ("/\\.gitconfig\\'" . gitconfig-mode))

(use-package git-modes
  :config (linguist--loaded-message "gitignore-mode")
  :mode ("/git/ignore\\'" . gitignore-mode)
  :mode ("/info/exclude\\'" . gitignore-mode)
  :mode ("/\\.gitignore\\'" . gitignore-mode))

(use-package ledger-mode
  :config (linguist--loaded-message "ledger-mode")
  :mode ("\\.ledger\\'" . ledger-mode))

(use-package markdown-mode
  :config (linguist--loaded-message "markdown-mode")
  :mode ("\\.\\(?:md\\|markdown\\|mkd\\|mdown\\|mkdn\\|mdwn\\)\\'" . markdown-mode)
  :mode ("\\.mdx\\'" . markdown-mode))

(use-package nix-mode
  :config (linguist--loaded-message "nix-mode")
  :mode ("\\.nix\\'" . nix-mode)
  :mode ("^/nix/store/.+\\.drv\\'" . nix-drv-mode))

(use-package yaml-mode
  :config (linguist--loaded-message "yaml-mode")
  :mode ("\\.\\(e?ya?\\|ra\\)ml\\'" . yaml-mode))
