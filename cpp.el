;; C++ Development in Emacs

;; Treesitter intergration

(use-package cc-mode
  :preface
  (defun my-c-style ()
    "Setup Personal C Style."
    (c-set-style "my-style")
    )
  
  :config
  (c-add-style "my-style"
               '("gnu"
                 (c-offsets-alist . ((arglist-intro . +)
                                     (arglist-cont . 0)
                                     (arglist-cont-nonempty . c-lineup-arglist)
                                     (arglist-close . 0)))))
  :hook
  (c-mode-common-hook  . my-c-style)
  )

(use-package c-ts-mode
  :if (and (version<= "29.1" emacs-version)
           (treesit-available-p)
           (treesit-language-available-p 'cpp)
           (treesit-language-available-p 'c))

  :preface
  ;; Ref: https://emacs.stackexchange.com/questions/77232/c-c-with-tree-sitter-how-to-change-indent
  (defun my-indent-style()
    "Override the built-in BSD indentation style with some additional rules"
    `(;; Here are your custom rules
      ((node-is ")") parent-bol 0)
      ((match nil "argument_list" nil 1 1) parent-bol c-ts-mode-indent-offset)
      ((parent-is "argument_list") prev-sibling 0)
      ((match nil "parameter_list" nil 1 1) parent-bol c-ts-mode-indent-offset)
      ((parent-is "parameter_list") prev-sibling 0)
      ;; Append here the indent style you want as base
      ,@(alist-get 'gnu (c-ts-mode--indent-styles 'cpp)))
    )
  :custom
  (c-ts-mode-indent-style #'my-indent-style)
  :init
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  )
;; Use lsp-mode + ccls

;; NOTE: Install ccls through your package manager / compile yourself.
(use-package ccls
  :after (projectile lsp)
  :hook ((c-mode c++-mode objc-mode cuda-mode c-ts-mode c++-ts-mode) .
         lsp-deferred)
  :init
  (add-to-list 'lsp-enabled-clients 'ccls)
  (add-to-list 'lsp-enabled-clients 'ccls-tramp)
  (add-to-list 'lsp-enabled-clients 'clangd-tramp)
  )

(use-package cuda-mode
  :hook
  (cuda-mode-hook . my-c-style))
(use-package cmake-mode)
