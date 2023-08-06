;; c++ mode
(load "~/.emacs.d/cpp.el")

;; Python
(load "~/.emacs.d/python.el")

;; js-mode
(load "~/.emacs.d/js.el")

;; rust-mode
(load "~/.emacs.d/rust.el")

;; LaTeX mode
(load "~/.emacs.d/latex.el")

;; org-mode
(load "~/.emacs.d/org.el")

;; markdown mode
(load "~/.emacs.d/markdown.el")

;; yaml-mode

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  )

(use-package dotenv-mode)
(use-package dockerfile-mode)
(use-package caddyfile-mode)
(use-package bison-mode)
