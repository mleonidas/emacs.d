;;; +go.el -*- lexical-binding: t; -*-

;; Golang

(after! go-mode
  (set-lookup-handlers! 'go-mode
    :definition #'godef-jump
    :references #'go-guru-referrers
    :documentation #'godoc-at-point))

(setq gofmt-command "goimports")
(add-hook 'before-save-hook #'lsp-format-buffer)
(add-hook 'before-save-hook #'lsp-organize-imports)
