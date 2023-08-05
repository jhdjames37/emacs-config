;; C++ Development in Emacs

;; Use lsp-mode + ccls

(use-package ccls
  :after projectile
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         lsp-deferred)
  :init
  (add-to-list 'lsp-enabled-clients 'ccls)
  )
