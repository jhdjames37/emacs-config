;; basic.el
;; Basic Config of Emacs

;;(add-to-list 'load-path "~/.emacs.d/")
;; global setting

(setq backup-inhibited t
      inhibit-startup-screen t)
(column-number-mode t)
(show-paren-mode t)
;;(setq show-paren-style 'parentheses)

(fset 'yes-or-no-p 'y-or-n-p)
(global-font-lock-mode t)
(global-linum-mode t)

(load-theme 'tango-dark t)

(setq-default indent-tabs-mode nil)

(tool-bar-mode -1)

(which-key-mode)

;; fonts
(set-face-attribute 'default nil :font "Noto Mono 14")
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    ;;(font-spec :family "Source Han Sans CN" :size 18)))
                    (font-spec :family "Noto Sans Mono CJK SC" :size 18)))

;; Switch shell to zsh
;;(setq shell-file-name "bin/zsh")

;; from orbitingflea
;; Global keyset
(setq shell-file-name "/bin/bash")
(global-set-key [f5] '(lambda () (interactive) (compile "make -k -j8")))
(global-set-key [f7] '(lambda () (interactive) (compile "make clean")))
(global-set-key [f11] 'shell)
(global-set-key [f12] 'treemacs)

;; turn off sound

;; Auto complete via company
;;(global-company-mode t)


;;(setq visible-bell 1)

;; transparent style
(set-frame-parameter (selected-frame) 'alpha (list 85 50))
(add-to-list 'default-frame-alist (cons 'alpha (list 85 50)))

;; All programming modes
(defun enable-programming-modes ()
  "Add all dependencies for programming"
  (lsp)
  (company-mode)
  (flycheck-mode)
  (yas-minor-mode)
  (editorconfig-mode)   
  (editorconfig-apply)
  )
