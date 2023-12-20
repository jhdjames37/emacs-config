;;; settings.el --- Summary
;;; Commentary:

;;; Here contains all machine dependent parameters,

;;; Code:

(defvar my/use-zsh t
  "Whether to use zsh."
  )
(defvar my/use-builtin-theme nil
  "Use built-in background instead of doom-themes.")

(defvar my/enabled-lang
  '(cpp python js rust latex org markdown typst yaml dotenv dockerfile caddyfile bison)
  "Language extensions enabled.
available: (cpp python js rust latex org markdown typst yaml dotenv dockerfile caddyfile bison)")

;;(defvar my/org-path
;;  '(:archive
;;   :agenda)
;;  "Path used in org-mode. nil when not set")
  

(provide 'settings)
;;; settings.el ends here
