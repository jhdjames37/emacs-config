;; C++ Development in Emacs

;; Use lsp-mode + ccls

;; NOTE: Install ccls through your package manager / compile yourself.
(use-package ccls
  :after projectile
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         lsp-deferred)
  :init
  (add-to-list 'lsp-enabled-clients 'ccls)
  )

(use-package cuda-mode)
(use-package cmake-mode)
