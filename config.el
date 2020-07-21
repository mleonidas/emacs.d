;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Michael Leone"
      user-mail-address "mike.leone@credsimple.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-theme 'doom-solarized-dark)

(setq doom-themes-enable-bold nil)

(setq doom-font (font-spec :family "MesloLGSDZ Nerd Font" :size 14)
      doom-big-font (font-spec :family "MesloLGSDZ Nerd Font" :size 24)
      doom-unicode-font (font-spec :family "MesloLGSDZ Nerd Font"))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;

(setq doom-line-numbers-style 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


; (setq-default show-trailing-whitespace t)

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))


(setq projectile-rails-vanilla-command "bundle exec rails"
      projectile-rails-spring-command "bin/spring"
      projectile-rails-zeus-command "bin/zeus")

(setq python-shell-interpreter-args "--simple-prompt -i")

(setq python-shell-unbuffered nil)
(setq python-shell-prompt-detect-failure-warning nil)
(setq python-shell-prompt-detect-enabled nil)

(after! ivy
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy))))


;; load some snippets
(defvar +mleone-dir (file-name-directory load-file-name))
(defvar +mleone-snippets-dir (expand-file-name "snippets/" +mleone-dir))

;; feature/snippets
(after! yasnippet
  ;; Don't use default snippets, use mine.
  (setq yas-snippet-dirs
        (append (list '+mleone-snippets-dir)
                (delq 'yas-installed-snippets-dir yas-snippet-dirs))))

(after! rustic
        (setq rustic-format-on-save t))


(after! rust
  ;; (require 'ein)
  (setq rust-format-on-save t)
  (add-hook! :after rust-mode-hook #'lsp)
  (add-hook! :after rust-mode-hook #'rust-enable-format-on-save))

(add-hook! ruby-mode
  (flycheck-mode)
  )


(setq dumb-jump-prefer-searcher 'rg)


(after! robe
  (set-company-backend! 'ruby-mode '(company-robe company-files company-dabbrev-code)))
;; these are the defaults (before I changed them)
(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 3))

(use-package! pyimport
  :after (python))


(after! cargo
  (setq cargo-process--custom-path-to-bin "/Users/mleone/.cargo/bin/cargo"))


;; (setq gofmt-command "goimports"
;;       (add-hook 'before-save-hook #'gofmt-before-save))

(use-package! company-lsp
  :after (lsp-mode lsp-ui)
  :config
  (add-to-list #'company-backends #'company-lsp)
  (add-to-list #'company-backends #'company-files)
  (setq company-lsp-async t))

(setq projectile-project-search-path '("~/Documents/repos/work/"))

(add-hook! rust-mode
  (flycheck-rust-setup)
  (flycheck-mode)
  (cargo-minor-mode)
  (lsp)
  (rust-enable-format-on-save)
  (map! :map rust-mode-map
        "C-c C-f" #'rust-format-buffer))

(setq flycheck-python-pycompile-executable "python3")

;; display of certain characters and control codes to UTF-8
(defun my-term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))


(add-hook 'term-exec-hook 'my-term-use-utf8)


(setq doom-modeline-buffer-file-name-style 'relative-to-project
      doom-modeline-modal-icon nil)

(setq doom-modeline-height 12)


(add-to-list 'initial-frame-alist '(fullscreen . maximized))


(after! ivy
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy))))

;; xfce ssh agent juggling

(load! "+bindings")


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
