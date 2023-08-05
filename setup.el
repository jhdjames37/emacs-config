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

(use-package yasnippets
  :after company
  :hook (prog-mode . yas-minor-mode)
  :init
  (add-to-list 'company-backends '(company-capf :with company-yasnippet))
  )

(use-package editorconfig
  :hook (prog-mode . editorconfig-mode)
  )

(provide 'setup)
;;; Setup.el ends here
