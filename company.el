;; configuration to company-mode

(eval-after-load 'company-mode
  '(progn
     (setq 'company-idle-delay 0)
     (setq 'company-minimum-prefix-length 2)
     (global-set-key "\t" company-complete-common)
  )
  )

;(use-package company-box
;  :hook (company-mode . company-box-mode))
