(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  ;; :bind (:map dired-mode-map
  ;;             ("h" . dired-up-directory)
  ;;             ("j" . dired-next-line)
  ;;             ("k" . dired-previous-line)
  ;;             ("l" . dired-single-buffer))
  :delight "Dired"
  :custom
  (dired-auto-revert-buffer t)
  (dired-dwim-target t)
  (dired-hide-details-hide-symlink-targets nil)
  (dired-listing-switches "-alh --group-directories-first --time-style=iso")
  (dired-ls-F-marks-symlinks nil)
  )

(use-package dired-single
  :after dired
  :bind (:map dired-mode-map
              ([remap dired-find-file] . dired-single-buffer)
              ([remap dired-up-directory] . dired-single-up-directory)
              ("M-DEL" . dired-prev-subdir)))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :bind (:map dired-mode-map
              ("H" . dired-hide-dotfiles-mode)))

(use-package dired-subtree
  :after dired
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)))

(use-package dired-git)
