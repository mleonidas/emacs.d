;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Michael Leone"
      user-mail-address "mleone@attentivemobile.com")

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

(setq-hook! '+doom-dashboard-mode-hook default-directory "~")

(setq doom-font (font-spec :family "MesloLGSDZ Nerd Font" :size 12)
      doom-big-font (font-spec :family "MesloLGSDZ Nerd Font" :size 24)
      doom-big-font-increment 5
      doom-variable-pitch-font (font-spec :family "DejaVu Sans")
      doom-unicode-font (font-spec :family "MesloLGSDZ Nerd Font"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;

(when (string= system-type "darwin")
  (setq dired-use-ls-dired t
        insert-directory-program "/usr/local/bin/gls"
        dired-listing-switches "-aBhl --group-directories-first"))


(setq doom-line-numbers-style 'relative)
(setq display-line-numbers-type 'relative)
(setq confirm-kill-emacs nil)

;; Company
(after! company
  (add-to-list 'company-backends 'company-files)
  (setq company-selection-wrap-around t)
  (setq company-minimum-prefix-length 3)
  (setq company-idle-delay 0.2))


(use-package! lsp-mode
  :init
  (setq +lsp-company-backends '(company-files company-capf)))


(setq doom-modeline-buffer-file-name-style 'relative-to-project
      doom-modeline-modal-icon nil
      doom-modeline-github t)



;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.



;; Ruby
(setq projectile-rails-vanilla-command "bundle exec rails"
      projectile-rails-spring-command "bin/spring"
      projectile-rails-zeus-command "bin/zeus")

;; js/typescript
;;
;; (defun typescript-mode-setup ()
;;   "Custom setup for Typescript mode"
;;   (setq flycheck-checker 'javascript-eslint 'js-mode)
;;   (setq flycheck-checker 'typescript-tslint 'rjsx-mode)
;;   )
;; (add-hook 'typescript-mode-hook 'typescript-mode-setup)
(add-hook! ruby-mode
  (flycheck-mode))

(after! robe
  (set-company-backend! 'ruby-mode '(company-robe company-files company-dabbrev-code)))

(defvar +mleone-dir (file-name-directory load-file-name))
;; (defvar +mleone-snippets-dir (expand-file-name "snippets/" +mleone-dir))

;; Rust
(after! rustic
        (setq rustic-format-on-save t))

(setq! lsp-auto-guess-root nil)

;; Terraform
(after! terraform
  (setq terraform-format-on-save-mode 1))


(use-package! ansible
  :commands ansible-auto-decrypt-encrypt
  :init
  (put 'ansible-vault-password-file 'safe-local-variable #'stringp)
  :config
  (setq ansible-section-face 'ansible-section-face
        ansible-task-label-face 'font-lock-doc-face)
  (map! :map ansible-key-map
        :localleader
        :desc "Decrypt buffer"          "d" #'ansible-decrypt-buffer
        :desc "Encrypt buffer"          "e" #'ansible-encrypt-buffer
        :desc "Look up in Ansible docs" "h" #'ansible-doc))


(after! terraform
  (add-hook! :after terraform-mode-hook #'terraform-format-buffer))

;; Dumb jump
(setq dumb-jump-prefer-searcher 'rg)

;; display of certain characters and control codes to UTF-8
(defun my-term-use-utf8 ()
  (set-process-coding-system 'utf-8-unix 'utf-8-unix))

(defun turn-on-comint-history (history-file)
          (setq comint-input-ring-file-name history-file)
          (comint-read-input-ring 'silent))

(add-hook 'inf-ruby-mode-hook
          (lambda ()
            (turn-on-comint-history "~/.pry_history")))

(add-hook 'yaml-mode-hook
          (lambda ()
            (set (make-local-variable 'font-lock-variable-name-face)
                 'font-lock-function-name-face)))

;; (use-package kubernetes
;;   :defer
;;   :commands (kubernetes-overview))
;; (use-package kubernetes-evil
;;   :defer
;;   :after kubernetes)
;; (map! :leader
;;       (:prefix "o"
;;         :desc "Kubernetes" "K" 'kubernetes-overview))

(load! "+bindings")
(load! "+java")
(load! "+go")
(load! "+rust")
(load! "+python")

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
