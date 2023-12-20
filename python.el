;; Python configuration

(when (and (version<= "29.1" emacs-version)
           (treesit-available-p)
           (treesit-language-available-p 'python))
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
  )


(use-package python-mode
  :hook
  ((python-mode python-ts-mode) . lsp)
  )

;; NOTE: run `jedi:install-server` in the first run
;; NOTE: Install jedi-language-server through pip (or other package manager)
(use-package lsp-jedi
  :ensure t

  :config
  (with-eval-after-load "lsp-mode"
    ;;(add-to-list 'lsp-jedi-python-library-directories "/home/jhdjames37/miniconda3/") ;; Add conda support
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)
    (add-to-list 'lsp-enabled-clients 'pyls-tramp)
    (add-to-list 'lsp-enabled-clients 'jedi-tramp)
    ))

(use-package company-jedi
  :after lsp-jedi)

;; (lsp-register-client
;;     (make-lsp-client :new-connection (lsp-tramp-connection "pylsp")
;;                      :major-modes '(python-mode python-ts-mode)
;;                      :remote? t
;;                      :server-id 'pyls-remote))


;; (add-to-list 'lsp-enabled-clients 'pyls-remote)
(use-package jupyter)
