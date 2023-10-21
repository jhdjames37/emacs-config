
;;; Code:
(setq gc-cons-threshold (* 100 1024 1024))

;; ELPA using TUNA source
(require 'package)
(setq package-archives
      '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa-stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")
        ("non-gnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
        ;;("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
      ))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Remove use of deprecated package `cl`
;; See: https://discourse.doomemacs.org/t/warning-at-startup-package-cl-is-deprecated/60/5
;;(use-package cl-libify)


(use-package delight :ensure t)
(use-package use-package-ensure-system-package :ensure t)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package cus-edit
  :ensure nil
  :custom (custom-file (expand-file-name "custom.el" user-emacs-directory))
  :config
  (when (file-exists-p custom-file)
    (load custom-file t))
  )

;; Custom vars
(load "~/.emacs.d/settings.el")

;; Basic settings
(load "~/.emacs.d/basic.el")

;; Environment setup
(load "~/.emacs.d/setup.el")

;; Specific language settings
(load "~/.emacs.d/lang.el")
