(use-package hydra
  :bind (;;("C-c I" . hydra-image/body)
         ;;("C-c L" . hydra-ledger/body)
         ("C-c M" . hydra-merge/body)
         ;; ("C-c T" . hydra-tool/body)
         ;; ("C-c b" . hydra-btoggle/body)
         ;; ("C-c c" . hydra-clock/body)
         ;; ("C-c e" . hydra-circe/body)
         ("C-c f" . hydra-flycheck/body)
         ("C-c g" . hydra-go-to-file/body)
         ;; ("C-c m" . hydra-magit/body)
         ("C-c o" . hydra-org/body)
         ;; ("C-c p" . hydra-projectile/body)
         ;; ("C-c s" . hydra-spelling/body)
         ;; ("C-c t" . hydra-tex/body)
         ;; ("C-c u" . hydra-upload/body)
         ("C-c w" . hydra-windows/body)
         ("C-c r" . hydra-treemacs/body)
         ("C-c v" . hydra-view/body)
         )
  )

(use-package major-mode-hydra
  :after hydra
  :preface
  (defun with-alltheicon (icon str &optional height v-adjust face)
    "Display an icon from all-the-icon."
    (s-concat (all-the-icons-alltheicon icon :v-adjust (or v-adjust 0) :height (or height 1) :face face) " " str))

  (defun with-faicon (icon str &optional height v-adjust face)
    "Display an icon from Font Awesome icon."
    (s-concat (all-the-icons-faicon icon ':v-adjust (or v-adjust 0) :height (or height 1) :face face) " " str))

  (defun with-fileicon (icon str &optional height v-adjust face)
    "Display an icon from the Atom File Icons package."
    (s-concat (all-the-icons-fileicon icon :v-adjust (or v-adjust 0) :height (or height 1) :face face) " " str))

  (defun with-octicon (icon str &optional height v-adjust face)
    "Display an icon from the GitHub Octicons."
    (s-concat (all-the-icons-octicon icon :v-adjust (or v-adjust 0) :height (or height 1) :face face) " " str)))

(pretty-hydra-define hydra-flycheck
  (:hint nil :color teal :quit-key "q" :title (with-faicon "plane" "Flycheck" 1 -0.05))
  ("Checker"
   (("?" flycheck-describe-checker "describe")
    ("d" flycheck-disable-checker "disable")
    ("m" flycheck-mode "mode")
    ("s" flycheck-select-checker "select"))
   "Errors"
   (("<" flycheck-previous-error "previous" :color pink)
    (">" flycheck-next-error "next" :color pink)
    ("f" flycheck-buffer "check")
    ("l" flycheck-list-errors "list"))
   "Other"
   (("M" flycheck-manual "manual")
    ("v" flycheck-verify-setup "verify setup"))))

(pretty-hydra-define hydra-merge
  (:hint nil :color pink :quit-key "q" :title (with-octicon "mark-github" "Magit" 1 -0.05))
  ("Move"
   (("n" smerge-next "next")
    ("p" smerge-prev "previous"))
   "Keep"
   (("RET" smerge-keep-current "current")
    ("a" smerge-keep-all "all")
    ("b" smerge-keep-base "base")
    ("l" smerge-keep-lower "lower")
    ("u" smerge-keep-upper "upper"))
   "Diff"
   (("<" smerge-diff-base-upper "upper/base")
    ("=" smerge-diff-upper-lower "upper/lower")
    (">" smerge-diff-base-lower "base/lower")
    ("R" smerge-refine "redefine")
    ("E" smerge-ediff "ediff"))
   "Other"
   (("C" smerge-combine-with-next "combine")
    ("r" smerge-resolve "resolve")
    ("k" smerge-kill-current "kill current"))))

(pretty-hydra-define hydra-windows
  (:hint nil :forein-keys warn :quit-key "q" :title (with-faicon "windows" "Windows" 1 -0.05))
  ("Window"
   (("b" balance-windows "balance")
    ;;("c" centered-window-mode "center")
    ("i" enlarge-window "heighten")
    ("j" shrink-window-horizontally "narrow")
    ("k" shrink-window "lower")
    ("u" winner-undo "undo")
    ("r" winner-redo "redo")
    ("l" enlarge-window-horizontally "widen")
    ("o" ace-window "switch")
    ("t" treemacs-select-window "treemacs")
    ;;("s" switch-window-then-swap-buffer "swap" :color teal)
    )
   "Zoom"
   (("-" text-scale-decrease "out")
    ("+" text-scale-increase "in")
    ("=" (text-scale-increase 0) "reset"))))

(pretty-hydra-define hydra-treemacs
  (:hint nil :color pink :quit-key "q" :title (with-faicon "tree" "Treemacs" 1 -0.05))
  ("Project"
   (("a" treemacs-add-project "Add")
    ("r" treemacs-remove-project-from-workspace "Remove"))
   "Workspace"
    (("s" treemacs-switch-workspace "Switch")
     ("e" treemacs-edit-workspaces "Edit")   
     )
   )
  )

(pretty-hydra-define hydra-org
  (:hint nil :color teal :quit-key "q" :title (with-fileicon "org" "Org" 1 -0.05))
  ("Action"
   (("A" my/org-archive-done-tasks "archive")
    ("a" org-agenda "agenda")
    ("c" org-capture "capture")
    ("d" org-decrypt-entry "decrypt")
    ("i" org-insert-link-global "insert-link")
    ("j" org-capture-goto-last-stored "jump-capture")
    ("k" org-cut-subtree "cut-subtree")
    ("o" org-open-at-point-global "open-link")
    ("r" org-refile "refile")
    ("s" org-store-link "store-link")
    ("t" org-show-todo-tree "todo-tree"))))

(defhydra hydra-view
  (:hint nil :color amaranth)
         "View: move like vi, q to quit"
  ("h" backward-char)
  ("l" forward-char)
  ("k" previous-line)
  ("j" next-line)
  ("a" move-beginning-of-line)
  ("d" move-end-of-line)
  ("q" nil :color blue)
  )
;;(pretty-)
