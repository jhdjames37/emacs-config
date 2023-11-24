;; C++ Development in Emacs

;; Treesitter intergration

(when (and (version<= "29.1" emacs-version)
           (treesit-available-p)
           (treesit-language-available-p 'cpp))
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
  )

(when (and (version<= "29.1" emacs-version)
           (treesit-available-p)
           (treesit-language-available-p 'c))
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  )

;; Use lsp-mode + ccls

;; NOTE: Install ccls through your package manager / compile yourself.
(use-package ccls
  :after projectile
  :hook ((c-mode c++-mode objc-mode cuda-mode c-ts-mode c++-ts-mode) .
         lsp-deferred)
  :init
  (add-to-list 'lsp-enabled-clients 'ccls)
  (add-to-list 'lsp-enabled-clients 'ccls-tramp)
  (add-to-list 'lsp-enabled-clients 'clangd-tramp)
  )

;;(use-package cuda-mode)
(use-package cmake-mode)

;; (with-eval-after-load 'lsp-mode
;;   (progn
;;     (require 'lsp)
;;     (lsp-register-client
;;      (make-lsp-client :new-connection (lsp-tramp-connection
;;                                        '("clangd" "--log=verbose"))
;;                                        ;;'("bash" "/home/jhd/1.sh"))
;;                       :major-modes '(c-mode c++-mode c-ts-mode c++-ts-mode)
;;                       :remote? t
;;                       :server-id 'clangd-remote))

;;     (lsp-register-client
;;      (make-lsp-client :new-connection (lsp-tramp-connection "ccls")
;;                       :major-modes '(c-mode c++-mode c-ts-mode c++-ts-mode)
;;                       :remote? t
;;                       :server-id 'ccls-remote))
    
    
;;     (add-to-list 'lsp-enabled-clients 'clangd-remote)
;;     (add-to-list 'lsp-enabled-clients 'ccls-remote)
;;     (add-to-list 'lsp-enabled-clients 'ccls-test)
;;     ))
