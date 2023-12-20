(use-package org
  :ensure org-contrib
  :delight "Θ"
  :hook (org-mode . turn-off-auto-fill)
  :bind ("C-c i" . org-insert-structure-template)
  :init
  (require 'ox-latex)
  :preface
  (defun my/org-archive-done-tasks ()
    "Archive finished or cancelled tasks."
    (interactive)
    (org-map-entries
     (lambda ()
       (org-archive-subtree)
       (setq org-map-continue-from (outline-previous-heading)))
     "TODO=\"DONE\"|TODO=\"CANCELLED\"" (if (org-before-first-heading-p) 'file 'tree)))

  (defun my/org-jump ()
    "Jump to a specific task."
    (interactive)
    (let ((current-prefix-arg '(4)))
      (call-interactively 'org-refile)))

  (defun my/org-use-speed-commands-for-headings-and-lists ()
    "Activate speed commands on list items too."
    (or (and (looking-at org-outline-regexp) (looking-back "^\**"))
        (save-excursion (and (looking-at (org-item-re)) (looking-back "^[ \t]*")))))

  (defmacro ignore-args (fnc)
    "Returns function that ignores its arguments and invokes FNC."
    `(lambda (&rest _rest)
       (funcall ,fnc)))
  :hook (
         (org-mode . visual-line-mode)
         (auto-save . org-save-all-org-buffers)
         )
  :custom
  (org-archive-location "~/Documents/miscs/archives/%s::")
  (org-blank-before-new-entry '((heading . nil)
                                (plain-list-item . nil)))
  (org-confirm-babel-evaluate nil)
  (org-cycle-include-plain-lists 'integrate)
  (org-ellipsis " ▾")
  (org-export-backends '(ascii beamer html icalendar latex man md org texinfo))
  (org-hide-emphasis-markers nil)
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-modules '(org-crypt
                 org-habit
                 org-mouse
                 org-protocol
                 org-tempo))
  (org-refile-allow-creating-parent-nodes 'confirm)
  (org-refile-targets '((org-agenda-files :maxlevel . 1)
                        ))
  (org-refile-use-cache nil)
  (org-refile-use-outline-path nil)
  (org-startup-indented t)
  (org-startup-with-inline-images t)
  (org-tag-alist
   '((:startgroup . "Context")
     ("@errands" . ?e)
     ("@project" . ?w)
     ("@regular" . ?r)
     ("@longterm" . ?l)
     (:endgroup)
     (:startgroup . "Difficulty")
     ("easy" . ?E)
     ("medium" . ?M)
     ("challenging" . ?C)
     (:endgroup)
     ))
  (org-tags-exclude-from-inheritance '("crypt"))
  (org-todo-keywords '((sequence "TODO(t)"
                                 "STARTED(s)"
                                 "NEXT(n)"
                                 "SOMEDAY(.)"
                                 "WAITING(w)""|" "DONE(x!)" "CANCELLED(c@)")))
  (org-use-effective-time t)
  (org-use-speed-commands 'my/org-use-speed-commands-for-headings-and-lists)
  (org-yank-adjusted-subtrees t)

  (org-latex-compiler "xelatex")
  (org-latex-listings "listings")
  (org-export-with-tags nil)
  (org-export-with-toc nil)
  (org-export-with-section-numbers 0)
  (org-latex-default-class "org-article")

  (org-highlight-latex-and-related '(native scripts entities))
  :config
  ;;(add-to-list 'org-global-properties '("Effort_ALL". "0:05 0:15 0:30 1:00 2:00 3:00 4:00"))
  (add-to-list 'org-speed-commands '("$" call-interactively 'org-archive-subtree))
  (add-to-list 'org-speed-commands '("i" call-interactively 'org-clock-in))
  (add-to-list 'org-speed-commands '("o" call-interactively 'org-clock-out))
  (add-to-list 'org-speed-commands '("s" call-interactively 'org-schedule))
  (add-to-list 'org-speed-commands '("x" org-todo "DONE"))
  (add-to-list 'org-speed-commands '("y" org-todo-yesterday "DONE"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (advice-add 'org-deadline :after (ignore-args #'org-save-all-org-buffers))
  (advice-add 'org-schedule :after (ignore-args #'org-save-all-org-buffers))
  (advice-add 'org-store-log-note :after (ignore-args #'org-save-all-org-buffers))
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
  (advice-add 'org-todo :after (ignore-args #'org-save-all-org-buffers))
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (org-load-modules-maybe t)

  (add-to-list 'org-latex-classes
               '("org-article"
                 "\\documentclass[10pt, a4paper]{article}
\\usepackage{xeCJK, indentfirst, fancyhdr, ulem, graphicx, amsmath, amsfonts,
 amsthm, setspace, multirow, float, verbatim, booktabs, makecell,
 tabularx, lastpage, enumitem, xcolor, color, titlesec, enumitem, listings}
\\usepackage[hmargin=1.25in, vmargin=1in]{geometry}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
\\usepackage{hyperref}
\\hypersetup{pdfborder={0 0 0}, colorlinks, linkcolor=red, anchorcolor=blue, citecolor=blue, urlcolor=blue}
\\setCJKmainfont[BoldFont={SimHei}, ItalicFont={KaiTi}]{SimSun}
\\setCJKsansfont{SimHei}
\\setCJKmonofont{KaiTi}
\\linespread{1.3}
\\setlength{\\parindent}{2em}
\\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\\parskip,topsep=0pt,leftmargin=3em}
\\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\\parskip,topsep=0pt,leftmargin=3em}
\\setdescription{itemsep=0pt,partopsep=0pt,parsep=\\parskip,topsep=0pt,leftmargin=3em}
\\lstset{
  columns=fullflexible,
  keepspaces=true,
  showspaces=false,
  showtabs=false,
  breaklines=true,
  showstringspaces=false,
  breakatwhitespace=true,
  rulecolor=\\lst@ifdisplaystyle\\color{blue}\\fi,
  commentstyle=\\itshape\\lst@ifdisplaystyle\\color{olive}\\fi,
  stringstyle=\\bfseries\\lst@ifdisplaystyle\\color{orange}\\fi,
  keywordstyle=\\bfseries\\lst@ifdisplaystyle\\color{blue}\\fi,
  numberstyle=\\footnotesize\\ttfamily\\lst@ifdisplaystyle\\color{gray}\\fi,
  basicstyle=\\ttfamily\\normalsize,
  frame=single,
  framesep=3pt,
  xleftmargin=12pt,
  tabsize=4,
  captionpos=b,
  numbers=left
}
\\makeatletter
\\renewcommand{\\maketitle}{
  \\begin{center}
    {\\bfseries \\LARGE \\@title }
    \\vspace{6pt}
  \\end{center}
}
\\makeatother
[EXTRA]
"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  )


(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  )

(use-package org-agenda
  :ensure nil
  :bind (:map org-agenda-mode-map
              ("C-n" . org-agenda-next-item)
              ("C-p" . org-agenda-previous-item)
              ("j" . org-agenda-goto)
              ("X" . my/org-agenda-mark-done-next)
              ("x" . my/org-agenda-mark-done))
  :preface
  (defun my/org-agenda-mark-done (&optional arg)
    "Mark the current TODO as done in org-agenda."
    (interactive "P")
    (org-agenda-todo "DONE"))

  (defun my/org-agenda-mark-done-next ()
    "Mark the current TODO as done and add another task after it."
    (interactive)
    (org-agenda-todo "DONE")
    (org-agenda-switch-to)
    (org-capture 0 "t"))
  :custom
 
  (org-agenda-category-icon-alist
   `(("home" ,(list (all-the-icons-faicon "home" :v-adjust -0.05)) nil nil :ascent center :mask heuristic)
     ("inbox" ,(list (all-the-icons-faicon "inbox" :v-adjust -0.1)) nil nil :ascent center :mask heuristic)
     ("people" ,(list (all-the-icons-material "people" :v-adjust -0.25)) nil nil :ascent center :mask heuristic)
     ("work" ,(list (all-the-icons-material "work" :v-adjust -0.25)) nil nil :ascent center :mask heuristic)
     ("routine" ,(list (all-the-icons-material "repeat" :v-adjust -0.25)) nil nil :ascent center :mask heuristic)
     ))
  ;; (org-agenda-custom-commands
  ;;  '(("d" "Dashboard"
  ;;     ((agenda "" ((org-deadline-warning-days 7)))
  ;;      (todo "NEXT"
  ;;            ((org-agenda-overriding-header "Next Tasks")))
  ;;      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

  ;;    ("n" "Next Tasks"
  ;;     ((agenda "" ((org-deadline-warning-days 7)))
  ;;      (todo "NEXT"
  ;;            ((org-agenda-overriding-header "Next Tasks")))))

  ;;    ;;("h" "Home Tasks" tags-todo "@home")
  ;;    ("w" "Project Tasks" tags-todo "@project")
  ;;    ("r" "Routine Tasks" tags-todo "@routine")

  ;;    ("E" "Easy Tasks" tags-todo "easy")
  ;;    ("C" "Challenging Tasks" tags-todo "challenging")

  ;;    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
  ;;     ((org-agenda-overriding-header "Low Effort Tasks")
  ;;      (org-agenda-max-todos 20)
  ;;      (org-agenda-files org-agenda-files)))))
  (org-agenda-dim-blocked-tasks t)
  (org-agenda-files '("~/Documents/agenda"))
  ;;(org-agenda-inhibit-startup t)
  (org-agenda-show-log t)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-span 14)
  (org-agenda-start-on-weekday 0)
  (org-agenda-start-with-log-mode t)
  (org-agenda-sticky nil)
  (org-agenda-tags-column 90)
  (org-agenda-time-grid '((daily today require-timed)))
  (org-agenda-use-tag-inheritance t)
  (org-columns-default-format "%14SCHEDULED %1PRIORITY %TODO %50ITEM %TAGS")
  (org-default-notes-file "~/Documents/agenda/inbox.org")
  ;;(org-directory "~/Documents/agenda")
  (org-enforce-todo-dependencies t)
  (org-habit-completed-glyph ?✓)
  (org-habit-graph-column 80)
  (org-habit-show-habits-only-for-today nil)
  (org-habit-today-glyph ?‖)
  (org-track-ordered-property-with-tag t))

(use-package org-capture
  :ensure nil
  :preface
  (defvar my/org-basic-task-template
    (concat "** TODO %^{Task}\n"
            ":CAPTURED: %<%Y-%m-%d %H:%M>\n"
            ":END:") "Template for basic task.")
  :custom
  (org-capture-templates
   `(
     ("a" "Simple task" entry (file+headline "~/Documents/agenda/inbox.org" "Tasks"),
      my/org-basic-task-template
      :empty-lines 0
      :prepend
      :immediate-finish nil)
     )))

;; Ref: https://hsingko.pages.dev/post/2021/12/23/org-download/
(use-package org-download
  :config
  (setq-default org-download-heading-lvl nil)
  (setq-default org-download-image-dir "./.org-img")
  (setq org-download-backend "wget")
  (defun dummy-org-download-annotate-function (link)
    "")
  ;;(setq org-download-abbreviate-filename-function "relative")
  (setq org-download-annotate-function
        #'dummy-org-download-annotate-function)
  (setq org-download-screenshot-method "spectacle -br -o %s")
  )

