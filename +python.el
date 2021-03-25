;;; +python.el -*- lexical-binding: t; -*-

;; ipython
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

(after! python-pytest
  (setq python-pytest-arguments '("--color" "--failed-first" "import-mode=append"))
  (evil-set-initial-state 'python-pytest-mode 'normal))

(setq python-shell-interpreter-args "--simple-prompt -i")
(setq py-python-command-args '("--colors=linux"))
(setq python-shell-unbuffered nil)
(setq python-shell-prompt-detect-failure-warning nil)
(setq python-shell-prompt-detect-enabled nil)
