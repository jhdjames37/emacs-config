;;; settings.el --- Summary
;;; Commentary:

;;; Here contains all machine dependent parameters,

;;; Code:

(setq my/use-zsh t
      my/use-builtin-theme nil
      my/doom-theme 'doom-fairy-floss
      my/enabled-lang
      '(cpp python python-jupyter js rust latex org markdown typst yaml dotenv dockerfile caddyfile bison)
      my/minibuffer-backend 'vertico
      my/font-scale 1.8
      my/enabled-feat '(ellama aidermacs pdf workspace)
      my/use-lsp-frontend 'eglot)

(provide 'settings)
;;; settings.el ends here
