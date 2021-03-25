;;; +rust.el -*- lexical-binding: t; -*-

(after! cargo
  (setq cargo-process--custom-path-to-bin "/Users/mleone/.cargo/bin/cargo"))

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

