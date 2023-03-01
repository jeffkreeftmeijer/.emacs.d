(defun linguist--loaded-message (mode)
  (message (concat "Linguist: Loaded " mode ".")))

(use-package elixir-mode
  :config (linguist--loaded-message "elixir-mode")
  :mode ("mix\\.lock" . elixir-mode)
  :mode ("\\.exs\\'" . elixir-mode)
  :mode ("\\.ex\\'" . elixir-mode)
  :mode ("\\.elixir\\'" . elixir-mode))

(use-package ledger-mode
  :config (linguist--loaded-message "ledger-mode")
  :mode ("\\.ledger\\'" . ledger-mode))

(use-package yaml-mode
  :config (linguist--loaded-message "yaml-mode")
  :mode ("\\.\\(e?ya?\\|ra\\)ml\\'" . yaml-mode))
