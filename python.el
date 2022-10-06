;; Python configuration

(defun python-basic-enable ()
  "cpp basic config, incl. hs-minor-mode"
  (hs-minor-mode)
  (global-set-key [f9] 'hs-toggle-hiding)
  (setq jedi:complete-on-dot 1)
  )



(add-hook 'python-mode-hook 'enable-programming-modes)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'python-basic-enable)

(use-package lsp-jedi
  :ensure t
  :config
  (with-eval-after-load "lsp-mode"
    ;;(add-to-list 'lsp-jedi-python-library-directories "/home/jhdjames37/miniconda3/") ;; Add conda support
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)))

