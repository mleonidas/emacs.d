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

(setq doom-font (font-spec :family "MesloLGMDZ Nerd Font" :size 19)
      doom-big-font (font-spec :family "MesloLGMDZ Nerd Font" :size 24)
      doom-big-font-increment 5
      doom-variable-pitch-font (font-spec :family "DejaVu Sans Mono Nerd Font")
      doom-unicode-font (font-spec :family "MesloLGMDZ Nerd Font"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;


(setq doom-line-numbers-style 'relative)
(setq display-line-numbers-type 'relative)

;; Company
(after! company
  (add-to-list 'company-backends 'company-files)
  (setq company-selection-wrap-around t)
  (setq company-minimum-prefix-length 3)
  (setq company-idle-delay 0.2))

(use-package! lsp-mode
  :init
  (setq +lsp-company-backends '(company-files company-capf)))

;; Doom modeline config
(after! doom-modeline
  :config
  (setq doom-modeline-height 12)
  (setq doom-modeline-buffer-file-name-style 'relative-to-project)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-buffer-encoding t)
  (setq doom-modeline-modal-icon nil))

;; ivy
(after! ivy
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)

  ;; enable this if you want `swiper' to use it
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
           (counsel-rg . ivy--regex-plus)
          (t      . ivy--regex-fuzzy)))

  (recentf-mode 1)
  (defun eh-ivy-return-recentf-index (dir)
    (when (and (boundp 'recentf-list)
            recentf-list)
      (let ((files-list
              (cl-subseq recentf-list
                0 (min (- (length recentf-list) 1) 20)))
             (index 0))
        (while files-list
          (if (string-match-p dir (car files-list))
            (setq files-list nil)
            (setq index (+ index 1))
            (setq files-list (cdr files-list))))
        index)))

  (defun eh-ivy-sort-file-function (x y)
    (let* ((x (concat ivy--directory x))
            (y (concat ivy--directory y))
            (x-mtime (nth 5 (file-attributes x)))
            (y-mtime (nth 5 (file-attributes y))))
      (if (file-directory-p x)
        (if (file-directory-p y)
          (let ((x-recentf-index (eh-ivy-return-recentf-index x))
                 (y-recentf-index (eh-ivy-return-recentf-index y)))
            (if (and x-recentf-index y-recentf-index)
              ;; Directories is sorted by `recentf-list' index
              (< x-recentf-index y-recentf-index)
              (string< x y)))
          t)
        (if (file-directory-p y)
          nil
          ;; Files is sorted by mtime
          (time-less-p y-mtime x-mtime)))))

  (add-to-list 'ivy-sort-functions-alist
    '(read-file-name-internal . eh-ivy-sort-file-function)))



;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.


;; Python
;;
;; ipython
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

(after! python
  (remove-hook! 'python-mode-hook #'pipenv-mode))

(setq python-shell-interpreter-args "--simple-prompt -i")
(setq py-python-command-args '("--colors=linux"))
(setq python-shell-unbuffered nil)
(setq python-shell-prompt-detect-failure-warning nil)
(setq python-shell-prompt-detect-enabled nil)

;; Ruby
(setq projectile-rails-vanilla-command "bundle exec rails"
      projectile-rails-spring-command "bin/spring"
      projectile-rails-zeus-command "bin/zeus")


(add-hook! ruby-mode
  (flycheck-mode))

(after! robe
  (set-company-backend! 'ruby-mode '(company-robe company-files company-dabbrev-code)))

(defvar +mleone-dir (file-name-directory load-file-name))
(defvar +mleone-snippets-dir (expand-file-name "snippets/" +mleone-dir))

;; Rust
(after! rustic
        (setq rustic-format-on-save t))

(after! cargo
  (setq cargo-process--custom-path-to-bin "/Users/mike/.cargo/bin/cargo"))

(after! rust
  (setq rust-format-on-save t)
  (add-hook! :after rust-mode-hook #'lsp)
  (add-hook! :after rust-mode-hook #'rust-enable-format-on-save))

  (add-hook! rust-mode
    (flycheck-rust-setup)
    (flycheck-mode)
    (cargo-minor-mode)
    (lsp)
    (rust-enable-format-on-save)
    (map! :map rust-mode-map
          "C-c C-f" #'rust-format-buffer))


(after! terraform
  (setq terraform-format-on-save-mode 1))

;; Docker?
(use-package! docker-compose-mode
  :after (docker))

(after! terraform
  (add-hook! :after terraform-mode-hook #'terraform-format-buffer))
;; Dumb jump
(setq dumb-jump-prefer-searcher 'rg)

(setq projectile-project-search-path '("~/Documents/repos/work/"))

;; display of certain characters and control codes to UTF-8
(defun my-term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))

(add-hook 'term-exec-hook 'my-term-use-utf8)

(defun turn-on-comint-history (history-file)
          (setq comint-input-ring-file-name history-file)
          (comint-read-input-ring 'silent))

(add-hook 'inf-ruby-mode-hook
          (lambda ()
            (turn-on-comint-history "~/.pry_history")))

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (docker-compose-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
