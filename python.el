;; Python configuration


(use-package python-mode
  :hook
  (python-mode . lsp)
  )

(use-package lsp-jedi
  :ensure t

  :config
  (with-eval-after-load "lsp-mode"
    ;;(add-to-list 'lsp-jedi-python-library-directories "/home/jhdjames37/miniconda3/") ;; Add conda support
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)))

