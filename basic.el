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

;; enhancement:
;; ref: https://www.cnblogs.com/aqing1987/p/4464106.html
;; to make it properly executed in tty (i.e. `emacs -nw`)
(defun s-font()
  (interactive)
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      ;;(font-spec :family "Source Han Sans CN" :size 18)))
                      (font-spec :family "Noto Sans Mono CJK SC" :size 14)))
  ;; tune rescale so that Chinese character width = 2 * English character width
  ;; 中文测试 test
  (setq face-font-rescale-alist '(("Noto Mono" . 1.0) ("Noto Sans Mono CJK SC" . 1.23)))
  )
(add-to-list 'after-make-frame-functions
             (lambda (new-frame)
               (select-frame new-frame)
               (if window-system
                   (s-font))))
(if window-system
    (s-font))



;; Switch shell to zsh
;; use `IN_EMACS` env. var. to recognize
;; and to select theme
;; (theme with unicode does not work well due to
;;  the above font settings)
(setenv "IN_EMACS" "1")
(setq shell-file-name "/bin/zsh")

;; from orbitingflea
;; Global keyset
;;(setq shell-file-name "/bin/bash")
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

;; hs-minor-mode
(defun enable-hs ()
  "Enable hs-minor mode and key binding"
  (hs-minor-mode)
  (global-set-key [f9] 'hs-toggle-hiding)
  )

(projectile-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(global-hl-todo-mode)


(with-eval-after-load "tramp"
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))
             

