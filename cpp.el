;; C++ Development in Emacs

;; Use lsp-mode + ccls

(defun cpp-basic-enable ()
  "cpp basic config, incl. hs-minor-mode"
  (enable-hs)
  )

(add-hook 'c-mode-common-hook 'enable-programming-modes)

(add-hook 'c-mode-common-hook
          '(lambda ()
             (require 'ccls)
             (add-to-list 'lsp-enabled-clients 'ccls)
             ;(add-to-list 'lsp-enabled-clients 'ccls-remote)
             ))
(add-hook 'c-mode-common-hook 'cpp-basic-enable)

(use-package ccls)

(lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "ccls")
                     :major-modes '(c++-mode)
                     :remote? t
                     :server-id 'ccls-remote
                     :multi-root nil
                     :notification-handlers
                     (lsp-ht ("$ccls/publishSkippedRanges" #'ccls--publish-skipped-ranges)
                             ("$ccls/publishSemanticHighlight" #'ccls--publish-semantic-highlight))
                     :initialization-options (lambda () ccls-initialization-options)
                     :library-folders-fn ccls-library-folders-fn
                     ))

