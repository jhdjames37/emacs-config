;; c++ mode
(when (member 'cpp my/enabled-lang)
  (load "~/.emacs.d/cpp.el"))

;; Python
(when (member 'python my/enabled-lang)
  (load "~/.emacs.d/python.el"))

;; js-mode
(when (member 'js my/enabled-lang)
  (load "~/.emacs.d/js.el"))

;; rust-mode
(when (member 'rust my/enabled-lang)
  (load "~/.emacs.d/rust.el"))

;; LaTeX mode
(when (member 'latex my/enabled-lang)
  (load "~/.emacs.d/latex.el"))

;; org-mode
(when (member 'org my/enabled-lang)
  (load "~/.emacs.d/org.el"))

;; markdown mode
(when (member 'markdown my/enabled-lang)
  (load "~/.emacs.d/markdown.el"))

;; yaml-mode
(when (member 'yaml my/enabled-lang)
  (use-package yaml-mode
    :config
    (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
    )
  )

(when (member 'dotenv my/enabled-lang)
  (use-package dotenv-mode))

(when (member 'dockerfile my/enabled-lang)
  (use-package dockerfile-mode))

(when (member 'caddyfile my/enabled-lang)
  (use-package caddyfile-mode))

(when (member 'bison my/enabled-lang)
  (use-package bison-mode))
