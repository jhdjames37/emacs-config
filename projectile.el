;; Configuration for projectile

(eval-after-load 'projectile-mode
  '(progn
     (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
     ))


