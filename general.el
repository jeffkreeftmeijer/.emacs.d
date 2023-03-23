;;; General configuration

(use-package emacs
  :init
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (setq initial-scratch-message nil)
  (set-face-attribute 'default nil :font "SF Mono-15"))
