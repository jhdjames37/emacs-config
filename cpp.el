;; C++ Development in Emacs

;; Use lsp-mode + ccls

(defun cpp-basic-enable ()
  "cpp basic config, incl. hs-minor-mode"
  (hs-minor-mode)
  (global-set-key [f9] 'hs-toggle-hiding)
  )

(add-hook 'c-mode-common-hook 'enable-programming-modes)

(add-hook 'c-mode-common-hook
          '(lambda ()
             (require 'ccls)
             (add-to-list 'lsp-enabled-clients 'ccls)
             ))
(add-hook 'c-mode-common-hook 'cpp-basic-enable)

(use-package ccls)

