;; configuration to company-mode

(use-package company
  :hook (prog-mode . company-mode)
  :bind
  ;;("C-i" . company-complete-common)
  :custom
  (company-idle-delay 0.7)
  (company-minimum-prefix-length 1)
  )

;(use-package company-box
;  :hook (company-mode . company-box-mode))
