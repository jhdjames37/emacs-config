;; Basic configs

(require 'settings)

(setq-default
 backup-inhibited t          
 inhibit-startup-screen t    
 indent-tabs-mode nil
 )

(setq
 word-wrap-by-category t ;; see https://emacs-china.org/t/topic/2616/25
 )

;; common modes
(column-number-mode t)
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(global-font-lock-mode t)
;; It seems that in Emacs 29.1, linum-mode has been removed
;;(global-linum-mode t)
;; use display-line-numbers-mode instead
(global-display-line-numbers-mode)
(when my/use-builtin-theme
  (load-theme 'tango-dark t)
  )
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode)

;; fonts
(defun set-default-font ()
  (set-face-attribute 'default nil :font "Noto Sans Mono 14")
  )
(set-default-font)
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
  (setq face-font-rescale-alist '(("Noto Sans Mono CJK SC" . 1.3)))
  )

;; setup font in client mode
(add-to-list 'after-make-frame-functions
             (lambda (new-frame)
               (select-frame new-frame)
               (set-default-font)
               (if window-system
                   (s-font))))
(if window-system
    (s-font))



;; Switch shell to zsh
;; use `IN_EMACS` env. var. to recognize
;; and to select theme
;; (theme with unicode does not work well due to
;;  the above font settings)
(when my/use-zsh
  (progn
    (setenv "IN_EMACS" "1")
    ;; lsp-mode accidentally use `shell-file-name` to identify remote shells
    ;; which is not desired.
    ;; https://github.com/emacs-lsp/lsp-mode/blob/master/lsp-mode.el#L7392
    (setenv "ESHELL" "/bin/zsh")
    ;;(setq shell-file-name "/bin/zsh")
    ))

;; from orbitingflea
;; Global keyset
;;(setq shell-file-name "/bin/bash")
(global-set-key [f5] #'(lambda () (interactive) (compile "make -k -j")))
(global-set-key [f7] #'(lambda () (interactive) (compile "make clean")))
(global-set-key [f11] 'shell)



;; turn off sound

;; Auto complete via company

;;(setq visible-bell 1)

;; transparent style
(set-frame-parameter (selected-frame) 'alpha (list 90 90))
(add-to-list 'default-frame-alist (cons 'alpha (list 90 90)))

;; Terminal mouse integration
;; Reference: https://www.gnu.org/software/emacs/manual/html_node/emacs/Text_002dOnly-Mouse.html
;; https://stackoverflow.com/questions/18198387/how-do-i-mouse-scroll-in-emacs-in-the-terminal-i-havent-gotten-mouse-wheel-mod
;; `gpm' may not properly setup, use xterm-mouse-mode instead
;; TODO: add checks
(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
  )
