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

(use-package avy
  :bind (("M-g f" . avy-goto-line)
         ("M-g w" . avy-goto-word-1)
         ("M-g e" . avy-goto-word-0)
         )
  )

(use-package winner
  :ensure nil
  :config (winner-mode))

;; iedit-mode
(use-package iedit
  :bind (("C-:" . iedit-mode)))

(use-package smart-hungry-delete
  :ensure t
  :bind (([remap backward-delete-char-untabify] . smart-hungry-delete-backward-char)
	 ([remap delete-backward-char] . smart-hungry-delete-backward-char)
	 ([remap delete-char] . smart-hungry-delete-forward-char))
  :init (smart-hungry-delete-add-default-hooks)
  )

;; tramp
                                        ;(with-eval-after-load "tramp"
                                        ;  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

;; helm
(when (eq my/minibuffer-backend 'helm)
  (use-package helm
    :bind (("M-x" . helm-M-x)
           ("C-x C-f" . helm-find-files)
           )
    :config (helm-mode 1)
    )
  (use-package helm-lsp
    :after (helm lsp))
  )

;; Alternatively, vertico
(when (eq my/minibuffer-backend 'vertico)
  (use-package vertico
    :init (vertico-mode)
    :bind (:map vertico-map
                ("C-<backspace>" . vertico-directory-up)
                ("C-l" . vertico-directory-up)
                ("RET" . vertico-directory-enter)
                )
    :custom (vertico-cycle t)
    :config
    (vertico-multiform-mode)
    (add-to-list 'vertico-multiform-categories '(embark-keybinding grid))
    )
  
  (use-package marginalia
    :init (marginalia-mode))
  (use-package embark
    :bind
    (("C-." . embark-act)
     ("C-," . embark-dwim)
     ("C-h B" . embark-bindings))

    :custom
    (embark-indicators
     '(embark-minimal-indicator  ; default is embark-mixed-indicator
       embark-highlight-indicator
       embark-isearch-highlight-indicator))
    (embark-help-key "?") ; All typical moving & searching commands are available.
    )

  ;; Consult users will also want the embark-consult package.
  (use-package embark-consult
    :hook
    (embark-collect-mode . consult-preview-at-point-mode))

  ;; Example configuration for Consult
  (use-package consult
    ;; Replace bindings. Lazily loaded by `use-package'.
    :bind (;; C-c bindings in `mode-specific-map'
           ("C-c M-x" . consult-mode-command)
           ("C-c h" . consult-history)
           ("C-c k" . consult-kmacro)
           ("C-c m" . consult-man)
           ("C-c i" . consult-info)
           ([remap Info-search] . consult-info)
           ;; C-x bindings in `ctl-x-map'
           ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
           ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
           ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
           ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
           ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
           ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
           ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
           ;; Custom M-# bindings for fast register access
           ("M-#" . consult-register-load)
           ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
           ("C-M-#" . consult-register)
           ;; Other custom bindings
           ("M-y" . consult-yank-pop)                ;; orig. yank-pop
           ;; M-g bindings in `goto-map'
           ("M-g e" . consult-compile-error)
           ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
           ("M-g g" . consult-goto-line)             ;; orig. goto-line
           ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
           ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
           ("M-g m" . consult-mark)
           ("M-g k" . consult-global-mark)
           ("M-g i" . consult-imenu)
           ("M-g I" . consult-imenu-multi)
           ;; M-s bindings in `search-map'
           ("M-s d" . consult-find)                  ;; Alternative: consult-fd
           ("M-s c" . consult-locate)
           ("M-s g" . consult-grep)
           ("M-s G" . consult-git-grep)
           ("M-s r" . consult-ripgrep)
           ("M-s l" . consult-line)
           ("M-s L" . consult-line-multi)
           ("M-s k" . consult-keep-lines)
           ("M-s u" . consult-focus-lines)
           ;; Isearch integration
           ("M-s e" . consult-isearch-history)
           :map isearch-mode-map
           ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
           ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
           ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
           ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
           ;; Minibuffer history
           :map minibuffer-local-map
           ("M-s" . consult-history)                 ;; orig. next-matching-history-element
           ("M-r" . consult-history))                ;; orig. previous-matching-history-element

    ;; Enable automatic preview at point in the *Completions* buffer. This is
    ;; relevant when you use the default completion UI.
    :hook (completion-list-mode . consult-preview-at-point-mode)

    ;; The :init configuration is always executed (Not lazy)
    :init

    ;; Optionally configure the register formatting. This improves the register
    ;; preview for `consult-register', `consult-register-load',
    ;; `consult-register-store' and the Emacs built-ins.
    (setq register-preview-delay 0.5
          register-preview-function #'consult-register-format)

    ;; Optionally tweak the register preview window.
    ;; This adds thin lines, sorting and hides the mode line of the window.
    (advice-add #'register-preview :override #'consult-register-window)

    ;; Use Consult to select xref locations with preview
    (setq xref-show-xrefs-function #'consult-xref
          xref-show-definitions-function #'consult-xref)

    ;; Configure other variables and modes in the :config section,
    ;; after lazily loading the package.
    :config

    ;; Optionally configure preview. The default value
    ;; is 'any, such that any key triggers the preview.
    ;; (setq consult-preview-key 'any)
    ;; (setq consult-preview-key "M-.")
    ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
    ;; For some commands and buffer sources it is useful to configure the
    ;; :preview-key on a per-command basis using the `consult-customize' macro.
    (consult-customize
     consult-theme :preview-key '(:debounce 0.2 any)
     consult-ripgrep consult-git-grep consult-grep
     consult-bookmark consult-recent-file consult-xref
     consult--source-bookmark consult--source-file-register
     consult--source-recent-file consult--source-project-recent-file
     ;; :preview-key "M-."
     :preview-key '(:debounce 0.4 any))

    ;; Optionally configure the narrowing key.
    ;; Both < and C-+ work reasonably well.
    (setq consult-narrow-key "<") ;; "C-+"

    ;; Optionally make narrowing help available in the minibuffer.
    ;; You may want to use `embark-prefix-help-command' or which-key instead.
    ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
    )

  (use-package orderless
    :ensure t
    :custom
    (completion-styles '(orderless basic))
    (completion-category-overrides '((file (styles basic partial-completion)))))
  )



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
  :bind
  ("C-c d" . dashboard-open)
  :init
  (setq initial-buffer-choice 'dashboard-open)
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

  :config
  (dashboard-setup-startup-hook)
  ;;(add-hook 'after-make-frame-functions
                                        ;          (lambda (frame)
                                        ;            (select-frame frame)
                                        ;            (dashboard-refresh-buffer))
                                        ;          )
  )

(use-package treemacs
  :ensure t
  :bind
  ([f12] . treemacs)
  ("M-o" . treemacs-select-window)
  :hook
  (treemacs-mode . (lambda () (display-line-numbers-mode 0)))
  :config
  (treemacs-project-follow-mode)
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

(use-package deadgrep
  :bind
  ("<f6>" . deadgrep))

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

;; Copilot
(when (file-exists-p "~/.emacs.d/deps/copilot/copilot.el")
  (add-to-list 'load-path "~/.emacs.d/deps/copilot/")
  (require 'copilot)
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
  )

(use-package keyfreq
  :init
  (keyfreq-mode)
  (keyfreq-autosave-mode)
  :custom
  (keyfreq-file "~/.emacs.d/keyfreq")
  (keyfreq-file-lock "~/.emacs.d/keyfreq.lock")
  )

;; Guess and adjust indent styles.
(use-package dtrt-indent
  :init
  (dtrt-indent-global-mode))

(use-package undo-fu
  :config
  (setq undo-limit 400000           ; 400kb (default is 160kb)
        undo-strong-limit 3000000   ; 3mb   (default is 240kb)
        undo-outer-limit 48000000)  ; 48mb  (default is 24mb)
  :bind
  (([remap undo] . undo-fu-only-undo)
   ("C-?" . undo-fu-only-redo)
   )
  )

(use-package vundo)

(use-package persp-mode
  :disabled
  :config
  (setq wg-morph-on nil) ;; switch off animation
  (setq persp-autokill-buffer-on-remove 'kill-weak)
  (add-hook 'window-setup-hook #'(lambda () (persp-mode 1)))
  )


(use-package atomic-chrome
  :init
  (atomic-chrome-start-server)
  )

(provide 'setup)
;;; Setup.el ends here
