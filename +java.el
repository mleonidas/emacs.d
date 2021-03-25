;;; +java.el -*- lexical-binding: t; -*-

(setq lsp-java-jdt-download-url "https://download.eclipse.org/jdtls/snapshots/jdt-language-server-0.58.0-202007061255.tar.gz")

(setq lsp-java-configuration-runtimes '[(:name "JavaCorretto-8"
                                                 :path "/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home"
                                                 :default t)])
