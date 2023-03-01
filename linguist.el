(defun linguist--loaded-message (mode)
  (message (concat "Linguist: Loaded " mode ".")))

(use-package yaml-mode
  :config (linguist--loaded-message "yaml-mode")
  :mode ("\\.\\(e?ya?\\|ra\\)ml\\'" . yaml-mode))
