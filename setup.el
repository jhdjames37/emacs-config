;;; setup.el ---- General packages setup
;;; Commentary:

;;; Code:

(require 'settings)

;;; Projectile
(use-package projectile
  :hook
  (prog-mode . projectile-mode)
  :bind
  ("C-c P" . projectile-command-map)
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

(use-package winner
  :ensure nil
  :config (winner-mode))

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
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this)
  )

;; hs-minor-mode
(defun enable-hs ()
  "Enable hs-minor mode and key binding."
  (hs-minor-mode)
  (global-set-key [f9] 'hs-toggle-hiding)
  )

(add-hook 'prog-mode-hook 'enable-hs)

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

(when (not my/use-builtin-theme)
  (use-package doom-themes
    :config
    ;; SEE: https://github.com/doomemacs/themes/tree/screenshots for more choices
    (load-theme 'doom-fairy-floss t)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (select-frame frame)
                (load-theme 'doom-fairy-floss t)))
    (doom-themes-org-config)
    (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
    (doom-themes-treemacs-config)
    
    (when (not (window-system))
      ;; no background color is provided in terminal
      ;; so we need to force it to be no background
      ;;(set-background-color )
      )
    )
  
  ;; NOTE: RUN `nerd-icons-install-fonts` in the first run.
  (use-package doom-modeline
    :ensure t
    :init (doom-modeline-mode 1)
    :custom
    (doom-modeline-icon (display-graphic-p))
    (doom-modeline-minor-modes t)
    )

  (use-package minions
    :config (minions-mode 1))
  )


(use-package solaire-mode
  :defer 0.1
  :custom (solaire-mode-remap-fringe t)
  :config (solaire-global-mode)
  ;; https://github.com/hlissner/emacs-solaire-mode/issues/51
  (push '(treemacs-window-background-face . solaire-default-face) solaire-mode-remap-alist)
  (push '(treemacs-hl-line-face . solaire-hl-line-face) solaire-mode-remap-alist)
  )

(use-package dashboard
  ;;:hook
  ;;(dashboard-mode . emacs-lock-mode)
  :custom
  (dashboard-center-content t)
  (dashboard-startup-banner 'logo)
  (dashboard-set-file-icons t)
  (dashboard-items '((recents  . 10)
                     (bookmarks . 3)
                     (projects . 3)
                     (agenda . 5)
                     ))
  (dashboard-set-footer nil)
  (initial-buffer-choice (lambda ()
                           ;;(dashboard-refresh-buffer)
                           (get-buffer-create "*dashboard*")))
  :config
  (dashboard-setup-startup-hook)
  (add-hook 'after-make-frame-functions
            (lambda (frame)
              (select-frame frame)
              (dashboard-refresh-buffer))
            )
  )

(use-package treemacs
  :ensure t
  :bind
  ([f12] . treemacs)
  ("M-o" . treemacs-select-window)
  :hook
  (treemacs-mode . (lambda () (display-line-numbers-mode 0)))
  
  )
(use-package treemacs-projectile
  :after (treemacs projectile))
(use-package treemacs-magit
  :after (treemacs magit))

(use-package magit)

(use-package which-key
  :init (which-key-mode))

(use-package ibuffer
  :ensure nil
  :after dashboard
  :preface
  (defvar protected-buffers '("*scratch*" "*Messages*")
    "Buffer that cannot be killed.")

  (defun my/protected-buffers ()
    "Protect some buffers from being killed."
    (dolist (buffer protected-buffers)
      (with-current-buffer buffer
        (emacs-lock-mode 'kill))))
  :bind ("C-x C-b" . ibuffer)
  :config (my/protected-buffers))

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom ((highlight-indent-guides-method 'bitmap)
           (highlight-indent-guides-auto-enabled nil))
  :config
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray")
  )

(use-package recentf
  :ensure nil
  :bind ("C-x C-r" . recentf-open-files)
  :init (recentf-mode)
  :custom
  (recentf-exclude (list "/scp:"
                         "/ssh:"
                         "/sudo:"
                         "/tmp/"
                         "~$"
                         "COMMIT_EDITMSG"
                         "~/.emacs.d/recentf"
                         "~/.emacs.d/bookmarks"))
  (recentf-max-menu-items 15)
  (recentf-max-saved-items 200)
  ;; Save recent files every 5 minutes to manage abnormal output.
  :config (run-at-time nil (* 5 60) 'recentf-save-list))

(use-package pdf-tools
  :magic ("%PDF" . pdf-view-mode)
  :init (pdf-tools-install :no-query)
  :hook (pdf-view-mode . (lambda () (display-line-numbers-mode -1)))
  )

(use-package pdf-view
  :ensure nil
  :after pdf-tools
  :bind (:map pdf-view-mode-map
              ("C-s" . isearch-forward)
              ("d" . pdf-annot-delete)
              ("h" . pdf-annot-add-highlight-markup-annotation)
              ("t" . pdf-annot-add-text-annotation))
  :custom
  (pdf-view-display-size 'fit-page)
  (pdf-view-resize-factor 1.1)
  ;; Avoid searching for unicodes to speed up pdf-tools.
  (pdf-view-use-unicode-ligther nil)
  ;; Enable HiDPI support, at the cost of memory.
  (pdf-view-use-scaling t))

;; better word wrap
;; see https://ruib.in/posts/enable-line-wrapping-for-org-mode/
;; (use-package visual-fill-column
;;   :hook
;;   (text-mode . visual-fill-column-mode)
;;   (text-mode . (lambda ()
;;                  (toggle-truncate-lines -1)
;;                  (set-fill-column 80)
;;                  ))

;;   )

(use-package keychain-environment
  :config
  (keychain-refresh-environment)
  )

(use-package deadgrep)

(defvar use-lsp-frontend 'lsp-mode)

(use-package eat
  :bind
  ("<f11>" . eat))

;; I don't know whether it works
;;(use-package clipetty
;;  :init
;;  (unless (display-graphic-p)
;;    (global-clipetty-mode)
;;    ))

;; lsp-mode
(cl-case use-lsp-frontend
  (lsp-mode (load "~/.emacs.d/lsp.el"))
  (eglot (load "~/.emacs.d/eglot.el")))

;; Company-mode
(load "~/.emacs.d/company.el")

;; Dired related
(load "~/.emacs.d/dired.el")

(load "~/.emacs.d/hydra.el")

;; Remote server settings
(when (file-exists-p "~/.emacs.d/remote.el")
  (load "~/.emacs.d/remote.el"))

(provide 'setup)
;;; Setup.el ends here
