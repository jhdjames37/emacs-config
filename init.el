
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; ELPA using TUNA source
(require 'package)
(setq package-archives
      '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;        ("melpa-stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
      ))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cargo rust-mode cmake-mode dotenv-mode all-the-icons-dired xref dired-git yaml-mode bison-mode dockerfile-mode cuda-mode editorconfig format-all web-mode magit ein use-package flycheck lsp-jedi treemacs-projectile ccls lsp-treemacs lsp-ui projectile treemacs which-key lsp-mode typescript-mode company-jedi company-auctex company-c-headers company-math yasnippet company-irony irony company auctex))
 '(warning-suppress-log-types '((jedi)))
 '(warning-suppress-types '((lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; basic
(load "~/.emacs.d/basic.el")

;; markdown mode
(load "~/.emacs.d/markdown.el")

;; c++ mode
(load "~/.emacs.d/cpp.el")


;; LaTeX mode
(load "~/.emacs.d/latex.el")

;; org-mode
(load "~/.emacs.d/org.el")

;; Python
(load "~/.emacs.d/python.el")

;; Company-mode
(load "~/.emacs.d/company.el")

;; js-mode
(load "~/.emacs.d/js.el")

;; lsp-mode
(load "~/.emacs.d/lsp.el")

;; package config
;; (load "~/.emacs.d/package.el")


;;(add-hook 'tetris-mode-hook '(lambda () (linum-mode 0)))
;;(eval-after-load 'tetris '(load "~/.emacs.d/tetris/main.el"))

;; yaml-mode

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))



