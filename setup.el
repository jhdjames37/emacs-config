;;; setup.el ---- General packages setup
;;; Commentary:

;;; Code:

;;; Projectile
(use-package projectile
  :hook
  (prog-mode . projectile-mode)
  :bind
  ("C-c p" . projectile-command-map)
  )

;; Prettify display
(use-package faces
  :ensure nil
  :custom (show-paren-delay 0)
  :config
  (set-face-background 'show-paren-match "#161719")
  (set-face-bold 'show-paren-match t)
  (set-face-foreground 'show-paren-match "#ffffff"))


(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode)
  )

(use-package hl-todo
  :config
  (global-hl-todo-mode)
  )

;; ACE-window
(use-package ace-window
  :bind ("C-x o" . ace-window)
  :init (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  )

;; iedit-mode
(use-package iedit)

;; tramp
;(with-eval-after-load "tramp"
;  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))
             
;; helm
(use-package helm
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         )
  :config (helm-mode 1)
  )
(use-package helm-lsp
  :after (helm lsp))

;; multiple cursors
(use-package multiple-cursors
  :bind ("C-S-c C-S-c" . mc/edit-lines)
  )

;; hs-minor-mode
(defun enable-hs ()
  "Enable hs-minor mode and key binding."
  (hs-minor-mode)
  (global-set-key [f9] 'hs-toggle-hiding)
  )

(use-package flycheck
  :hook (prog-mode . flycheck-mode))

(use-package yasnippet
  :after company
  :hook (prog-mode . yas-minor-mode)
  :init
  (add-to-list 'company-backends '(company-capf :with company-yasnippet))
  )

(use-package editorconfig
  :hook (prog-mode . editorconfig-mode)
  )

;; NOTE: RUN `all-the-icons-install-fonts` in the first run.
(use-package doom-themes
  :config
  ;; SEE: https://github.com/doomemacs/themes/tree/screenshost for more choices
  (load-theme 'doom-moonlight t)
  (doom-themes-org-config)
  (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  )


;; NOTE: RUN `nerd-icons-install-fonts` in the first run.
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-icon (display-graphic-p))
  )

(use-package treemacs
  :ensure t
  :bind
  ([f12] . treemacs)
  ("M-o" . treemacs-select-window)
  :hook
  (treemacs-mode . (lambda () (linum-mode 0)))
  
  )
(use-package treemacs-projectile
  :after treemacs)
(use-package treemacs-magit
  :after (treemacs magit))

(use-package magit)

(use-package which-key
  :init (which-key-mode))

(use-package ibuffer
  :ensure nil
  :preface
  (defvar protected-buffers '("*scratch*" "*Messages*")
    "Buffer that cannot be killed.")

  (defun my/protected-buffers ()
    "Protect some buffers from being killed."
    (dolist (buffer protected-buffers)
      (with-current-buffer buffer
        (emacs-lock-mode 'kill))))
  :bind ("C-x C-b" . ibuffer)
  :init (my/protected-buffers))

;; lsp-mode
(load "~/.emacs.d/lsp.el")

;; Company-mode
(load "~/.emacs.d/company.el")

;; Dired related
(load "~/.emacs.d/dired.el")


(provide 'setup)
;;; Setup.el ends here
