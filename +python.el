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


(use-package! python-black
  :demand t
  :after python)
(add-hook! 'python-mode-hook #'python-black-on-save-mode)
;; Feel free to throw your own personal keybindings here
(map! :leader :desc "Blacken Buffer" "m b b" #'python-black-buffer)
(map! :leader :desc "Blacken Region" "m b r" #'python-black-region)
(map! :leader :desc "Blacken Statement" "m b s" #'python-black-statement)


(defun lsp-python-ms-format-buffer ()
  (interactive)
  (when (and (executable-find "yapf") buffer-file-name)
    (call-process "yapf" nil nil nil "-i" buffer-file-name)))
(add-hook 'python-mode-hook
          (lambda ()
            (add-hook 'after-save-hook #'lsp-python-ms-format-buffer t t)))
