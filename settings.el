;;; settings.el --- Summary
;;; Commentary:

;;; Here contains all machine dependent parameters,

;;; Code:

(setq my/use-zsh t)

(setq my/use-builtin-theme nil)

(setq my/enabled-lang
      '(cpp python js rust latex org markdown typst yaml dotenv dockerfile caddyfile bison))

(setq my/minibuffer-backend 'vertico)

(provide 'settings)
;;; settings.el ends here
