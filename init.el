
;;; Code:
(setq gc-cons-threshold (* 100 1024 1024))

;; ELPA using TUNA source
(require 'package)
(setq package-archives
      '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;        ("melpa-stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
      ))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package delight :ensure t)
(use-package use-package-ensure-system-package :ensure t)

(use-package cus-edit
  :ensure nil
  :custom (custom-file (expand-file-name "custom.el" user-emacs-directory))
  :config
  (when (file-exists-p custom-file)
    (load custom-file t))
)

;; Basic settings
(load "~/.emacs.d/basic.el")

;; Environment setup
(load "~/.emacs.d/setup.el")

;; lsp-mode
(load "~/.emacs.d/lsp.el")

;; Company-mode
(load "~/.emacs.d/company.el")

;; Below are specific modes


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

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
