;;(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)


(use-package lsp-latex
  ;;:after lsp
  :hook
  ((tex-mode latex-mode LaTeX-mode) . lsp-deferred)
  :init
  (add-to-list 'lsp-enabled-clients 'texlab)
  :custom
  (lsp-latex-forward-search-executable "okular")
  (lsp-latex-forward-search-args '("--unique" "file:%p#src:%l%f"))
  (lsp-latex-build-args '("-xelatex" "-halt-on-error" "-interaction=nonstopmode" "%f"))
  (lsp-latex-build-on-save t)
  )

(use-package tex
  :ensure auctex
  :after yasnippet
  :hook
  ((LaTeX-mode tex-mode latex-mode) .
   (lambda ()
     (yas-reload-all)             ;; must reload for some reasons
     (company-mode t)
     (yas-minor-mode t)
     (setq TeX-auto-untabify t     ; remove all tabs before saving
           TeX-engine 'xetex       ; use xelatex default
           TeX-show-compilation t) ; display compilation windows
     (setq TeX-save-query nil)
     (imenu-add-menubar-index)
     )
   )
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default Tex-master nil)
  )

(use-package reftex
  :ensure nil
  :custom
  (reftex-save-parse-info t)
  (reftex-use-multiple-selection-buffers t)
  )

(use-package company-auctex)
