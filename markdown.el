;; Markdown mode

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(setq markdown-enable-math t)

;;(setq markdown-command "python3 /home/jhdjames37/Tools/markdown-render/render.py")
(setq markdown-command "pandoc --mathjax | python3 /home/jhdjames37/Tools/markdown-render/render2.py")
