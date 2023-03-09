
(add-hook 'rust-mode-hook 'enable-programming-modes)

(add-hook 'rust-mode-hook
          #'(lambda ()
              (add-to-list 'lsp-enabled-clients 'rust-analyzer)
              (enable-hs)
              )
          )

