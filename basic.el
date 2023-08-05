;; Basic configs

(setq-default
 backup-inhibited t          
 inhibit-startup-screen t    
 indent-tabs-mode nil
 )

;; common modes
(column-number-mode t)
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(global-font-lock-mode t)
(global-linum-mode t)
(load-theme 'tango-dark t)
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
(global-set-key (kbd "M-o") 'treemacs-select-window)

;; turn off sound

;; Auto complete via company

;;(setq visible-bell 1)

;; transparent style
(set-frame-parameter (selected-frame) 'alpha (list 85 50))
(add-to-list 'default-frame-alist (cons 'alpha (list 85 50)))
