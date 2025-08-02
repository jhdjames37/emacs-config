
;;; Code:
(setq gc-cons-threshold (* 100 1024 1024))

;; ELPA using TUNA source
(require 'package)

(package-initialize)

;;(if (file-exists-p (expand-file-name "config.el" user-emacs-directory))
;;    (load-file (expand-file-name "config.el" user-emacs-directory))
;;  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

;;(load-file (expand-file-name "config.el" user-emacs-directory))
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

;;; setup load path
;;(add-to-list 'load-path "~/.emacs.d/")

;; Specific language settings
;;(load "~/.emacs.d/lang.el")

(setq gc-cons-threshold (* 10 1024 1024))
