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

(setq doom-font (font-spec :family "MesloLGSDZ Nerd Font" :size 12)
      doom-big-font (font-spec :family "MesloLGSDZ Nerd Font" :size 19)
      doom-unicode-font (font-spec :family "Meslo LG S DZ"))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;

(setq doom-line-numbers-style 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/repos/work/org/")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


; (after! rustic
;   (setq rust-format-on-save t))
;
; (setq exec-path (append exec-path '("/Users/mleone/.cargo/bin")))


(after! ivy
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy))))



(after! rustic 
        (setq rustic-format-on-save t))

(add-hook! rustic 
  (flycheck-rust-setup)
  (flycheck-mode)
  (racer-mode)
  (cargo-minor-mode))


(after! cargo
  (setq cargo-process--custom-path-to-bin "/Users/mleone/.cargo/bin/cargo"))


;; display of certain characters and control codes to UTF-8
(defun my-term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))


(add-hook 'term-exec-hook 'my-term-use-utf8)


(setq doom-modeline-buffer-file-name-style 'relative-to-project)

(setq doom-modeline-height 8)

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
