;;(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)

(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)

(mapc (lambda (mode)
        (add-hook 'LaTeX-mode-hook mode))
      (list 
            'LaTeX-math-mode
            'turn-on-reftex
            ;'company-mode
            ;'yas-minor-mode))
            ))

;(require 'company-auctex)
;(require 'company-math)
(require 'lsp-latex)
(with-eval-after-load "tex-mode"
 (add-hook 'tex-mode-hook 'lsp)
 (add-hook 'latex-mode-hook 'lsp)
 (add-hook 'LaTeX-mode-hook 'lsp)
 (add-to-list 'lsp-enabled-clients 'texlab)

 ;(setq lsp-latex-forward-search-after t)
 (setq lsp-latex-forward-search-executable "okular")
 (setq lsp-latex-forward-search-args '("--unique" "file:%p#src:%l%f"))

 (setq lsp-latex-build-args '("-xelatex" "-halt-on-error" "-interaction=nonstopmode" "%f"))
 (setq lsp-latex-build-on-save t)
 )


(add-hook 'LaTeX-mode-hook
          (lambda ()
            (enable-programming-modes)
            (setq TeX-auto-untabify t     ; remove all tabs before saving
                  TeX-engine 'xetex       ; use xelatex default
                  TeX-show-compilation t) ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
            ;(define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
            ;(add-to-list 'company-backends 'company-math-symbols-latex)
            ;(add-to-list 'company-backends 'company-yasnippet)
            ;(company-auctex-init)
            
            (yas-reload-all) ;; must reload for some reasons
            )
          )

