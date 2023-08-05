(use-package rust-mode
  :hook (rust-mode . lsp-deferred)
  :hook (rust-mode . enable-hs)
  :init
  (add-to-list 'lsp-enabled-clients 'rust-analyzer)  
  )
