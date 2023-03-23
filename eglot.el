(use-package eglot
  :ensure t
  :hook
  (elixir-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(elixir-mode "elixir-ls")))
