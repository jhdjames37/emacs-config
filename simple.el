;; This is a simplified config for cases such as contests or exams
;; No network possible, so there's no external packages.

;; from most important to least important
(global-set-key [f5] #'(lambda () (interactive) (compile "make -k -j")))
(global-set-key [f11] 'shell)

(global-linum-mode t)
;; or maybe in Emacs 29 or higher
;; (global-display-line-numbers-mode)
(load-theme 'tango-dark t)
(show-paren-mode t)
(column-number-mode t)

(global-set-key [f9] 'hs-toggle-hiding)
(add-hook 'c-mode-common-hook 'hs-minor-mode)

(setq-default indent-tabs-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(set-face-attribute 'default nil :font "Ubuntu Mono 16")
(tool-bar-mode -1)
