;; Config for javascript/typescript
;; Language Server Config:
;; M-x lsp-install-server RET ts-ls RET

;; TODO: (if I had chance to use JS again,) modify this.

(defun js-enable ()
  (add-to-list 'lsp-enabled-clients 'ts-ls)
  (enable-programming-modes)
  (setq create-lockfiles nil)  ; lock files will kill `npm start'
  )

(defun web-enable ()
  (js-enable)
  (setq web-mode-enable-auto-pairing nil)
  )

(add-hook 'js-mode-hook 'js-enable)
(add-hook 'javascript-mode-hook 'js-enable)
(add-hook 'typescript-mode-hook 'js-enable)
(add-hook 'web-mode-hook 'web-enable)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode)) ; For React file
